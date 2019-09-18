//
//  FNMCAOrderDetailModel.h
//  THB
//
//  Created by jimmy on 2017/7/27.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNMCAOrderDetailModel : NSObject
/**
 *  ID
 */
@property (nonatomic, copy)NSString* ID;
/**
 *  returnstatus
 */
@property (nonatomic, copy)NSString* returnstatus;
/**
 *  goods_title
 */
@property (nonatomic, copy)NSString* goods_title;
/**
 *  fnuo_id
 */
@property (nonatomic, copy)NSString* fnuo_id;
/**
 *  createDate
 */
@property (nonatomic, copy)NSString* createDate;
/**
 *  goods_img
 */
@property (nonatomic, copy)NSString* goods_img;
/**
 *  fnuo_url
 */
@property (nonatomic, copy)NSString* fnuo_url;
/**
 *  commission
 */
@property (nonatomic, copy)NSString* commission;
/**
 *  orderId
 */
@property (nonatomic, copy)NSString* orderId;
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

@end
