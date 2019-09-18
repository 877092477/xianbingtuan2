//
//  FNStorePayModel.h
//  THBTests
//
//  Created by Weller on 2019/7/29.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNStoreMyCouponeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNStorePayModel : NSObject
@property (nonatomic, copy) NSString* discount_str;
@property (nonatomic, copy) NSString* discount_id;
@property (nonatomic, copy) NSString* discount_bili;
@property (nonatomic, copy) NSString* tips;
@property (nonatomic, copy) NSString* commission_bili;
@property (nonatomic, copy) NSString* commission_str;
@end

@interface FNStorePayConfirmModel : NSObject

@property (nonatomic, copy) NSString* full_reduction_id;
@property (nonatomic, copy) NSString* full_reduction;
@property (nonatomic, copy) NSString* red_packet_count;
@property (nonatomic, copy) NSString* red_packet_str;
@property (nonatomic, copy) NSString* yhq_count;
@property (nonatomic, copy) NSString* yhq_str;
@property (nonatomic, copy) NSString* commission_str;
@property (nonatomic, copy) NSString* money;
@property (nonatomic, strong) NSArray<FNStoreMyCouponeModel*>* red_packet_list;
@property (nonatomic, copy) NSArray<FNStoreMyCouponeModel*>* yhq_list;

@end

NS_ASSUME_NONNULL_END
