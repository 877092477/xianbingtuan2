//
//  FNSeckillDataRequestTool.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/11/14.
//  Copyright © 2016年 方诺科技. All rights reserved.
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

#import "FNSeckillDataRequestTool.h"
#import "FNSeckillHomeModel.h"
#import "FNHSecKillProudctModel.h"
#import "JMHiBuySeckillModel.h"
@implementation FNSeckillDataRequestTool

+ (void)secKillRequestForHomeWithParams:(NSMutableDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure isHiddenTips:(BOOL)isHidden{
    FNSeckillDataRequestTool *tool = [FNSeckillDataRequestTool requestWithParams:params andURL:_api_home_seckillhome];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
            NSDictionary *dict = respondsObject[DataKey];
            FNSeckillHomeModel* model = [FNSeckillHomeModel mj_objectWithKeyValues:dict];
            success(model);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:isHidden];
}
+ (void)secKillRequestForProductsWithParams:(NSMutableDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure isHiddenTips:(BOOL)isHidden{
    
    FNSeckillDataRequestTool *tool = [FNSeckillDataRequestTool requestWithParams:params andURL:_api_home_seckilpro];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        NSNumber *number = params[@"is_index"];
        if (number.integerValue == 0) {
            NSArray *data = respondsObject[DataKey];
            NSMutableArray *results = [NSMutableArray new];
            if (data &&data.count > 0) {
                [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [results addObject:[FNHSecKillProudctModel mj_objectWithKeyValues:obj]];
                }];
            }
            success(results);
        }else{
            NSDictionary *data = respondsObject[DataKey];
            JMHiBuySeckillModel*model = [JMHiBuySeckillModel mj_objectWithKeyValues:data];
            success(model);
        }

    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:isHidden];

}



@end
