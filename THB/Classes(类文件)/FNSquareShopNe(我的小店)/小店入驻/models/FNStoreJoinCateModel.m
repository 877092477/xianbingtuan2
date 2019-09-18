//
//  FNStoreJoinCateModel.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/19.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreJoinCateModel.h"

@implementation FNStoreJoinTagModel

@end

@implementation FNStoreJoinCateModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"label":[FNStoreJoinTagModel class]
             };
}

@end
