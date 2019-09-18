//
//  FNNetCouponeReceiveAlertView.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNetCouponeReceiveAlertView.h"
#import "FNNetCouponeAlertModel.h"

@interface FNNetCouponeReceiveAlertView()

@property (nonatomic, strong) UIButton *btnBg;
@property (nonatomic, strong) UIImageView *imgBorder;
@property (nonatomic, strong) UIButton *btnClose;

@property (nonatomic, strong) UIImageView *imgCode;
@property (nonatomic, strong) UILabel *lblCode;
@property (nonatomic, strong) UIButton *btnOK;
@property (nonatomic, strong) UILabel *lblDesc;

@end

@implementation FNNetCouponeReceiveAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _btnBg = [[UIButton alloc] init];
    _imgBorder = [[UIImageView alloc] init];
    _btnClose = [[UIButton alloc] init];
    _imgCode = [[UIImageView alloc] init];
    _lblCode = [[UILabel alloc] init];
    _btnOK = [[UIButton alloc] init];
    _lblDesc = [[UILabel alloc] init];
    
    [self addSubview:_btnBg];
    [self addSubview:_imgBorder];
    [self addSubview:_btnClose];
    [self addSubview:_imgCode];
    [self addSubview:_lblCode];
    [self addSubview:_btnOK];
    [self addSubview:_lblDesc];
    
    [_btnBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_imgBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.centerX.equalTo(@0);
        make.width.mas_equalTo(305);
        make.height.mas_equalTo(400);
    }];
    [_btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgBorder.mas_bottom).offset(38);
        make.centerX.equalTo(@0);
    }];
    [_imgCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.imgBorder).offset(102);
        make.width.height.mas_equalTo(126);
    }];
    [_lblCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(self.imgBorder).offset(20);
        make.right.lessThanOrEqualTo(self.imgBorder).offset(-20);
        make.top.equalTo(self.imgCode.mas_bottom).offset(12);
        make.centerX.equalTo(@0);
    }];
    [_btnOK mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imgBorder).offset(-65);
        make.height.mas_equalTo(38);
        make.width.mas_equalTo(0);
        make.centerX.equalTo(@0);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imgBorder).offset(-30);
        make.left.greaterThanOrEqualTo(self.imgBorder).offset(20);
        make.right.lessThanOrEqualTo(self.imgBorder).offset(-20);
        make.centerX.equalTo(@0);
    }];
    
    _btnBg.backgroundColor = RGBA(0, 0, 0, 0.3);
    
    [_btnClose setImage:IMAGE(@"net_coupone_button_close") forState: UIControlStateNormal];
    [_btnClose addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    _lblCode.textColor = RGB(50, 47, 42);
    _lblCode.font = [UIFont boldSystemFontOfSize:18];
    
    _lblDesc.textColor = RGB(163, 164, 168);
    _lblDesc.font = kFONT12;
    
    [_btnOK addTarget:self action:@selector(okClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)show:(NSString*)imgBorder button: (NSString*)imgButton desc: (NSString*)desc{
    self.hidden = NO;
    
    [self.imgBorder sd_setImageWithURL: URL(imgBorder)];
    
    @weakify(self)
    [self.btnOK sd_setBackgroundImageWithURL:URL(imgButton) forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            [self.btnOK mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(38 * image.size.width / image.size.height);
            }];
        }
    }];
    self.lblDesc.text = desc;
}

- (void)show:(FNNetCouponeAlertModel*)model {
    self.hidden = NO;
    
    [self.imgBorder sd_setImageWithURL: URL(model.bjimg)];

    [self.imgCode sd_setImageWithURL: URL(model.url)];
    self.lblCode.text = model.code;
    
    @weakify(self)
    [self.btnOK sd_setBackgroundImageWithURL:URL(model.btn_img) forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            [self.btnOK mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(38 * image.size.width / image.size.height);
            }];
        }
    }];
    self.lblDesc.text = model.str;
}

- (void)dismiss {
    self.hidden = YES;
}

- (void)okClick {
    if (_btnClickedAction) {
        _btnClickedAction();
    }
}

@end
