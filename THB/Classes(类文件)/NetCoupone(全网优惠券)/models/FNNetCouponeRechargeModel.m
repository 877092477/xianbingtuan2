//
//  FNNetCouponeRechargeModel.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNetCouponeRechargeModel.h"

@implementation FNNetCouponeRechargeCardModel

@end

@implementation FNNetCouponeRechargePayModel

@end

@implementation FNNetCouponeRechargeModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"card_list":[FNNetCouponeRechargeCardModel class],
             @"pay_list":[FNNetCouponeRechargePayModel class]
             };
}

@end
