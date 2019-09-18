//
//  FNFreeProductDetailAlertView.m
//  THB
//
//  Created by Weller on 2018/12/19.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNFreeProductDetailAlertView.h"

@interface FNFreeProductDetailAlertView()

@property (nonatomic, strong) UIButton *btnBackground;
@property (nonatomic, strong) UIView *vBackground;

@property (nonatomic, strong) UIImageView *imgTitle;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;

@property (nonatomic, strong) UIButton *btnAccept;
@property (nonatomic, strong) UIButton *btnLeave;

@property (nonatomic, assign) BOOL closable;

@end

@implementation FNFreeProductDetailAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _closable = YES;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _btnBackground = [[UIButton alloc] init];
    _vBackground = [[UIView alloc] init];
    _imgTitle = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _btnAccept = [[UIButton alloc] init];
    _btnLeave = [[UIButton alloc] init];
    
    [self addSubview:_btnBackground];
    [self addSubview:_vBackground];
    [_vBackground addSubview:_imgTitle];
    [_vBackground addSubview:_lblTitle];
    [_vBackground addSubview:_lblDesc];
    [_vBackground addSubview:_btnAccept];
    [_vBackground addSubview:_btnLeave];
    
    [_btnBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.mas_equalTo(260);
    }];
    [_imgTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@20);
        make.width.height.mas_equalTo(42);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_imgTitle);
        make.left.equalTo(_imgTitle.mas_right).offset(10);
        make.right.lessThanOrEqualTo(@-10);
        make.top.greaterThanOrEqualTo(@20);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.top.greaterThanOrEqualTo(_imgTitle.mas_bottom).offset(20);
        make.top.greaterThanOrEqualTo(_lblTitle.mas_bottom).offset(20);
    }];
    [_btnAccept mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblDesc.mas_bottom).offset(20);
        make.bottom.equalTo(@-20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.left.equalTo(@20);
    }];
    [_btnLeave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_btnAccept);
        make.width.equalTo(_btnAccept);
        make.height.mas_equalTo(40);
        make.right.equalTo(@-20);
    }];
    
    self.hidden = YES;
    
    _btnBackground.backgroundColor = RGBA(0, 0, 0, 0.2);
    
    _vBackground.backgroundColor = UIColor.whiteColor;
    _vBackground.cornerRadius = 10;
    
    _imgTitle.image = IMAGE(@"free_image_giff");
    
    _lblTitle.text = @"亲～选好了吗？";
    _lblTitle.textColor = RED;
    _lblTitle.font = [UIFont systemFontOfSize:24];
    
    _lblDesc.font = kFONT12;
    _lblDesc.textColor = RGB(145, 145, 145);
    _lblDesc.numberOfLines = 0;
    
    [_btnAccept setTitle:@"我要领取" forState:UIControlStateNormal];
    [_btnAccept setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    _btnAccept.backgroundColor = RED;
    _btnAccept.cornerRadius = 8;
    
    [_btnLeave setTitle:@"确定离开" forState:UIControlStateNormal];
    [_btnLeave setTitleColor:RGB(145, 145, 145) forState:UIControlStateNormal];
    _btnLeave.backgroundColor = RGB(240, 240, 240);
    _btnLeave.cornerRadius = 8;
    
    [_btnAccept addTarget:self action:@selector(onAcceptClick)];
    [_btnLeave addTarget:self action:@selector(onLeaveClick)];
}

- (void)show: (NSString*)desc backgroundClosable: (BOOL)closable {
    self.hidden = NO;
    _closable = closable;
    _lblDesc.text = desc;
}

- (void)dismiss {
    self.hidden = YES;
}

- (void)onBackgroundClick {
    if (_closable)
        [self dismiss];
}

- (void)onAcceptClick {
    if ([_delegate respondsToSelector:@selector(didAcceptClick:)])
        [_delegate didAcceptClick:self];
}

- (void)onLeaveClick {
    if ([_delegate respondsToSelector:@selector(didLeaveClick:)])
        [_delegate didLeaveClick:self];
}

@end
