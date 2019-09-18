//
//  FNNewStoreCarAlertView.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/27.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreCarModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNNewStoreCarAlertView;
@protocol FNNewStoreCarAlertViewDelegate <NSObject>

- (void)didClearClick: (FNNewStoreCarAlertView*)alertView;
- (void)didSubClick: (FNNewStoreCarAlertView*)alertView atIndex: (NSInteger) index;
- (void)didAddClick: (FNNewStoreCarAlertView*)alertView atIndex: (NSInteger) index;

@end

@interface FNNewStoreCarAlertView : UIView

@property (nonatomic, weak) id<FNNewStoreCarAlertViewDelegate> delegate;

- (void)setCars: (NSArray<FNStoreCarModel*>*) cars;
- (void)show;
- (void)dismiss;

- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
