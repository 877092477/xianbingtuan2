//
//  FNMBOrderManageBarTitleView.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/9/22.
//  Copyright © 2016年 jimmy. All rights reserved.
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

#import "FNMBOrderManageBarTitleView.h"

@implementation FNMBOrderManageBarTitleView
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArr
{
    self = [super initWithFrame:frame];
    if (self) {
    
        _titles = titlesArr;
        self.borderColor = RED;
        self.cornerRadius = 3;
        self.borderWidth = 1.0f;
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    CGFloat height = self.height;
    CGFloat width  = self.width / _titles.count;
    for (NSInteger i = 0; i < _titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i +1000;
        btn.selected = i == 0 ;
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = kFONT14;
        [btn setBackgroundImage:[UIImage createImageWithColor:RED] forState:UIControlStateSelected];
        btn.frame = CGRectMake(0+width*i, 0, width, height);
        [btn setTitleColor:FNWhiteColor forState:UIControlStateSelected];
        [btn setTitleColor:RED forState:UIControlStateNormal];
        
        
        [btn addTarget:self action:@selector(observingClickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}
- (void)observingClickedButton:(UIButton *)btn
{
    btn.selected = YES;
    if (self.clickedBtnAtIndex) {
        self.clickedBtnAtIndex(btn.tag - 1000);
    }
    
    for (UIButton *button in self.subviews) {
        if (button != btn) {
            button.selected = NO;
        }
    }
}
- (void)setButtonOnAtIndex:(NSInteger)index{
    UIButton* btn = [self viewWithTag:index+1000];
    btn.selected = YES;
    for (UIButton *button in self.subviews) {
        if (button != btn) {
            button.selected = NO;
        }
    }
}
@end
