//
//  FNMyVideoCardModel.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/30.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMyVideoCardModel.h"

@implementation FNMyVideoCardModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id",
             @"img_copy": @"copy_img",
             @"str_copy": @"copy_str",
             @"color_copy": @"copy_color"
             };
}

@end
