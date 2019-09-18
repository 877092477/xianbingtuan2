//
//  FNNewFreeProductDetailModel.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNNewFreeProductDetailShareModel : NSObject

@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* type;

@end

@interface FNNewFreeProductDetailButtonModel : NSObject

@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* top_str;
@property (nonatomic, copy) NSString* btm_str;
@property (nonatomic, copy) NSString* font_color;
@property (nonatomic, copy) NSString* bj_color;
@property (nonatomic, copy) NSString* over_time;

@end

@interface FNNewFreeProductDetailModel : FNBaseProductModel

@property (nonatomic, strong) NSArray<FNNewFreeProductDetailButtonModel*> *btn_list;
@property (nonatomic, strong) NSArray<FNNewFreeProductDetailShareModel*> *share_list;

@property (nonatomic, strong) NSArray<NSString*> *detailArr;
@property (nonatomic, strong) NSArray<NSString*> *imgArr;

@property (nonatomic, copy) NSString* explain_str;
@property (nonatomic, copy) NSString* explain_font_color;
@property (nonatomic, copy) NSString* explain_color;

@property (nonatomic, copy) NSString* sales_str;
@property (nonatomic, copy) NSString* stock_str;
@property (nonatomic, copy) NSString* price_color;

@property (nonatomic, copy) NSString* share_title;
@property (nonatomic, copy) NSString* share_content;

@property (nonatomic, copy) NSString* tb_pid;
@property (nonatomic, copy) NSString* APP_adzoneId;
@property (nonatomic, copy) NSString* APP_alliance_appkey;

@property (nonatomic, copy) NSString* old_url;
@property (nonatomic, copy) NSString* old_h5_url;

@end

NS_ASSUME_NONNULL_END
