//
//  FNmerchantIndentItemCancleAlertView.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/24.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ConfirmClick)(BOOL isAgree, NSString *msg);

@interface FNmerchantIndentItemCancleAlertView : UIView

- (void)show: (ConfirmClick) block;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
