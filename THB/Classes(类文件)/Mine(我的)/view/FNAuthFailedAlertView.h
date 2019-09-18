//
//  FNAuthFailedAlertView.h
//  THB
//
//  Created by Weller Zhao on 2019/3/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNAuthFailedAlertView : UIView

typedef void(^AuthBlock)(void);

- (void)showTitle: (NSString*)title withDesc: (NSString*)desc authBlock: (AuthBlock) block cancleBlock:(AuthBlock) cancleBlock;

- (void)showTitle: (NSString*)title withDesc: (NSString*)desc leftTitle: (NSString*)leftTitle rightTitle: (NSString*)rightTitle leftBlock: (AuthBlock) leftBlock rightBlock: (AuthBlock) rightBlock;

@end

NS_ASSUME_NONNULL_END
