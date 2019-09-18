//
//  FNCouponTransitionView.h
//  THB
//
//  Created by jimmy on 2017/5/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FNBaseProductModel;
@interface FNCouponTransitionView : UIView
@property (nonatomic, strong)FNBaseProductModel* model;
+ (void)showWithModel:(FNBaseProductModel* )model;
+ (void)hiddenCouopon;
@end
