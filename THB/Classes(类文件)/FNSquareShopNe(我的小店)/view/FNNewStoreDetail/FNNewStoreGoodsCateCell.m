//
//  FNNewStoreGoodsCateCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/19.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreGoodsCateCell.h"
#import "SliderControl.h"

@interface FNNewStoreGoodsCateCell()<SliderControlDelegate>

@property (nonatomic, strong) SliderControl *sliderCate;

@end

@implementation FNNewStoreGoodsCateCell

-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _sliderCate = [[SliderControl alloc] init];
    [self addSubview: _sliderCate];
    
    [_sliderCate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    _sliderCate.backgroundColor = FNWhiteColor;
    _sliderCate.font = kFONT12;
    _sliderCate.hightlightFont = kFONT12;
    _sliderCate.textColor = RGB(153, 153, 153);
    _sliderCate.textHighlightColor = RGB(51, 51, 51);
    _sliderCate.highlightColor = RGB(246, 43, 59);
    _sliderCate.autoSize = YES;
    _sliderCate.delegate = self;
}

#pragma mark - SliderControlDelegate
- (void)sliderControl: (SliderControl*) slider didCellSelectedAtIndex: (NSInteger) index {
    if ([_delegate respondsToSelector:@selector(cateCell:didCateClickAt:)]) {
        [_delegate cateCell:self didCateClickAt: index];
    }
}

- (void)setTitles: (NSArray<NSString*>*)cates selected: (NSInteger)index{
    [_sliderCate setTitles: cates];
    [_sliderCate setSelected: index animated: NO];
}

@end
