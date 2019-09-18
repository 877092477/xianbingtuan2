//
//  FNHomePromotionalView.h
//  THB
//
//  Created by jimmy on 2017/5/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FNBaseProductModel;
@interface FNHomePromotionalView : UIView
@property (nonatomic, copy)void (^clickedblock)(void);
+ (void)showWithModel:(FNBaseProductModel* )model clickedProBlock:(void(^)(void))block;
@end
