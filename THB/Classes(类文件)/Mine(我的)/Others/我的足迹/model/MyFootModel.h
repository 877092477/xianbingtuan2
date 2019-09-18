//
//  MyFootModel.h
//  THB
//
//  Created by zhongxueyu on 16/4/11.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import <Foundation/Foundation.h>


@interface MyFootModel : FNBaseProductModel

@property (nonatomic, copy) NSString *starttime;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, assign) CGFloat returnbl;

@property (nonatomic, copy) NSString *goodsid;

@property (nonatomic, copy) NSString *endtime;
@property (nonatomic, copy)NSString* goods_shop;

@end

