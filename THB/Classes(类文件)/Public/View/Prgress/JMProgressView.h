//
//  JMProgressView.h
//  ALL_Gain
//
//  Created by jimmy on 2017/8/7.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMProgressView : UIView
@property (nonatomic, strong)UIColor* bgColor;
@property (nonatomic, strong)UIColor* highlightedColor;
@property (nonatomic, assign)CGFloat maxNum;
@property (nonatomic, assign)BOOL isGradient;
- (void)setPersentNum:(CGFloat)persentNum;
@end
