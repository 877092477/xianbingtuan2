//
//  FNUpgradeCateCollectionViewCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/18.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNUpgradeCateCollectionViewCell.h"

@interface FNUpgradeCateCollectionViewCell()


@end

@implementation FNUpgradeCateCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _sliderView = [[SliderControl alloc] init];
    [self.contentView addSubview:_sliderView];
    
    [_sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
//        make.height.mas_equalTo(36);
    }];
    
    _sliderView.backgroundColor = UIColor.clearColor;
    _sliderView.font = kFONT12;
    _sliderView.hightlightFont = [UIFont boldSystemFontOfSize:15];
    _sliderView.textColor = RGB(184, 184, 186);
    _sliderView.textHighlightColor = RGB(41, 41, 46);
    _sliderView.highlightColor = UIColor.clearColor;
    _sliderView.autoSize = YES;
}

@end
