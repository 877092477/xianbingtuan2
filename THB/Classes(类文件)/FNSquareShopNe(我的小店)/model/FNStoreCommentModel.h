//
//  FNStoreCommentModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/25.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNStoreCommentCateModel : NSObject

@property (nonatomic, copy) NSString* str;
@property (nonatomic, copy) NSString* type;

@end

@interface FNStoreCommentModel : NSObject

@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* uid;
@property (nonatomic, copy) NSString* store_id;
@property (nonatomic, copy) NSString* order_id;
@property (nonatomic, copy) NSString* is_anonymous;
@property (nonatomic, copy) NSString* content;
@property (nonatomic, copy) NSArray<NSString*>* imgs;
@property (nonatomic, copy) NSString* time;
@property (nonatomic, copy) NSString* vote;
@property (nonatomic, copy) NSString* star;
@property (nonatomic, copy) NSString* c_number;
@property (nonatomic, copy) NSString* average_price;
@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* head_img;
@property (nonatomic, copy) NSString* vote_img1;
@property (nonatomic, copy) NSString* vote_img;
@property (nonatomic, copy) NSString* comment_img;
@property (nonatomic, copy) NSString* doubt;
@property (nonatomic, copy) NSString* doubt_img;
@property (nonatomic, copy) NSString* good_star;
@property (nonatomic, copy) NSString* bad_star;
@property (nonatomic, copy) NSString* star_str;
@property (nonatomic, copy) NSString* has_vote;

@property (nonatomic, copy) NSString* vote_color1;
@property (nonatomic, copy) NSString* vote_color;

@end

NS_ASSUME_NONNULL_END
