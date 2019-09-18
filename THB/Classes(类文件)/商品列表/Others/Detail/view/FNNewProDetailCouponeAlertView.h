//
//  FNNewProDetailCouponeAlertView.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNNewProductDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNNewProDetailCouponeAlertView;
@protocol FNNewProDetailCouponeAlertViewDelegate <NSObject>

- (void)didBuyClick;
- (void)didCancleClick;
- (void)didRechargeClick;

@end

@interface FNNewProDetailCouponeAlertView : UIView

@property (nonatomic, weak) id<FNNewProDetailCouponeAlertViewDelegate> delegate;

- (void)show: (FNNewProductDetailCouponeModel*)model;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
