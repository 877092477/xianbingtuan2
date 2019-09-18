//
//  FNBrandShopModel.h
//  THB
//
//  Created by jimmy on 2017/5/19.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JMShop_yhq,FNBaseProductModel;
@interface FNBrandShopModel : NSObject
@property (nonatomic, copy)NSString* returnbili;
@property (nonatomic, copy)NSString* zhe;
@property (nonatomic, copy)NSString* hot;
@property (nonatomic, copy)NSString* type;
@property (nonatomic, copy)NSString* start_time;
@property (nonatomic, copy)NSString* logo;
@property (nonatomic, copy)NSString* abc;
@property (nonatomic, copy)NSString* banner;
@property (nonatomic, copy)NSString* dp_id;
@property (nonatomic, copy)NSString* end_time;
@property (nonatomic, copy)NSString* day_new;
@property (nonatomic, copy)NSString* info;
@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* is_yhq;
@property (nonatomic, strong)NSArray<FNBaseProductModel *>* shop_goods;
@property (nonatomic, strong)NSArray<JMShop_yhq *>* shop_yhq;

//additional
@property (nonatomic, assign)CGFloat goodsH;
@end

@interface JMShop_yhq : NSObject
@property (nonatomic, copy)NSString* yhq_price;
@property (nonatomic, copy)NSString* yhq_span;
@end
