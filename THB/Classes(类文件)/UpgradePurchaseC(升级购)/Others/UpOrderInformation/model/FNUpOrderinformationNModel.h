//
//  FNUpOrderinformationNModel.h
//  THB
//
//  Created by 李显 on 2018/10/4.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNUpOrderinformationNModel : NSObject
@property (nonatomic, copy) NSDictionary *address;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSArray *alipay_type;
@property (nonatomic, copy) NSDictionary *goodsInfo;
@property (nonatomic, copy) NSString *is_hasaddress;
@property (nonatomic, copy) NSArray *msg;
@property (nonatomic, copy) NSString *payment;
@end



@interface FNUpOrderAddressNModel : NSObject

@property (nonatomic, copy) NSString *address_id;
@property (nonatomic, copy) NSString *address_msg;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *defauls;
@property (nonatomic, copy) NSString *detail_address;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *is_acquiesce;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *surname;

@end

@interface FNUpOrderAlipayNModel : NSObject

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *is_not_pay;
@property (nonatomic, copy) NSString *str;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *val;
@end

@interface FNUpOrderGoodsInfoNModel : NSObject

@property (nonatomic, copy) NSString *attr;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *label1;
@property (nonatomic, copy) NSString *label_bjcolor1;
@property (nonatomic, copy) NSString *label_fontcolor1;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *title;
@end

@interface FNUpOrderMsgNModel : NSObject

@property (nonatomic, copy) NSString *str;
@property (nonatomic, copy) NSString *val;
@end
