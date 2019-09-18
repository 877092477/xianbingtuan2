//
//  FNPromotionalTeamModel.m
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPromotionalTeamModel.h"

@implementation FNPromotionalTeamModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"fan":[PTMfan class]};
}
@end

@implementation PTMfan
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end;
