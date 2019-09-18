//
//  FNIntegralMallOrdelModel.h
//  THB
//
//  Created by Weller Zhao on 2019/1/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNIntegralMallOrdelAddressModel : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* phone;
@property (nonatomic, copy) NSString* address_id;
@property (nonatomic, copy) NSString* address_msg;

@end

@interface FNIntegralMallOrdelGoodsModel : NSObject

@property (nonatomic, copy) NSString* num;
@property (nonatomic, copy) NSString* ID;
@property (nonatomic, copy) NSString* price;
@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* attr;
@property (nonatomic, copy) NSString* title;

@end

@interface FNIntegralMallOrdelMsgModel : NSObject

@property (nonatomic, copy) NSString* str;
@property (nonatomic, copy) NSString* val;

@end

@interface FNIntegralMallOrdelPayModel : NSObject

@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* str;
@property (nonatomic, copy) NSString* val;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* is_not_pay;

@end

@interface FNIntegralMallOrdelModel : NSObject

@property (nonatomic, copy) NSString* payment;
@property (nonatomic, copy) NSString* total;
@property (nonatomic, copy) NSString* is_hasaddress;
@property (nonatomic, copy) NSString* is_need_pay;

@property (nonatomic, strong) FNIntegralMallOrdelAddressModel* address;
@property (nonatomic, strong) FNIntegralMallOrdelGoodsModel* goodsInfo;
@property (nonatomic, strong) NSArray<FNIntegralMallOrdelMsgModel*>* msg;
@property (nonatomic, strong) NSArray<FNIntegralMallOrdelPayModel*>* alipay_type;

@end

NS_ASSUME_NONNULL_END
