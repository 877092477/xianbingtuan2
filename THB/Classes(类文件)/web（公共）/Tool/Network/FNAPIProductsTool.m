//
//  FNAPIProductsTool.m
//  LikeKaGou
//
//  Created by jimmy on 16/10/12.
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

#import "FNAPIProductsTool.h"
#import "FNProductDetailModel.h"
#import "FNCouponListModel.h"
@implementation FNAPIProductsTool
+ (void)apiProductsRequestProdetailWithGoodsId:(NSString *)goodId success:(SuccessRequest)success failure:(FailureRequest)failure{
    FNAPIProductsTool *tool = [ FNAPIProductsTool new];
    tool.apiURL = FNAPIProductOpDetail;
    tool.gid = goodId;
    [tool startRequestSuccess:^(id respondObject) {
    
        if (respondObject && [respondObject[SuccessKey] isEqualToString:SuccessValue]) {
            FNProductDetailModel *model = [FNProductDetailModel mj_objectWithKeyValues:respondObject[DataKey]];
            success(model);
        }else {
            success(respondObject[MsgKey]);
        }
    } failure:^(NSString *error) {
        failure(error);
    }];
}
+ (void)apiProductsRequestCouponListWithParams:(NSMutableDictionary *)params success:(SuccessRequest)success failure:(FailureRequest)failure{
    FNAPIProductsTool *tool = [ FNAPIProductsTool new];
    [tool setValuesForKeysWithDictionary:params];
    tool.apiURL = _api_coupon_yhq_goodslist;
    [SVProgressHUD show];

    [tool startRequestSuccess:^(id respondObject) {
        
        if (respondObject && [respondObject[SuccessKey] isEqualToString:SuccessValue]) {
            NSDictionary *data = respondObject[DataKey];
            FNCouponListModel *model = [FNCouponListModel mj_objectWithKeyValues:data];
            success(model);
            [SVProgressHUD dismiss];

        }else {
            success(respondObject[MsgKey]);
            [SVProgressHUD dismiss];

        }
    } failure:^(NSString *error) {
        failure(error);
    }];
}
@end
