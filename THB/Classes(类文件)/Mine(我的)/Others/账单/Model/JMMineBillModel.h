//
//  JMMineBillModel.h
//  THB
//
//  Created by jimmy on 2017/3/30.
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

@interface JMMineBillModel : NSObject
/**
 *  金额
 */
@property (nonatomic, copy)NSString* interal;
/**
 *  详情
 */
@property (nonatomic, copy)NSString* detail;
/**
 *  时间
 */
@property (nonatomic, copy)NSString* time;
/**
 * 手续费
 */
@property (nonatomic, copy)NSString* sxf;
@end


@interface FNheaderTypeModel : NSObject
/**
 *  名字
 */
@property (nonatomic, copy)NSString* name;
/**
 *  类型
 */
@property (nonatomic, copy)NSString* type;

@end


@interface FNBillDetailsModel : NSObject
/**
 *  文字
 */
@property (nonatomic, copy)NSString* detail;
/**
 *  值
 */
@property (nonatomic, copy)NSString* interal;
/**
 *  到账时间：
 */
@property (nonatomic, copy)NSString* dzstr;
/**
 *  类型
 */
@property (nonatomic, copy)NSString* orderType;
/**
 *  时间
 */
@property (nonatomic, copy)NSString* time;
/**
 *  订单号
 */
@property (nonatomic, copy)NSString* oid;

@end


@interface FNheaderIncomeModel : NSObject
/**
 *  名字
 */
@property (nonatomic, copy)NSString* name;
/**
 *  值
 */
@property (nonatomic, copy)NSString* val;

@end
