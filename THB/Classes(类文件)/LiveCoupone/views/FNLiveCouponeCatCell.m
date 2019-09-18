//
//  FNLiveCouponeCatCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveCouponeCatCell.h"

@interface FNLiveCouponeCatCell()<SliderControlDelegate>



@end

@implementation FNLiveCouponeCatCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.backgroundColor = UIColor.clearColor;
    
    _slider = [[SliderControl alloc] init];
    [self.contentView addSubview:_slider];
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
    
    
    _slider.textColor = RGB(51, 51, 51);
    _slider.font = kFONT15;
    _slider.hightlightFont = kFONT15;
    _slider.textHighlightColor = RGB(259, 84 , 71);
    _slider.highlightColor = RGB(259, 84 , 71);
    _slider.autoSize = YES;
    _slider.delegate = self;
}

#pragma mark - SliderControlDelegate

- (void)sliderControl:(SliderControl *)slider didCellSelectedAtIndex:(NSInteger)index {
    if ([_delegate respondsToSelector:@selector(cell:didItemSelectedAt:)]) {
        [_delegate cell:self didItemSelectedAt:index];
    }
}


@end
