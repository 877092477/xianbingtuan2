//
//  FNMineButton.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/7/30.
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

#import "FNMineButton.h"

@interface FNMineButton ()

@end
@implementation FNMineButton
- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image andTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = image;
        self.title = title;
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.backgroundColor = FNWhiteColor;
    //image
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    imageView.image = self.image;
    [imageView sizeToFit];
    [self addSubview:imageView];
    _imageView = imageView;
    
    //title
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    titleLabel.textColor = FNGlobalTextGrayColor;
    titleLabel.text = self.title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = kFONT14;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    [titleLabel sizeToFit];
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickedCenter:)]];
    [self setUpFrames];
}
- (void)setUpFrames
{
    CGFloat temMargin = self.height;
    NSInteger i = 1;
    for (UIView *view in self.subviews) {
        temMargin -= view.height;
        i++;
    }
    CGFloat verticalMargin = temMargin/i;
    _imageView.width = 28;
    _imageView.height = 28;
    CGFloat maxW = self.imageView.width > _titleLabel.width ? self.imageView.width:_titleLabel.width;
    CGFloat horizionMargin = self.width - maxW;
    
    _imageView.frame = CGRectMake(horizionMargin, verticalMargin, _imageView.width, _imageView.height);
    _imageView.centerX = self.width/2;
    
    _titleLabel.frame = CGRectMake(0, CGRectGetMaxY(_imageView.frame)+verticalMargin, self.width, _titleLabel.height);
    
    [self setNeedsDisplay];
}
- (void)clickedCenter:(UITapGestureRecognizer *)tap
{
    if (self.buttonClicked) {
        self.buttonClicked(tap.view);
    }
}
#pragma mark - override method
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = _title;
    [self.titleLabel sizeToFit];
    [self setUpFrames];
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = _image;
    [self.imageView sizeToFit];
    [self setUpFrames];
}
@end
