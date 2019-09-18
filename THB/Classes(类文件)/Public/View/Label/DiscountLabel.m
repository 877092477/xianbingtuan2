//
//  DiscountLabel.m
//  Text3_3
//
//  Created by Jimmy on 15/9/24.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//
 

#import "DiscountLabel.h"

@implementation DiscountLabel
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setNeedsDisplay];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    //创建画笔
    CGContextRef cgrf = UIGraphicsGetCurrentContext();
    //设置画笔宽度
    CGContextSetLineWidth(cgrf, self.lineWidth);
    //获取label边框
    CGPoint point = CGPointMake(self.frame.size.width, self.frame.size.height);
    //设置画笔颜色
    CGContextSetStrokeColorWithColor(cgrf, self.lineColor.CGColor);
    
    //开始画画
    CGContextMoveToPoint(cgrf, 0, point.y/2);
    CGContextAddLineToPoint(cgrf, point.x, point.y/2);
    //填充
    CGContextStrokePath(cgrf);
    [super drawRect:rect];
}
@end
