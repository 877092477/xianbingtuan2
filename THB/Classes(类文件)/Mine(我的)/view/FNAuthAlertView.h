//
//  FNAuthAlertView.h
//  THB
//
//  Created by Weller Zhao on 2019/3/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNAuthAlertView : UIView

typedef void(^AuthBlock)(void);

- (void)showTitle: (NSString*)title withDesc: (NSString*)desc block: (AuthBlock) block;

@end

NS_ASSUME_NONNULL_END
