//
//  FNPosterModel.h
//  THB
//
//  Created by jimmy on 2017/8/29.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNPosterModel : NSObject
@property (nonatomic, copy)NSString* ID;
@property (nonatomic, copy)NSString* image;
@property (nonatomic, copy)NSString* is_check;

@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSArray* ImgCon;
@property (nonatomic, copy)NSString* btmImg2;
@property (nonatomic, copy)NSString* btmImg1;
@property (nonatomic, copy)NSString* topImg;
@property (nonatomic, copy)NSString* url;
@property (nonatomic, copy)NSString* content;

@property (nonatomic, copy)NSString* haibao_left_str;
@property (nonatomic, copy)NSString* haibao_left_strcolor;
@property (nonatomic, copy)NSString* haibao_left_btncolor;
@property (nonatomic, copy)NSString* haibao_right_str;
@property (nonatomic, copy)NSString* haibao_right_strcolor;
@property (nonatomic, copy)NSString* haibao_right_btncolor;
@property (nonatomic, copy)NSString* haibao_share_wenan;
@property (nonatomic, copy)NSString* haibao_tip_str;
@property (nonatomic, copy)NSString* haibao_left_bordercolor;
@property (nonatomic, copy)NSString* haibao_right_bordercolor;
@property (nonatomic, copy)NSString* haibao_share_url;
@end
