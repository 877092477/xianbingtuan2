//
//  JMDrawLine.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/23.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
typedef enum : NSUInteger {
    RealLineVertical,
    RealLineHorizonal,
    DottedLineVertical,
    DottedLineHorizonal,
    BrokenLine,
} DrawType;
/**
 *  画线工具（实线，虚线）
 */
@interface JMDrawLine : UIView
+ (JMDrawLine *)createLineInRect:(CGRect)lineRect drawType:(DrawType)drawType andColor:(UIColor *)color;
@end
