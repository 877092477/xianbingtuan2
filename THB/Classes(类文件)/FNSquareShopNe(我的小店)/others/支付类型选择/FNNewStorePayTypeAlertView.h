//
//  FNNewStorePayTypeAlertView.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/1.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNNewStorePayTypeModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNNewStorePayTypeAlertView;
@protocol FNNewStorePayTypeAlertViewDelegate <NSObject>

- (void)payTypeAlert: (FNNewStorePayTypeAlertView*)view didSelected: (FNNewStorePayTypeModel*) type;

@end

@interface FNNewStorePayTypeAlertView : UIView

@property (nonatomic, weak) id<FNNewStorePayTypeAlertViewDelegate> delegate;

- (void)show;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
