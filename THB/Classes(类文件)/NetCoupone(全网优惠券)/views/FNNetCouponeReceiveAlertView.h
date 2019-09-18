//
//  FNNetCouponeReceiveAlertView.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNNetCouponeAlertModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNNetCouponeReceiveAlertView : UIView

@property (nonatomic, copy)void (^btnClickedAction)(void);

- (void)show:(FNNetCouponeAlertModel*)model;
- (void)dismiss;

- (void)show:(NSString*)imgBorder button: (NSString*)imgButton desc: (NSString*)desc;

@end

NS_ASSUME_NONNULL_END
