//
//  FNmerDiscountsItemModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNmerDiscountsItemModel : NSObject
@property (nonatomic, copy)NSString* id;
@property (nonatomic, copy)NSString* price;
@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* str1;
@property (nonatomic, copy)NSString* str2;
@property (nonatomic, copy)NSString* str3;
@property (nonatomic, copy)NSString* str4;
@property (nonatomic, copy)NSString* str5;
@property (nonatomic, copy)NSString* str6;
@property (nonatomic, copy)NSString* str7;
@property (nonatomic, copy)NSString* str8;
@property (nonatomic, copy)NSString* str10;
@property (nonatomic, copy)NSString* str11;
@property (nonatomic, copy)NSString* str12;
@property (nonatomic, copy)NSString* guoqi_icon;
@property (nonatomic, copy)NSString* rest_tips;
@property (nonatomic, copy)NSString* rest_tips_icon;
@property (nonatomic, copy)NSString* str9;
@property (nonatomic, copy)NSString* status_str;
@property (nonatomic, copy)NSString* typeStr;
@property (nonatomic, assign)CGFloat rowHeight;

@property (nonatomic, copy)NSString* typeZY;


@property (nonatomic, copy)NSString* title;//    string    折扣标题
@property (nonatomic, copy)NSString* status;//    int    状态 1 上架中 0 下架

@property (nonatomic, copy)NSString* time;//    string    活动时间
@property (nonatomic, copy)NSString* icon;//    string    右上角icon
@property (nonatomic, copy)NSString* str;//    string    描述
@property (nonatomic, copy)NSString* is_expired;//    int    是否过期 0 否 1 是
@property (nonatomic, copy)NSString* is_ongoing;//    int    是否进行中 0 否 1 是 

//is_expired    int    是否过期 0 否 1 是【过期不显示修改按钮】
//is_ongoing    int    是否进行中 0 否 1 是 【进行中字体为黑色】
@end

@interface FNmerDiscountsTopTypeModel : NSObject
@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* type;


@end

NS_ASSUME_NONNULL_END
