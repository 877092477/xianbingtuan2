//
//  FNBargainGoodsModel.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNBargainGoodsModel.h"

@implementation FNBargainGoodsButtonModel

@end

@implementation FNBargainGoodsShareModel

@end

@implementation FNBargainGoodsModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"imgArr":[NSString class],
             @"detailArr": [NSString class],
             @"btn_list": [FNBargainGoodsButtonModel class],
             @"share_list": [FNBargainGoodsShareModel class]};
}

@end
