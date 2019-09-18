//
//  FNVideoMarketingModel.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNVideoMarketingModel.h"

@implementation FNVideoMarketingItemModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

@end

@implementation FNVideoMarketingModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[FNVideoMarketingItemModel class]};
}

@end
