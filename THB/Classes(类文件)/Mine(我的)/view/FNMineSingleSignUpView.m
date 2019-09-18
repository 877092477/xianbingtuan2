//
//  FNMineSingleSignUpView.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/7/29.
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

#import "FNMineSingleSignUpView.h"

@interface FNMineSingleSignUpView ()

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *valueStr;
@end
@implementation FNMineSingleSignUpView
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title andValue:(NSString *)value
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.title = title;
        self.valueStr = value;
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectZero];
//    valueLabel.textColor = FNBlackColor;
    valueLabel.text = self.valueStr;
    valueLabel.textAlignment = NSTextAlignmentCenter;
    valueLabel.font = kFONT14;
    valueLabel.font = [UIFont fontWithDevice:FNGlobalFontNormalSize];
    [valueLabel sizeToFit];
    [self addSubview:valueLabel];
    _valueLabel = valueLabel;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
//    titleLabel.textColor = FNWhiteColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = kFONT14;
    titleLabel.text = self.title;
    [titleLabel sizeToFit ];
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;

    _line = [UIView new];
    [self addSubview:_line];
    //layout
    CGFloat margin = (self.height-valueLabel.height-titleLabel.height)/3;
    

    [_valueLabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:margin];
    
    [_valueLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_valueLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [_valueLabel autoSetDimension:(ALDimensionHeight) toSize:_valueLabel.height];

    [titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:margin];
    [titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [titleLabel autoSetDimension:(ALDimensionHeight) toSize:titleLabel.height];
    
//    [_line autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:titleLabel];
//    [_line autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:titleLabel];
    [_line autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:titleLabel withOffset:5];
    [_line autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    [_line autoSetDimension:(ALDimensionHeight) toSize:1.5];
    [_line autoSetDimension:(ALDimensionWidth) toSize:_title.length*15];
    
    //add event
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)]];
}
- (void)viewTapped:(UITapGestureRecognizer *)tap
{
    if (self.viewTapped) {
        self.viewTapped(tap.view);
    }
    
}
- (void)chnangeValue:(NSString *)string
{
    _valueLabel.text = string;
}
@end
