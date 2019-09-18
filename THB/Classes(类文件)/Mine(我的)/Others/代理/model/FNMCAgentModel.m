//
//  FNMCAgentModel.m
//  THB
//
//  Created by jimmy on 2017/8/1.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNMCAgentModel.h"

@implementation FNMCAgentModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"today_yes":[FNMCAgentTYModel class]};
}
@end
@implementation FNMCAgentTYModel



@end
