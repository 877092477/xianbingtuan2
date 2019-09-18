//
//  FNIntegralMallAddressController.h
//  THB
//
//  Created by Weller Zhao on 2019/1/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class FNAddressModel;
@protocol FNIntegralMallAddressControllerDelegate <NSObject>

- (void)didAddressSelected: (FNAddressModel*)address;

@end

@interface FNIntegralMallAddressController : SuperViewController

@property (nonatomic, weak) id<FNIntegralMallAddressControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
