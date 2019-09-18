//
//  FNProfitStatisticsModel.m
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNProfitStatisticsModel.h"

@implementation FNProfitStatisticsModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"today_yes":[PStoday_yes class]};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end

@implementation PStoday_yes
@end
