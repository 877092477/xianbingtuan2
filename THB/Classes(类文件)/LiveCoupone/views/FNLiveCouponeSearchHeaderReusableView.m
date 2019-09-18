//
//  FNLiveCouponeSearchHeaderReusableView.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveCouponeSearchHeaderReusableView.h"

@interface FNLiveCouponeSearchHeaderReusableView()


@property (nonatomic, strong) UIButton *btnClear;

@end

@implementation FNLiveCouponeSearchHeaderReusableView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _lblTitle = [[UILabel alloc] init];
    _btnClear = [[UIButton alloc] init];
    
    [self addSubview:_lblTitle];
    [self addSubview:_btnClear];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.right.lessThanOrEqualTo(self.btnClear.mas_left).offset(-20);
        make.centerY.equalTo(@0);
    }];
    
    [_btnClear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-12);
        make.centerY.equalTo(@0);
    }];
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = kFONT15;
    
    [_btnClear setTitle:@"清除" forState:(UIControlStateNormal)];
    [_btnClear setTitleColor:RGB(153, 153, 153) forState:(UIControlStateNormal)];
    _btnClear.titleLabel.font = kFONT12;
    [_btnClear addTarget:self action:@selector(clearAction)];
}

- (void)setTitle: (NSString*)title isClearShow: (BOOL)isShow {
    _lblTitle.text = title;
    _btnClear.hidden = !isShow;
}

- (void)clearAction {
    if ([_delegate respondsToSelector:@selector(didClearClick:)]) {
        [_delegate didClearClick:self];
    }
}

@end
