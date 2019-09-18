//
//  ExceptionCrash.h
//  THB
//
//  Created by Weller Zhao on 2018/12/24.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExceptionCrash : NSObject

+(instancetype) shareInstance;
- (void)config;

@end

NS_ASSUME_NONNULL_END
