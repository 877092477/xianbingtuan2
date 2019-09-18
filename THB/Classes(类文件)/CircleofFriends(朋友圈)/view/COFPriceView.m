//
//  COFPriceView.m
//  新版嗨如意
//
//  Created by Weller on 2019/5/28.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "COFPriceView.h"

@implementation COFPriceView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = self.bounds.size.height;
    CGFloat p = 0;
    CGFloat p1 = 0.5;
    [self cutWithTopLeftRounded: height * p topRightRounded: height * p1 bottomRightRounded: height * p bottomLeftRounded: height * p1];
}
    
    - (void)cutWithTopLeftRounded:(CGFloat)topLeftRounded topRightRounded:(CGFloat)topRightRounded bottomRightRounded:(CGFloat)bottomRightRounded bottomLeftRounded:(CGFloat)bottomLeftRounded{
        
        UIBezierPath* path = [UIBezierPath bezierPath];
        
        // 开始绘画 - 顺时针
        
        //左上
        [path addArcWithCenter:CGPointMake(topLeftRounded, topLeftRounded) radius:topLeftRounded startAngle:M_PI endAngle:M_PI *3/2 clockwise:YES];
        [path addLineToPoint:CGPointMake(self.width - topRightRounded, 0)];
        
        //右上
        [path addArcWithCenter:CGPointMake(self.width - topRightRounded, topRightRounded) radius:topRightRounded startAngle:M_PI *3/2 endAngle:0 clockwise:YES];
        [path addLineToPoint:CGPointMake(self.width, self.height - bottomRightRounded)];
        
        //右下
        [path addArcWithCenter:CGPointMake(self.width - bottomRightRounded, self.height - bottomRightRounded) radius:bottomRightRounded startAngle:0 endAngle:M_PI *1/2 clockwise:YES];
        [path addLineToPoint:CGPointMake(bottomLeftRounded, self.height)];
        
        //左下
        [path addArcWithCenter:CGPointMake(bottomLeftRounded, self.height - bottomLeftRounded) radius:bottomLeftRounded startAngle:M_PI *1/2 endAngle:M_PI clockwise:YES];
        [path addLineToPoint:CGPointMake(0, topLeftRounded)];
        
        
        CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
        maskLayer1.frame = self.bounds;
        maskLayer1.path = path.CGPath;
        self.layer.mask = maskLayer1;
    }

@end
