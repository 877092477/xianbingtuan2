//
//  FNStoreGoodsDetailModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/27.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNstoreInformationDaModel.h"
#import "FNStoreGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNStoreGoodsDetailModel : FNStoreGoodsModel

@property (nonatomic, copy) NSString *cart_goods;


@property (nonatomic, copy) NSString *store_name;
@property (nonatomic, copy) NSString *distance_str;
@property (nonatomic, copy) NSString *map_icon;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, copy) NSString *discount_time;

@property (nonatomic, strong) NSDictionary *fxz;
@property (nonatomic, strong) NSDictionary *zgz;
@property (nonatomic, strong) NSDictionary *sjz;

@property(nonatomic, strong) NSArray<FNstoreCouponeModel*> *yhq_list;

@end

NS_ASSUME_NONNULL_END
