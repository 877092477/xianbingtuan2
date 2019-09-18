//
//  FNUpgradeModel.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/17.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNUpgradeModel.h"

@implementation FNUpgradeTopModel

@end

@implementation FNUpgradeDataModel

@end

@implementation FNUpgradeModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[FNUpgradeDataModel class]};
}
@end

@implementation FNUpgradeCateModel

@end
