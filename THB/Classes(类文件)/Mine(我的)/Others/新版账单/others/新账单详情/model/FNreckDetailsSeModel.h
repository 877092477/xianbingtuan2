//
//  FNreckDetailsSeModel.h
//  THB
//
//  Created by Jimmy on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNreckDetailsSeModel : NSObject

@property (nonatomic, copy)NSString* str;

@property (nonatomic, copy)NSString* str1;

@property (nonatomic, copy)NSString* type_str;

@property (nonatomic, copy)NSString* img;

@property (nonatomic, copy)NSString* interal;

@property (nonatomic, copy)NSArray* list;

@end

@interface FNreckDetailsItemModel : NSObject

@property (nonatomic, copy)NSString* name;

@property (nonatomic, copy)NSString* val;

@property (nonatomic, copy)NSString* is_order;

@end

NS_ASSUME_NONNULL_END
