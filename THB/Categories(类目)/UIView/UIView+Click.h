//
//  UIView+Click.h
//  THB
//
//  Created by zhongxueyu on 16/6/12.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIView (Click)
typedef void (^TouchBlock)();
typedef void (^TouchBlockWithObject)(id obj);
-(void)addJXTouch:(TouchBlock)block;
- (void)addJXTouchWithObject:(TouchBlockWithObject)block;
@end
