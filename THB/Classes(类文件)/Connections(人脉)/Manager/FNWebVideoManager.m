//
//  FNWebVideoManager.m
//  THB
//
//  Created by Weller Zhao on 2019/2/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNWebVideoManager.h"
#import "FNWebFileManager.h"
#import <Photos/Photos.h>

@implementation FNWebVideoManager

static FNWebVideoManager* _instance = nil;

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
    return [FNWebVideoManager shareInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [FNWebVideoManager shareInstance] ;
}

- (void) downloadWithUrl: (NSURL*)url completed: (FNWebVideoDownloaderCompletedBlock)block {
    NSString *path = [[FNWebFileManager shareInstance] getCachePath:url];
    NSURL *cacheUrl = URL(path);
    // aa.mp4
    NSString *cacheFullName = [cacheUrl lastPathComponent];
    // aa
    NSString *cacheName = [cacheFullName stringByDeletingPathExtension];
    NSString *coverImagePath =  [path stringByReplacingOccurrencesOfString:cacheFullName withString:[NSString stringWithFormat:@"%@.%@", cacheName, @"jpg"]];
    NSLog(@"视频缩略图：%@", coverImagePath);
    
    [[FNWebFileManager shareInstance] downloadWithUrl:url completed:^(NSURL * fileUrl, NSError * error, BOOL finished) {
        if (error != nil) {
            block(nil, nil, error, finished);
            return;
        }
        
        UIImage *coverImage = [FNWebVideoManager getImage:fileUrl];
//        NSData *data = UIImageJPEGRepresentation(coverImage, 1);
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        [fileManager createFileAtPath:coverImagePath contents:data attributes:nil];
        
        block(coverImage, fileUrl, nil, finished);
        
    }];
}

+ (UIImage *)getImage:(NSURL*)videoURL {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;
    
}


@end
