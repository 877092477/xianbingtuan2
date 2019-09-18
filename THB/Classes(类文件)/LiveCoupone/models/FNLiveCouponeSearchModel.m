//
//  FNLiveCouponeSearchModel.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveCouponeSearchModel.h"

@implementation FNLiveCouponeSearchHotModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

@end

@implementation FNLiveCouponeSearchModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"str_copy":@"copy_str"};
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"search_list":[FNLiveCouponeSearchHotModel class]};
}

@end
