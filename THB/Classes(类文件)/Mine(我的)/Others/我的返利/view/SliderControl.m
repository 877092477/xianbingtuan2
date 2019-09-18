//
//  SliderControl.m
//  THB
//
//  Created by Weller Zhao on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "SliderControl.h"

@interface SliderControl()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) UIView *vSlider;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation SliderControl

#define SliderWidth 20

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.backgroundColor = UIColor.whiteColor;
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = UIColor.clearColor;
    
    _scrollView.alwaysBounceHorizontal = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self);
    }];
    
    _vSlider = [[UIView alloc] init];
    [_scrollView addSubview:_vSlider];
    _vSlider.backgroundColor = RED;
    _vSlider.cornerRadius = 1.5;
    [_vSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-1);
        make.height.mas_equalTo(3);
        make.left.equalTo(_scrollView);
        make.right.equalTo(_scrollView);
    }];
    
    _vSlider.hidden = YES;
}

- (void)setTitles: (NSArray*)titles {
    
    for (UIView *view in _items) {
        [view removeFromSuperview];
    }
    [_items removeAllObjects];
    
    for (NSInteger index = 0; index < titles.count; index ++) {
        NSString *title = titles[index];
        
        UIButton *btnTitle = [[UIButton alloc] init];
        [_scrollView addSubview:btnTitle];
        [_items addObject:btnTitle];
        if (_autoSize) {
            [btnTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                if (index == 0) {
                    make.left.equalTo(_scrollView).offset(30);
                } else {
                    make.left.equalTo(((UIView*)_items[index - 1]).mas_right).offset(30);
                }
                if (index == titles.count - 1) {
                    make.right.equalTo(_scrollView).offset(-30);
                }
            }];
        } else {
            [btnTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                if (index == 0) {
                    make.left.equalTo(_scrollView);
                } else {
                    make.left.equalTo(((UIView*)_items[index - 1]).mas_right);
                }
                if (index == titles.count - 1) {
                    make.right.equalTo(_scrollView);
                }
                make.width.equalTo(self).dividedBy(titles.count);
            }];
        }
        
        [btnTitle setTitle:title forState:UIControlStateNormal];
        [btnTitle setTitleColor:index == _selectedIndex ? _textHighlightColor : _textColor forState:UIControlStateNormal];
        btnTitle.titleLabel.font = _selectedIndex ? _hightlightFont : _font;
        [btnTitle addTarget:self action:@selector(onItemClick:)];
    }
    [self setSelected:0 animated:NO];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _vSlider.frame = CGRectMake(_vSlider.x, self.bounds.size.height - 4, _vSlider.width, _vSlider.height);
}

- (void)setSelected:(NSInteger)index animated: (BOOL)animated {
    if (index >= _items.count)
        return;
    UIButton *cell = _items[index];
    
    if (cell) {
        [((UIButton*)_items[_selectedIndex]) setTitleColor:_textColor forState:UIControlStateNormal];
        [cell setTitleColor:_textHighlightColor forState:UIControlStateNormal];
        ((UIButton*)_items[_selectedIndex]).titleLabel.font = _font;
        cell.titleLabel.font = _hightlightFont;
        _selectedIndex = index;
        _vSlider.hidden = NO;
        
        if (animated) {
            [UIView animateWithDuration:0.2 animations:^{
                [_vSlider mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self).offset(-1);
                    make.height.mas_equalTo(3);
                    make.width.mas_equalTo(SliderWidth);
                    make.centerX.equalTo(cell);
                }];
                [_scrollView layoutIfNeeded];
            }];
        } else {
            [_vSlider mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self).offset(-1);
                make.height.mas_equalTo(3);
                make.width.mas_equalTo(SliderWidth);
                make.centerX.equalTo(cell);
            }];
        }
    }
}
- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    for (NSInteger index = 0; index < _items.count; index++) {
        if (_selectedIndex != index)
            ((UIButton*)_items[index]).titleLabel.textColor = textColor;
    }
}
- (void)setFont:(UIFont *)font {
    _font = font;
    if (_hightlightFont == nil)
        _hightlightFont = font;
    for (NSInteger index = 0; index < _items.count; index++) {
        ((UIButton*)_items[index]).titleLabel.font = font;
    }
}

- (void)setHightlightFont: (UIFont *)font {
    _hightlightFont = font;
    if (_selectedIndex >= 0 && _selectedIndex < _items.count) {
        ((UIButton*) _items[_selectedIndex]).titleLabel.font = font;
    }
}

- (void)setTextHighlightColor:(UIColor *)textHighlightColor {
    _textHighlightColor = textHighlightColor;
    if (_selectedIndex >= 0 && _selectedIndex < _items.count) {
        [(UIButton*) _items[_selectedIndex] setTitleColor:textHighlightColor forState:UIControlStateNormal];
    }
}

- (void)setHighlightColor:(UIColor *)highlightColor {
    _highlightColor = highlightColor;
    _vSlider.backgroundColor = highlightColor;
}

- (void)onItemClick: (UITapGestureRecognizer*)sender {
    UIView *view = sender.view;
    NSInteger index = [_items indexOfObject:view];
    if (index >= 0 && index < _items.count) {
        [self setSelected:index animated:YES];
        if (_delegate && [_delegate respondsToSelector:@selector(sliderControl:didCellSelectedAtIndex:)]) {
            [_delegate sliderControl:self didCellSelectedAtIndex:index];
        }
    }
}

@end
