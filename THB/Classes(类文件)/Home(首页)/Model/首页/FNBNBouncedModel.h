//
//  FNBNBouncedModel.h
//  THB
//
//  Created by Jimmy on 2018/9/18.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNBNBouncedModel : NSObject

@property (nonatomic, assign)NSInteger LinkType;

@property (nonatomic, copy)NSString *NEWSkipUIIdentifier;

@property (nonatomic, copy)NSString *descriptionStr;

@property (nonatomic, copy)NSString *gnType;

@property (nonatomic, copy)NSString *gn_type;

@property (nonatomic, copy)NSString *goodslist_img;

@property (nonatomic, copy)NSString *goodslist_str;

@property (nonatomic, copy)NSString *hide;

@property (nonatomic, copy)NSString *ID;

@property (nonatomic, copy)NSString *is_app;

@property (nonatomic, copy)NSString *ktype;

@property (nonatomic, copy)NSString *sort;

@property (nonatomic, copy)NSString *target;

@property (nonatomic, copy)NSString *type2;

@property (nonatomic, copy)NSString *img;

@property (nonatomic, copy)NSString *name;

@property (nonatomic, copy)NSString *url;

@property (nonatomic, copy)NSString *SkipUIIdentifier;

@property (nonatomic, copy)NSString *ViewType;

@end

@interface FNHometipRedpacketModel : NSObject


@property (nonatomic, copy)NSArray *redpacket;//    是    array    数据数组    数据数组
@property (nonatomic, copy)NSArray *tip_list;//    是    array    数据数组    数据数组
//红包图数组
@property (nonatomic, copy)NSString *name;//    是    string    文字    文字
@property (nonatomic, copy)NSString *img;//    是    string    图片链接    图片链接
@property (nonatomic, copy)NSString *url;//    是    string    超链接    超链接
@property (nonatomic, copy)NSString *SkipUIIdentifier;//    是    string    跳转标识    跳转标识
@property (nonatomic, copy)NSString *ViewType;//    是    int    样式标识    样式标识
@property (nonatomic, copy)NSString *show_type_str;//    是    int    类型    （跳转时传）
//温馨提示数组
@property (nonatomic, copy)NSString *is_new;//    是    string    是否新消息    0否 1是
@property (nonatomic, copy)NSString *content;//    是    string    文字    文字
@property (nonatomic, copy)NSString *content_color;//    是    string    文字颜色    文字颜色
//@property (nonatomic, copy)NSString *img;//    是    string    背景图    背景图
@property (nonatomic, copy)NSString *closeimg;//    是    string    关闭图标    关闭图标
@property (nonatomic, copy)NSString *msgimg;//    是    string    通知图标    通知图标
//@property (nonatomic, copy)NSString *url;//    是    string    超链接    超链接
//@property (nonatomic, copy)NSString *SkipUIIdentifier;//    是    string    跳转标识    跳转标识
//@property (nonatomic, copy)NSString *ViewType;//    是    int    样式标识    样式标识
//@property (nonatomic, copy)NSString *show_type_str;//    是    int    类型    （跳转时传）

@property (nonatomic, copy)NSString *bjimg;


@end
