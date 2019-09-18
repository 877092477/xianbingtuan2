//
//  MenuModel.h
//  FnuoApp
//
//  Created by zhongxueyu on 16/2/27.
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

@interface MenuModel : NSObject

@property (nonatomic, assign) NSInteger success;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *url;

/** 界面标识 **/
@property (nonatomic, copy) NSString *UIIdentifier;
/** 界面标识 **/
@property (nonatomic, copy) NSString* SkipUIIdentifier;

/**
 *  描述
 */
@property (nonatomic, copy)NSString* title;

/**
 *  图片
 */
@property (nonatomic, copy)NSString* image;

/**
 *  图片
 */
@property (nonatomic, copy)NSString* img1;
/**
 *  图片
 */
@property (nonatomic, copy)NSString* img2;
@property (nonatomic, copy)NSString* font_img;
@property (nonatomic, copy)NSString* go_img;

/**
 *  图片2
 */
@property (nonatomic, copy)NSString* image2;
/**
 *  显示活动倒计时
 */
@property (nonatomic, copy)NSString* activity_time;
/**
 *  	今日上新数
 */
@property (nonatomic, copy)NSString* num;

@property (nonatomic, copy)NSString* webType;

@property (nonatomic, copy)NSString* view_type;
@property (nonatomic, copy)NSString* type;

@property (nonatomic, copy)NSString* val;

/**
 商品列表头部图片
 */
@property (nonatomic, copy)NSString* goodslist_img;

/**
 商品列表头部文字
 */
@property (nonatomic, copy)NSString* goodslist_str;

@property (nonatomic, copy)NSString* count;

@property (nonatomic, copy)NSString* str;

@property (nonatomic, copy)NSString* is_need_login;

#pragma mark - 美利淘
@property (nonatomic, copy)NSString* des;

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, copy)NSString* ID;

/**
 font_color
 */
@property (nonatomic, copy)NSString* font_color;

@property (nonatomic, copy)NSString* keyword;

@property (nonatomic, copy)NSString* show_type_str;

@property (nonatomic, copy)NSString* jsonInfo;

@end

