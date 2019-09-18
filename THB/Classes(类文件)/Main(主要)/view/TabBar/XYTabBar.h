//
//  XYTabBar.h
//  FnuoApp
//
//  Created by zhongxueyu on 16/2/22.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYTabBarButton.h"
@class XYTabBar;

//给每个按钮定义协议 与 方法
@protocol tabbarDelegate <NSObject>
@optional
-(void)tabBar:(XYTabBar * )tabBar didselectedButtonFrom:(int)from to:(int)to;
@end

@interface XYTabBar : UIView

@property (weak ,nonatomic)XYTabBarButton *selectedButton;
/**
 *  给自定义的tabbar添加按钮
 */
-(void)addTabBarButtonWithItem:(UITabBarItem *)itme;
@property(nonatomic , weak) id <tabbarDelegate> delegate;
-(void)buttonClick:(XYTabBarButton*)button;
@end
