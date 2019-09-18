//
//  FNNewStorePayAlertView.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/30.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStorePayModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNNewStorePayAlertView;
@protocol FNNewStorePayAlertViewDelegate <NSObject>

- (void)onAlertPayClick;
- (void)onAlertPayTypeClick;

- (void)onAlertPayCouponeClick;
- (void)onAlertPayRedpackClick;

@end

@interface FNNewStorePayAlertView : UIView

@property (nonatomic, weak) id<FNNewStorePayAlertViewDelegate> delegate;

- (void)show: (NSString*)title;
- (void)dismiss;
- (void)setPay: (FNStorePayConfirmModel*) model;

- (void)setPayType: (NSString*)payType;

@end

NS_ASSUME_NONNULL_END
