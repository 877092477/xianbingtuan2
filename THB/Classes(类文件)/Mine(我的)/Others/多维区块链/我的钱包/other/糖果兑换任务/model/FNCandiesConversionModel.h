//
//  FNCandiesConversionModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNCandiesConversionModel : NSObject
@property (nonatomic, copy)NSString* dwqkb_task_title;
@property (nonatomic, copy)NSString* dwqkb_task_SkipUIIdentifier;
@property (nonatomic, copy)NSString* dwqkb_task_return_btn;
@property (nonatomic, copy)NSString* dwqkb_task_rule_btn;
@property (nonatomic, copy)NSString* dwqkb_task_top_color;
@property (nonatomic, copy)NSString* dwqkb_task_top_bj;
@property (nonatomic, copy)NSString* dwqkb_task_exchange_bj;
@property (nonatomic, copy)NSString* dwqkb_task_exchange;
@property (nonatomic, copy)NSString* dwqkb_task_exchange_color;
@property (nonatomic, copy)NSString* dwqkb_task_dqqkb;
@property (nonatomic, copy)NSString* dwqkb_task_dqyj;
@property (nonatomic, copy)NSString* dwqkb_task_explain_str;
@property (nonatomic, copy)NSString* dwqkb_task_lq_explain;
@property (nonatomic, copy)NSString* dwqkb_lingqu_last_time;
@property (nonatomic, copy)NSString* dwqkb_lingqu_type;
@property (nonatomic, copy)NSString* explain_url;
@property (nonatomic, copy)NSString* qkb_counts;
@property (nonatomic, copy)NSString* commission;
@property (nonatomic, copy)NSDictionary* skip;
@end


@interface FNCandiesMyTaskModel : NSObject


@property (nonatomic, copy)NSString* id;
@property (nonatomic, copy)NSString* type;
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* icon;
@property (nonatomic, copy)NSString* condition;
@property (nonatomic, copy)NSString* expire_time;
@property (nonatomic, copy)NSString* tips1;
@property (nonatomic, copy)NSString* lq_count;
@property (nonatomic, copy)NSString* total;
@property (nonatomic, copy)NSString* complete;
@property (nonatomic, copy)NSString* progress_color;
@property (nonatomic, copy)NSString* progress_color1;
@property (nonatomic, copy)NSString* progress_bg_color;
@property (nonatomic, copy)NSDictionary* skip;
@property (nonatomic, copy)NSString* btn;
@property (nonatomic, copy)NSString* counts;


@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* cate_name;
@property (nonatomic, copy)NSString* bj_img;
@property (nonatomic, copy)NSString* color;
@property (nonatomic, copy)NSString* need_str;
@property (nonatomic, copy)NSString* need_count;
@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* str1;
@property (nonatomic, copy)NSString* str2;
@property (nonatomic, copy)NSString* str3;
@property (nonatomic, copy)NSString* reward_str;
@property (nonatomic, copy)NSString* qkb_icon;
@property (nonatomic, copy)NSString* left_icon;
@property (nonatomic, copy)NSString* status; 

@end

@interface FNCandiesTaskStyleModel : NSObject
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* title_color;
@property (nonatomic, copy)NSString* type;
@property (nonatomic, copy)NSString* body_bj;
@property (nonatomic, copy)NSString* top_bj;
@property (nonatomic, copy)NSString* bottom_bj;
@property (nonatomic, copy)NSArray* list;
@end
NS_ASSUME_NONNULL_END
