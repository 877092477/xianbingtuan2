//
//  FNStoreLocationRedpackCateAlertView.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/23.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreLocationRepackCateModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNStoreLocationRedpackCateAlertView;
@protocol FNStoreLocationRedpackCateAlertViewDelegate <NSObject>

- (void)alertView: (FNStoreLocationRedpackCateAlertView*)view didItemSelectedAt: (NSInteger) index;

@end

@interface FNStoreLocationRedpackCateAlertView : UIView

@property (nonatomic, weak) id<FNStoreLocationRedpackCateAlertViewDelegate> delegate;

- (void)show: (NSArray<FNStoreLocationRepackCateModel*>*)cates above: (UIView*)sender;
- (void)dismiss ;

@end

NS_ASSUME_NONNULL_END
