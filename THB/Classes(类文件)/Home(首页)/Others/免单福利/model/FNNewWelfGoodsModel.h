//
//  FNNewWelfGoodsModel.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNNewProductDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNNewWelfGoodsModel : FNNewProductDetailModel

@property (nonatomic, copy) NSString* price_color;
@property (nonatomic, copy) NSString* btn_font_color;
@property (nonatomic, copy) NSString* btn_color;
@property (nonatomic, copy) NSString* btn_str;
@property (nonatomic, copy) NSString* sales_str;
@property (nonatomic, copy) NSString* stock_str;

@property (nonatomic, strong) NSDictionary *data;

@end

NS_ASSUME_NONNULL_END
