//
//  FNHLFPayView.h
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 2017/1/9.
//  Copyright © 2017年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */
#import <UIKit/UIKit.h>

typedef void(^wayChoosed)(NSInteger index);
@interface FNHLFPayView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak)UIView* mainView;

@property (nonatomic, strong) UIView* titleView;
@property (nonatomic, strong) UILabel* titleLable;
@property (nonatomic, strong) UILabel* mValueLabel;

@property (nonatomic, weak)UITableView* tableView;
@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* mvalue;
@property (nonatomic, weak)NSString* balance;

@property (nonatomic, copy)wayChoosed choosed;

@property (nonatomic, copy)void (^dismissBlock)(BOOL isSuccessed);

- (void)showWihtBlock:(wayChoosed)choosed;
- (void)dismiss;
@end
