//
//  FNCustomSearchBar.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/7/27.
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

#import "FNCustomSearchBar.h"

@implementation FNCustomSearchBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    //seacrh icon
    UIImageView *searchView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_search"]];
    searchView.frame = CGRectMake(0, 0, searchView.width+20, searchView.height+20);
    searchView.contentMode = UIViewContentModeCenter;
    self .leftViewMode = UITextFieldViewModeAlways;
    self.leftView = searchView;
    
    //horn icon
    UIImageView *hornImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    hornImageView.image = [UIImage imageNamed:@"home_voice"];
    hornImageView.userInteractionEnabled = YES;
    [hornImageView sizeToFit];
    hornImageView.frame = CGRectMake(0, 0, hornImageView.width+20, hornImageView.height+20);
    hornImageView.contentMode = UIViewContentModeCenter;
    [hornImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hornClicked:)]];
    self.rightViewMode = UITextFieldViewModeUnlessEditing;
    self.rightView = hornImageView;
    
    self.contentMode = UIViewContentModeTop;
}
- (void)hornClicked:(UITapGestureRecognizer *)tap
{
    if (self.hornClicked) {
        self.hornClicked();
    }
}

@end
