//
//  FNmeFicheisModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNmeFicheisModel : NSObject

@property (nonatomic, copy)NSArray* cates;
@property (nonatomic, copy)NSString* select_color;

@end



@interface FNmeFicheTypeisModel : NSObject

@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* type;

@end

@interface FNmeFicheItemisModel : NSObject

@property (nonatomic, copy)NSString* id;
@property (nonatomic, copy)NSString* discount_use;
@property (nonatomic, copy)NSString* coupon_use;
@property (nonatomic, copy)NSString* money;
@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* tips;
@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* str1;
@property (nonatomic, copy)NSString* str3;
@property (nonatomic, copy)NSString* store_name;
@property (nonatomic, copy)NSString* store_id;
@end


NS_ASSUME_NONNULL_END
