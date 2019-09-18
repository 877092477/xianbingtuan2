//
//  FNmeMemberIndentItemModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNmeMemberIndentItemModel : NSObject
@property (nonatomic, copy)NSString* id;
@property (nonatomic, copy)NSString* orderId;
@property (nonatomic, copy)NSString* store_id;
@property (nonatomic, copy)NSString* pay_type;
@property (nonatomic, copy)NSString* buy_type;
@property (nonatomic, copy)NSString* createDate;
@property (nonatomic, copy)NSString* confirmDate;
@property (nonatomic, copy)NSString* phone;
@property (nonatomic, copy)NSString* aid;
@property (nonatomic, copy)NSString* is_use;
@property (nonatomic, copy)NSString* is_pay;
@property (nonatomic, copy)NSString* is_rebate;
@property (nonatomic, copy)NSString* payment;
@property (nonatomic, copy)NSString* commission;
@property (nonatomic, copy)NSString* bili;
@property (nonatomic, copy)NSString* discount;
@property (nonatomic, copy)NSString* now_user;
@property (nonatomic, copy)NSString* payment_time;
@property (nonatomic, copy)NSString* code;
@property (nonatomic, copy)NSString* is_cancel;
@property (nonatomic, copy)NSString* fcommission;
@property (nonatomic, copy)NSString* lv_bili;
@property (nonatomic, copy)NSString* alipay_id;
@property (nonatomic, copy)NSString* uid;
@property (nonatomic, copy)NSString* box_price;
@property (nonatomic, copy)NSString* postage_money;
@property (nonatomic, copy)NSString* returnstatus;
@property (nonatomic, copy)NSString* delay_time;
@property (nonatomic, copy)NSString* delay_count;
@property (nonatomic, copy)NSString* area_fl;
@property (nonatomic, copy)NSString* choucheng;
@property (nonatomic, copy)NSString* fxz_commission;
@property (nonatomic, copy)NSString* fxz_fcommission;
@property (nonatomic, copy)NSString* in_refund;
@property (nonatomic, copy)NSString* refund_str;
@property (nonatomic, copy)NSString* store_name;
@property (nonatomic, copy)NSString* store_phone;
@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* type;
@property (nonatomic, copy)NSString* type_color;
@property (nonatomic, copy)NSString* status;
@property (nonatomic, copy)NSString* color;
@property (nonatomic, copy)NSString* str1;
@property (nonatomic, copy)NSString* t;
@property (nonatomic, copy)NSString* count;
@property (nonatomic, copy)NSString* content;
@property (nonatomic, copy)NSArray *goods; 

@property (nonatomic, copy)NSString* has_comment;
@property (nonatomic, copy)NSString* confirm_service;
@property (nonatomic, copy)NSString* apply_refund;
@end

@interface FNmeMemberIndentGoodsItemModel : NSObject 
@property (nonatomic, copy)NSString* count;
@property (nonatomic, copy)NSString* goods_price;
@property (nonatomic, copy)NSString* specs;
@property (nonatomic, copy)NSString* attribute;
@property (nonatomic, copy)NSString* goods_title;
@property (nonatomic, copy)NSString* gid;
@property (nonatomic, copy)NSString* goods_img;
@property (nonatomic, copy)NSString* sum;
@property (nonatomic, copy)NSString* type;
@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* color;
@property (nonatomic, copy)NSString* font_color;
@property (nonatomic, copy)NSString* str1;
@property (nonatomic, copy)NSString* commission;
@property (nonatomic, copy)NSString* fxz_bili;
@property (nonatomic, copy)NSString* number;
@property (nonatomic, copy)NSString* tips;
@end
NS_ASSUME_NONNULL_END
