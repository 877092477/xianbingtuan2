//
//  FNmerDeliverySetController.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "FNmerSetingsModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmerDeliverySetControllerDelegate <NSObject>
// 修改配送费
- (void)inDidMerDeliverySetRefreshAction;
@end
@interface FNmerDeliverySetController : SuperViewController
@property (nonatomic, strong)FNmerSetingsModel *dataModel;
@property (nonatomic, weak)id<FNmerDeliverySetControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END

