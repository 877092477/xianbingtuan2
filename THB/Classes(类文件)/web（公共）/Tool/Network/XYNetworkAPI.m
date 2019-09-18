//
//  XYNetworkAPI.m
//  FnuoApp
//
//  Created by zhongxueyu on 16/2/24.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "XYNetworkAPI.h"
#import <Reachability/Reachability.h>
#import "XYNetworkCache.h"
#import "JPUSHService.h"
#import "FNWindow.h"

#ifndef ALBBService
#define ALBBService(__protocol__) ((id <__protocol__>) ([[TaeSDK sharedInstance] getService:@protocol(__protocol__)]))
#endif
#define kNetworkNotReachability ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus <= 0)
@implementation XYNetworkAPI

+ (BOOL)isExistenceNetwork {
    // Allocate a reachability object
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    // Set the blocks
    reach.reachableBlock = ^(Reachability*reach) {
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    };
    
    reach.unreachableBlock = ^(Reachability*reach) {
        //        [RKDropdownAlert title:@"没有网络，请检查网络连接"];
        XYLog(@"没网");
    };
    [reach startNotifier];
    return reach.currentReachabilityStatus != NotReachable;
}
+(XYNetworkAPI *)sharedManager{
    static XYNetworkAPI *sharedNetworkSingleton = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        sharedNetworkSingleton = [[self alloc] init];
    });
    return sharedNetworkSingleton;
}
-(AFHTTPRequestOperationManager *)baseHtppRequest{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:20];
    //header 设置
    
    //    [manager.requestSerializer setValue:K_PASS_IP forHTTPHeaderField:@"Host"];
    //    [manager.requestSerializer setValue:@"max-age=0" forHTTPHeaderField:@"Cache-Control"];
    //    [manager.requestSerializer setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    //    [manager.requestSerializer setValue:@"zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3" forHTTPHeaderField:@"Accept-Language"];
    //    [manager.requestSerializer setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    //    [manager.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    //    [manager.requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:35.0) Gecko/20100101 Firefox/35.0" forHTTPHeaderField:@"User-Agent"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html",@"application/javascript",@"application/json", nil];
    
    return manager;
}

-(void)getResultWithParameter:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    urlStr = [[NSMutableString stringWithString:IP] stringByAppendingFormat:@"%@",url];
    [manager GET:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        XYLog(@"url is %@?%@",urlStr,operation);
         successBlock(responseObject);
         
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
         if ([errorStr kr_isNotEmpty]) {
             failureBlock(errorStr);
             
         }
         
     }];
    
    
}

-(void)postResultWithParameter:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    [self postResultWithParameter:parameter url:url isCache:YES successBlock:successBlock failureBlock:failureBlock];
}

/**清除缓存和cookie*/
- (void)cleanCacheAndCookie{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

-(void)postResultWithParameter:(NSDictionary *)parameter url:(NSString *)url isCache: (BOOL)isCache successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    [self postResultWithParameter:parameter url:url isCache:isCache retry:3 successBlock:successBlock failureBlock:failureBlock];
}

-(void)postResultWithParameter:(NSDictionary *)parameter url:(NSString *)url isCache: (BOOL)isCache retry: (int)times successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    
    id cacheData = nil;
//#if RELEASE
    if (isCache) {
        cacheData = [XYNetworkCache.shareInstance getDataWithUrl:url andParams:parameter];
        if (cacheData && times >= 3) {
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                successBlock(cacheData);
            });
        }
    }
//#endif
    
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    urlStr = [[NSMutableString stringWithString:IP] stringByAppendingFormat:@"%@",url];
    @weakify(self)
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        @strongify(self)
        if (responseObject == nil && times > 0) {
            XYLog(@"请求丢失，重新请求，正在重试，倒数%d次...", times);
            [self postResultWithParameter:parameter url:url isCache:isCache retry:times - 1 successBlock:successBlock failureBlock:failureBlock];
            return;
        }
        
        if ([responseObject[@"msg"] containsString:@"用户不存在"]) {
            [self cleanCacheAndCookie];
            [[ALBBSDK sharedInstance]logout];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:XYAccessToken];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:XYUserID];
            [JPUSHService setAlias:@"" callbackSelector:(nil) object:(nil)];
            
            
//            failureBlock(responseObject[@"msg"] );
            if (cacheData == nil)
                successBlock(responseObject);
            return;
        }
        
        if (cacheData == nil)
            successBlock(responseObject);
        
        
        
        //缓存处理
        [XYNetworkCache.shareInstance saveData:responseObject withUrl:url andParams:parameter];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){

        if (error.code == -1009 && cacheData == nil) {
//            if ([[UIApplication sharedApplication].keyWindow isKindOfClass: [FNWindow class]] &&
//                [[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass: [XYTabBarViewController class]]) {
//                
//                [((FNWindow*)[UIApplication sharedApplication].keyWindow) showNetworkError];
//                return;
//            }
        }
        if (times > 0) {
            // 请求丢失，重新请求，重试3次
            XYLog(@"请求超时，重新请求，正在重试，倒数%d次...", times);
            [self postResultWithParameter:parameter url:url isCache:isCache retry:times - 1 successBlock:successBlock failureBlock:failureBlock];
            return;
        }

        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        NSString *errorStr2 = [error localizedDescription];
        if (cacheData == nil && [errorStr kr_isNotEmpty]) {
            failureBlock(errorStr);
        } else if (cacheData == nil && [errorStr2 kr_isNotEmpty]) {
            failureBlock(errorStr2);
        }
        XYLog(@"errorStr is %@",[error localizedDescription]);
        XYLog(@"errorStr is %@",errorStr);

        
        [KVNProgress dismiss];
        [SVProgressHUD dismiss];
//        [FNTipsView showTips:errorStr];
    }];
}

//H5
-(void)withHFUrl:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"H5:%@",urlStr);
//    [manager POST:urlStr parameters:NULL success:^(AFHTTPRequestOperation *operation, id responseObject){
//        successBlock(responseObject);
//        XYLog(@"url is %@?%@",urlStr,operation);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
//        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
//        failureBlock(errorStr);
//        XYLog(@"errorStr is %@",errorStr);
//        [KVNProgress dismiss];
//        //[FNTipsView showTips:errorStr];
//    }];
    [manager GET:urlStr parameters:url success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         XYLog(@"H5 %@?%@",urlStr,operation);
         successBlock(responseObject);
         
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
         if ([errorStr kr_isNotEmpty]) {
             failureBlock(errorStr);
             
         }
         
     }];
}

-(void)upImageWithParameter:(NSDictionary *)parameter imageArray:(NSArray *)images url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    
    AFHTTPRequestOperationManager *manger=[self baseHtppRequest];
    NSString *urlStr=[[NSMutableString stringWithString:IP] stringByAppendingFormat:@"%@",[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
    [manger POST:urlStr parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i=1; i<=images.count; i++) {
            UIImage *image=[UIImage scaleImage:images[i-1] toKb:800];
            
            XYLog(@"image%@",image);
            NSData *imageData=UIImageJPEGRepresentation(image, 0.7);
            
            // 上传的参数名
            NSString * Name =[NSString stringWithFormat:@"img%d",i];
            // 上传filename
            NSString * fileName = [NSString stringWithFormat:@"%@_image%d.png",[NSString GetNowTimes],i];
            [formData appendPartWithFileData:imageData name:Name fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        if ([errorStr kr_isNotEmpty]) {
            failureBlock(errorStr);
            
        }
        
    }];
}
-(void)upImageWithParameter:(NSDictionary *)parameter imageArray:(NSArray *)images imageSize:(CGFloat)size url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    
    AFHTTPRequestOperationManager *manger=[self baseHtppRequest];
    NSString *urlStr=[[NSMutableString stringWithString:IP] stringByAppendingFormat:@"%@",[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
    [manger POST:urlStr parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i=1; i<=images.count; i++) {
            UIImage *image=[UIImage scaleImage:images[i-1] toKb:800];
            NSData *imageData=UIImageJPEGRepresentation(image, size);
            // 上传的参数名
            NSString * Name =[NSString stringWithFormat:@"img%d",i];
            // 上传filename
            NSString * fileName = [NSString stringWithFormat:@"%@_image%d.png",[NSString GetNowTimes],i];
            [formData appendPartWithFileData:imageData name:Name fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        if ([errorStr kr_isNotEmpty]) {
            failureBlock(errorStr);
        }
    }];
}

-(void)upDataWithParameter:(NSDictionary *)parameter data:(NSData *)data withKey: (NSString*)key fileName: (NSString*)fileName url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    
    AFHTTPRequestOperationManager *manger=[self baseHtppRequest];
    NSString *urlStr=[[NSMutableString stringWithString:IP] stringByAppendingFormat:@"%@",[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
    [manger POST:urlStr parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
//        NSData *data= [UIImage scaleData:image toKb:MAX_IMAGE_SIZE];
//        NSString * fileName = [NSString stringWithFormat:@"%@_image.jpg",[NSString GetNowTimes]];
        [formData appendPartWithFileData:data name:key fileName:fileName mimeType:@"file"];
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        if ([errorStr kr_isNotEmpty]) {
            failureBlock(errorStr);
            
        }
        
    }];
}

+ (void)cancelAllRequest {
    [SVProgressHUD dismiss];
    [[AFHTTPRequestOperationManager manager].operationQueue cancelAllOperations];
}


+ (void)queryFail {
    if (kNetworkNotReachability) {
        [KVNProgress showErrorWithStatus:XYErrorCheckNetwork];
    }else {
        [KVNProgress showErrorWithStatus:XYErrorSeverError];
    }
}

+ (void)queryFinishTip:(NSDictionary *)dict {
//    [KVNProgress showErrorWithStatus:[dict objectForKey:XYMessage]];
    if ([[dict objectForKey:XYMessage] isEqualToString:XYOtherLogin]) {
        [[ALBBSDK sharedInstance]logout];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:XYAccessToken];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:XYUserID];
//        NSNotification *notification =[NSNotification notificationWithName:@"RefreshToken" object:nil userInfo:nil];
//        //通过通知中心发送通知
//        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (![UserAccessToken kr_isNotEmpty]) {
                XYTabBarViewController *mainCtrl = [XYTabBarViewController mainViewController];
                [UIApplication sharedApplication].delegate.window.rootViewController = mainCtrl;
            }
        });
        
        
    }else if ([[dict objectForKey:XYMessage] isEqualToString:NoToken]){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (![UserAccessToken kr_isNotEmpty]) {
                XYTabBarViewController *mainCtrl = [XYTabBarViewController mainViewController];
                [UIApplication sharedApplication].delegate.window.rootViewController = mainCtrl;
            }
        });

    }
    
    
    [SVProgressHUD dismiss];
    
}

+ (void)downloadImages: (NSArray<NSString*>*) imageUrls withFinishedBlock:(void (^)(NSArray<UIImage*> *))block{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    NSLock *dictionary_lock = [[NSLock alloc] init];
    if (imageUrls.count>0) {
        for (NSString *imgUrl in imageUrls){
            dispatch_group_enter(group);
            dispatch_async(queue, ^{
                NSString *key = [NSString md5:imgUrl];
                [[SDWebImageManager sharedManager] downloadImageWithURL:URL(imgUrl) options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    if (finished) {
                        [dictionary_lock lock];
                        [dict setObject:image forKey:key];
                        [dictionary_lock unlock];
                        dispatch_group_leave(group);
                    }
                }];
            });
        }
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSString *url in imageUrls) {
            NSString *key = [NSString md5:url];
            UIImage *image = [dict objectForKey:key];
            [array addObject:image];
        }
        if (block) {
            block(array);
        }
    });
}

+ (void)downloadImages:(NSArray<NSString *> *)imageUrls withIndexBlock:(void (^)(UIImage* image, NSInteger index))block failureBlock: (void (^)(NSError* error))failureBlock {
    [XYNetworkAPI downloadImages:imageUrls withIndex:0 withIndexBlock:block failureBlock:failureBlock];
}

+ (void)downloadImages:(NSArray<NSString *> *)imageUrls withIndex: (NSInteger)index withIndexBlock:(void (^)(UIImage* image, NSInteger index))block failureBlock: (void (^)(NSError* error))failureBlock {
    if (index >= imageUrls.count)
        return;
    [[SDWebImageManager sharedManager] downloadImageWithURL:URL(imageUrls[index]) options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (error) {
            failureBlock(error);
            [XYNetworkAPI downloadImages:imageUrls withIndex:index + 1 withIndexBlock:block failureBlock:failureBlock];
            return;
        }
        if (finished) {
            if (block) {
                block(image, index);
            }
            [XYNetworkAPI downloadImages:imageUrls withIndex:index + 1 withIndexBlock:block failureBlock:failureBlock];
        }
    }];
}

-(void)postResultWithThisLocalityParameter:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
//    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
//    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    urlStr = [[NSMutableString stringWithString:@"http://192.168.0.254/fnuoos_dgapp/?"] stringByAppendingFormat:@"%@",url];
//    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject){
//        successBlock(responseObject);
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
//        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
//        NSString *errorStr2 = [error localizedDescription];
//        XYLog(@"errorStr is %@",[error localizedDescription]);
//        XYLog(@"errorStr is %@",errorStr);
//        XYLog(@"errorStr2 is %@",errorStr2);
//        [KVNProgress dismiss];
//        [SVProgressHUD dismiss];
//        [FNTipsView showTips:errorStr];
//    }];
    //urlStr = [[NSMutableString stringWithString:IP] stringByAppendingFormat:@"%@",url];
    [self postResultWithParameter:parameter url:url isCache:NO retry:3 successBlock:successBlock failureBlock:failureBlock];
}
@end


