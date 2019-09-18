//
//  FNcandiesIncomeModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNcandiesIncomeModel : NSObject
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* return_btn;
@property (nonatomic, copy)NSString* top_color;
@property (nonatomic, copy)NSString* top_bg;
@property (nonatomic, copy)NSString* top_bg_bili;
@property (nonatomic, copy)NSString* qkb_count;
@property (nonatomic, copy)NSString* all_count_str;
@property (nonatomic, copy)NSString* duiduan_btn;
@property (nonatomic, copy)NSString* yesterday_income;
@property (nonatomic, copy)NSString* date_bg;
@property (nonatomic, copy)NSString* date;
@property (nonatomic, copy)NSString* shouru_bg;
@property (nonatomic, copy)NSString* zhichu_bg;
@property (nonatomic, copy)NSString* shouru;
@property (nonatomic, copy)NSString* zhichu;
@property (nonatomic, copy)NSArray* list;
@end
@interface FNcandiesIncomeItemModel : NSObject
@property (nonatomic, copy)NSString* left_icon;
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* counts;
@property (nonatomic, copy)NSString* time;
@property (nonatomic, copy)NSString* tips;

@end
NS_ASSUME_NONNULL_END
