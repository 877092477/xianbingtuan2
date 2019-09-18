//
//  COFshareBtn.m
//  THB
//
//  Created by Jimmy on 2018/8/30.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "COFshareBtn.h"
static CGFloat const kIconHeight = 40;
static CGFloat const kTitleHeight = 30;
@implementation COFshareBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGRect rect = CGRectMake((contentRect.size.width-kIconHeight)/2, 15, kIconHeight, kIconHeight);
    //(contentRect.size.height - kIconHeight - kTitleHeight) / 2
    return rect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    //(contentRect.size.height - kIconHeight - kTitleHeight) / 3 + kIconHeight
    CGRect rect = CGRectMake(0, kIconHeight+20, contentRect.size.width, kTitleHeight);
    return rect;
}

- (void)setHighlighted:(BOOL)highlighted {
    
}

- (void)dealloc {
   //NSLog(@"shareButton");
}

@end
