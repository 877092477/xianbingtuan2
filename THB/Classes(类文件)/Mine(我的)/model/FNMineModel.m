//
//  FNMineModel.m
//  THB
//
//  Created by Weller Zhao on 2018/12/27.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNMineModel.h"

@implementation FNMineModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[FNMineDataModel class]};
}

@end

@implementation FNMineIncomeModel



@end

@implementation FNMineDataModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"income_list":[FNMineIncomeModel class]};
}

@end
