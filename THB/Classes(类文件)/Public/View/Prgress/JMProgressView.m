//
//  JMProgressView.m
//  ALL_Gain
//
//  Created by jimmy on 2017/8/7.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMProgressView.h"

@interface JMProgressView ()
@property (nonatomic, strong)CAShapeLayer* progresslayer;
@property (nonatomic, strong)CAGradientLayer* gradientlayer;
@end
@implementation JMProgressView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgColor = [UIColor whiteColor];
        self.highlightedColor  = [UIColor redColor];
        self.maxNum = 100.0;
    }
    return self;
}
- (void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
}
- (void)setPersentNum:(CGFloat)persentNum{
    CGFloat rate = persentNum/self.maxNum;
    [self.progresslayer removeFromSuperlayer];
    self.progresslayer = nil;
    [self.gradientlayer removeFromSuperlayer];
    self.gradientlayer = nil;
    if (rate>=1) {
        rate = 1;
    }else if (rate <= 0){
        rate = 0;
        return;
    }
    
    
    
    if (self.isGradient) {
        _gradientlayer = [CAGradientLayer layer];
        _gradientlayer.colors = @[(__bridge id)self.highlightedColor.CGColor, (__bridge id)self.bgColor.CGColor];
        _gradientlayer.startPoint = CGPointMake(0, 0);
        _gradientlayer.endPoint = CGPointMake(1.0, 0);
        _gradientlayer.frame = CGRectMake(0, 0, self.width*rate, self.height);
        [self.layer addSublayer:self.gradientlayer]; 
        CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnima.duration = 1;
        pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnima.fillMode = kCAFillModeForwards;
        pathAnima.removedOnCompletion = NO;
        [self.gradientlayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
    }else{
        UIBezierPath* path = [UIBezierPath bezierPath];
        [path moveToPoint:(CGPointMake(0, self.height*0.5))];
        [path addLineToPoint:(CGPointMake(self.width*rate, self.height*0.5))];
        path.lineWidth = self.height;
        
        self.progresslayer = [[CAShapeLayer alloc]init];
        self.progresslayer.strokeColor  =self.highlightedColor.CGColor;
        self.progresslayer.path = path.CGPath;
        self.progresslayer.lineWidth = self.height;
        self.progresslayer.lineCap = @"round";
        [self.layer addSublayer:self.progresslayer];
        
        CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnima.duration = 1;
        pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnima.fillMode = kCAFillModeForwards;
        pathAnima.removedOnCompletion = NO;
        [self.progresslayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
    }
    
    
    
}
@end
