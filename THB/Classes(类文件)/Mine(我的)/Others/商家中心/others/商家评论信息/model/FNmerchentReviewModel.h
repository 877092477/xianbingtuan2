//
//  FNmerchentReviewModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/10.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNmerchentReviewModel : NSObject
@property (nonatomic, copy)NSString* zongjia;
@property (nonatomic, copy)NSDictionary* top;
@property (nonatomic, copy)NSDictionary* center;
@property (nonatomic, copy)NSArray* order_msg;

@property (nonatomic, copy)NSString* id;
@property (nonatomic, copy)NSString* uid;
@property (nonatomic, copy)NSString* store_id;
@property (nonatomic, copy)NSString* order_id;
@property (nonatomic, copy)NSString* is_anonymous;
@property (nonatomic, copy)NSString* content;
@property (nonatomic, copy)NSArray* imgs;
@property (nonatomic, copy)NSString* time;
@property (nonatomic, copy)NSString* vote;
@property (nonatomic, copy)NSString* star;
@property (nonatomic, copy)NSString* c_number;
@property (nonatomic, copy)NSString* username;
@property (nonatomic, copy)NSString* head_img;
@property (nonatomic, copy)NSString* vote_img;
@property (nonatomic, copy)NSString* comment_img;
@property (nonatomic, copy)NSString* doubt;
@property (nonatomic, copy)NSString* doubt_img;
@property (nonatomic, copy)NSString* good_star;
@property (nonatomic, copy)NSString* bad_star;
@property (nonatomic, copy)NSString* star_str;
@property (nonatomic, copy)NSString* average_price;

@property (nonatomic, copy)NSString* has_vote;
@property (nonatomic, copy)NSString* vote_img1;
@property (nonatomic, copy)NSString* vote_color1;
@property (nonatomic, copy)NSString* vote_color;


@property (nonatomic, copy)NSString* vote_str;
@property (nonatomic, copy)NSArray* vote_user_img;


@property (nonatomic, copy)NSString* sub_comment_str;
@property (nonatomic, copy)NSString* sub_comment_time;
@property (nonatomic, copy)NSString* sub_comment_icon;
@property (nonatomic, copy)NSString* sub_comment;

@property (nonatomic, copy)NSDictionary* store;
@end

@interface FNmerReviewHeadModel : NSObject 
@property (nonatomic, copy)NSString* store_name;
@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSString* top_bj;
@property (nonatomic, copy)NSString* color;
@property (nonatomic, copy)NSString* today_visitor_str;
@property (nonatomic, copy)NSString* today_visitor;
@property (nonatomic, copy)NSString* all_visitor_str;
@property (nonatomic, copy)NSString* all_visitor;
@end

@interface FNmerReviewQueryModel : NSObject
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* content_tips;
@property (nonatomic, copy)NSString* btn;
@property (nonatomic, copy)NSArray* type;

@end

@interface FNmerReviewQueryItemModel : NSObject
@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* type;
@property (nonatomic, assign)NSInteger  state;


@end

@interface FNmerReviewItemModel : NSObject
@property (nonatomic, copy)NSString* id;
@property (nonatomic, copy)NSString* uid;
@property (nonatomic, copy)NSString* comment_id;
@property (nonatomic, copy)NSString* content;
@property (nonatomic, copy)NSString* time;
@property (nonatomic, copy)NSString* username;
@property (nonatomic, copy)NSString* head_img;

@end
NS_ASSUME_NONNULL_END
