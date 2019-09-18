//
//  FNNewStoreCouponeAlertView.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/26.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNstoreInformationDaModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNNewStoreCouponeAlertView;
@protocol FNNewStoreCouponeAlertViewDelegate <NSObject>

- (void)onCouponeClickAt: (NSInteger) index;

@end

@interface FNNewStoreCouponeAlertView : UIView

@property (nonatomic, weak) id<FNNewStoreCouponeAlertViewDelegate> delegate;

- (void)setCoupones: (NSArray<FNstoreCouponeModel*>*) coupones;
- (void)show;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
