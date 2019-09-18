//
//  FNMCTopGoodsModel.h
//  THB
//
//  Created by jimmy on 2017/11/1.
//  Copyright © 2017年 方诺科技. All rights reserved.
//


#import "MenuModel.h"
@interface FNMCTopGoodsModel : MenuModel

/**
 *  yhq_price
 */
@property (nonatomic, copy)NSString* yhq_price;
/**
 *  goods_price
 */
@property (nonatomic, copy)NSString* goods_price;
/**
 *  fnuo_id
 */
@property (nonatomic, copy)NSString* fnuo_id;
/**
 *  yhq_url
 */
@property (nonatomic, copy)NSString* yhq_url;
/**
 *  fnuo_url
 */
@property (nonatomic, copy)NSString* fnuo_url;
/**
 *  price_span
 */


@property (nonatomic, copy)NSString* price_span; 
@property (nonatomic, copy)NSString* getGoodsType;
@property (nonatomic, copy)NSString* goods_title;
@property (nonatomic, copy)NSString* goodsInfo;
@property (nonatomic, copy)NSString* pdd;
@property (nonatomic, copy)NSString* jd;
@property (nonatomic, copy)NSString* shop_type;
@property (nonatomic, copy)NSString* shop_id;
@end
