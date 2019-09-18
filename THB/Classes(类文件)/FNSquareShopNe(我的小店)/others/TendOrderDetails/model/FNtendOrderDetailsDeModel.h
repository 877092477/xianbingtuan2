//
//  FNtendOrderDetailsDeModel.h
//  69橙子
//
//  Created by 李显 on 2018/12/9.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

 

@interface FNtendOrderDetailsDeModel : NSObject
@property(nonatomic, copy) NSString     *id;
@property(nonatomic, copy) NSString     *orderId;
@property(nonatomic, copy) NSString     *createDate;
@property(nonatomic, copy) NSString     *img;
@property(nonatomic, copy) NSString     *store_name;
@property(nonatomic, copy) NSString     *store_phone;
@property(nonatomic, copy) NSString     *code;
@property(nonatomic, copy) NSString     *payment;
@property(nonatomic, copy) NSString     *status;
@property(nonatomic, copy) NSString     *color;
@property(nonatomic, copy) NSString     *str1;
@property(nonatomic, copy) NSString     *t;
@property(nonatomic, copy) NSString     *str;

@property(nonatomic, copy) NSString     *str2;
@property(nonatomic, copy) NSString     *str3;
@property(nonatomic, copy) NSString     *buy_type;

@property(nonatomic, copy) NSDictionary     *buy_msg;
@property(nonatomic, copy) NSArray     *order_msg;

@property(nonatomic, copy) NSArray     *goods;

@property(nonatomic, copy) NSString     *apply_refund;

@end

 
@interface FNtendDetailsBuyMsgModel : NSObject
@property(nonatomic, copy) NSString     *address;
@property(nonatomic, copy) NSString     *phone;
@property(nonatomic, copy) NSString     *name;
@property(nonatomic, copy) NSString     *str;
@property(nonatomic, copy) NSString     *code;
@property(nonatomic, copy) NSString     *str_color;

@end


@interface FNtendDetailsOrderMsgModel : NSObject
@property(nonatomic, copy) NSString     *str;
@property(nonatomic, copy) NSString     *val;


@end


@interface FNtendDetailsGoodsModel : NSObject
@property(nonatomic, copy) NSString     *sum;
@property(nonatomic, copy) NSString     *type;
@property(nonatomic, copy) NSString     *count;
@property(nonatomic, copy) NSString     *goods_title;
@property(nonatomic, copy) NSString     *goods_img;
@property(nonatomic, copy) NSString     *str;
@property(nonatomic, copy) NSString     *color;
@property(nonatomic, copy) NSString     *font_color;
@property(nonatomic, copy) NSString     *str1;


@end
