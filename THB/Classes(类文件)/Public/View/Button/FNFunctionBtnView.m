//
//  FNFunctionBtnView.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/7/26.
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
 

#import "FNFunctionBtnView.h"

@interface FNFunctionBtnView ()
@property (nonatomic, strong)UIImage *btnImage;
@property (nonatomic, copy)NSString *title;
@end
@implementation FNFunctionBtnView
- (instancetype)initWithFrame:(CGRect)frame btnImage:(UIImage *)image andTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        _btnImage = image;
        _title = title;
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.userInteractionEnabled = NO;
    [button setImage:_btnImage forState:UIControlStateNormal];
    [button sizeToFit];
    [self addSubview:button];
    _button = button;
    [_button addObserver:self forKeyPath:@"selected" options:  NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld  context:nil];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame), self.width, 0)];
    label.text = _title;
    label.font  = kFONT14;
    label.textColor = [UIColor grayColor];
    [label sizeToFit];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    _label = label;
    
    //layout
    CGFloat verticalMargin  = (self.height - button.height - label.height)/3;
    
    [button autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [button autoSetDimensionsToSize:button.size];
    [button autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:verticalMargin];
    
    [label autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [label autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, verticalMargin, 0) excludingEdge:ALEdgeTop];
}
- (void)setSelectedImage:(UIImage *)selectedImage
{
    _selectedImage = selectedImage;
    [_button setImage:_selectedImage forState:UIControlStateSelected];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSNumber *flag = [change objectForKey:NSKeyValueChangeNewKey];
    self.label.textColor = flag.boolValue == YES ? RED: [UIColor grayColor];
    [self setNeedsDisplay];
}
- (void)dealloc
{
    [_button removeObserver:self forKeyPath:@"selected"];
}
@end
