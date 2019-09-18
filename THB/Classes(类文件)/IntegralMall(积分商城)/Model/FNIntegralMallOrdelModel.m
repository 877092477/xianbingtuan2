//
//  FNIntegralMallOrdelModel.m
//  THB
//
//  Created by Weller Zhao on 2019/1/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNIntegralMallOrdelModel.h"

@implementation FNIntegralMallOrdelAddressModel

@end

@implementation FNIntegralMallOrdelGoodsModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end

@implementation FNIntegralMallOrdelPayModel

@end

@implementation FNIntegralMallOrdelMsgModel

@end

@implementation FNIntegralMallOrdelModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"msg":[FNIntegralMallOrdelMsgModel class],
             @"alipay_type":[FNIntegralMallOrdelPayModel class]
             };
}

@end
