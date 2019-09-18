//
//  FNSearchView.m
//  THB
//
//  Created by Weller Zhao on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNSearchView.h"

@interface FNSearchView() <UITextFieldDelegate>

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UITextField *txfInput;
@property (nonatomic, strong) UIButton *btnSearch;
@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UIView *vPlaceholder;
@property (nonatomic, strong) UIImageView *imgSearch;
@property (nonatomic, strong) UILabel *lblSearch;

@end


@implementation FNSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.vBackground = [[UIView alloc] init];
    self.txfInput = [[UITextField alloc] init];
    self.btnSearch = [[UIButton alloc] init];
    self.vLine = [[UIView alloc] init];
    
    self.vPlaceholder = [[UIView alloc] init];
    self.imgSearch = [[UIImageView alloc] init];
    self.lblSearch = [[UILabel alloc] init];
    
    [self addSubview: self.vBackground];
    [self addSubview: self.vPlaceholder];
    [self.vPlaceholder addSubview: self.imgSearch];
    [self.vPlaceholder addSubview: self.lblSearch];
    [self addSubview: self.txfInput];
    [self addSubview: self.btnSearch];
    [self addSubview: self.vLine];

    [self.vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.txfInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.bottom.equalTo(@0);
        make.right.equalTo(self.vLine.mas_left).offset(0);
    }];
    [self.btnSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.top.bottom.equalTo(@0);
        make.left.equalTo(self.vLine.mas_right).offset(10);
        make.width.mas_equalTo(25);
    }];
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.top.equalTo(@8);
        make.bottom.equalTo(@-8);
    }];
    
    [self.vPlaceholder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.txfInput);
    }];
    [self.imgSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.greaterThanOrEqualTo(@0);
        make.bottom.lessThanOrEqualTo(@0);
        make.centerY.equalTo(@0);
    }];
    [self.lblSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgSearch.mas_right).offset(4);
        make.right.equalTo(@0);
        make.top.greaterThanOrEqualTo(@0);
        make.bottom.lessThanOrEqualTo(@0);
        make.centerY.equalTo(@0);
    }];

    self.vLine.backgroundColor = RGB(200, 200, 200);

    self.vBackground.backgroundColor = RGB(245, 245, 245);

    [self.btnSearch setTitle:@"搜索" forState:UIControlStateNormal];
    [self.btnSearch setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
    self.btnSearch.titleLabel.font = kFONT12;
    [self.btnSearch addTarget:self action:@selector(onSearchClick)];

    self.txfInput.textColor = RGB(60, 60, 60);
    self.txfInput.font = kFONT14;
    self.txfInput.delegate = self;
    self.txfInput.keyboardType = UIKeyboardTypeWebSearch;
    
    self.imgSearch.image = IMAGE(@"order_image_search");
    
    self.lblSearch.text = @"搜索您想要的账单";
    self.lblSearch.textColor = RGB(200, 200, 200);
    self.lblSearch.font = [UIFont systemFontOfSize:12];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _vBackground.cornerRadius = self.bounds.size.height / 2;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _lblSearch.text = placeholder;
}

- (void)setText:(NSString *)text {
    _txfInput.text = text;
}

- (NSString*)getText {
    return _txfInput.text;
}

#pragma mark - Action

- (void)onSearchClick {
    if ([self.delegate respondsToSelector:@selector(searchView:didSearch:)]) {
        [self.delegate searchView:self didSearch:self.txfInput.text];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.vPlaceholder.hidden =
    ![string isEqualToString:@""];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchView:didSearch:)]) {
        [self.delegate searchView:self didSearch:self.txfInput.text];
    }
    return YES;
}
@end
