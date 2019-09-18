//
//  FNDetailCateCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/24.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNDetailCateCell.h"

@interface FNDetailCateCell()<SliderControlDelegate>


@end

@implementation FNDetailCateCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _sliderControl = [[SliderControl alloc] init];
    [self addSubview: _sliderControl];
    
    [_sliderControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    _sliderControl.backgroundColor = FNWhiteColor;
    _sliderControl.font = kFONT16;
    _sliderControl.hightlightFont = [UIFont boldSystemFontOfSize:16];
    _sliderControl.textColor = RGB(51, 51, 51);
    _sliderControl.textHighlightColor = RGB(51, 51, 51);
    _sliderControl.highlightColor = RGB(246, 43, 59);
    _sliderControl.autoSize = YES;
    _sliderControl.delegate = self;
}

#pragma mark - SliderControlDelegate
- (void)sliderControl: (SliderControl*) slider didCellSelectedAtIndex: (NSInteger) index {

}

@end
