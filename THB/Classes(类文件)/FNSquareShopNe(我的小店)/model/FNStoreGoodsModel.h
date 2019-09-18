//
//  FNStoreGoodsModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/24.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNStoreGoodsSpecDataModel : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* price;
@property (nonatomic, copy) NSString* stock;
@property (nonatomic, copy) NSString* id;
@property (nonatomic, assign)BOOL isSelected;

@end

@interface FNStoreGoodsSpecModel : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSArray<FNStoreGoodsSpecDataModel*>* data;

@end

@interface FNStoreGoodsAttributeDataModel : NSObject

@property (nonatomic, copy) NSString* key;
@property (nonatomic, copy) NSString* value;

@end

@interface FNStoreGoodsAttributeModel : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSArray<FNStoreGoodsAttributeDataModel*>* data;

@end

@interface FNStoreGoodsModel : NSObject

@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* goods_title;
@property (nonatomic, copy) NSString* goods_price;
@property (nonatomic, copy) NSString* goods_cost_price;
@property (nonatomic, copy) NSString* stock;
@property (nonatomic, copy) NSString* goods_sales;
@property (nonatomic, copy) NSString* describe;
@property (nonatomic, copy) NSString* start_day;
@property (nonatomic, copy) NSString* end_day;
@property (nonatomic, copy) NSString* start_hour;
@property (nonatomic, copy) NSString* end_hour;
@property (nonatomic, copy) NSString* goods_img;
@property (nonatomic, copy) NSString* store_id;
@property (nonatomic, copy) NSString* data;
@property (nonatomic, copy) NSString* commission;
@property (nonatomic, copy) NSString* mealbox_money;
@property (nonatomic, copy) NSString* is_show;
@property (nonatomic, copy) NSString* is_discount;
@property (nonatomic, copy) NSString* share_bili;
@property (nonatomic, strong) FNStoreGoodsSpecModel* specs;
@property (nonatomic, strong) NSArray<FNStoreGoodsAttributeModel*>* attribute;
@property (nonatomic, copy) NSString* cate_id;
@property (nonatomic, copy) NSString* sort;
@property (nonatomic, copy) NSString* sales_str;
@property (nonatomic, copy) NSString* count;
@property (nonatomic, copy) NSString* day_str;
@property (nonatomic, copy) NSString* hour_str;
@property (nonatomic, copy) NSString* share_font;
@property (nonatomic, copy) NSString* share_font_color;
@property (nonatomic, copy) NSString* share_bjimg;
@property (nonatomic, copy) NSString* yhq_font;
@property (nonatomic, copy) NSString* yhq_font_color;
@property (nonatomic, copy) NSString* yhq_bjimg;
@property (nonatomic, copy) NSString* fanli_font;
@property (nonatomic, copy) NSString* fanli_font_color;
@property (nonatomic, copy) NSString* fanli_bjimg;

@end

NS_ASSUME_NONNULL_END
