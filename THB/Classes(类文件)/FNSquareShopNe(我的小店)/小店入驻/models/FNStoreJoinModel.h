//
//  FNStoreJoinModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/19.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNStoreJoinCateModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNStoreJoinItemModel : NSObject

@property (nonatomic, copy) NSString* bj_color;
@property (nonatomic, copy) NSString* font_color;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* desc;
@property (nonatomic, copy) NSString* img;

@end

@interface FNStoreJoinModel : NSObject

@property (nonatomic, copy) NSString* has_store;
@property (nonatomic, copy) NSString* has_store_tps;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* top_img;
@property (nonatomic, copy) NSString* btn_font;
@property (nonatomic, copy) NSString* btn_color;
@property (nonatomic, copy) NSString* btn_bj;
@property (nonatomic, strong) NSArray<FNStoreJoinItemModel*>* introducts;

@end

@interface FNStoreJoinFormModel : NSObject

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* select_color;
@property (nonatomic, copy) NSString* select_font_color;
@property (nonatomic, copy) NSString* need_extend_id;
@property (nonatomic, strong) NSArray<FNStoreJoinCateModel*>* cate;

@end

NS_ASSUME_NONNULL_END
