//
//  FNFreeProductDetailModel.m
//  THB
//
//  Created by Weller on 2018/12/19.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNFreeProductDetailModel.h"
@implementation FNFreeProductDetailRuleModel

@end

@implementation FNFreeProductDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"act_rule":[FNFreeProductDetailRuleModel class],
             @"imgArr":[NSString class]};
}

@end
