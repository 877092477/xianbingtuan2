//
//  XYQuickMenuView.h
//  THB
//
//  Created by zhongxueyu on 16/4/25.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "XYMenuView.h"
extern const CGFloat _quick_menuH;
extern const CGFloat _quick_pageH;
@class MenuModel;
@protocol MenuCellClickDelegate <NSObject>

//@optional
-(void)OnTapMenuView:(NSInteger )index;

@end
@interface XYQuickMenuView : UIView

/** 数据模型 */
@property (nonatomic,strong) MenuModel *menu;

@property (nonatomic, weak) id<MenuCellClickDelegate> delegate;
/** 存放快速入口Model的数组 */
@property (nonatomic, strong)NSArray<MenuModel *>* menuModelArray;

@property (nonatomic, strong)NSMutableArray<XYMenuView *> *menuviews;
@end
