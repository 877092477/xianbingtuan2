//
//  FNShareMixModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/4.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNShareMixButtonModel : NSObject

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* share_platform;

@end

@interface FNShareMixModel : NSObject

@property (nonatomic, copy) NSString* goods_img;
@property (nonatomic, copy) NSString* str_copy;
@property (nonatomic, copy) NSString* color_copy;
@property (nonatomic, copy) NSString* bjcolor_copy;
@property (nonatomic, copy) NSString* goods_title;
@property (nonatomic, copy) NSArray<NSString*>* img_list;
@property (nonatomic, copy) NSString* share_title;
@property (nonatomic, copy) NSString* share_content;
@property (nonatomic, copy) NSString* share_url;
@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* webpageUrl;
@property (nonatomic, copy) NSString* content;
@property (nonatomic, copy) NSString* url_title;
@property (nonatomic, copy) NSString* mini_title;
@property (nonatomic, copy) NSString* mini_label;
@property (nonatomic, copy) NSString* mini_ico;
@property (nonatomic, copy) NSString* mini_ico1;
@property (nonatomic, copy) NSString* mini_share_str;
@property (nonatomic, copy) NSString* mini_share_color;
@property (nonatomic, copy) NSString* mini_share_bjcolor;
@property (nonatomic, copy) NSArray<FNShareMixButtonModel*>* share_list;

@property (nonatomic, copy) NSString* img_share_url;
@property (nonatomic, copy) NSString* miniprogram_share_type;

@end


NS_ASSUME_NONNULL_END
