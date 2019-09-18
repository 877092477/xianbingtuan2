//
//  FNWebFileManager.m
//  THB
//
//  Created by Weller Zhao on 2019/2/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNWebFileManager.h"

@interface FNWebFileManager()

// 创建文件管理对象
@property (nonatomic, strong) NSFileManager *fileManager;

@end

@implementation FNWebFileManager

#define PATH @"FileDownload"

static FNWebFileManager* _instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    
    return _instance ;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [FNWebFileManager shareInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [FNWebFileManager shareInstance] ;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fileManager = [NSFileManager defaultManager];
    }
    return self;
}


/**
 获取文件缓存地址
 
 @return
 */
- (NSString*) getCacheFilePath {
    // 根据token创建用户路径
//    NSString *path = [CachePath stringByAppendingPathComponent:PATH];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/Caches/%@",PATH]];
    [self.fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    return path;
}

- (NSString*) getCachePath: (NSURL*)url {
    //文件后缀名
    NSString *pathExtension = [url pathExtension];
    
    NSString *path = [self getCacheFilePath];
//    NSString *filePath = [NSString stringWithFormat:@"%@/%@.%@", path, [NSString md5:url.absoluteString], pathExtension];
    NSString *filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", [NSString md5:url.absoluteString], pathExtension]];
    
    return filePath;
}

- (void) downloadWithUrl: (NSURL*)url completed: (FNWebFileDownloaderCompletedBlock)block {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSString *urlString = [self getCachePath:url];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:urlString]) {
        NSLog(@"缓存文件读取");
        block([NSURL fileURLWithPath:urlString], nil, YES);
        return;
    }
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        return [NSURL fileURLWithPath:[self getCachePath:url]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        block(filePath, error, YES);
    }];
    [downloadTask resume];
}

@end
