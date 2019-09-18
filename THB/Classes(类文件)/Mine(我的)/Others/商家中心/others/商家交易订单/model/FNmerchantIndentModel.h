//
//  FNmerchantIndentModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNmerchantIndentModel : NSObject
@property (nonatomic, copy)NSString* select_color;
@property (nonatomic, strong)NSArray* status;
@property (nonatomic, strong)NSArray* date;
@property (nonatomic, strong)NSArray* type;
@property (nonatomic, copy)NSString* top_bj;
@property (nonatomic, copy)NSString* color;
@property (nonatomic, copy)NSString* balance_text;
@property (nonatomic, copy)NSString* balance;
@property (nonatomic, copy)NSString* tixian_tips;
@property (nonatomic, copy)NSString* tixian_btn;
@property (nonatomic, copy)NSString* tixian_btn_color;
@property (nonatomic, copy)NSString* tixian_btn_bj;

@property (nonatomic, copy)NSString* counts_str;
@property (nonatomic, copy)NSString* counts_color;
@property (nonatomic, copy)NSString* counts;
@property (nonatomic, copy)NSString* commossion_str;
@property (nonatomic, copy)NSString* commossion_color;
@property (nonatomic, copy)NSString* commossion;
@property (nonatomic, copy)NSArray* list;
@end

@interface FNmerchantIndentTypeModel : NSObject
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* status;
@property (nonatomic, copy)NSString* date; 
@end


@interface FNmerchantIndentItemModel : NSObject 
@property (nonatomic, copy)NSString* date;
@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSString* username;
@property (nonatomic, copy)NSString* head_img;
@property (nonatomic, copy)NSString* order_id;
@property (nonatomic, copy)NSString* create_date;
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* status;
@property (nonatomic, copy)NSString* status_str;
@property (nonatomic, copy)NSString* status_bj; 
@property (nonatomic, copy)NSString* status_color;
@property (nonatomic, copy)NSString* income;
@property (nonatomic, copy)NSString* income_color;
@property (nonatomic, copy)NSString* income_str;

@property (nonatomic, copy)NSString* type_str;
@property (nonatomic, copy)NSString* type_str_color;

@end

NS_ASSUME_NONNULL_END
