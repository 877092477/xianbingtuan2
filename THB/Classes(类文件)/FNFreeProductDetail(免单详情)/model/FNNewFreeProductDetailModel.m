//
//  FNNewFreeProductDetailModel.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNNewFreeProductDetailModel.h"

@implementation FNNewFreeProductDetailShareModel

@end

@implementation FNNewFreeProductDetailButtonModel

@end

@implementation FNNewFreeProductDetailModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"btn_list":[FNNewFreeProductDetailButtonModel class],
             @"share_list":[FNNewFreeProductDetailShareModel class],
             @"detailArr":[NSString class],
             @"imgArr":[NSString class]};
}

@end
