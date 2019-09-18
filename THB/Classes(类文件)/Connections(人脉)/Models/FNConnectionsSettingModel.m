//
//  FNConnectionsSettingModel.m
//  THB
//
//  Created by Weller Zhao on 2019/3/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsSettingModel.h"

@implementation FNConnectionsSettingModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[FNConnectionsGroupModel class]};
}

@end
