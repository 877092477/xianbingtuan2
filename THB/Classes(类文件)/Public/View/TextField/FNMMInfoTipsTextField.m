//
//  FNMMInfoTipsTextField.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/8/23.
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

#import "FNMMInfoTipsTextField.h"
#define FNMMHorizontalMargin 10

@interface FNMMInfoTipsTextField ()
@property (nonatomic, copy) NSString *tipsString;
@end
@implementation FNMMInfoTipsTextField
- (instancetype)initWithFrame:(CGRect)frame tips:(NSString *)tips
{
    self = [super initWithFrame:frame];
    if (self) {
        _tipsString = tips;
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    tipsLabel.textColor = FNMainTextNormalColor;
    tipsLabel.text = _tipsString;
    tipsLabel.font = kFONT14;
    tipsLabel.numberOfLines = 0;
    CGSize size = [self sizeWithString:_tipsString font:kFONT14  withMaxSize:CGSizeMake(self.width-FNMMHorizontalMargin*2, CGFLOAT_MAX)];
    tipsLabel.size = size;
    tipsLabel.x = FNMMHorizontalMargin;
    tipsLabel.y = FNMMHorizontalMargin;
     [self addSubview:tipsLabel];
    _tipsLabel = tipsLabel;
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(FNMMHorizontalMargin,CGRectGetMaxY(_tipsLabel.frame)+FNMMHorizontalMargin*0.5, self.width-FNMMHorizontalMargin*2, 40)];
    textField.secureTextEntry = self.secureTextEntry;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.borderColor = FNHomeBackgroundColor;
    textField.borderWidth = 1.0;
    textField.font = kFONT14;
//    textField.contentScaleFactor = 1.0;
    textField.cornerRadius = 5;
    
    [self addSubview:textField];
    _textField = textField;
    
    self.height = CGRectGetMaxY(_textField.frame) + FNMMHorizontalMargin;
}
- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _secureTextEntry = secureTextEntry;
    _textField.secureTextEntry = _secureTextEntry;
}
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font withMaxSize:(CGSize)size
{
    CGRect rect = [string boundingRectWithSize:size//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}
@end
