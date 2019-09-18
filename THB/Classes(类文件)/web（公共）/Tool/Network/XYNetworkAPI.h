//
//  XYNetworkAPI.h
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

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "XYTabBarViewController.h"
#import "LoginViewController.h"
#import "XYNavigationController.h"


//请求超时
#define TIMEOUT 30

typedef void(^SuccessBlock)(id responseBody);

typedef void(^FailureBlock)(NSString *error);

@interface XYNetworkAPI : NSObject
{
    XYTabBarViewController *rootViewController;
}
@property (strong, nonatomic) UIWindow *window;

/**
 *  检查是否有网络(废弃)
 *
 *  @return
 */
+ (BOOL)isExistenceNetwork;

+(XYNetworkAPI *)sharedManager;
-(AFHTTPRequestOperationManager *)baseHtppRequest;

#pragma mark - GET
-(void)getResultWithParameter:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark - POST

/**
 发送post请求（默认自动缓存）

 @param parameter 参数
 @param url 地址
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
-(void)postResultWithParameter:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;


/**
 发送post请求

 @param parameter 参数
 @param url 地址
 @param isCache 是否读取缓存
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
-(void)postResultWithParameter:(NSDictionary *)parameter url:(NSString *)url isCache: (BOOL)isCache successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark - AFN上传照片
-(void)upImageWithParameter:(NSDictionary *)parameter imageArray:(NSArray *)images url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
/**
 发送post请求
 @param parameter 参数
 @param images  图片数组
 @param size 单张图片大小比例
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
-(void)upImageWithParameter:(NSDictionary *)parameter imageArray:(NSArray *)images imageSize:(CGFloat)size url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

-(void)upDataWithParameter:(NSDictionary *)parameter data:(NSData *)data withKey: (NSString*)key fileName: (NSString*)fileName url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

+ (void)cancelAllRequest;
+ (void)queryFail;
+ (void)queryFinishTip:(NSDictionary *)dict;

#pragma mark - 测试H5
-(void)withHFUrl:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;


/**
 批量下载图片

 @param imageUrls 图片url列表
 @param block UIImage数组
 */
+ (void)downloadImages: (NSArray<NSString*>*) imageUrls withFinishedBlock:(void (^)(NSArray<UIImage*> *))block;


/**
 批量顺序下载图片

 @param imageUrls 图片url列表
 @param block 第index张图片下载成功回调
 @param failureBlock 失败回调
 */
+ (void)downloadImages:(NSArray<NSString *> *)imageUrls withIndexBlock:(void (^)(UIImage* image, NSInteger index))block failureBlock: (void (^)(NSError* error))failureBlock;
/**
  获取本地数据
 */
-(void)postResultWithThisLocalityParameter:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
@end
