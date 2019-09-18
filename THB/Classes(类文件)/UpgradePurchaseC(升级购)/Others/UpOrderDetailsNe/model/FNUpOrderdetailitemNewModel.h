//
//  FNUpOrderdetailitemNewModel.h
//  THB
//
//  Created by 李显 on 2018/10/4.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNUpOrderdetailitemNewModel : NSObject

@property (nonatomic, copy) NSString *oid;
@property (nonatomic, copy) NSString *payment;
@property (nonatomic, copy) NSString *goods_payment;
@property (nonatomic, copy) NSString *postage;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *status_str;
@property (nonatomic, copy) NSString *status_num;
@property (nonatomic, copy) NSString *wl_str;
@property (nonatomic, copy) NSString *wl_id;
@property (nonatomic, copy) NSString *wl_company;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *str;
@property (nonatomic, copy) NSArray *goods;

@end

@interface FNOrderdetailitemGoodsNModel : NSObject

@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *attr;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *label1;
@property (nonatomic, copy) NSString *label_fontcolor1;
@property (nonatomic, copy) NSString *label_bjcolor1;

@end
