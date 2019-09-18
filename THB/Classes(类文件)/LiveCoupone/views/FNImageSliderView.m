//
//  FNImageSliderView.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNImageSliderView.h"
#import "FNImageText.h"

@interface FNImageSliderView()<FNImageTextDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray<FNImageText*> *items;
@property (nonatomic, strong) UIView *vSlider;
@property (nonatomic, assign) NSInteger selectedIndex;

@end


@implementation FNImageSliderView

#define CellWidth (XYScreenWidth / 4)
#define SliderWidth 50

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

- (void)setTitles: (NSArray*)titles imageUrls: (NSArray*)imgUrls {
    
    for (UIView *view in _items) {
        [view removeFromSuperview];
    }
    [_items removeAllObjects];
    
    for (NSInteger index = 0; index < titles.count; index ++) {
        NSString *title = titles[index];
        
        FNImageText *btnTitle = [[FNImageText alloc] init];
        [_scrollView addSubview:btnTitle];
        [_items addObject:btnTitle];

        [btnTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self);
            if (index == 0) {
                make.left.equalTo(_scrollView);
            } else {
                make.left.equalTo(((UIView*)_items[index - 1]).mas_right);
            }
            if (index == titles.count - 1) {
                make.right.equalTo(_scrollView);
            }
            make.width.mas_equalTo(CellWidth);
            make.centerY.equalTo(@0);
        }];
        
        [btnTitle.imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(44);
        }];
        btnTitle.imgIcon.cornerRadius = 22;
        
        btnTitle.lblTitle.text = title;
        btnTitle.lblTitle.textColor = index == _selectedIndex ? _textHighlightColor : _textColor;
        btnTitle.lblTitle.font = _selectedIndex ? _hightlightFont : _font;
        [btnTitle.imgIcon sd_setImageWithURL:URL(imgUrls[index])];
        btnTitle.delegate = self;
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
    FNImageText *cell = _items[index];
    
    if (cell) {
        FNImageText *selectedCell = _items[_selectedIndex];
        selectedCell.lblTitle.textColor = _textColor;
        selectedCell.lblTitle.font = _font;
        cell.lblTitle.textColor = _textHighlightColor;
        cell.lblTitle.font = _hightlightFont;
        
        _selectedIndex = index;
        _vSlider.hidden = NO;
        
        if (cell.frame.origin.x < self.scrollView.contentOffset.x) {
            [self.scrollView setContentOffset:CGPointMake(cell.frame.origin.x, 0) animated:YES];
        } else if (cell.frame.origin.x > self.scrollView.contentOffset.x + self.scrollView.bounds.size.width - cell.frame.size.width) {
            [self.scrollView setContentOffset:CGPointMake(cell.frame.origin.x - self.scrollView.bounds.size.width + cell.frame.size.width, 0) animated:YES];
        }
        
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

//- (void)onItemClick: (UITapGestureRecognizer*)sender {
//    FNImageSliderView *view = sender.view;
//    NSInteger index = [_items indexOfObject:view];
//    if (index >= 0 && index < _items.count) {
//        [self setSelected:index animated:YES];
//        if (_delegate && [_delegate respondsToSelector:@selector(sliderControl:didCellSelectedAtIndex:)]) {
//            [_delegate sliderControl:self didCellSelectedAtIndex:index];
//        }
//    }
//}

#pragma mark - FNImageTextDelegate
- (void)didIconClick:(FNImageText *)icon {
    NSInteger index = [_items indexOfObject:icon];
    if (index >= 0 && index < _items.count) {
        [self setSelected:index animated:YES];
        if (_delegate && [_delegate respondsToSelector:@selector(sliderControl:didCellSelectedAtIndex:)]) {
            [_delegate sliderControl:self didCellSelectedAtIndex:index];
        }
    }
}

@end
