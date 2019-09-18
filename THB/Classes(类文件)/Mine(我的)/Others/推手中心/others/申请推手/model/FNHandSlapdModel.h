//
//  FNHandSlapdModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNHandSlapdModel : NSObject
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* title_color;
@property (nonatomic, copy)NSString* return_icon;
@property (nonatomic, copy)NSString* bg_img;
@property (nonatomic, copy)NSString* equity_img;
@property (nonatomic, copy)NSString* condition_bg;
@property (nonatomic, copy)NSString* condition_title_img;
@property (nonatomic, copy)NSString* btn; 
@property (nonatomic, copy)NSArray* condition;
@end

@interface FNHandConditionItemModel : NSObject
@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* icon;
@property (nonatomic, copy)NSString* bgImg;
@end

@interface FNHandResultsModel : NSObject

@property (nonatomic, copy)NSString* bg_img;
@property (nonatomic, copy)NSString* btn_bj;
@property (nonatomic, copy)NSString* btn_color;
@property (nonatomic, copy)NSString* btn_str;
@property (nonatomic, copy)NSString* gray_circle;
@property (nonatomic, copy)NSString* gray_line;
@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSArray* progress;
@property (nonatomic, copy)NSString* red_circle;
@property (nonatomic, copy)NSString* red_circle_count;
@property (nonatomic, copy)NSString* red_line;
@property (nonatomic, copy)NSString* status;
@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* tips;
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* time;
@end

NS_ASSUME_NONNULL_END
