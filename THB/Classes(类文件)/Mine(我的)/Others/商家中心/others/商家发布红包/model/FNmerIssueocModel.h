//
//  FNmerIssueocModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNmerIssueocModel : NSObject
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* value;
@property (nonatomic, copy)NSString* valueHint;
@property (nonatomic, copy)NSString* unit;
@property (nonatomic, copy)NSString* bottomHint;

@property (nonatomic, copy)NSString* startDate;
@property (nonatomic, copy)NSString* endDate;

@property (nonatomic, assign)BOOL  rightunit;
@property (nonatomic, assign)BOOL  rightCondition;
@property (nonatomic, assign)BOOL  isCompile;
@property (nonatomic, assign)BOOL  isHideRight;
@property (nonatomic, assign)NSInteger  isStyle;
@property (nonatomic, assign)NSInteger  isBoth;
@property (nonatomic, assign)CGFloat  rowheight;
@property (nonatomic, assign)NSInteger  switchState;

@property (nonatomic, copy)NSString* editType;
@property (nonatomic, copy)NSString* value1Orange;
@property (nonatomic, copy)NSString* value2Orange;
@property (nonatomic, copy)NSString* type;
@property (nonatomic, copy)NSString* isCommon;


@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* name;

@property (nonatomic, copy)NSString* online;
@property (nonatomic, copy)NSString* offline;

@property (nonatomic, copy)NSString* onlineState;
@property (nonatomic, copy)NSString* offlineState;

@property (nonatomic, copy)NSString* condition;
@property (nonatomic, copy)NSString* price;
@end

@interface FNmerIssueocAlterModel : NSObject
@property (nonatomic, copy)NSString* id;
@property (nonatomic, copy)NSString* store_id;
@property (nonatomic, copy)NSString* now_price;
@property (nonatomic, copy)NSString* now_counts;
@property (nonatomic, copy)NSString* start_time;
@property (nonatomic, copy)NSString* end_time;

@end


@interface FNmoneyOffOItemModel : NSObject
@property (nonatomic, strong)NSString* id;
@property (nonatomic, strong)NSString* condition;
@property (nonatomic, strong)NSString* price;


@property (nonatomic, copy)NSString* title1Str;
@property (nonatomic, copy)NSString* title2Str;
@property (nonatomic, copy)NSString* unit1Str;
@property (nonatomic, copy)NSString* unit2Str;
@property (nonatomic, copy)NSString* hintStr;
@property (nonatomic, copy)NSString* valueHint1Str;
@property (nonatomic, copy)NSString* valueHint2Str;

@property (nonatomic, copy)NSString* leftBtnStr;
@property (nonatomic, copy)NSString* rightBtnStr;
@property (nonatomic, copy)NSString* leftBtnimg;
@property (nonatomic, copy)NSString* rightBtnimg;

@property (nonatomic, assign)NSInteger  leftBtnState;
@property (nonatomic, assign)NSInteger  rightBtnState;

@property (nonatomic, copy)NSString* editType;

@property (nonatomic, assign)CGFloat  rowheight;
@property (nonatomic, assign)BOOL  isHint;
@property (nonatomic, assign)BOOL  isThree;

@end

@interface FNmoneyOffFullMinusModel : NSObject
@property (nonatomic, strong)NSString* id;
@property (nonatomic, strong)NSString* store_id;
@property (nonatomic, strong)NSArray* condition_data;
@property (nonatomic, strong)NSString* allow_cates;
@property (nonatomic, strong)NSString* allow_goods;
@property (nonatomic, strong)NSString* on_line;
@property (nonatomic, strong)NSString* on_shop;
@property (nonatomic, strong)NSString* with_red_packet;
@property (nonatomic, strong)NSString* with_yhq;
@property (nonatomic, strong)NSString* start_time;
@property (nonatomic, strong)NSString* end_time;
@property (nonatomic, strong)NSString* create_time;
@property (nonatomic, strong)NSString* status;



@property (nonatomic, strong)NSString* discount;
@property (nonatomic, strong)NSString* start_hours;
@property (nonatomic, strong)NSString* end_hours;


@end

@interface FNmoneyOffFullMinusItemModel : NSObject
@property (nonatomic, strong)NSString* condition;
@property (nonatomic, strong)NSString* price;
@end

NS_ASSUME_NONNULL_END
