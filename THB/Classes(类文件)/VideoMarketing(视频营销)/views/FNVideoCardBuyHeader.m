//
//  FNVideoCardBuyHeader.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNVideoCardBuyHeader.h"

@interface FNVideoCardBuyCellView : UIView

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UILabel *lblOriginalPrice;

@end

@implementation FNVideoCardBuyCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lblTitle = [[UILabel alloc] init];
        _lblPrice = [[UILabel alloc] init];
        _lblOriginalPrice = [[UILabel alloc] init];
        
        [self addSubview:_lblTitle];
        [self addSubview:_lblPrice];
        [self addSubview:_lblOriginalPrice];
        
        [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.left.greaterThanOrEqualTo(@10);
            make.right.lessThanOrEqualTo(@-10);
            make.top.equalTo(@10);
            make.height.mas_equalTo(20);
        }];
        [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.left.greaterThanOrEqualTo(@10);
            make.right.lessThanOrEqualTo(@-10);
            make.top.equalTo(self.lblTitle.mas_bottom).offset(14);
            make.height.mas_equalTo(18);
        }];
        [_lblOriginalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.left.greaterThanOrEqualTo(@10);
            make.right.lessThanOrEqualTo(@-10);
            make.top.equalTo(self.lblPrice.mas_bottom).offset(8);
            make.height.mas_equalTo(12);
            make.bottom.equalTo(@-10);
        }];
        
        self.borderWidth = 2;
        self.cornerRadius = 4;
        
        
        _lblTitle.font = [UIFont systemFontOfSize:20];
        _lblTitle.textColor = RGB(51, 51, 51);
        
        _lblPrice.font = [UIFont systemFontOfSize:18];
        _lblPrice.textColor = RGB(246, 64, 57);
        
        _lblOriginalPrice.font = [UIFont systemFontOfSize:12];
        _lblOriginalPrice.textColor = RGB(153, 153, 153);
        
    }
    return self;
}

@end

@interface FNVideoCardBuyHeader()


@property (nonatomic, strong) UIView *vContent;

@property (nonatomic, strong) NSMutableArray<FNVideoCardBuyCellView*>* contents;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation FNVideoCardBuyHeader

#define Column 3

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _contents = [[NSMutableArray alloc] init];
        _currentIndex = 0;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _imgHeader = [[UIImageView alloc] init];
    _vContent = [[UIView alloc] init];
    [self addSubview:_imgHeader];
    [self addSubview:_vContent];
    
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.centerX.equalTo(@0);
        make.height.mas_equalTo(128);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
    }];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(self.imgHeader.mas_bottom).offset(10);
        make.bottom.equalTo(@-20);
    }];
    
    _imgHeader.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundColor = UIColor.whiteColor;
    
}

- (void)selectItem: (NSInteger)index {
    _currentIndex = index;
    for (NSInteger i = 0; i < _contents.count; i++) {
        FNVideoCardBuyCellView *view = _contents[i];
        view.borderColor = i == _currentIndex ? RGB(221, 78, 93) : RGB(185, 185, 185);
    }
}

- (void)setHeaders: (NSArray*)titles withPrices: (NSArray*)prices andOPrices: (NSArray*)oPrices {
    if (titles.count != prices.count || titles.count != oPrices.count) {
        return;
    }
    
    for (UIView* view in _contents) {
        [view removeFromSuperview];
    }
    [_contents removeAllObjects];
    
    for (NSInteger index = 0; index < titles.count; index ++) {
        FNVideoCardBuyCellView *view = [[FNVideoCardBuyCellView alloc] init];
        
        [_vContent addSubview:view];
        [_contents addObject:view];
        view.lblTitle.text = titles[index];
        view.lblPrice.text = prices[index];
        view.lblOriginalPrice.attributedText = [[NSAttributedString alloc] initWithString:oPrices[index] attributes:@{NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle)}];
        view.borderColor = index == _currentIndex ? RGB(221, 78, 93) : RGB(185, 185, 185);
        
        NSInteger row = index / Column;
        NSInteger column = index % Column;
        
        NSInteger i = index;
        @weakify(self)
        [view addJXTouch:^{
            @strongify(self)
            if ([_delegate respondsToSelector:@selector(header:didItemSelectedAt:)]) {
                [_delegate header:self didItemSelectedAt:i];
            }
            [self selectItem:i];
        }];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (row == 0) {
                make.top.equalTo(@0);
            } else {
                make.top.equalTo(self.contents[index - Column].mas_bottom).offset(10);
            }
            
            if (column == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(self.contents[index - 1].mas_right).offset(10);
            }
            if (index != 0) {
                make.width.equalTo(self.contents[0]);
            }
            
            if (column == Column - 1) {
                make.right.equalTo(@0);
            }
            make.bottom.lessThanOrEqualTo(@0);
        }];
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
