//
//  JMHiBuyHomeADModel.h
//  THB
//
//  Created by jimmy on 2017/3/29.
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

@interface JMHiBuyHomeADModel : NSObject
/**
 *  图片
 */
@property (nonatomic, copy)NSString* img;
/**
 *  主标题
 */
@property (nonatomic, copy)NSString* title;
/**
 *  	副标题
 */
@property (nonatomic, copy)NSString* des;
/**
 *  	副标题1
 */
@property (nonatomic, copy)NSString* description1;
/**
 *  跳转类型1：优惠券 2：品牌特卖 3：9块9 4：商城返利 5：摇一摇 6：超高返 7：20元封顶 16：限时抢购 17：嗨代言
 */
@property (nonatomic, copy)NSString* UIIdentifier;
@end
