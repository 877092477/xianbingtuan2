//
//  FNSectionHeaderView.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/9/24.
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

#import "FNSectionHeaderView.h"

@implementation FNSectionHeaderView

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
    self.backgroundColor = FNHomeBackgroundColor;
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = FNFontDefault(FNGlobalFontNormalSize);
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    [_titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:15];
    [_titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15];
    [_titleLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
}
@end
