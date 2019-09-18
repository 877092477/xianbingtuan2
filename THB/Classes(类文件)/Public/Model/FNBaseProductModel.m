//
//  FNBaseProductModel.m
//  LikeKaGou
//
//  Created by jimmy on 16/9/29.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "FNBaseProductModel.h"

@implementation FNBaseProductModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id",@"n_icon":@"new_icon"};
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"imgArr":[NSString class]
             };
}

@end
