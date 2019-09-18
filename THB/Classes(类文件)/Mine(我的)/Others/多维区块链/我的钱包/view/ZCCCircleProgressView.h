//
//  ZCCCircleProgressView.h
//  MOSOBOStudent
//
//  Created by mac on 2017/10/23.
//  Copyright © 2017年 zcc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZCCCircleProgressView : UIView

@property (nonatomic, strong)NSTimer *timer;

- (void)addCircleWithColor:(UIColor *)color;

//背景色color  plancolor:完成进度色  edgeColor:边距色;
- (void)addCircleWithColor:(UIColor *)color withPlan:(UIColor *)plancolor withEdge:(UIColor *)edgeColor;
//画虚线
- (void)addimaginaryLineWithColor:(UIColor *)color;

- (void)deleteTimer;

- (void)addLabelWithStr:(NSString *)str;
//跳到进度
- (void)animateToProgress:(CGFloat)progress;
//进度为0
- (void)animateToZero;

@end
