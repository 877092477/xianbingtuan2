//
//  FNRequestTool.h
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/8/27.
//  Copyright © 2016年 jimmy. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    ResponseTypeNone = 0,
    ResponseTypeArray,
    ResponseTypeModel,
    ResponseTypeDataKey,
} ResponseType;
/**
 *  成功回调block
 *
 *  @param respondsObject 回调数据
 */
typedef void(^RequestSuccess)(id respondsObject);
/**
 *  请求失败回调block
 *
 *  @param error 回调错误信息
 */
typedef void(^RequestFailure)(NSString *error);
@interface FNRequestTool : NSObject
@property (nonatomic, strong)NSDictionary* params;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, assign)NSInteger cacheTimeInSeconds;
@property (nonatomic, strong)void (^CompleteBlock)(NSString* error);
+ (instancetype)requestWithParams:(NSMutableDictionary *)params andURL:(NSString *)url;
- (void)startRequestWithCompletionBlockWithSuccess:(RequestSuccess)success failure:(RequestFailure)failure isHideTips:(BOOL)isHide;

/**
 发起请求

 @param success 成功回调
 @param failure 失败回调
 @param isHide 是否隐藏错误提示
 @param isCache 是否显示缓存
 */
- (void)startRequestWithCompletionBlockWithSuccess:(RequestSuccess)success failure:(RequestFailure)failure isHideTips:(BOOL)isHide isCache: (BOOL)isCache;

/**
 多个请求同时进行

 @param requests 请求
 @param block 请求完成回调
 */
+ (void)startWithRequests:(NSArray<FNRequestTool *>*)requests withFinishedBlock:(void (^)(NSArray *erros))block;

- (void)startRequestWithCompletionBlockWithSuccess:(RequestSuccess)success failure:(RequestFailure)failure;


/**
 Post 请求
 
 @param params 请求参数（内部已有time sign,所以只有time sign时可以直接传nil）
 @param api 请求副链接
 @param type 请求响应JSON ，再分解类型（详见ResponseType枚举）
 @param modelTyep model类名
 @param success 成功回调
 @param failure 失败请求
 @param isHide 多个请求时使用，用于隐藏和显示加等候加载view,单个请求传NO,多个传yes
 @param isCache 是否读取缓存
 @return request instance
 */
+ (FNRequestTool *)requestWithParams:(NSMutableDictionary *)params api:(NSString*)api respondType:(ResponseType)type modelType:(NSString*)modelTyep success:(RequestSuccess)success failure:(RequestFailure)failure isHideTips:(BOOL)isHide;

+ (FNRequestTool *)requestWithParams:(NSMutableDictionary *)params api:(NSString*)api respondType:(ResponseType)type modelType:(NSString*)modelTyep success:(RequestSuccess)success failure:(RequestFailure)failure isHideTips:(BOOL)isHide isCache: (BOOL)isCache;

/**
 上传多张图片
 
 @param params 请求参数（内部已有time sign,所以只有time sign时可以直接传nil）
 @param api 请求副链接
 @param images  UIImage数组
 @param success 成功回调
 @param failure 失败请求
 @return request instance
 */
+ (FNRequestTool *)uploadImageWithParams:(NSMutableDictionary *)params api:(NSString*)api  imageS:(NSArray*)images  success:(RequestSuccess)success failure:(RequestFailure)failure;

+ (FNRequestTool *)uploadImageWithParams:(NSMutableDictionary *)params api:(NSString*)api  imageDict:(NSDictionary*)images  success:(RequestSuccess)success failure:(RequestFailure)failure;

+ (FNRequestTool *)uploadDataWithParams:(NSMutableDictionary *)params api:(NSString*)api  data:(NSData*)data withKey: (NSString*)key fileName: (NSString*)fileName success:(RequestSuccess)success failure:(RequestFailure)failure;
@end
