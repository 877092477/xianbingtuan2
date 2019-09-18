//
//  FNUpgradeNMode.h
//  THB
//
//  Created by Jimmy on 2018/9/25.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNUpgradeNMode : NSObject
@property (nonatomic, copy) NSString *search_str;
@property (nonatomic, copy) NSString *topleft_str;
@property (nonatomic, copy) NSDictionary *recommend;
@property (nonatomic, copy) NSDictionary *preferential;
@end

@interface FNrecommendNMode : NSObject
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSMutableArray *goods;
@property (nonatomic, copy) NSMutableArray *cate;
@end


@interface FNRecommendNMode : FNBaseProductModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *label_bjcolor;
@property (nonatomic, copy) NSString *label_fontcolor;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *goods_sales;
@property (nonatomic, copy) NSString *postage;
@property (nonatomic, copy) NSString *detail_img;
@property (nonatomic, copy) NSString *standard_img;
@property (nonatomic, copy) NSArray  *slide_img;
@property (nonatomic, copy) NSString *preferential;
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
@property (nonatomic, copy) NSString *attr_data;
@property (nonatomic, copy) NSString *f_str;
@end
