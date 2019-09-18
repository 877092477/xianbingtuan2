//
//  FNAPIMine.m
//  THB
//
//  Created by jimmy on 2017/5/22.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNAPIMine.h"
#import "JMInviteFriendModel.h"
#import "JMMineBillModel.h"
#import "FNMineFunctionModel.h"
@implementation FNAPIMine
+ (FNAPIMine *)apiMineForGetCodeWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    FNAPIMine *tool = [FNAPIMine requestWithParams:params andURL:_api_mine_getcode];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {

        success(SuccessValue);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return  tool;
}

+ (FNAPIMine *)apiMineForCheckCodeWithParams:(NSMutableDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    FNAPIMine *tool = [FNAPIMine requestWithParams:params andURL:_api_mine_checkcode];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        
        success(SuccessValue);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return  tool;
}
+ (FNAPIMine *)apiMineRequestInvitedTestWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    FNAPIMine *tool = [FNAPIMine requestWithParams:params andURL:_home_api_invitedText];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        
        NSDictionary* data =respondsObject[DataKey];
        if ([data isKindOfClass:[NSDictionary class]]) {
            NSArray* keys =data.allKeys;
            if (keys.count > 0 ) {
                success(data[@"str"]);
            }else{
                success(@"");
            }
        }else{
            success(@"");
        }

    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return  tool;
}
+ (FNAPIMine *)apiMineRequestFriendsInvitedWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    FNAPIMine *tool = [FNAPIMine requestWithParams:params andURL:_home_api_invitefriend];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        
        JMInviteFriendModel*model = [JMInviteFriendModel mj_objectWithKeyValues:respondsObject[DataKey]];
        success(model);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return  tool;
}

+ (FNAPIMine *)apiMineApiForMineBillWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    FNAPIMine *tool = [FNAPIMine requestWithParams:params andURL:_api_mine_bill];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        NSArray* datas = respondsObject[DataKey];
        NSMutableArray* results = [NSMutableArray new];
        if (datas.count > 0) {
            [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                JMMineBillModel* model = [JMMineBillModel mj_objectWithKeyValues:obj];
                [results addObject:model];
            }];
        }
        success(results);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return  tool;
}

+ (FNAPIMine *)apiMineApiForMineFunctionsWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    FNAPIMine *tool = [FNAPIMine requestWithParams:params andURL:_api_mine_functions];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        NSArray* datas = respondsObject[DataKey];
        NSMutableArray* results = [NSMutableArray new];
        if (datas.count > 0) {
            [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNMineFunctionModel* model = [FNMineFunctionModel mj_objectWithKeyValues:obj];
                [results addObject:model];
            }];
        }
        success(results);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return  tool;
}
@end
