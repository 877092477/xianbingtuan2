//
//  FNSearchTipsAlertView.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/9.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FNSearchTipsAlertViewDelegate <NSObject>

- (void)didTipsSelect: (NSString*)tip;

@end

@interface FNSearchTipsAlertView : UIView

@property (nonatomic, weak) id<FNSearchTipsAlertViewDelegate> delegate;

- (void)showTips: (NSString*)keyword SkipUIIdentifier: (NSString*) SkipUIIdentifier;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
