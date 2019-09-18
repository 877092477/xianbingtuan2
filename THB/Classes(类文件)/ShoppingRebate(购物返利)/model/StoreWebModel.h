//
//  StoreWebModel.h
//  THB
//
//  Created by Weller Zhao on 2018/12/29.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNNewProductDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreWebModel : NSObject

@property (nonatomic, copy) NSString* str;
@property (nonatomic, copy) NSString* font_color;
@property (nonatomic, copy) NSString* bj_color;
@property (nonatomic, copy) NSString* str1;
@property (nonatomic, copy) NSString* font_color1;
@property (nonatomic, copy) NSString* bj_color1;
@property (nonatomic, copy) NSString* is_jump_detail;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, copy) NSString* fnuo_id;
@property (nonatomic, copy) NSString* shop_type;


@property (nonatomic, strong) NSArray<FNBaseProductModel*>* goods_msg;

@end

NS_ASSUME_NONNULL_END
