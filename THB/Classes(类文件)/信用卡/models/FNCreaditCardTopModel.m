//
//  FNCreaditCardTopModel.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/21.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNCreaditCardTopModel.h"

@implementation FNCreaditCardTopIconModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

@end

@implementation FNCreaditCardTopModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[FNCreaditCardTopIconModel class]};
}


@end
