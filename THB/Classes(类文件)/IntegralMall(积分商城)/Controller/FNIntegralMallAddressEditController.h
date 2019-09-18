//
//  FNIntegralMallAddressEditController.h
//  THB
//
//  Created by Weller Zhao on 2019/1/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "FNAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNIntegralMallAddressEditController;
@protocol FNIntegralMallAddressEditControllerDelegate <NSObject>

- (void)onAddressSave: (FNIntegralMallAddressEditController*)controller;

@end

@interface FNIntegralMallAddressEditController : SuperViewController

@property (nonatomic, strong, setter=setModel:) FNAddressModel *model;

@property (nonatomic, weak) id<FNIntegralMallAddressEditControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
