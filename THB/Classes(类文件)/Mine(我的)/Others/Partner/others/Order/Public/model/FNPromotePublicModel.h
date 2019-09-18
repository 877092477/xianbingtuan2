//
//  FNPromotePublicModel.h
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PPMorder;
@interface FNPromotePublicModel : NSObject

/**
 *  粉丝销量数量
 */
@property (nonatomic, copy)NSString* fsxl;
/**
 *  即将到帐数量
 */
@property (nonatomic, copy)NSString* jjdz;
/**
 *  累计奖励数量
 */
@property (nonatomic, copy)NSString* ljjl;
/**
 *  数组    order list
 */
@property (nonatomic, strong)NSArray<PPMorder *>* order;

/**
 *  全部数量
 */
@property (nonatomic, copy)NSString* all;
/**
 *  已付款数量
 */
@property (nonatomic, copy)NSString* yfk;
/**
 *  已失效数量
 */
@property (nonatomic, copy)NSString* ysx;
/**
 *  已结算数量
 */
@property (nonatomic, copy)NSString* yjs;
/**
 *  已收货数量
 */
@property (nonatomic, copy)NSString* ysh;
@end

@interface PPMorder:FNBaseProductModel
/**
 *  ID
 */
@property (nonatomic, copy)NSString* ID;
/**
 *  returnstatus
 */
@property (nonatomic, copy)NSString* returnstatus;
/**
 *  goodsInfo
 */
@property (nonatomic, copy)NSString* goodsInfo;
/**
 *  uid
 */
@property (nonatomic, copy)NSString* uid;
/**
 *  createDate
 */
@property (nonatomic, copy)NSString* createDate;
/**
 *  goodsNum
 */
@property (nonatomic, copy)NSString* goodsNum;
/**
 *  realCost
 */
@property (nonatomic, copy)NSString* realCost;
/**
 *  tgNickname
 */
@property (nonatomic, copy)NSString* tgNickname;
/**
 *  orderType
 */
@property (nonatomic, copy)NSString* orderType;
/**
 *  orderId
 */
@property (nonatomic, copy)NSString* orderId;
/**
 *  commission
 */
@property (nonatomic, copy)NSString* commission;
/**
 *  goodsId
 */
@property (nonatomic, copy)NSString* goodsId;
/**
 *  status
 */
@property (nonatomic, copy)NSString* status;
/**
 *  payment
 */
@property (nonatomic, copy)NSString* payment;
/**
 *  goods_img
 */
@property (nonatomic, copy)NSString* goods_img;

@end
