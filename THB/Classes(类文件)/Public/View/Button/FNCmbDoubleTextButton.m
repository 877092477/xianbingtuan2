//
//  FNCmbDoubleTextButton.m
//  LikeKaGou
//
//  Created by jimmy on 16/9/28.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "FNCmbDoubleTextButton.h"
#define CDTBFont kFONT14
@implementation FNCmbDoubleTextButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        self.frame = frame;
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{

    
    if (self.isHiidenTop == NO) {
        UIButton *topLable = [UIButton buttonWithType:UIButtonTypeCustom];
        topLable.titleLabel.font = CDTBFont;
        topLable.titleLabel.adjustsFontSizeToFitWidth = YES;
        topLable.userInteractionEnabled = NO;
        [self addSubview:topLable];
        _topLable = topLable;
    }
    

    
    UIButton *bottomLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomLabel.titleLabel.font = CDTBFont;
    bottomLabel.titleLabel.adjustsFontSizeToFitWidth = YES;
    bottomLabel.userInteractionEnabled = NO;
    [self addSubview:bottomLabel];
    _bottomLabel = bottomLabel;
    
    @WeakObj(self);
    [self addJXTouchWithObject:^(id obj) {
        if (selfWeak.clickedBlock) {
            selfWeak.clickedBlock(obj);
        }
    }];
}
- (void)setUpFrame
{
    CGFloat btnW = self.width;
    CGFloat btnH = self.height*0.5;
    if (self.isHiidenTop == NO) {
        _topLable.frame = CGRectMake(0, 0, btnW, btnH);
        _bottomLabel.frame = CGRectMake(0, btnH, btnW, btnH);
        
    }else{
        _bottomLabel.frame = CGRectMake(0, 0, btnW, self.height);
        
    }
    

}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (_topLable) {
        [self setUpFrame];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setUpFrame];
}
- (void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    if (_normalColor) {
        [_topLable setTitleColor:_normalColor forState:UIControlStateNormal];
        [_bottomLabel setTitleColor:_normalColor forState:UIControlStateNormal];
    }
}
- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    if (_selectedColor) {
        [_topLable setTitleColor:_selectedColor forState:UIControlStateSelected];
        [_bottomLabel setTitleColor:_selectedColor forState:UIControlStateSelected];
    }
}
- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    _topLable.selected = _selected;
    _bottomLabel.selected = _selected;
}
@end
