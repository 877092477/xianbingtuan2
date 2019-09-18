//
//  FNStoreLocationRedpackPayAlertView.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/30.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreLocationRedpackPayModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNStoreLocationRedpackPayAlertView;
@protocol FNStoreLocationRedpackPayAlertViewDelegate <NSObject>

- (void)onAlertPayTypeClick;
- (void)onAlertPayClick;

@end

@interface FNStoreLocationRedpackPayAlertView : UIView

@property (nonatomic, weak) id<FNStoreLocationRedpackPayAlertViewDelegate> delegate;

- (void)show: (NSString*)title;
- (void)dismiss;

- (void)setPay: (FNStoreLocationRedpackPayModel*) model;
- (void)setPayType: (NSString*)payType;

@end

NS_ASSUME_NONNULL_END
