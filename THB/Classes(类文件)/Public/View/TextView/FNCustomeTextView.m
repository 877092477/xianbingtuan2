//
//  FNCustomeTextView.m
//  LikeKaGou
//
//  Created by jimmy on 16/10/9.
//  Copyright © 2016年 方诺科技. All rights reserved.
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

#import "FNCustomeTextView.h"
#define CTVMargin 10.0f
@implementation FNCustomeTextView
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
    UITextView *textView = [[UITextView alloc]init];
    textView.font = FNFontDefault(FNGlobalFontNormalSize);
    textView.delegate = self;
    [self addSubview:textView];
    _textView = textView;
    [_textView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(CTVMargin, CTVMargin, CTVMargin, CTVMargin))];
    
}
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    if (_placeHolderLabel == nil) {
        UILabel *label = [UILabel new];
        label.textColor = self.placeholderColor;
        label.text = _placeholder;
        label.numberOfLines = 0;
        [self addSubview:label];
        _placeHolderLabel = label;
        [_placeHolderLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_textView withOffset: CTVMargin*0.5];
        [_placeHolderLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:_textView withOffset:CTVMargin*0.5+1];
       [_placeHolderLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:_textView withOffset:-CTVMargin*0.5];
        [self bringSubviewToFront:_placeHolderLabel];
    }
}
#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    if (_textView.text.length == 0) {
        _placeHolderLabel.hidden = NO;
    }else {
        _placeHolderLabel.hidden = YES;
    }
}
@end
