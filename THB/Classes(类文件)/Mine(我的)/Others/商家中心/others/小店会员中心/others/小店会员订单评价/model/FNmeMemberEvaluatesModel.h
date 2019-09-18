//
//  FNmeMemberEvaluatesModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNmeMemberEvaluatesModel : NSObject
@property(nonatomic,strong)NSString *order_tips;
@property(nonatomic,strong)NSString *comment_title;
@property(nonatomic,strong)NSString *comment_tips;
@property(nonatomic,strong)NSString *order_desc;
@property(nonatomic,strong)NSString *order_img;
@property(nonatomic,strong)NSArray *star_level;
@property(nonatomic,strong)NSString *store_name;
@property(nonatomic,strong)NSString *store_img;
@property(nonatomic,strong)NSString *btn_str;
@property(nonatomic,strong)NSString *btn_color;
@property(nonatomic,strong)NSString *btn_bj;
@end

@interface FNmeMemberStarsModel : NSObject
@property(nonatomic,strong)NSString *imgSeleted;
@property(nonatomic,strong)NSString *imgNor;
@property(nonatomic,strong)NSString *state;
@property(nonatomic,strong)NSString *moId;
@end

NS_ASSUME_NONNULL_END
