//
//  FNMyCardPayTypeModel.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNMyCardPayTypeModel : NSObject

@property(nonatomic, copy) NSString* pay_type;
@property(nonatomic, copy) NSString* img;
@property(nonatomic, copy) NSString* str;
@property(nonatomic, copy) NSString* str2;
@property(nonatomic, copy) NSString* val;

@property (nonatomic, assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
