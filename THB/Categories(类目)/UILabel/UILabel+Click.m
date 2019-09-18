//
//  UILabel+Click.m
//  UIView+Chick
//
//  Created by zhongxueyu on 16/6/3.
//  Copyright © 2016年 ZhuJX. All rights reserved.
//

#import "UILabel+Click.h"

@implementation UILabel (Click)
static char touchKey;
-(void)actionTap{
    void (^block)(void) = objc_getAssociatedObject(self, &touchKey);
    if (block) block();
}
-(void)addJXTouch:(TouchBlock)block{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap)];
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self, &touchKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}@end
