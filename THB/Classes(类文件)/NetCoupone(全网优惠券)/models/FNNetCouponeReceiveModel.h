//
//  FNNetCouponeReceiveModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/11.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNNetCouponeReceiveModel : NSObject

@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* price;
@property (nonatomic, copy) NSString* start_time;
@property (nonatomic, copy) NSString* end_time;
@property (nonatomic, copy) NSString* num;
@property (nonatomic, copy) NSString* leave_num;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* info;
@property (nonatomic, copy) NSString* user_num;
@property (nonatomic, copy) NSString* lable_img;
@property (nonatomic, copy) NSString* valid_day;
@property (nonatomic, copy) NSString* SkipUIIdentifier;
@property (nonatomic, copy) NSString* bjimg;
@property (nonatomic, copy) NSString* str;
@property (nonatomic, copy) NSString* str_color;
@property (nonatomic, copy) NSString* jindu;
@property (nonatomic, copy) NSString* djs;
@property (nonatomic, copy) NSString* is_set_remind;
@property (nonatomic, copy) NSString* remind_img;
@property (nonatomic, copy) NSString* remind_img1;

@property (nonatomic, strong) NSDate *time;

@end

NS_ASSUME_NONNULL_END
