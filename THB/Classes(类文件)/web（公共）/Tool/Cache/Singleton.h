//
//  Singleton.h
//  THB
//
//  Created by Weller Zhao on 2018/12/21.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Singleton : NSObject

+(instancetype) shareInstance;

@end

NS_ASSUME_NONNULL_END
