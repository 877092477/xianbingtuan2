//
//  FNNewConnectionMemModel.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/6/10.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNNewConnectionMemModel.h"

@implementation FNNewConnectionMemCommissionModel

@end

@implementation FNNewConnectionMemModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"commission_arr":[FNNewConnectionMemCommissionModel class]};
}

@end
