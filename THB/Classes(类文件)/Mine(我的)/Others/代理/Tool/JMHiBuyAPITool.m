//
//  JMHiBuyAPITool.m
//  THB
//
//  Created by jimmy on 2017/3/29.
//  Copyright © 2017年 方诺科技. All rights reserved.
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
#import "JMHiBuyAPITool.h"


#import "JMMemberDisplayModel.h"
#import "JMHiBuyHomeADModel.h"

#define JMHiBuyHomeADURL @"mod=default&act=api&ctrl=midcategorynav"
#define JMHiBuyUpgradeURL @"mod=appapi&act=dg_vip&ctrl=upgrade"
#define JMHiBuyUpgradeActionURL @"mod=appapi&act=dg_payment&ctrl=vipRecharge"
#define JMHiBuyMineBillURL @"mod=gh&act=ghdy&ctrl=szDetail"
//1.9 嗨代言
#define JMHiBuyShareURL @"mod=gh&act=dyshare&ctrl=index"
//1.10嗨代言介绍图
#define JMHiBuyHiImage @"mod=gh&act=ghdy&ctrl=index"
#define JMHiBuyHiLogin @"mod=gh&act=ghdy&ctrl=login"
@implementation JMHiBuyAPITool
+ (void)apiHiBuyForHomeADWithParams:(NSMutableDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure{
    params[TimeKey] = [NSString GetNowTimes];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    JMHiBuyAPITool *tool = [JMHiBuyAPITool requestWithParams:params andURL:JMHiBuyHomeADURL];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        if (respondsObject && [NSString checkIsSuccess:respondsObject[SuccessKey] andElement:SuccessValue ]) {
            NSArray* datas = respondsObject[DataKey];
            NSMutableArray* results = [NSMutableArray new];
            if (datas.count > 0) {
                [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    JMHiBuyHomeADModel* model = [JMHiBuyHomeADModel mj_objectWithKeyValues:obj];
                    [results addObject:model];
                }];
            }
            success(results);
        } else {
            if (failure) {
                failure(respondsObject[MsgKey]);
            }
        }
    } failure:^(NSString *error) {
        //        if (failure) {
        //            failure(error);
        //        }
    }];
    
}

+ (void)apiHiBuyForUpgradeMemberWithParams:(NSMutableDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure{

    JMHiBuyAPITool *tool = [JMHiBuyAPITool requestWithParams:params andURL:JMHiBuyUpgradeURL];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        if (respondsObject && [NSString checkIsSuccess:respondsObject[SuccessKey] andElement:SuccessValue ]) {
            NSDictionary* datas = respondsObject[DataKey];
            JMMemberDisplayModel* model = [JMMemberDisplayModel mj_objectWithKeyValues:datas];
            success(model);
        } else {
            if (failure) {
                failure(respondsObject[MsgKey]);
            }
        }
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)apiHiBuyForUpgradeMemberOperatingWithParams:(NSMutableDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure{

    JMHiBuyAPITool *tool = [JMHiBuyAPITool requestWithParams:params andURL:JMHiBuyUpgradeActionURL];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        if (respondsObject && [NSString checkIsSuccess:respondsObject[SuccessKey] andElement:SuccessValue ]) {
            NSDictionary* datas = respondsObject[DataKey];
            success(datas[@"code"]);
        } else {
            if (failure) {
                failure(respondsObject[MsgKey]);
            }
        }
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)apiHiBuyForHiImageWithParams:(NSMutableDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure{

    JMHiBuyAPITool *tool = [JMHiBuyAPITool requestWithParams:params andURL:JMHiBuyHiImage];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        if (respondsObject && [NSString checkIsSuccess:respondsObject[SuccessKey] andElement:SuccessValue ]) {
            success(respondsObject[DataKey]);
        } else {
            if (failure) {
                failure(respondsObject[MsgKey]);
            }
        }
    } failure:^(NSString *error) {
        //        if (failure) {
        //            failure(error);
        //        }
    }];
}


+ (void)apiHiBuyForLoginWithCodeWithParams:(NSMutableDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure{

    JMHiBuyAPITool *tool = [JMHiBuyAPITool requestWithParams:params andURL:JMHiBuyHiLogin];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        if (respondsObject && [NSString checkIsSuccess:respondsObject[SuccessKey] andElement:SuccessValue ]) {
            NSDictionary* datas = respondsObject[DataKey];
            [[NSUserDefaults  standardUserDefaults] setObject:datas[@"token"] forKey:XYAccessToken];
            success(SuccessValue);
        } else {
            if (failure) {
                failure(respondsObject[MsgKey]);
            }
        }
    } failure:^(NSString *error) {
        //        if (failure) {
        //            failure(error);
        //        }
    }];
}

@end
