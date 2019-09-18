//
//  FNStoreGoodsDetailModel.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/27.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsDetailModel.h"

@implementation FNStoreGoodsDetailModel

+ (NSDictionary *)mj_objectClassInArray{
//    NSMutableDictionary *dict = [NSMutableDictionary alloc] initWithD
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[FNStoreGoodsModel mj_objectClassInArray]];
    dict[@"yhq_list"] = [FNstoreCouponeModel class];
    return dict;
}

@end
