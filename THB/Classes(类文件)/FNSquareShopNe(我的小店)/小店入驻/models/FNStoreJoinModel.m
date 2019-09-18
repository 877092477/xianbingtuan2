//
//  FNStoreJoinModel.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/19.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreJoinModel.h"

@implementation FNStoreJoinItemModel

@end

@implementation FNStoreJoinModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"introducts":[FNStoreJoinItemModel class]
             };
}

@end

@implementation FNStoreJoinFormModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"cate":[FNStoreJoinCateModel class]
             };
}

@end
