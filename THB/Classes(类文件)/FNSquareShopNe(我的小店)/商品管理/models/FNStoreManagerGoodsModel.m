//
//  FNStoreManagerGoodsModel.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/9.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreManagerGoodsModel.h"

@implementation FNStoreManagerGoodsAttriModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data":[NSString class]};
}
@end

@implementation FNStoreManagerGoodsModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"attribute":[FNStoreManagerGoodsAttriModel class]};
}
@end

@implementation FNStoreManagerCateModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"goods":[FNStoreManagerGoodsModel class]
             };
}
@end
