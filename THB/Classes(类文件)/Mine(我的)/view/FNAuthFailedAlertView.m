//
//  FNAuthFailedAlertView.m
//  THB
//
//  Created by Weller Zhao on 2019/3/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNAuthFailedAlertView.h"

@interface FNAuthFailedAlertView()

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIImageView *imgBorder;
@property (nonatomic, strong) UIButton *btnClose;
@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;

@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnMore;

@property (nonatomic, strong) AuthBlock authBlock;
@property (nonatomic, strong) AuthBlock cancleBlock;

@end

@implementation FNAuthFailedAlertView


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
    _btnCancel = [[UIButton alloc] init];
    _btnMore = [[UIButton alloc] init];
    
    [self addSubview:_vBackground];
    [_vBackground addSubview:_imgBorder];
    [_vBackground addSubview:_btnClose];
    [_vBackground addSubview:_imgHeader];
    [_vBackground addSubview:_lblTitle];
    [_vBackground addSubview:_lblDesc];
    [_vBackground addSubview:_btnCancel];
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
    [_btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgBorder).offset(20);
        make.right.equalTo(self.imgBorder.mas_centerX).offset(-10);
        make.top.equalTo(self.lblDesc.mas_bottom).offset(20);
        make.bottom.equalTo(self.imgBorder).offset(-40);
        make.height.mas_equalTo(50);
    }];
    [_btnMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgBorder.mas_centerX).offset(10);
        make.right.equalTo(self.imgBorder).offset(-20);
        make.top.equalTo(self.lblDesc.mas_bottom).offset(20);
        
    }];
    
    _imgBorder.image = IMAGE(@"auth_alert_border");
    [_btnClose setImage:IMAGE(@"auth_alert_button_close") forState:UIControlStateNormal];
    _imgHeader.image = IMAGE(@"auth_alert_warn");
    
    [_btnClose addTarget:self action:@selector(cancleClick)];
    
    _lblTitle.text = @"授权失败将无法获取收益";
    _lblTitle.font = [UIFont systemFontOfSize:18];
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.numberOfLines = 0;
    
    _lblDesc.text = @"您的淘宝账号还未绑定支付宝，请先去授权";
    _lblDesc.font = [UIFont systemFontOfSize:12];
    _lblDesc.textColor = RGB(153, 153, 153);
    _lblDesc.numberOfLines = 0;
    
    [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [_btnCancel setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    [_btnCancel setBackgroundImage:IMAGE(@"auth_alert_button_cancle") forState:UIControlStateNormal];
    [_btnCancel addTarget:self action:@selector(cancleClick)];
    
    [_btnMore setTitle:@"重新授权" forState:UIControlStateNormal];
    [_btnMore setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_btnMore setBackgroundImage:IMAGE(@"auth_alert_button_normal") forState:UIControlStateNormal];
    [_btnMore addTarget:self action:@selector(authClick)];
}

- (void)cancleClick {
    [self removeFromSuperview];
    if (_cancleBlock)
        _cancleBlock();
    _cancleBlock = nil;
}

- (void)authClick {
    [self removeFromSuperview];
    if (_authBlock)
        _authBlock();
    _authBlock = nil;
}

- (void)showTitle: (NSString*)title withDesc: (NSString*)desc authBlock: (AuthBlock) block cancleBlock:(AuthBlock) cancleBlock {
    [self showTitle:title withDesc:desc leftTitle:@"取消" rightTitle:@"重新授权" leftBlock:cancleBlock rightBlock:block];
}

- (void)showTitle: (NSString*)title withDesc: (NSString*)desc leftTitle: (NSString*)leftTitle rightTitle: (NSString*)rightTitle leftBlock: (AuthBlock) leftBlock rightBlock: (AuthBlock) rightBlock{
    
    _lblTitle.text = title;
    _lblDesc.text = desc;
    
    [_btnCancel setTitle:leftTitle forState:UIControlStateNormal];
    [_btnMore setTitle:rightTitle forState:UIControlStateNormal];
    _btnCancel.hidden = ![leftTitle kr_isNotEmpty];
    _btnMore.hidden = ![rightTitle kr_isNotEmpty];
    
    [_btnCancel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgBorder).offset(20);
        if ([rightTitle kr_isNotEmpty]) {
            make.right.equalTo(self.imgBorder.mas_centerX).offset(-10);
        } else {
            make.right.equalTo(self.imgBorder).offset(-20);
        }
        make.top.equalTo(self.lblDesc.mas_bottom).offset(20);
        make.bottom.equalTo(self.imgBorder).offset(-40);
        make.height.mas_equalTo(50);
    }];
    [_btnMore mas_remakeConstraints:^(MASConstraintMaker *make) {
        if ([leftTitle kr_isNotEmpty]) {
            make.left.equalTo(self.imgBorder.mas_centerX).offset(10);
        } else {
            make.left.equalTo(self.imgBorder).offset(20);
        }
        make.right.equalTo(self.imgBorder).offset(-20);
        make.top.equalTo(self.lblDesc.mas_bottom).offset(20);
        make.bottom.equalTo(self.imgBorder).offset(-40);
        make.height.mas_equalTo(50);
    }];
    
    _authBlock = rightBlock;
    _cancleBlock = leftBlock;
    
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
