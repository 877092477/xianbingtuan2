//
//  FNControllerManager.h
//  新版嗨如意
//
//  Created by Weller on 2019/5/29.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNControllerManager : NSObject

typedef void(^ControllerBlock)(SuperViewController* controller);

+ (SuperViewController*) controllerWithModel: (id)model;

+ (SuperViewController*)goProductVCWithModel:(id)model;
+ (SuperViewController*)goProductVCWithModel:(id)model withData: (nullable NSDictionary*)data;
+ (SuperViewController*)goProductVCWithModel:(id)model withData: (nullable NSDictionary*)data isLive: (BOOL)isLive;


+ (void)apiRequesteDetail: (NSString*)url block: (ControllerBlock) block;

@end

NS_ASSUME_NONNULL_END
