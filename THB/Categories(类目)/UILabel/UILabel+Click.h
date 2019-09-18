//
//  UILabel+Click.h
//  UIView+Chick
//
//  Created by zhongxueyu on 16/6/3.
//  Copyright © 2016年 ZhuJX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface UILabel (Click)
typedef void (^TouchBlock)();
-(void)addJXTouch:(TouchBlock)block;
@end
