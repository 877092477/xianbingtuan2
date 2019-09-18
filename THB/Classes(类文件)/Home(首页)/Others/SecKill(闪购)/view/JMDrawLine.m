//
//  JMDrawLine.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/23.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMDrawLine.h"
typedef enum : NSUInteger {
    VerticalDirection,
    HorizonalDirection,
} Direction;
@interface JMDrawLine ()
@property (nonatomic, assign) DrawType drawType;
@property (nonatomic, assign) CGRect lineRect; // for dotted line
@property (nonatomic, strong) UIColor *lineColor;
@end
@implementation JMDrawLine
- (UIColor *)lineColor
{

    if (_lineColor == nil) {
        _lineColor = [UIColor grayColor];
    }
    return _lineColor;
}

- (void)drawDottedLine:(Direction)direction
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    if (direction == VerticalDirection) {
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) , CGRectGetHeight(self.frame)/2)];
    }else {
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
    }
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色
    [shapeLayer setStrokeColor:_lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:direction == VerticalDirection?CGRectGetWidth(self.frame):CGRectGetHeight(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:@[@1,@2.0]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    if (direction == VerticalDirection) {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(self.frame)-0.5);
    }else {
        CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame)-0.5, 0);
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];

}
- (void)drawRealLine:(Direction)direction
{
    self.layer.sublayers = nil;
    CAShapeLayer *realLineLayer = [CAShapeLayer new];
    CGMutablePathRef path = CGPathCreateMutable();
    realLineLayer.fillColor = self.lineColor.CGColor;
    realLineLayer.strokeColor = self.lineColor.CGColor;
    realLineLayer.lineWidth = direction == VerticalDirection?self.width: self.height;
    CGPathMoveToPoint(path, nil, 0, 0);
    
    if (direction ==  VerticalDirection) {
        CGPathAddLineToPoint(path, nil, 0, self.height);
    }else {
        CGPathAddLineToPoint(path, nil, self.width, 0);
    }
    
    
    realLineLayer.path = path;
    
    [self.layer addSublayer:realLineLayer];
    CGPathRelease(path);
    
}

+ (JMDrawLine *)createLineInRect:(CGRect)lineRect drawType:(DrawType)drawType andColor:(UIColor *)color
{
    JMDrawLine *line = [[JMDrawLine alloc]initWithFrame:lineRect];
    line.backgroundColor = [UIColor clearColor];
    line.lineRect = lineRect;
    line.drawType = drawType;
    line.lineColor = color;
    switch (drawType) {
        case RealLineVertical:
            [line drawRealLine:VerticalDirection];
            break;
        case RealLineHorizonal:
            [line drawRealLine:HorizonalDirection];
            break;
        case DottedLineVertical:
            [line drawDottedLine:VerticalDirection];
            break;
        case DottedLineHorizonal:
            [line drawDottedLine:HorizonalDirection];
            break;
        default:
            break;
    }
    
    return line;
}

@end
