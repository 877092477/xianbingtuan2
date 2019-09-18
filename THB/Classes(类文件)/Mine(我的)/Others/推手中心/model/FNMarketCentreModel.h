//
//  FNMarketCentreModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNMarketCentreModel : NSObject
@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSString* bili;
@property (nonatomic, copy)NSString* color;
@property (nonatomic, copy)NSString* code;
@property (nonatomic, copy)NSString* commission;
@property (nonatomic, copy)NSString* commission_str;
@property (nonatomic, copy)NSString* str1;
@property (nonatomic, copy)NSString* str2;
@property (nonatomic, copy)NSString* str3;
@property (nonatomic, copy)NSString* shouru;
@property (nonatomic, copy)NSString* tixian;
@property (nonatomic, copy)NSString* select_color;
@property (nonatomic, copy)NSArray* select;

@property (nonatomic, copy)NSString* status;
@end

@interface FNMarketCentreSelectModel : NSObject
@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* type;
@property (nonatomic, copy)NSArray* list;
@end

@interface FNMarketCentreSelectItemModel : NSObject
@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* type;
@property (nonatomic, copy)NSString* type1;
@property (nonatomic, copy)NSString* select_color;
@property (nonatomic, assign)NSInteger  seletedInt;
@property (nonatomic, assign)NSInteger typeAdId;

@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSString* imgOne;
@property (nonatomic, copy)NSString* imgTwo;
@end

@interface FNMarketCentreStoreItemModel : NSObject 
@property (nonatomic, copy)NSString* id;
@property (nonatomic, copy)NSString* uid;
@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSString* order_counts;
@property (nonatomic, copy)NSString* commission;
@property (nonatomic, copy)NSString* td_commission;
@property (nonatomic, copy)NSString* order_str;
@property (nonatomic, copy)NSString* commission_str;
@property (nonatomic, copy)NSString* td_commission_str;
@property (nonatomic, copy)NSString* commission_str_color;
@property (nonatomic, copy)NSString* td_commission_color;

@property (nonatomic, copy)NSString* icon;

@property (nonatomic, copy)NSString* time;
@property (nonatomic, copy)NSString* time_color;
@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* str_color;
@property (nonatomic, copy)NSString* status;
@property (nonatomic, copy)NSString* status_color;
@property (nonatomic, copy)NSString* commission_color;
@end

NS_ASSUME_NONNULL_END
