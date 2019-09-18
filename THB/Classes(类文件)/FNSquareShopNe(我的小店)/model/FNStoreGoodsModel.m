//
//  FNStoreGoodsModel.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/24.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsModel.h"

@implementation FNStoreGoodsSpecDataModel

@end

@implementation FNStoreGoodsSpecModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data":[FNStoreGoodsSpecDataModel class]};
}
@end

@implementation FNStoreGoodsAttributeDataModel
@end

@implementation FNStoreGoodsAttributeModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data":[FNStoreGoodsAttributeDataModel class]};
}

@end

@implementation FNStoreGoodsModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"attribute":[FNStoreGoodsAttributeModel class]};
}

@end
