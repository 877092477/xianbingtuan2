//
//  FNStoreGoodsSpecManagerModel.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsSpecManagerModel.h"

@implementation FNStoreGoodsSpecManagerModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[FNStoreGoodsSpecDataModel class]
             };
}
@end
