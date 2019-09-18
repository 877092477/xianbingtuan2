//
//  FNBNHomeBouncedView.h
//  THB
//
//  Created by Jimmy on 2018/9/18.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNBNHomeBouncedView : UIView

@property (nonatomic, copy)void (^purchaseBlock) (id model);
+ (void)showWithModel:(id)model view:(UIView *)view purchaseblock:(void (^)(id model))block;

@end
