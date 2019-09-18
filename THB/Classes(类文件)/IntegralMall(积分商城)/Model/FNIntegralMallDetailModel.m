//
//  FNIntegralMallDetailModel.m
//  THB
//
//  Created by Weller Zhao on 2019/1/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNIntegralMallDetailModel.h"

@implementation FNIntegralMallDetailAtrrSectionModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"attr_val":[FNIntegralMallDetailAtrrDataModel class]};
}

@end

@implementation FNIntegralMallDetailAtrrDataModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

@end
@implementation FNIntegralMallDetailLabelModel

@end

@implementation FNIntegralMallDetailModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"attr_data":[FNIntegralMallDetailAtrrSectionModel class],
             @"detail_label":[FNIntegralMallDetailLabelModel class],
             @"goods_type":[NSString class],
             @"banner_img":[NSString class],
             @"detail_img":[NSString class]
             };
}
@end
