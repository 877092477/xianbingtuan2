//
//  FNAddressModel.h
//  THB
//
//  Created by Weller Zhao on 2019/1/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNAddressModel : NSObject

@property (nonatomic, copy) NSString* province;
@property (nonatomic, copy) NSString* city;
@property (nonatomic, copy) NSString* district;
@property (nonatomic, copy) NSString* area;
@property (nonatomic, copy) NSString* address;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* phone;
@property (nonatomic, copy) NSString* ID;
@property (nonatomic, copy) NSString* defauls;
@property (nonatomic, copy) NSString* label;
@property (nonatomic, copy) NSString* detail_address;
@property (nonatomic, copy) NSString* surname;
@property (nonatomic, copy) NSString* is_acquiesce;

@end

NS_ASSUME_NONNULL_END
