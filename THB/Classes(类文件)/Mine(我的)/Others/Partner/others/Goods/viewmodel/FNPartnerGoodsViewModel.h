//
//  FNPartnerGoodsViewModel.h
//  SuperMode
//
//  Created by jimmy on 2017/10/19.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMViewModel.h"
#import "FNCategoryModel.h"
#import "FNPartnerGoodsModel.h"
@interface FNPartnerGoodsViewModel : JMViewModel
@property (nonatomic, strong)NSMutableArray<FNPartnerGoodsModel *>* products;
/**
 *  cateNames
 */
@property (nonatomic, strong)NSMutableArray* cateNames;
/**
 *  categories
 */
@property (nonatomic, strong)NSArray<FNCategoryModel *>* categories;
/**
 *  category id
 */
@property (nonatomic, copy)NSString* cid;
/**
 *  keyword
 */
@property (nonatomic, copy)NSString* keyword;
/**
 *  最小价格(筛选条件)
 */
@property (nonatomic, copy)NSString* start_price;
/**
 *  最大价格(筛选条件)
 */
@property (nonatomic, copy)NSString* end_price;
/**
 *  1=>人气 2=>价格低到高 3=>最新 4=>销量
 */
@property (nonatomic, strong)NSNumber* sort;
/**
 *  1=>淘宝 2=>天猫 3=>京东 (筛选条件)
 */
@property (nonatomic, strong)NSNumber* source;

@property (nonatomic, strong)RACCommand* categorycommand;
@end
