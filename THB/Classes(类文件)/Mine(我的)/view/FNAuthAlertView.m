//
//  FNAuthAlertView.m
//  THB
//
//  Created by Weller Zhao on 2019/3/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNAuthAlertView.h"

@interface FNAuthAlertView()

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIImageView *imgBorder;
@property (nonatomic, strong) UIButton *btnClose;
@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;

@property (nonatomic, strong) UIButton *btnMore;

@property (nonatomic, strong) AuthBlock authBlock;

@end

@implementation FNAuthAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)configUI {
    _vBackground = [[UIView alloc] init];
    _imgBorder = [[UIImageView alloc] init];
    _btnClose = [[UIButton alloc] init];
    _imgHeader = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _btnMore = [[UIButton alloc] init];
    
    [self addSubview:_vBackground];
    [_vBackground addSubview:_imgBorder];
    [_vBackground addSubview:_btnClose];
    [_vBackground addSubview:_imgHeader];
    [_vBackground addSubview:_lblTitle];
    [_vBackground addSubview:_lblDesc];
    [_vBackground addSubview:_btnMore];
    
    [_vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.top.greaterThanOrEqualTo(@20);
        make.bottom.lessThanOrEqualTo(@-20);
    }];
    
    [_imgBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgBorder).offset(-20);
        make.top.equalTo(self.imgBorder).offset(20);
    }];
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.imgBorder).offset(40);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.left.greaterThanOrEqualTo(self.imgBorder).offset(40);
        make.right.lessThanOrEqualTo(self.imgBorder).offset(-40);
        make.top.equalTo(self.imgHeader.mas_bottom).offset(20);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.left.greaterThanOrEqualTo(self.imgBorder).offset(40);
        make.right.lessThanOrEqualTo(self.imgBorder).offset(-40);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(20);
    }];
    [_btnMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgBorder).offset(40);
        make.right.equalTo(self.imgBorder).offset(-40);
        make.top.equalTo(self.lblDesc.mas_bottom).offset(20);
        make.bottom.equalTo(self.imgBorder).offset(-40);
        make.height.mas_equalTo(40);
    }];
    
    _imgBorder.image = IMAGE(@"auth_alert_border");
    _imgHeader.image = IMAGE(@"auth_alert_image_taobao");
    
    
    [_btnClose setImage:IMAGE(@"auth_alert_button_close") forState:UIControlStateNormal];
    [_btnClose addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    _lblTitle.text = @"授权失败将无法获取收益";
    _lblTitle.font = [UIFont systemFontOfSize:18];
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.numberOfLines = 0;
    
    _lblDesc.text = @"您的淘宝账号还未绑定支付宝，请先去授权";
    _lblDesc.font = [UIFont systemFontOfSize:12];
    _lblDesc.textColor = RGB(153, 153, 153);
    _lblDesc.numberOfLines = 0;
    
    [_btnMore setTitle:@"去授权" forState:UIControlStateNormal];
    [_btnMore setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_btnMore setBackgroundImage:IMAGE(@"auth_alert_button_width") forState:UIControlStateNormal];
    [_btnMore addTarget:self action:@selector(authClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)close {
    [self removeFromSuperview];
    _authBlock = nil;
}

- (void)authClick {
    [self removeFromSuperview];
    
    if (self.authBlock)
        self.authBlock();
    _authBlock = nil;
}

- (void)showTitle: (NSString*)title withDesc: (NSString*)desc block: (AuthBlock) block {
    
    _lblTitle.text = title;
    _lblDesc.text = desc;
    
    _authBlock = block;
    
    [FNKeyWindow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    @WeakObj(self);
    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [selfWeak.vBackground.layer setValue:@(0) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.23 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [selfWeak.vBackground.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
            selfWeak.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.09 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [selfWeak.vBackground.layer setValue:@(.9) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.05 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [selfWeak.vBackground.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                } completion:^(BOOL finished) {

                }];
            }];
        }];
    }];
}

@end
