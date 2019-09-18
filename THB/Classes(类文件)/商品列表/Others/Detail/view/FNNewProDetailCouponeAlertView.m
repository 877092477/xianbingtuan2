//
//  FNNewProDetailCouponeAlertView.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewProDetailCouponeAlertView.h"

@interface FNNewProDetailCouponeAlertView()

@property (nonatomic, strong) UIButton *btnBg;
@property (nonatomic, strong) UIView *vCoupone;

@property (nonatomic, strong) UIImageView *imgCoupone;
@property (nonatomic, strong) UIImageView *imgTitle;
@property (nonatomic, strong) UILabel *lblCoupone;
@property (nonatomic, strong) UIButton *btnRecharge;
@property (nonatomic, strong) UILabel *lblPrice;

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UIImageView *imgCost;
@property (nonatomic, strong) UILabel *lblCostTitle;
@property (nonatomic, strong) UILabel *lblCost;
@property (nonatomic, strong) UILabel *lblDesc;

@property (nonatomic, strong) UIButton *btnCancle;
@property (nonatomic, strong) UIButton *btnBuy;

@property (nonatomic, strong) UIView *vLine1;
@property (nonatomic, strong) UIView *vLine2;

@end

@implementation FNNewProDetailCouponeAlertView

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
    _vCoupone = [[UIView alloc] init];
    _imgCoupone = [[UIImageView alloc] init];
    _imgTitle = [[UIImageView alloc] init];
    _lblCoupone = [[UILabel alloc] init];
    _btnRecharge = [[UIButton alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _vContent = [[UIView alloc] init];
    _imgCost = [[UIImageView alloc] init];
    _lblCostTitle = [[UILabel alloc] init];
    _lblCost = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _btnCancle = [[UIButton alloc] init];
    _btnBuy = [[UIButton alloc] init];
    _vLine1 = [[UIView alloc] init];
    _vLine2 = [[UIView alloc] init];
    
    [self addSubview:_btnBg];
    [self addSubview:_vCoupone];
    [_vCoupone addSubview:_imgCoupone];
    [_vCoupone addSubview:_imgTitle];
    [_vCoupone addSubview:_lblCoupone];
    [_vCoupone addSubview:_btnRecharge];
    [_vCoupone addSubview:_lblPrice];
    [_vCoupone addSubview:_vContent];
    [_vContent addSubview:_imgCost];
    [_vContent addSubview:_lblCostTitle];
    [_vContent addSubview:_lblCost];
    [_vContent addSubview:_lblDesc];
    [_vContent addSubview:_btnCancle];
    [_vContent addSubview:_btnBuy];
    [_vContent addSubview:_vLine1];
    [_vContent addSubview:_vLine2];
    
    [_btnBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_vCoupone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
//        make.bottom.equalTo(@0);
        make.top.equalTo(self.mas_bottom);
    }];
    [_imgCoupone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.mas_equalTo(@0);
    }];
    [_imgTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@18);
        make.width.height.mas_equalTo(18);
    }];
    [_lblCoupone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgTitle.mas_right).offset(12);
        make.centerY.equalTo(self.imgTitle);
        make.right.lessThanOrEqualTo(self.btnRecharge.mas_left).offset(-20);
    }];
    [_btnRecharge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-15);
        make.centerY.equalTo(self.imgTitle);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(0);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.bottom.equalTo(self.imgCoupone).offset(-30);
    }];
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(self.imgCoupone.mas_bottom);
        make.height.mas_equalTo(143 + (isIphoneX ? 34 : 0));
    }];
    [_imgCost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@22);
        make.width.height.mas_equalTo(18);
    }];
    [_lblCostTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgCost.mas_right).offset(12);
        make.centerY.equalTo(self.imgCost);
        
    }];
    [_lblCost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblCostTitle.mas_right).offset(25);
        make.centerY.equalTo(self.imgCost);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@26);
        make.right.lessThanOrEqualTo(@-10);
        make.bottom.equalTo(self.vLine1.mas_top).offset(-5);
    }];
    [_btnCancle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.height.mas_equalTo(43);
        make.right.equalTo(self.vContent.mas_centerX);
        make.bottom.equalTo(isIphoneX ? @-34 : @0);
    }];
    [_btnBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.height.mas_equalTo(43);
        make.left.equalTo(self.vContent.mas_centerX);
        make.bottom.equalTo(isIphoneX ? @-34 : @0);
    }];
    [_vLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.btnCancle.mas_top);
        make.height.mas_equalTo(1);
    }];
    [_vLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.vLine1);
        make.bottom.equalTo(self.btnCancle);
        make.width.mas_equalTo(1);
    }];
    
    _btnBg.backgroundColor = RGBA(0, 0, 0, 0.3);

    _lblCoupone.font = [UIFont boldSystemFontOfSize:12];
    
    _lblPrice.font = [UIFont boldSystemFontOfSize:44];
    
    _vContent.backgroundColor = UIColor.whiteColor;
    
    _lblCostTitle.font = [UIFont boldSystemFontOfSize:12];
    
    _lblCost.font = [UIFont boldSystemFontOfSize:18];
    
    _lblDesc.font = [UIFont systemFontOfSize:9];
    _lblDesc.numberOfLines = 2;
    
    _btnCancle.titleLabel.font = kFONT15;
    _btnBuy.titleLabel.font = kFONT15;
    _vLine1.backgroundColor = RGB(238, 238, 238);
    _vLine2.backgroundColor = RGB(238, 238, 238);
    
    self.hidden = YES;
    
    
    [_btnBg addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_btnCancle addTarget:self action:@selector(onCancleClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnBuy addTarget:self action:@selector(onBuyClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnRecharge addTarget:self action:@selector(onRechargeClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)show: (FNNewProductDetailCouponeModel*)model {
    self.hidden = NO;
    [self layoutIfNeeded];
    @weakify(self)
    [_imgCoupone sd_setImageWithURL: URL(model.coupon_exchange_bjimg) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            [self.imgCoupone mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(XYScreenWidth * image.size.height / image.size.width);
            }];
        }
    }];
    [_imgTitle sd_setImageWithURL: URL(model.coupon_exchange_moneyico)];
    [self.btnRecharge sd_setBackgroundImageWithURL:URL(model.coupon_exchange_btn_img) forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            [self.btnRecharge mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(20 * image.size.width / image.size.height);
            }];
        }
    }];
    
    _lblCoupone.text = model.title;
    _lblCoupone.textColor = [UIColor colorWithHexString: model.title_color];
    _lblPrice.text = model.coupon_money;
    _lblPrice.textColor = [UIColor colorWithHexString: model.coupon_money_color];
    
    [_imgCost sd_setImageWithURL: URL(model.coupon_exchange_ico)];
    
    _lblCostTitle.text = model.title1;
    _lblCostTitle.textColor = [UIColor colorWithHexString: model.title1_color];
    _lblCost.text = model.exchange_price;
    _lblCost.textColor = [UIColor colorWithHexString: model.exchange_price_color];
    _lblDesc.text = model.info;
    _lblDesc.textColor = [UIColor colorWithHexString: model.info_color];
    
    [_btnCancle setTitle:model.left_btn_str forState: UIControlStateNormal];
    [_btnCancle setTitleColor:[UIColor colorWithHexString: model.left_btn_color] forState: UIControlStateNormal];
    [_btnBuy setTitle:model.right_btn_str forState: UIControlStateNormal];
    [_btnBuy setTitleColor:[UIColor colorWithHexString: model.right_btn_color] forState: UIControlStateNormal];
    
    
    [_vCoupone mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    [UIView animateWithDuration:0.3 // 动画时长
                          delay:0.0 // 动画延迟
                        options:UIViewAnimationOptionCurveEaseIn // 动画过渡效果
                     animations:^{
                         [self layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         // 动画完成后执行
                     }];
}

- (void)dismiss {
    
    [_vCoupone mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.mas_bottom);
    }];
    
    [UIView animateWithDuration:0.3 // 动画时长
                          delay:0.0 // 动画延迟
                        options:UIViewAnimationOptionCurveEaseIn // 动画过渡效果
                     animations:^{
                         [self layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         
                         self.hidden = YES;
                     }];
}

- (void)onCancleClick {
    if ([_delegate respondsToSelector:@selector(didCancleClick)]) {
        [_delegate didCancleClick];
    }
}

- (void)onBuyClick {
    if ([_delegate respondsToSelector:@selector(didBuyClick)]) {
        [_delegate didBuyClick];
    }
}
- (void)onRechargeClick {
    if ([_delegate respondsToSelector:@selector(didRechargeClick)]) {
        [_delegate didRechargeClick];
    }
}
@end
