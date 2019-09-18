//
//  FNAuthController.h
//  THB
//
//  Created by Weller Zhao on 2019/1/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "secondViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNAuthController : secondViewController

typedef void(^AuthVCBlock)(BOOL);

@property (nonatomic, strong) AuthVCBlock block;

@end

NS_ASSUME_NONNULL_END
