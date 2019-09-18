//
//  FNTabModel.h
//  THB
//
//  Created by jimmy on 2017/11/2.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNTabModel : NSObject
/**
 *  ID
 */
@property (nonatomic, copy)NSString* ID;
/**
 *  img
 */
@property (nonatomic, copy)NSString* img;
/**
 *  img1
 */
@property (nonatomic, copy)NSString* img1;
/**
 *  is_check
 */
@property (nonatomic, copy)NSString* is_check;
/**
 *  name
 */
@property (nonatomic, copy)NSString* name;
/**
 *  color_val
 */
@property (nonatomic, copy)NSString* color_val;


@property (nonatomic, copy) NSString *msg;

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
 *  图片2
 */
@property (nonatomic, copy)NSString* image2;
/**
 *  显示活动倒计时
 */
@property (nonatomic, copy)NSString* activity_time;
/**
 *      今日上新数
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


@property (nonatomic, copy)NSString* shop_type;

@property (nonatomic, copy)NSString* fnuo_id;

@property (nonatomic, copy)NSString* goodsInfo;
@property (nonatomic, copy)NSString* getGoodsType;
@property (nonatomic, copy)NSString* goods_title;


#pragma mark - 美利淘
@property (nonatomic, copy)NSString* des;

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, copy) NSString *show_name;

@property (nonatomic, copy) NSString *fnuo_url;

@property (nonatomic, copy) NSString *show_type_str;
@property (nonatomic, copy) NSString *is_need_login;
@property (nonatomic, copy) NSString *jsonInfo;

@property (nonatomic, copy) NSString *keyword;
@end
