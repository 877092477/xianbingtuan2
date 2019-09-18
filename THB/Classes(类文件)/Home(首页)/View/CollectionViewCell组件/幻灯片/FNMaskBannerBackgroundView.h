//
//  FNMaskBannerBackgroundView.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNMaskBannerViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNMaskBannerBackgroundView : UIView<UIScrollViewDelegate>

#pragma mark- Array
//@property (nonatomic, strong)NSArray* bannerArray;
-(void)setBackgroundImage: (NSString*)imgUrl;
-(void)setForegroundImage: (NSString*)imgUrl;
-(void)setPercent: (CGFloat)percent;

@end

NS_ASSUME_NONNULL_END
