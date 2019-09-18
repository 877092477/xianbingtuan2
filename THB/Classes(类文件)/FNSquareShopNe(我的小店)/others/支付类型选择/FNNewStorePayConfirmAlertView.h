//
//  FNNewStorePayConfirmAlertView.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/1.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNrushPurchaseNeModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNNewStorePayConfirmAlertView;
@protocol FNNewStorePayConfirmAlertViewDelegate <NSObject>

- (void)didPayClick: (FNNewStorePayConfirmAlertView*)view;

@end

@interface FNNewStorePayConfirmAlertView : UIView

@property (nonatomic, weak) id<FNNewStorePayConfirmAlertViewDelegate> delegate;

- (void)show;
- (void)dismiss;

- (void)setModel: (FNrushPurchaseNeModel*) model payType: (NSString*)payType;

@end

NS_ASSUME_NONNULL_END
