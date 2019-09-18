//
//  FNNewFreeProductShareAlertView.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNNewFreeProductShareAlertView : UIView

typedef void(^ShareBlock)(NSInteger index);

+ (void)showImages: (NSArray<NSString*>*)imageUrls withTitles: (NSArray<NSString*>*)titles bottomOffset: (CGFloat)offset onClick: (ShareBlock) block;
+ (void)dismiss;

@end

NS_ASSUME_NONNULL_END
