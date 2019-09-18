//
//  FNMCAgentApplyShowModel.m
//  THB
//
//  Created by jimmy on 2017/8/1.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNMCAgentApplyShowModel.h"

@implementation FNMCAgentApplyShowModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"dl_list":[FNAgentListModel class]};
}
@end
@implementation FNAgentListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end
