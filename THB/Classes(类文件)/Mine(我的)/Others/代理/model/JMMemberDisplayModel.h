//
//  JMMemberDisplayModel.h
//  THB
//
//  Created by jimmy on 2017/3/31.
//  Copyright © 2017年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */
#import <Foundation/Foundation.h>
@class JMPaymentWayModel;
@interface JMMemberDisplayModel : NSObject
/**
 *  	金额
 */
@property (nonatomic, copy)NSString* vip_price;
/**
 *  	图标
 */
@property (nonatomic, copy)NSString* vip_img;
/**
 *  	title
 */
@property (nonatomic, copy)NSString* vip_name;
/**
 *  	天数
 */
@property (nonatomic, copy)NSString* vip_time;
/**
 *  头像
 */
@property (nonatomic, copy)NSString* head_img;
/**
 *  用户id
 */
@property (nonatomic, copy)NSString* userid;
/**
 *  邀请码
 */
@property (nonatomic, copy)NSString* tgid;
/**
 *  协议
 */
@property (nonatomic, copy)NSString* hdy_url;
/**
 *  是否有邀请码
 */
@property (nonatomic, copy)NSString* is_tgm;
@property (nonatomic, copy)NSString* is_yqbt;
/**
 *  	支付方式数组
 */
@property (nonatomic, copy)NSArray<JMPaymentWayModel *>* zftype;

/**
 *  	购买时间
 */
@property (nonatomic, copy)NSString* buy_time;

/**
 *  	剩余天数
 */
@property (nonatomic, copy)NSString* sy_day;
/**
 *  str1
 */
@property (nonatomic, copy)NSString* str1;

/**
 *  str2
 */
@property (nonatomic, copy)NSString* str2;

/**
 *  str3
 */
@property (nonatomic, copy)NSString* str3;

@end

@interface JMPaymentWayModel : NSObject
/**
 *  图标
 */
@property (nonatomic, copy)NSString* icon;
/**
 *  名称
 */
@property (nonatomic, copy)NSString* name;
/**
 *  支付类型
 */
@property (nonatomic, copy)NSString* type;

/**
 *  is selected
 */
@property (nonatomic, assign)BOOL isSelected;
@end
