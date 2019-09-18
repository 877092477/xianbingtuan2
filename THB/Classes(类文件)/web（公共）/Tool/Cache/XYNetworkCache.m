//
//  XYNetworkCache.m
//  THB
//
//  Created by Weller Zhao on 2018/12/21.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "XYNetworkCache.h"

@interface XYNetworkCache()

// 创建文件管理对象
@property (nonatomic, strong) NSFileManager *fileManager;
// 缓存parameter时需要忽略的参数
@property (nonatomic, strong) NSArray *ignoreKeys;

@end

@implementation XYNetworkCache

#define PATH @"Network"

static XYNetworkCache* _instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    });
    
    return _instance ;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [XYNetworkCache shareInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [Singleton shareInstance] ;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fileManager = [NSFileManager defaultManager];
        self.ignoreKeys = @[TimeKey, SignKey, systemVersionkey];
    }
    return self;
}


- (NSString*)getPathWithUrl:(NSString *)url andParams: (NSDictionary *)parameter {
    NSString *token = UserAccessToken;
    // 根据token创建用户路径
    NSString *tokenPath = [CachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@/", PATH, token]];
    if (token == nil || [token isEqualToString:@""] ) {
        tokenPath = [CachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/", PATH]];
    }
    [self.fileManager createDirectoryAtPath:tokenPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    //忽略部分参数
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:parameter];
    for (NSString *key in self.ignoreKeys) {
        [params removeObjectForKey:key];
    }
    
    //拼接url和parameter成新字符串
    NSMutableString *names = [[NSMutableString alloc] initWithString:url];
    NSData *paramData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramString = [[NSString alloc]initWithData:paramData encoding:NSUTF8StringEncoding];
    [names appendFormat:@"?%@", paramString];
    
    
    NSString *dataPath = [tokenPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", [NSString md5: names]]];
#ifdef DEBUG
    NSLog(@"!!! cache path: %@", dataPath);
#endif

    return dataPath;
}

- (void)saveData: (NSDictionary*)data withUrl:(NSString *)url andParams: (NSDictionary *)parameter {
    
    NSString *path = [self getPathWithUrl:url andParams:parameter];

    id page = [parameter objectForKey:PageNumber];
    //如果是分页，只缓存第一页
    if (page) {
        if ([page isKindOfClass:[NSString class]] && ((NSString*)page).integerValue > 1) {
            return;
        }
        else if ([page isKindOfClass:[NSNumber class]] && ((NSNumber*)page).integerValue > 1){
            return;
        }
    }
    
    NSDictionary *dict = [self processDictionaryIsNSNull:data];
    [dict writeToFile:path atomically:YES];
    
}

// 过滤不合法的字段
- (id) processDictionaryIsNSNull:(id)obj{
    const NSString *blank = @"";
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dt = [(NSMutableDictionary*)obj mutableCopy];
        for(NSString *key in [dt allKeys]) {
            id object = [dt objectForKey:key];
            if([object isKindOfClass:[NSNull class]]) {
                [dt setObject:blank
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSString class]]){
                NSString *strobj = (NSString*)object;
                if ([strobj isEqualToString:@"<null>"]) {
                    [dt setObject:blank
                           forKey:key];
                }
            }
            else if ([object isKindOfClass:[NSArray class]]){
                NSArray *da = (NSArray*)object;
                da = [self processDictionaryIsNSNull:da];
                [dt setObject:da
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSDictionary class]]){
                NSDictionary *ddc = (NSDictionary*)object;
                ddc = [self processDictionaryIsNSNull:object];
                [dt setObject:ddc forKey:key];
            }
        }
        return [dt copy];
    }
    else if ([obj isKindOfClass:[NSArray class]]){
        NSMutableArray *da = [(NSMutableArray*)obj mutableCopy];
        for (int i=0; i<[da count]; i++) {
            NSDictionary *dc = [obj objectAtIndex:i];
            dc = [self processDictionaryIsNSNull:dc];
            [da replaceObjectAtIndex:i withObject:dc];
        }
        return [da copy];
    }
    else{
        return obj;
    }
}


- (NSDictionary*)getDataWithUrl:(NSString *)url andParams: (NSDictionary *)parameter {
    NSString *path = [self getPathWithUrl:url andParams:parameter];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:path];
    return resultDic;
}


- (void)clearCache {
    NSString *path = [CachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/", PATH]];
    [_fileManager removeItemAtPath:path error:nil];
}
@end
