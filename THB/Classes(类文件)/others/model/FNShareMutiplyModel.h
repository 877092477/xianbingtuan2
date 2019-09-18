//
//  FNShareMutiplyModel.h
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SMMImage;
@interface FNShareMutiplyModel : NSObject
/**
 *  goods_title
 */
@property (nonatomic, copy)NSString* goods_title;
/**
 *  zhe
 */
@property (nonatomic, copy)NSString* zhe;
/**
 *  str
 */
@property (nonatomic, copy)NSString* str;
/**
 *  goods_img
 */
@property (nonatomic, strong)NSArray* goods_img;
/**
 *  goods_cost_price
 */
@property (nonatomic, copy)NSString* goods_cost_price;
/**
 *  fcommissionshow
 */
@property (nonatomic, copy)NSString* fcommissionshow;
/**
 *  fnuo_url
 */
@property (nonatomic, copy)NSString* fnuo_url;
/**
 *  detailurl
 */
@property (nonatomic, copy)NSString* detailurl;
/**
 *  fbili
 */
@property (nonatomic, copy)NSString* fbili;
/**
 *  yhq_span
 */
@property (nonatomic, copy)NSString* yhq_span;
/**
 *  goods_price
 */
@property (nonatomic, copy)NSString* goods_price;
/**
 *  yhq_url
 */
@property (nonatomic, copy)NSString* yhq_url;
/**
 *  commission
 */
@property (nonatomic, copy)NSString* commission;
/**
 *  fcommission
 */
@property (nonatomic, copy)NSString* fcommission;
/**
 *  yhq_price
 */
@property (nonatomic, copy)NSString* yhq_price;
/**
 *  fnuo_id
 */
@property (nonatomic, copy)NSString* fnuo_id;

@property (nonatomic, strong)NSArray<SMMImage *>* images;

@property (nonatomic, copy)NSString* fxz;

@property (nonatomic, copy)NSString* shop_img;

@end

@interface SMMImage:NSObject
/**
 *  image
 */
@property (nonatomic, copy)NSString* image;
/**
 *  isselected
 */
@property (nonatomic, assign)BOOL isselected;
@end
