//
//  UIView+Click.m
//  THB
//
//  Created by zhongxueyu on 16/6/12.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "UIView+Click.h"

@implementation UIView (Click)
static char touchKey;
static char otherKey;
-(void)actionTap{
    void (^block)(void) = objc_getAssociatedObject(self, &touchKey);
    if (block) block();
}
- (void)actionTap:(UITapGestureRecognizer *)tap
{
    void (^block)(id obj) = objc_getAssociatedObject(self, &otherKey);
    if (block) {
        block(tap.view);
    }
}
-(void)addJXTouch:(TouchBlock)block{
    
    self.userInteractionEnabled =YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap)];
    
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self, &touchKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)addJXTouchWithObject:(TouchBlockWithObject)block
{
    self.userInteractionEnabled =YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
    
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self, &otherKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
