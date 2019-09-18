//
//  FNmarketBillModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNmarketBillModel : NSObject
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSArray* types;
@property (nonatomic, copy)NSArray* dates;
@property (nonatomic, copy)NSString* types_color;
@property (nonatomic, copy)NSString* dates_color;
@end

@interface FNmarketBillTypeItemModel : NSObject
@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* date;
@property (nonatomic, copy)NSString* type;
@end

@interface FNmarketBillItemModel : NSObject
@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* time;
@property (nonatomic, copy)NSString* commission;
@end
NS_ASSUME_NONNULL_END
