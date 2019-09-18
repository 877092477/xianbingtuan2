//
//  FNCustomeNavigationBar.h
//  Two_Code
//
//  Created by jimmy on 2017/2/9.
//  Copyright © 2017年 Jimmy_Ng. All rights reserved.
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
#import "FNCustomSearchBar.h"

@interface FNCustomeNavigationBar : UIView<UISearchBarDelegate>
@property (nonatomic, strong,setter=setLeftButton:,getter=leftButton)UIView* leftButton;
@property (nonatomic, strong,setter=setRightButton:,getter=rightButton)UIView* rightButton;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)FNCustomSearchBar* textField;
@property (nonatomic, strong)UISearchBar* searchBar;
@property (nonatomic, copy)void (^SearchBarDidBeginEditing)(UISearchBar* searchbar);
@property (nonatomic, strong)UIView* customeview;

@property (nonatomic, strong)UILabel* ImagetitleLabel;




+ (instancetype)customeNavigationBarWithTextFieldFrame:(CGRect)frame andPlaceholder:(NSString*)palceholder;
+ (instancetype)customeNavigationBarWithSearchBarFrame:(CGRect)frame andPlaceholder:(NSString*)palceholder;
+ (instancetype)customeNavigationBarWithTitle:(NSString *)title;
+ (instancetype)customeNavigationBarWithCustomeView:(UIView*)customeview;
+ (instancetype)customeNavigationBarWithBgImageViewAddLable:(UIView *)customeview withTitle:(NSString*)title;



- (void)setRightButton:(UIView *)rightButton;
- (UIView *)rightButton;
- (void)setLeftButton:(UIView *)leftButton;
- (UIView *)leftButton;

@property (nonatomic, strong)NSString* searchColor;
@property (nonatomic, strong)NSString* searchImg;
@end
