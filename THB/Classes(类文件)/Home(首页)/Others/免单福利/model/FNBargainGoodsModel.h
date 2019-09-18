//
//  FNBargainGoodsModel.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface FNBargainGoodsButtonModel : NSObject

@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* top_str;
@property (nonatomic, copy) NSString* btm_str;
@property (nonatomic, copy) NSString* font_color;
@property (nonatomic, copy) NSString* bj_color;

@end

@interface FNBargainGoodsShareModel : NSObject

@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* img;

@end

@interface FNBargainGoodsModel : NSObject

@property (nonatomic, copy) NSString* goods_price;
@property (nonatomic, copy) NSString* sales_str;
@property (nonatomic, copy) NSString* stock_str;
@property (nonatomic, copy) NSString* explain_str;
@property (nonatomic, copy) NSString* explain_font_color;
@property (nonatomic, copy) NSString* price_color;
@property (nonatomic, copy) NSString* share_title;
@property (nonatomic, copy) NSString* share_content;
@property (nonatomic, copy) NSString* share_img;
@property (nonatomic, copy) NSString* share_url;
@property (nonatomic, strong) NSArray<NSString*>* imgArr;
@property (nonatomic, strong) NSArray<NSString*>* detailArr;
@property (nonatomic, strong) NSArray<FNBargainGoodsButtonModel*>* btn_list;

@property (nonatomic, copy) NSString* over_time;
@property (nonatomic, strong) NSArray<FNBargainGoodsShareModel*>* share_list;

@end

NS_ASSUME_NONNULL_END
