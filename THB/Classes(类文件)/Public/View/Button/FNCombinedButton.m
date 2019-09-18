//
//  FNCombinedButton.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/8/6.
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

#import "FNCombinedButton.h"

@implementation FNCombinedButton
- (instancetype)initWithImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedColor target:(id)target action:(SEL)action
{
    self = [super init];
    if (self) {
   
        //title label
        UIButton *titleLabel =[UIButton buttonWithType:UIButtonTypeCustom];
        titleLabel.userInteractionEnabled = NO;
        titleLabel.titleLabel.font = font;
        [titleLabel setTitle:title forState:UIControlStateNormal];
        [titleLabel setTitleColor:titleColor forState:UIControlStateNormal];
        [titleLabel setTitleColor:selectedColor==nil?titleColor:selectedColor forState:UIControlStateSelected];
        [titleLabel setImage:normalImage forState:UIControlStateNormal];
        [titleLabel setImage:selectedImage==nil? normalImage:selectedImage forState:UIControlStateSelected];
        [titleLabel sizeToFit];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        //add gesture
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];

    }
    return self;
}
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self layoutViews];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self layoutViews];
}
- (void)setTitle:(NSString *)title{
    [self.titleLabel setTitle:title forState:UIControlStateNormal];
    [self.titleLabel sizeToFit];
    [self layoutViews];
}
- (void)setSelected:(BOOL)selected{
    _selected = selected;
    _titleLabel.selected = _selected;
    [self layoutViews];
}
- (void)layoutViews{
    self.titleLabel.width=self.width;
    self.titleLabel.centerX = self.width*0.5;
    self.titleLabel.centerY = self.height*0.5;
    [self.titleLabel layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5.0f];
}
@end
