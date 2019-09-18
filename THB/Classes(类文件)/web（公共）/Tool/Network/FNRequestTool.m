//
//  FNRequestTool.m
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

#import "FNRequestTool.h"
#import "XYNetworkAPI.h"
@implementation FNRequestTool


+ (instancetype)requestWithParams:(NSMutableDictionary *)params andURL:(NSString *)url{
    if (params ==nil) {
        params = [NSMutableDictionary new];
    }
    
    params[TimeKey] = [NSString GetNowTimes];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    FNRequestTool *request = [FNRequestTool new];
    request.params = params;
    request.url = url;
    return request;
}

- (void)startRequestWithCompletionBlockWithSuccess:(RequestSuccess)success failure:(RequestFailure)failure isHideTips:(BOOL)isHide {
    [self startRequestWithCompletionBlockWithSuccess:success failure:failure isHideTips:isHide isCache: YES];
}

- (void)startRequestWithCompletionBlockWithSuccess:(RequestSuccess)success failure:(RequestFailure)failure isHideTips:(BOOL)isHide isCache: (BOOL)isCache {
       XYLog(@"+++++++++params is :%@++++++", self.params);
    [[XYNetworkAPI sharedManager] postResultWithParameter:self.params url:self.url isCache: isCache successBlock:^(id responseBody) {
        
        if (responseBody && [NSString checkIsSuccess:responseBody[SuccessKey] andElement:SuccessValue]) {
            success(responseBody);
        }else{
            if (!isHide) {
                [SVProgressHUD dismiss];
                if ([responseBody[MsgKey] kr_isNotEmpty]) {
                    [FNTipsView showTips:responseBody[MsgKey]];

                }
                
            }
          
            failure(responseBody[MsgKey]);
        }
        if (self.CompleteBlock) {
            self.CompleteBlock(nil);
        }
        
    } failureBlock:^(NSString *error) {
//        @strongify(self)
        XYLog(@"+++++++++error is :%@++++++", error);
        failure(error);
        if (!isHide) {
            [SVProgressHUD dismiss];
            [FNTipsView showTips:FNFailureRequest];
        }
        if (self.CompleteBlock) {
            self.CompleteBlock(error);
        }
    }];

}

+ (void)startWithRequests:(NSArray<FNRequestTool *> *)requests withFinishedBlock:(void (^)(NSArray *))block{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    NSMutableArray* errors = [NSMutableArray new];
    if (requests.count>0) {
        [requests enumerateObjectsUsingBlock:^(FNRequestTool * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            dispatch_group_enter(group);
            dispatch_async(queue, ^{
                obj.CompleteBlock = ^(NSString *error) {
                    if (error) {
                        [errors addObject:error];
                    }else{
                        [errors addObject:@""];
                    }
                    dispatch_group_leave(group);
                };
            });
        }];
    }
   dispatch_group_notify(group, dispatch_get_main_queue(), ^{
       
       if (block) {
           block(errors);
       }
   });
}
- (void)startRequestWithCompletionBlockWithSuccess:(RequestSuccess)success failure:(RequestFailure)failure{
    [self startRequestWithCompletionBlockWithSuccess:success failure:failure isCache:YES];
}


- (void)startRequestWithCompletionBlockWithSuccess:(RequestSuccess)success failure:(RequestFailure)failure isCache: (BOOL) isCache{
    [[XYNetworkAPI sharedManager] postResultWithParameter:self.params url:self.url isCache: isCache successBlock:^(id responseBody) {
        success(responseBody);
        XYLog(@"+++++++++JSON is :%@++++++", FNGetJSON(responseBody));
    } failureBlock:^(NSString *error) {
        failure(error);
        [SVProgressHUD dismiss];
        [FNTipsView showTips:FNFailureRequest];
    }];
    
}
-(void)uploadPicturesWithCompletionWithimage:(NSArray*)imageS WithSuccess:(RequestSuccess)success failure:(RequestFailure)failure{
    
    [[XYNetworkAPI sharedManager]upImageWithParameter:self.params imageArray:imageS url:self.url successBlock:^(id responseBody) {
        success(responseBody);
    } failureBlock:^(NSString *error) {
        failure(error);
        [SVProgressHUD dismiss];
        [FNTipsView showTips:FNFailureRequest];
        
    }];
}

-(void)uploadData:(NSData*)data withKey: (NSString*)key fileName: (NSString*)fileName success:(RequestSuccess)success failure:(RequestFailure)failure{
    [[XYNetworkAPI sharedManager] upDataWithParameter:self.params data:data withKey:key fileName:fileName url:self.url successBlock:^(id responseBody) {
        success(responseBody);
    } failureBlock:^(NSString *error) {
        failure(error);
        [SVProgressHUD dismiss];
        [FNTipsView showTips:FNFailureRequest];
    }];
}

//上传图片
+ (FNRequestTool *)uploadImageWithParams:(NSMutableDictionary *)params api:(NSString*)api  imageS:(NSArray*)images  success:(RequestSuccess)success failure:(RequestFailure)failure{
    FNRequestTool *request = [FNRequestTool requestWithParams:params andURL:api];
 
    [request uploadPicturesWithCompletionWithimage:images WithSuccess:^(id respondsObject) {
         success(respondsObject);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    return request;
}

+ (FNRequestTool *)uploadDataWithParams:(NSMutableDictionary *)params api:(NSString*)api  data:(NSData*)data withKey: (NSString*)key fileName: (NSString*)fileName success:(RequestSuccess)success failure:(RequestFailure)failure {
    FNRequestTool *request = [FNRequestTool requestWithParams:params andURL:api];

    [request uploadData:data withKey:key fileName:fileName success:^(id respondsObject) {
        success(respondsObject);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    return request;
}
+ (FNRequestTool *)requestWithParams:(NSMutableDictionary *)params api:(NSString*)api respondType:(ResponseType)type modelType:(NSString*)modelTyep success:(RequestSuccess)success failure:(RequestFailure)failure isHideTips:(BOOL)isHide {
    return [FNRequestTool requestWithParams:params api:api respondType:type modelType:modelTyep success:success failure:failure isHideTips:isHide isCache:YES];
}

+ (FNRequestTool *)requestWithParams:(NSMutableDictionary *)params api:(NSString*)api respondType:(ResponseType)type modelType:(NSString*)modelTyep success:(RequestSuccess)success failure:(RequestFailure)failure isHideTips:(BOOL)isHide isCache: (BOOL)isCache{
    FNRequestTool *request = [FNRequestTool requestWithParams:params andURL:api];
    [request startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        switch (type) {
            case ResponseTypeNone:
            {
                success(respondsObject);
                break;
            }
            case ResponseTypeArray:{
                NSMutableArray* result = [NSMutableArray new];
                NSArray* array = respondsObject[DataKey];
                if (array.count>0) {
                    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [result addObject:[NSClassFromString(modelTyep) mj_objectWithKeyValues:obj]];
                    }];
                }
                success(result);
                break;
            }
            case ResponseTypeModel:{
                NSDictionary* dict = respondsObject[DataKey];
                success([NSClassFromString(modelTyep) mj_objectWithKeyValues:dict]);
                break;
            }
            case ResponseTypeDataKey:{
                success(respondsObject[DataKey]);
                break;
            }
            default:
                break;
        }
        
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:isHide isCache:isCache];
    
    return request;
}
@end
