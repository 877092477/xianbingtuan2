//
//  FNVideoCardUseModel.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNVideoCardUseModel.h"

@implementation FNVideoCardUseRuleModel

@end


@implementation FNVideoCardUseModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"rule":[FNVideoCardUseRuleModel class]};
}

@end
