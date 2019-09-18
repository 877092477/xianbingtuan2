//
//  FNmerConsumeModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNmerConsumeModel : NSObject
@property (nonatomic, copy)NSString  *type;
@property (nonatomic, copy)NSString  *title;
@property (nonatomic, copy)NSArray   *listArr;

@property (nonatomic, copy)NSArray   *goods;
@property (nonatomic, copy)NSArray   *order_msg;
@property (nonatomic, copy)NSString  *shifu;
@property (nonatomic, copy)NSString  *code;
@property (nonatomic, copy)NSString  *store;
@property (nonatomic, copy)NSString  *id;
@property (nonatomic, copy)NSString  *is_use;

@property (nonatomic, copy)NSString  *seekStr;
@end


@interface FNmerConsumeGoodsItemModel : NSObject
@property (nonatomic, copy)NSString  *count;
@property (nonatomic, copy)NSString  *goods_price;
@property (nonatomic, copy)NSString  *specs;
@property (nonatomic, copy)NSString  *attribute;
@property (nonatomic, copy)NSString  *goods_title;
@property (nonatomic, copy)NSString  *gid;
@property (nonatomic, copy)NSString  *goods_img;
@property (nonatomic, copy)NSString  *sum;
@property (nonatomic, copy)NSString  *type;
@property (nonatomic, copy)NSString  *str;
@property (nonatomic, copy)NSString  *color;
@property (nonatomic, copy)NSString  *font_color;
@property (nonatomic, copy)NSString  *str1;
@property (nonatomic, copy)NSString  *commission;
@property (nonatomic, copy)NSString  *fxz_bili;
@property (nonatomic, copy)NSString  *number;
@property (nonatomic, copy)NSString  *tips;


@property (nonatomic, copy)NSString  *id;

@property (nonatomic, copy)NSString  *val;
@end
NS_ASSUME_NONNULL_END
