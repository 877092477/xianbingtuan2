//
//  FNIntegralMallDetailModel.h
//  THB
//
//  Created by Weller Zhao on 2019/1/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FNIntegralMallDetailAtrrDataModel;
@interface FNIntegralMallDetailAtrrSectionModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray<FNIntegralMallDetailAtrrDataModel*> *attr_val;

@end
            
@interface FNIntegralMallDetailAtrrDataModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *ID;
@end

@interface FNIntegralMallDetailLabelModel : NSObject
@property (nonatomic, copy) NSString *str;
@property (nonatomic, copy) NSString *img;
@end

@interface FNIntegralMallDetailModel : FNBaseProductModel

@property (nonatomic, copy) NSArray<FNIntegralMallDetailAtrrSectionModel*> *attr_data;
@property (nonatomic, copy) NSString *sales;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *label_color;
@property (nonatomic, copy) NSArray<FNIntegralMallDetailLabelModel*> *detail_label;
@property (nonatomic, copy) NSString *postage;
@property (nonatomic, copy) NSString *nowIntegral;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *detail_getimg;
@property (nonatomic, copy) NSArray<NSString*> *banner_img;
@property (nonatomic, copy) NSString *sales_str;
@property (nonatomic, copy) NSString *btn_str;
@property (nonatomic, copy) NSString *btn_color;
@property (nonatomic, copy) NSString *btn_bjcolor;
@property (nonatomic, copy) NSString *tip_str;
@property (nonatomic, copy) NSString *tip_bjcolor;
@property (nonatomic, copy) NSString *tip_color;
@property (nonatomic, copy) NSString *is_can_buy;
@property (nonatomic, copy) NSString *postage_str;
@property (nonatomic, copy) NSString *kf_bjcolor;
@property (nonatomic, copy) NSString *kf_str;
@property (nonatomic, copy) NSString *kf_fontcolor;
@property (nonatomic, copy) NSString *kf_img;
@property (nonatomic, copy) NSString *buy_img;
@property (nonatomic, copy) NSArray<NSString*> *detail_img;

@property (nonatomic, copy) NSString *top_title;

@property (nonatomic, copy) NSString * f_str;

@property (nonatomic, assign) int limit_num;

@end

NS_ASSUME_NONNULL_END
