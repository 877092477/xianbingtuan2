//
//  FNUpDetailsNModel.h
//  THB
//
//  Created by Jimmy on 2018/9/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNUpDetailsNModel : FNBaseProductModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *stock;
@property (nonatomic, copy) NSArray *attr_data;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *label_bjcolor;
@property (nonatomic, copy) NSString *label_fontcolor;
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *detail_img;
@property (nonatomic, copy) NSArray *standard_img;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *goods_sales;
@property (nonatomic, copy) NSString *postage;
@property (nonatomic, copy) NSArray *slide_img;
@property (nonatomic, copy) NSString *time_str;
@property (nonatomic, copy) NSString *is_postage;
@property (nonatomic, copy) NSString *label1;
@property (nonatomic, copy) NSString *label2;
@property (nonatomic, copy) NSString *label3;
@property (nonatomic, copy) NSString *label_fontcolor1;
@property (nonatomic, copy) NSString *label_fontcolor2;
@property (nonatomic, copy) NSString *label_fontcolor3;
@property (nonatomic, copy) NSString *label_bjcolor1;
@property (nonatomic, copy) NSString *label_bjcolor2;
@property (nonatomic, copy) NSString *label_bjcolor3;
@property (nonatomic, copy) NSDictionary *like;
@property (nonatomic, copy) NSArray *attr;
@property (nonatomic, copy) NSString *f_str;

@end


@interface FNUpDetailsLikeNModel : NSObject

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSMutableArray *goods;

@end



@interface FNUpDetailsLikeGoodsNModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *stock;
@property (nonatomic, copy) NSArray *attr_data;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *label_bjcolor;
@property (nonatomic, copy) NSString *label_fontcolor;
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *detail_img;
@property (nonatomic, copy) NSArray *standard_img;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *goods_sales;
@property (nonatomic, copy) NSString *postage;
@property (nonatomic, copy) NSArray *slide_img;
@property (nonatomic, copy) NSString *time_str;
@property (nonatomic, copy) NSString *is_postage;
@property (nonatomic, copy) NSString *label1;
@property (nonatomic, copy) NSString *label2;
@property (nonatomic, copy) NSString *label3;
@property (nonatomic, copy) NSString *label_fontcolor1;
@property (nonatomic, copy) NSString *label_fontcolor2;
@property (nonatomic, copy) NSString *label_fontcolor3;
@property (nonatomic, copy) NSString *label_bjcolor1;
@property (nonatomic, copy) NSString *label_bjcolor2;
@property (nonatomic, copy) NSString *label_bjcolor3;

@end


@interface FNUpGoodsAttrNModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *attr_val;


@end


@interface FNUpGoodsAttrItemNModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *id;
/** 是否点击 */
@property (nonatomic,assign)BOOL isSelect;

@end
