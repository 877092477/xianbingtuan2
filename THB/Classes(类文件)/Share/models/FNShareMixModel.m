//
//  FNShareMixModel.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/4.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNShareMixModel.h"

@implementation FNShareMixButtonModel


@end

@implementation FNShareMixModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"str_copy":@"copy_str",
             @"color_copy":@"copy_color",
             @"bjcolor_copy":@"copy_bjcolor"
             };
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"share_list":[FNShareMixButtonModel class],
             @"img_list":[NSString class],
             };
}

@end
