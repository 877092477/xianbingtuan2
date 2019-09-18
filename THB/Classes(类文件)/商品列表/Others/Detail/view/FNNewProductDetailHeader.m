//
//  FNNewProductDetailHeader.m
//  THB
//
//  Created by Jimmy on 2017/12/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNNewProductDetailHeader.h"
#import "FNNPDShopHeader.h"
#import "FNNewProductDetailModel.h"
#import "FNNPDSimularCell.h"
#import "FNProductVideoHeader.h"
#import "FNWebVideoManager.h"
const CGFloat _npdh_des_h = 40;
const CGFloat _npdh_price_h = 40;
const CGFloat _npdh_upgrade_h = 40;
const CGFloat _npdh_coupon_h = 80;
const CGFloat _npdh_simular_cell_h = 100 + 34 + 20+20+20;

@interface FNNewProductDetailHeader()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UIView* topview;
@property (nonatomic, strong)FNProductVideoHeader* imgscrollview;

@property (nonatomic, strong)UIView* desview;
@property (nonatomic, strong)UILabel* desLabel;

@property (nonatomic, strong)UIView* shareview;
@property (nonatomic, strong)NSLayoutConstraint* shareviewConsw;
@property (nonatomic, strong)UIButton* shareBtn;
@property (nonatomic, strong)UILabel* shareBtnLabel;
@property (nonatomic, strong)UIImageView* shareBgimg;
@property (nonatomic, strong)UILabel* shareLabel;

@property (nonatomic, strong)UIView* priceview;
@property (nonatomic, strong)UIImageView* priceimgview;
@property (nonatomic, strong)UILabel* priceLabel;
@property (nonatomic, strong)UILabel* typePriceLabel;
@property (nonatomic, strong)UILabel* salesLabel;
@property (nonatomic, strong)UILabel* redpacketLabel;

@property (nonatomic, strong)UIView* upgradeView;
@property (nonatomic, strong)UIImageView* imgUpgradeBG;
@property (nonatomic, strong)UIImageView* imgUpgrade;
@property (nonatomic, strong)UILabel* lblUpgrade;
@property (nonatomic, strong)UIButton* btnUpgrade;

@property (nonatomic, strong)UIView *vDesc;
@property (nonatomic, strong)UILabel *lblDesc;
@property (nonatomic, strong)UIButton *btnCopy;

@property (nonatomic, strong)UIView *vComment;
@property (nonatomic, strong)UILabel *lblCommentTitle;
@property (nonatomic, strong)UIImageView *imgCommentHeader;
@property (nonatomic, strong)UILabel *lblCommentNickname;
@property (nonatomic, strong)UILabel *lblComment;
@property (nonatomic, strong)UIButton *btnComment;
@property (nonatomic, strong)NSMutableArray<UIImageView*> *commentImages;

@property (nonatomic, strong)NSLayoutConstraint* upgradeviewconsh;

@property (nonatomic, strong)UIView* couponview;
@property (nonatomic, strong)UIImageView* couponbgimg;
@property (nonatomic, strong)UIView* coupon_left_view;
@property (nonatomic, strong)UILabel* coupon_des_label;
@property (nonatomic, strong)UILabel* coupon_date_label;
@property (nonatomic, strong)UIView* coupon_rgiht_view;
@property (nonatomic, strong)NSLayoutConstraint* couponviewconsh;
@property (nonatomic, assign)CGFloat couponviewH;

@property (nonatomic, strong)FNNPDShopHeader* shopview;
@property (nonatomic, strong)NSLayoutConstraint* shopconsh;
@property (nonatomic, strong)NSLayoutConstraint* shoptopconsh;

@property (nonatomic, strong)UIView* simularView;
@property (nonatomic, strong)NSLayoutConstraint* simularconsh;
//分享
@property (nonatomic, strong)UILabel *shareAddLb;
//升级
@property (nonatomic, strong)UILabel *supgradeAddLb;
//分享View
@property (nonatomic, strong)UIImageView *shareView;
//升级View
@property (nonatomic, strong)UIImageView *supgradeView;

@end
@implementation FNNewProductDetailHeader
- (FNProductVideoHeader *)imgscrollview{
    if (_imgscrollview == nil) {
        _imgscrollview = [FNProductVideoHeader new];
        _imgscrollview.backgroundColor = FNWhiteColor;
        @weakify(self)
        _imgscrollview.DownloadBlock = ^{
            @strongify(self)
            
            [self saveVideo:self.model.video];
        };
        _imgscrollview.ClickBlock = ^(NSInteger index) {
            @strongify(self)
            self.bannerClicked(nil, index);
        };
    }
    return _imgscrollview;
}

- (NSMutableArray<UIImageView*> *)commentImages {
    if (_commentImages == nil) {
        _commentImages = [[NSMutableArray alloc] init];
    }
    
    return _commentImages;
}

#pragma mark - des view
- (UIView *)desview{
    if (_desview == nil) {
        _desview = [UIView new];
        _desview.backgroundColor = FNWhiteColor;
        
        [_desview addSubview:self.desLabel];
//        [self.desLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
        [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return _desview;
}
- (UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [UILabel new];
        _desLabel.font = kFONT14;
        _desLabel.numberOfLines = 2;
    }
    return _desLabel;
}
#pragma mark - share view
- (UIButton *)shareBtn{
    if (_shareBtn == nil) {
        _shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _shareBtn.userInteractionEnabled = NO;
        [_shareBtn setImage:IMAGE(@"detail_share1") forState:(UIControlStateNormal)];
        [_shareBtn setImage:IMAGE(@"detail_share") forState:(UIControlStateSelected)];
        [_shareBtn sizeToFit];
        [_shareBtn addTarget:self action:@selector(shareBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _shareBtn;
}

- (UILabel *)shareBtnLabel{
    if (_shareBtnLabel == nil) {
        _shareBtnLabel = [UILabel new];
        _shareBtnLabel.text = @"分享";
        _shareBtnLabel.font = kFONT13;
        _shareBtnLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _shareBtnLabel;
}
- (UILabel *)shareLabel{
    if (_shareLabel == nil) {
        _shareLabel = [UILabel new];
        _shareLabel.textColor = FNWhiteColor;
        _shareLabel.font = kFONT13;
        _shareLabel.adjustsFontSizeToFitWidth=  YES;
        _shareLabel.numberOfLines = 2;
    }
    return _shareLabel;
}

- (UIImageView *)shareBgimg{
    if (_shareBgimg == nil) {
        _shareBgimg = [[UIImageView alloc]initWithImage:IMAGE(@"detail_share_word_bj")];
        _shareBgimg.alpha = 0;
        [_shareBgimg addSubview:self.shareLabel];
        [self.shareLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(3, 3, 3, 3))];
        
        
    }
    return _shareBgimg;
}
- (UIView *)shareview{
    if (_shareview == nil) {
        _shareview = [UIView new];
        
        [_shareview addSubview:self.shareBtn];
        [self.shareBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [self.shareBtn autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
        [self.shareBtn autoSetDimensionsToSize:self.shareBtn.size];
        
        [_shareview addSubview:self.shareBtnLabel];
        [self.shareBtnLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [self.shareBtnLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.shareBtn];
        [self.shareBtnLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.shareBtn withOffset:5];
        
        
        [_shareview addSubview:self.shareBgimg];
        [self.shareBgimg autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:self.shareBtn];
        [self.shareBgimg autoSetDimensionsToSize:self.shareBgimg.size];
        [self.shareBgimg autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];

        @weakify(self);
        [_shareview addJXTouch:^{
            @strongify(self);
            if (self.shareClicked) {
                self.shareClicked();
            }
        }];
    }
    return _shareview ;
}

#pragma makr - price
- (UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont boldSystemFontOfSize:16];
        _priceLabel.textColor = FNMainGobalControlsColor;
        
    }
    return _priceLabel;
}
- (UILabel *)salesLabel{
    if (_salesLabel == nil) {
        _salesLabel = [UILabel new];
        _salesLabel.textColor = FNGlobalTextGrayColor;
        _salesLabel.font = kFONT11;
    }
    return _salesLabel;
}
- (UILabel *)typePriceLabel{
    if (_typePriceLabel == nil) {
        _typePriceLabel = [UILabel new];
        _typePriceLabel.textColor = FNGlobalTextGrayColor;
        _typePriceLabel.font = kFONT12;
    }
    return _typePriceLabel;
}
- (UILabel *)redpacketLabel{
    if (_redpacketLabel == nil) {
        _redpacketLabel = [UILabel new];
        _redpacketLabel.font = kFONT10;
        _redpacketLabel.textColor = FNMainGobalControlsColor;
        _redpacketLabel.borderColor = FNMainGobalControlsColor;
        _redpacketLabel.borderWidth = 1;
        _redpacketLabel.cornerRadius = 3;
        
        
    }
    return _redpacketLabel;
}
- (UIImageView *)priceimgview{
    if (_priceimgview == nil) {
        _priceimgview = [UIImageView new];
        _priceimgview.size = IMAGE(@"list_after_quan").size;
    }
    return _priceimgview;
}


- (UIView *)priceview{
    if (_priceview == nil) {
        _priceview = [UIView new];
        
        //券后价image
//        [_priceview addSubview:self.priceimgview];
//        //[self.priceimgview autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.typePriceLabel];
//        [self.priceimgview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
//        [self.priceimgview autoSetDimensionsToSize:self.priceimgview.size];
        //券后价
        [_priceview addSubview:self.priceLabel];
        //[self.priceLabel autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
        [self.priceLabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
        [self.priceLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
//        [self.priceimgview autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.priceLabel];
        
        //天猫价 改为原价
        [_priceview addSubview:self.typePriceLabel];
        //[self.typePriceLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [self.typePriceLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.priceLabel withOffset:_jmsize_10];
        //[self.typePriceLabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
        [self.typePriceLabel autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.priceLabel withOffset:-2];
        //销量
        [_priceview addSubview:self.salesLabel];
        [self.salesLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.typePriceLabel];
        [self.salesLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.priceview withOffset:0];
        [self.salesLabel autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.priceLabel withOffset:-2];
        //[_priceview addSubview:self.redpacketLabel];
        //[self.redpacketLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        //[self.redpacketLabel autoSetDimension:(ALDimensionHeight) toSize:18];
       
        
        //[self.redpacketLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.priceLabel];
    }
    return _priceview;
}

- (UIImageView*) imgUpgradeBG {
    if (_imgUpgradeBG == nil) {
        _imgUpgradeBG = [[UIImageView alloc] init];
    }
    return _imgUpgradeBG;
}

- (UIImageView*) imgUpgrade {
    if (_imgUpgrade == nil) {
        _imgUpgrade = [[UIImageView alloc] init];
    }
    return _imgUpgrade;
}
- (UILabel*) lblUpgrade {
    if (_lblUpgrade == nil) {
        _lblUpgrade = [[UILabel alloc] init];
        _lblUpgrade.font = kFONT11;
//        _lblUpgrade.numberOfLines = 0;
    }
    return _lblUpgrade;
}
- (UIButton*) btnUpgrade {
    if (_btnUpgrade == nil) {
        _btnUpgrade = [[UIButton alloc] init];
        _btnUpgrade.titleLabel.font = kFONT11;
        @weakify(self);
        [_btnUpgrade addJXTouch:^{
            @strongify(self);
            if (self.upgradeClicked) {
                self.upgradeClicked();
            }
        }];
    }
    return _btnUpgrade;
}

- (UIView*) upgradeView {
    if (_upgradeView == nil) {
        
        _upgradeView = [[UIView alloc] init];
        
        [_upgradeView addSubview:self.imgUpgradeBG];
        [self.imgUpgradeBG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0).insets(UIEdgeInsetsMake(4, 10, 14, 10));
        }];
        
        [_upgradeView addSubview:self.imgUpgrade];
        [self.imgUpgrade mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgUpgradeBG).offset(5);
            make.centerY.equalTo(self.imgUpgradeBG);
            make.width.height.mas_equalTo(14);
        }];
//        self.imgUpgrade
        
        [_upgradeView addSubview:self.btnUpgrade];
        [self.btnUpgrade mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.imgUpgradeBG).offset(-4);
            make.centerY.equalTo(self.imgUpgradeBG);
        }];
        [self.btnUpgrade setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        
        [_upgradeView addSubview:self.lblUpgrade];
        [self.lblUpgrade mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgUpgrade.mas_right).offset(4);
//            make.top.equalTo(@6);
//            make.bottom.equalTo(@-6);
            make.centerY.equalTo(self.imgUpgradeBG);
            make.right.lessThanOrEqualTo(self.btnUpgrade.mas_left).offset(-10);
        }];
        
        
        
    }
    
    return _upgradeView;
}

- (UIView*)vComment {
    if (_vComment == nil) {
        _vComment = [[UIView alloc] init];
        _vComment.backgroundColor = UIColor.whiteColor;
        
        [_vComment addSubview:self.lblCommentTitle];
        [_vComment addSubview:self.imgCommentHeader];
        [_vComment addSubview:self.lblCommentNickname];
        [_vComment addSubview:self.lblComment];
        [_vComment addSubview:self.btnComment];
        
        [self.lblCommentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@10);
            make.right.lessThanOrEqualTo(self.btnComment.mas_left).offset(-10);
        }];
        
        [self.btnComment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.top.equalTo(@10);
        }];
        
        [self.imgCommentHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.top.equalTo(self.lblCommentTitle.mas_bottom).offset(4);
            make.width.height.mas_equalTo(22);
        }];
        
        [self.lblCommentNickname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgCommentHeader.mas_right).offset(4);
            make.centerY.equalTo(self.imgCommentHeader);
            make.right.lessThanOrEqualTo(@-10);
        }];
        
        [self.lblComment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.lessThanOrEqualTo(@-10);
            make.top.equalTo(self.imgCommentHeader.mas_bottom).offset(4);
            make.bottom.lessThanOrEqualTo(@-10);
        }];
        

    }
    return _vComment;
}

- (UILabel*)lblCommentTitle {
    if (_lblCommentTitle == nil) {
        _lblCommentTitle = [[UILabel alloc] init];
        _lblCommentTitle.font = [UIFont boldSystemFontOfSize:14];
        _lblCommentTitle.textColor = RGB(60, 60, 60);
        _lblCommentTitle.text = @"宝贝评价";
    }
    return _lblCommentTitle;
};
- (UIImageView*)imgCommentHeader {
    if (_imgCommentHeader == nil) {
        _imgCommentHeader = [[UIImageView alloc] init];
    }
    return _imgCommentHeader;
};
- (UILabel*)lblCommentNickname {
    if (_lblCommentNickname == nil) {
        _lblCommentNickname = [[UILabel alloc] init];
        _lblCommentNickname.font  = kFONT14;
        _lblCommentNickname.textColor = RGB(190, 190, 190);
    }
    return _lblCommentNickname;
};

- (UILabel*)lblComment {
    if (_lblComment == nil) {
        _lblComment = [[UILabel alloc] init];
        _lblComment.textColor = RGB(140, 140, 140);
        _lblComment.font = kFONT12;
        _lblComment.numberOfLines = 0;
    }
    return _lblComment;
}
- (UIButton*)btnComment {
    if (_btnComment == nil) {
        _btnComment = [[UIButton alloc] init];
        
        [self.btnComment setTitle:@"查看全部 >" forState:UIControlStateNormal];
        [self.btnComment setTitleColor:RGB(255, 95, 16) forState:UIControlStateNormal];
        self.btnComment.titleLabel.font = kFONT12;
        
        @weakify(self);
        [_btnComment addJXTouch:^{
            @strongify(self);
            if (self.CommentClicked) {
                self.CommentClicked();
            }
        }];
    }
    return _btnComment;
}

- (UIView*)vDesc {
    if (_vDesc == nil) {
        _vDesc = [[UIView alloc] init];
        _vDesc.backgroundColor = UIColor.whiteColor;
        
        [_vDesc addSubview:self.lblDesc];
        [_vDesc addSubview:self.btnCopy];
        
        [self.lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@10);
            make.right.lessThanOrEqualTo(@-10);
        }];
        
        [self.btnCopy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.top.equalTo(self.lblDesc.mas_bottom).offset(4);
            make.bottom.equalTo(@-10);
            make.width.mas_equalTo(66);
            make.height.mas_equalTo(20);
        }];
        self.btnCopy.cornerRadius = 10;
        
        
    }
    return _vDesc;
}
- (UILabel*)lblDesc {
    if (_lblDesc == nil) {
        _lblDesc = [[UILabel alloc] init];
        _lblDesc.textColor = RGB(140, 140, 140);
        _lblDesc.font = kFONT12;
        _lblDesc.numberOfLines = 0;
    }
    return _lblDesc;
}
- (UIButton*)btnCopy {
    if (_btnCopy == nil) {
        _btnCopy = [[UIButton alloc] init];
        [_btnCopy setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_btnCopy setTitle:@"复制文案" forState:UIControlStateNormal];
        _btnCopy.backgroundColor = RGB(255, 38, 38);
        _btnCopy.titleLabel.font = kFONT12;
        @weakify(self);
        [_btnCopy addJXTouch:^{
            @strongify(self);
            if (self.CopyClicked) {
                self.CopyClicked();
            }
        }];
    }
    return _btnCopy;
}
#pragma mark - coupon
- (UILabel *)coupon_des_label{
    if (_coupon_des_label == nil) {
        _coupon_des_label = [UILabel new];
        _coupon_des_label.font = [UIFont boldSystemFontOfSize:15];
        _coupon_des_label.textColor = FNWhiteColor;
        _coupon_des_label.adjustsFontSizeToFitWidth = YES;
        _coupon_des_label.textAlignment = NSTextAlignmentCenter;
    }
    return _coupon_des_label;
}
- (UILabel *)coupon_date_label{
    if (_coupon_date_label == nil) {
        _coupon_date_label = [UILabel new];
        _coupon_date_label.font = kFONT11;
        _coupon_date_label.textColor = FNWhiteColor;
        _coupon_date_label.adjustsFontSizeToFitWidth = YES;
        _coupon_date_label.textAlignment = NSTextAlignmentCenter;
    }
    return _coupon_date_label;
}
- (UIView *)coupon_left_view{
    if (_coupon_left_view == nil) {
        _coupon_left_view = [UIView new];
        
        [_coupon_left_view addSubview:self.coupon_des_label];
        [self.coupon_des_label autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
        
        [_coupon_left_view addSubview:self.coupon_date_label];
        [self.coupon_date_label autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.coupon_des_label withOffset:_jmsize_10];
        [self.coupon_date_label autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [self.coupon_date_label autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        
    }
    return _coupon_left_view;
}
- (UIView *)coupon_rgiht_view{
    if (_coupon_rgiht_view == nil) {
        _coupon_rgiht_view = [UIView new];
        
        UILabel * titleLabel = [UILabel new];
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        titleLabel.textColor = FNWhiteColor;
        titleLabel.text = @"立即领券";
        [_coupon_rgiht_view addSubview:titleLabel];
        [titleLabel autoCenterInSuperview];
        
        
    }
    return _coupon_rgiht_view;
}
- (UIView *)couponview{
    if (_couponview == nil) {
        _couponview = [UIView new];
        @weakify(self);
        [_couponview addJXTouch:^{
            @strongify(self);
            if (self.getCouponClicked) {
                self.getCouponClicked();
            }
        }];
        _couponview.backgroundColor = UIColor.whiteColor;
        _couponview.hidden = YES;
        _couponbgimg = [[UIImageView alloc]initWithImage:IMAGE(@"detail_big_quan_bj")];
        _couponbgimg.hidden=YES;
        [_couponview addSubview:_couponbgimg];
        CGFloat rate = _couponbgimg.width/_couponbgimg.height;
        
        [_couponbgimg autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(10, 10, 10, 10))];
        
        
        self.couponviewH = (JMScreenWidth-20)/rate + 20;
        _couponview.height = self.couponviewH;
        
        UIView *line = [UIView new];
        //line.backgroundColor = FNWhiteColor;
        [_couponview addSubview:line];
        [line autoSetDimension:(ALDimensionWidth) toSize:1];
        [line autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jm_leftMargin];
        [line autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:_jm_leftMargin];
        [_couponview addSubview:self.coupon_rgiht_view];
        [self.coupon_rgiht_view autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(_jm_leftMargin, 25, _jm_leftMargin, 25)) excludingEdge:(ALEdgeLeft)];
        [self.coupon_rgiht_view autoSetDimension:(ALDimensionWidth) toSize:15*6];
        [line autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:self.coupon_rgiht_view withOffset:-_jmsize_10];
        
        [_couponview addSubview:self.coupon_left_view];
        [self.coupon_left_view autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.coupon_date_label];
        [self.coupon_left_view autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:25];
        [self.coupon_left_view autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:line withOffset:-(_jmsize_10+25)];
        [self.coupon_left_view autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        
    }
    return _couponview;
}

#pragma mark - top view
- (UIView *)topview{
    if (_topview == nil) {
        _topview = [UIView new];
        _topview.backgroundColor = FNWhiteColor;
        
        [_topview addSubview:self.imgscrollview];
        [self.imgscrollview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
        [self.imgscrollview autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionWidth) ofView:self.imgscrollview];
        
        [_topview addSubview:self.priceview];
        [self.priceview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.imgscrollview withOffset:_jmsize_10];
        [self.priceview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        [self.priceview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [self.priceview autoSetDimension:(ALDimensionHeight) toSize:_npdh_price_h/2];
        
        [_topview addSubview:self.desview];
        [self.desview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        //[self.desview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:-_jmsize_10];
//        [self.desview autoSetDimension:(ALDimensionHeight) toSize:_npdh_des_h];
        [self.desview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.priceview withOffset:_jmsize_10];
        [self.desview autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.topview withOffset:-_jmsize_10];
        
        [_topview addSubview:self.upgradeView];
        [self.upgradeView autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.desview];
        [self.upgradeView autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.desview];
        [self.upgradeView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.desview withOffset:_jmsize_10] ;
        self.upgradeviewconsh = [self.upgradeView autoSetDimension:(ALDimensionHeight) toSize:0];
        
        [_topview addSubview:self.vDesc];
        self.vDesc.hidden = YES;
        
        [self.vDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(self.upgradeView.mas_bottom);
            make.bottom.equalTo(self.topview).offset(-10);
            make.height.equalTo(@0);
        }];
    }
    return _topview;
}

#pragma mark - shop view
- (FNNPDShopHeader *)shopview{
    if (_shopview == nil) {
        _shopview = [[FNNPDShopHeader alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 0))];
        _shopview.hidden = YES;
        @weakify(self);
        [_shopview addJXTouch:^{
            @strongify(self);
            if (self.shopClicked) {
                self.shopClicked();
            }
        }];
    }
    return _shopview;
}


#pragma mark - simular view
- (UIView *)simularView{
    if (_simularView == nil) {
        _simularView = [UIView new];
        _simularView.backgroundColor = FNWhiteColor;
        
        UIView* bgview = [UIView new];
        [_simularView addSubview:bgview];
        [bgview autoSetDimension:(ALDimensionHeight) toSize:40];
        [bgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
        
//        UIView* header = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 40))];
//        header.backgroundColor = FNWhiteColor;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 2, 14)];
        line.backgroundColor = RGB(255, 0, 54);
        [bgview addSubview:line];
        
        UILabel* titlelabel = [[UILabel alloc]initWithFrame: CGRectMake(20, 10, JMScreenWidth - 40, 14)];
        titlelabel.font = kFONT14;
        titlelabel.text = @"相似推荐";
        [bgview addSubview:titlelabel];
//        [titleLabel autoCenterInSuperview];
        
        UICollectionViewFlowLayout * flowlayout = [UICollectionViewFlowLayout new];
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowlayout.sectionInset = UIEdgeInsetsMake(0, _jmsize_10, 0, _jmsize_10);
        self.jm_collectionview = [[UICollectionView alloc]initWithFrame:(CGRectZero) collectionViewLayout:flowlayout];
        self.jm_collectionview.showsVerticalScrollIndicator = NO;
        self.jm_collectionview.dataSource  = self;
        self.jm_collectionview.delegate = self;
        self.jm_collectionview.emptyDataSetSource = nil;
        self.jm_collectionview.emptyDataSetDelegate = nil;
        self.jm_collectionview.showsHorizontalScrollIndicator = NO;
        self.jm_collectionview.backgroundColor = FNWhiteColor;
        [self.jm_collectionview registerClass:[FNNPDSimularCell class] forCellWithReuseIdentifier:@"FNNPDSimularCell"];
        [_simularView addSubview:self.jm_collectionview];
        [self.jm_collectionview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
        [self.jm_collectionview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:bgview];
        
    }
    return _simularView;
}

#pragma mark - set up

- (void)jm_setupViews{
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.topview];
    [self.topview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
//    [self.topview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.couponview withOffset:10];
    
    [self addSubview:self.couponview];
    [self.couponview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.topview withOffset:20];
    [self.couponview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.couponview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    self.couponviewconsh = [self.couponview autoSetDimension:(ALDimensionHeight) toSize:0];
    

    [self addSubview:self.vComment];
    self.vComment.hidden = YES;
    [self.vComment autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.couponview withOffset:_jmsize_10];
    [self.vComment autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.vComment autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
//    [self.vComment autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.topview withOffset:_jmsize_10];
    
    
    [self addSubview:self.shopview];
    self.shoptopconsh = [self.shopview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.couponview withOffset:_jmsize_10];
//    [self.shopview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.vComment withOffset:_jmsize_10];
    [self.shopview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.shopview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    self.shopconsh = [self.shopview autoSetDimension:(ALDimensionHeight) toSize:self.shopview.height];
    
    
    [self addSubview:self.simularView];
    [self.simularView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [self.simularView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.simularView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.shopview withOffset:5];
    self.simularconsh = [self.simularView autoSetDimension:(ALDimensionHeight) toSize:_npdh_simular_cell_h+34];
    
    
    [self shareAndUpgradeUI];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [self changeHeight];
}
#pragma mark - action
- (void)shareBtnAction{
    
}
- (void)changeHeight{
    self.height = self.topview.height + self.shopconsh.constant +
    self.simularconsh.constant+10 +
    (self.model.comment && self.model.comment.rateList && ![FNCurrentVersion isEqualToString: Setting_checkVersion] ? self.vComment.height : 0) +
    (self.model.yhq.boolValue ? self.couponviewH + 10 : 10) + 10 ;
}
#pragma mark - collection data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.xggoodsArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNNPDSimularCell* cell = [FNNPDSimularCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    cell.model  = self.model.xggoodsArr[indexPath.item];
    return cell;
}

#pragma mark - collection delelgate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = 100;
    CGFloat height = _npdh_simular_cell_h;
    CGSize size = CGSizeMake(width, height);
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.productClicked) {
        self.productClicked(self.model.xggoodsArr[indexPath.item]);
    }
}
- (void)setModel:(FNNewProductDetailModel *)model{
    _model = model;
    if (_model) {
        self.shopview.hidden = !self.model.is_store.boolValue;
        if (self.model.is_store.boolValue) {
            self.shopview.model = self.model.dpArr;
            self.shopconsh.constant = self.shopview.height;
        }else{
            self.shopconsh.constant = 0;
        }
        
        self.simularView.hidden = !(self.model.xggoodsArr.count>=1);
        if (self.model.xggoodsArr.count>=1) {
            self.simularconsh.constant = _npdh_simular_cell_h+34;
            [self layoutIfNeeded];
            [self.jm_collectionview reloadData];
        }else{
            self.simularconsh.constant = 0;
        }
        
        BOOL showMidUpgrade = self.model.mid_zgz && [self.model.mid_zgz[@"is_show"] isEqual:@1] && ![FNCurrentVersion isEqualToString:Setting_checkVersion];
        self.upgradeView.hidden = !showMidUpgrade;
        if  (showMidUpgrade) {
            self.upgradeviewconsh.constant = _npdh_upgrade_h;
            
            [self.imgUpgradeBG sd_setImageWithURL:URL(self.model.mid_zgz[@"img"])];
            [self.imgUpgrade sd_setImageWithURL:URL(self.model.mid_zgz[@"img1"])];
            self.lblUpgrade.text = self.model.mid_zgz[@"str"];
            self.lblUpgrade.textColor = [UIColor colorWithHexString:self.model.mid_zgz[@"fontcolor"]];
            [self.btnUpgrade setTitle:[NSString stringWithFormat:@"%@ >>", self.model.mid_zgz[@"str1"]] forState:UIControlStateNormal];
            [self.btnUpgrade setTitleColor:[UIColor colorWithHexString:self.model.mid_zgz[@"fontcolor"]] forState:UIControlStateNormal];
        } else {
            self.upgradeviewconsh.constant = 0;
        }
        
        NSString *doc_str = [model.doc_str kr_isNotEmpty] ? model.doc_str : @"商品文案：";
        if ([model.goods_description kr_isNotEmpty]) {
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:doc_str attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName: [UIColor colorWithHexString:model.doc_color]}];
            [str appendAttributedString:[[NSAttributedString alloc] initWithString:model.goods_description]];
            self.lblDesc.attributedText = str;
            [self.vDesc mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(@0);
                make.top.equalTo(self.upgradeView.mas_bottom);
                make.bottom.equalTo(self.topview).offset(-10);
            }];
            [self layoutIfNeeded];
            
            self.vDesc.hidden = NO;

        } else {
            self.lblDesc.text = @"";
            [self.vDesc mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(@0);
                make.top.equalTo(self.upgradeView.mas_bottom);
                make.bottom.equalTo(self.topview).offset(-10);
                make.height.equalTo(@0);
            }];
            
            [self layoutIfNeeded];
            self.vDesc.hidden = YES;
        }
        
        if ([model.doc_copy_str kr_isNotEmpty] && [model.doc_copy_color kr_isNotEmpty] && [model.doc_copy_btncolor kr_isNotEmpty]) {
            [_btnCopy setTitleColor:[UIColor colorWithHexString: model.doc_copy_color] forState:UIControlStateNormal];
            [_btnCopy setTitle:model.doc_copy_str forState:UIControlStateNormal];
            _btnCopy.backgroundColor = [UIColor colorWithHexString: model.doc_copy_btncolor];
        }
        
        if (model.comment && model.comment.rateList && ![FNCurrentVersion isEqualToString: Setting_checkVersion]) {
            
            self.lblCommentTitle.text = model.comment.totalCount;
            [self.imgCommentHeader sd_setImageWithURL:URL(model.comment.rateList.headPic)];
            self.lblCommentNickname.text = model.comment.rateList.userName;
            self.lblComment.text = model.comment.rateList.content;
            
            for (UIImageView *img in self.commentImages) {
                [img removeFromSuperview];
            }
            [self.commentImages removeAllObjects];
            
            int COLUMN = 4;
            CGFloat width = (XYScreenWidth - (COLUMN + 1) * 10) / COLUMN;
            for (NSInteger index = 0; index < model.comment.rateList.images.count; index ++) {
                UIImageView *img = [[UIImageView alloc] init];
                [_vComment addSubview:img];
                [img sd_setImageWithURL:URL(model.comment.rateList.images[index])];
                img.contentMode = UIViewContentModeScaleAspectFill;
                img.layer.masksToBounds = YES;
                [self.commentImages addObject:img];
                NSInteger row = index / COLUMN;
                NSInteger column = index % COLUMN;
                [img mas_makeConstraints:^(MASConstraintMaker *make) {
                    if (row == 0) {
                        make.top.equalTo(self.lblComment.mas_bottom).offset(10);
                    } else {
                        make.top.equalTo(self.commentImages[index - COLUMN].mas_bottom).offset(10);
                    }
                    if (column == 0) {
                        make.left.equalTo(@10);
                    } else {
                        make.left.equalTo(self.commentImages[index - 1].mas_right).offset(10);
                    }
                    make.width.height.mas_equalTo(width);
                    make.bottom.lessThanOrEqualTo(@-10);
                }];
                NSInteger i = index;
                @weakify(self)
                [img addJXTouch:^{
                    @strongify(self)
                    if (self.CommentImageClicked) {
                        self.CommentImageClicked(img, i);
                    }
                }];
            }

            [UIView autoRemoveConstraint:self.shoptopconsh];
            self.shoptopconsh = [self.shopview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.vComment withOffset:_jmsize_10];
            
            self.vComment.hidden = NO;
        } else {
            self.vComment.hidden = YES;
            
            [UIView autoRemoveConstraint:self.shoptopconsh];
            self.shoptopconsh = [self.shopview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.couponview withOffset:_jmsize_10];
        }
    
//        self.imgscrollview.imageURLStringsGroup = self.model.imgArr;
        [self.imgscrollview updateUIWithImageAndVideoArray:self.model.imgArr isVideoShow:[self.model.video kr_isNotEmpty]];
        @weakify(self)
        self.imgscrollview.PlayVideoOptBlock = ^(BOOL isOK) {
            @strongify(self)
            if (self.PlayClicked) {
                self.PlayClicked();
            }
            [self.imgscrollview playWithUrl:URL(self.model.video)];
        };
        self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",self.model.goods_price.floatValue];
        self.redpacketLabel.text = [NSString stringWithFormat:@"  %@  ",_model.str];
        
        [self.priceimgview setUrlImg:_model.goods_ico_one];
        self.couponview.hidden = !_model.yhq.boolValue;
        self.redpacketLabel.hidden = _model.str == nil || _model.str.length == 0;
        
        if ([FNBaseSettingModel settingInstance].app_sharegoods_onoff.boolValue) {
            self.shareview.hidden=YES;
//            self.shareviewConsw.constant=0;
        }else{
            self.shareview.hidden=NO;
            self.shareLabel.text = _model.fxz;
            if (_model.fxz == nil || _model.fxz.length == 0) {
                self.shareBtn.selected = YES;
                self.shareBtnLabel.hidden = NO;
                self.shareBgimg.alpha = 0;
//                self.shareviewConsw.constant = _npdh_des_h;
            }else{
                self.shareBtn.selected = NO;
                self.shareBtnLabel.hidden = YES;
                self.shareBgimg.alpha = 1;
//                self.shareviewConsw.constant = self.shareBgimg.width+self.shareBtn.width+20;
            }
        }
        
        if (_model.yhq.boolValue) {
            self.couponviewconsh.constant = self.couponviewH;
        }else{
            self.couponviewconsh.constant = 0;
            [self.topview layoutIfNeeded];
        }
        
        
        //self.salesLabel.text = [NSString stringWithFormat:@" 销量 %ld",_model.goods_sales.integerValue];
        self.salesLabel.text = [NSString stringWithFormat:@" 销量 %@",_model.goods_sales];
        
        //self.typePriceLabel.text = [NSString stringWithFormat:@"%@价 ¥%.2f",_model.shop_type,[_model.goods_cost_price floatValue]];
//        self.typePriceLabel.text = [NSString stringWithFormat:@"¥%.2f",[_model.goods_cost_price floatValue]];
        self.typePriceLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%.2f",[_model.goods_cost_price floatValue]] attributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
        
        self.desLabel.text = self.model.goods_title;
        if([self.model.goods_title kr_isNotEmpty]){
          [self.desLabel HttpLabelLeftImage:self.model.shop_img label:self.desLabel imageX:0 imageY:-1.5 imageH:13 atIndex:0];
        }
        self.couponbgimg.hidden=NO;
        [self.couponbgimg setUrlImg:[FNBaseSettingModel settingInstance].quan_bjimg];
        self.coupon_date_label.text = self.model.yhq_use_time;
        self.coupon_des_label.text = self.model.yhq_span;
        
        NSDictionary *img_sjzDic=self.model.img_sjz;
        NSInteger sjShow=[img_sjzDic[@"is_show"] integerValue];
        [self.supgradeView sd_setImageWithURL: URL(img_sjzDic[@"img"]) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            @strongify(self)
            if (image) {
                self.supgradeView.sd_layout
                .rightEqualToView(self).bottomSpaceToView(self.shareView, 10).heightIs(120 * image.size.height / image.size.width).widthIs(120);

            }
        }];
        
        if(sjShow==0){
            self.supgradeView.hidden=YES;
        }else{
             self.supgradeView.hidden=NO;
            NSString *sjString=[NSString stringWithFormat:@"%@\n%@",img_sjzDic[@"str"],img_sjzDic[@"bili"]];
            self.supgradeAddLb.text=sjString;
        }
       
        NSDictionary *img_fxz=self.model.img_fxz;
         NSInteger fxShow=[img_fxz[@"is_show"] integerValue];
        [self.shareView sd_setImageWithURL: URL(img_fxz[@"img"]) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            @strongify(self)
            if (image) {
                
                self.shareView.sd_layout
                .rightEqualToView(self).topSpaceToView(self, XYScreenWidth - 100).heightIs(120 * image.size.height / image.size.width).widthIs(120);

            }
        }];
        if(fxShow==0){
            self.shareView.hidden=YES;
        }else{
            self.shareView.hidden=NO;
            NSString *fxString=[NSString stringWithFormat:@"%@\n%@",img_fxz[@"str"],img_fxz[@"bili"]];
            self.shareAddLb.text=fxString;
        }
       
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
        [self changeHeight];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self changeHeight];
}

#pragma mark -  top分享 && 升级赚
-(void)shareAndUpgradeUI{
    
    //分享
    self.shareView=[UIImageView new];
    self.shareView.hidden=YES;
//    self.shareView.image=IMAGE(@"dshare_bj");
    [self addSubview:self.shareView];
    self.shareView.sd_layout
    .rightEqualToView(self).topSpaceToView(self, XYScreenWidth - 100).heightIs(30).widthRatioToView(self, 0.25);
    
    //分享图片
    UIImageView*shareImage = [UIImageView new];
    shareImage.cornerRadius=10;
//    shareImage.image = IMAGE(@"detail_shareNew");
    [self.shareView addSubview:shareImage];
//    shareImage.sd_layout
//    .leftSpaceToView(self.shareView, 0).centerYEqualToView(self.shareView).heightIs(30).widthIs(30);
    [shareImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.width.equalTo(self.shareView.mas_height);
        make.height.equalTo(self.shareView.mas_height);
        make.centerY.equalTo(@0);
    }];
    
    //分享文字
    self.shareAddLb=[UILabel new];
    self.shareAddLb.textColor=[UIColor whiteColor];
    self.shareAddLb.numberOfLines=2;
    self.shareAddLb.font=kFONT10;
    [self.shareView addSubview:self.shareAddLb];
//    self.shareAddLb.sd_layout.centerYEqualToView(self.supgradeView)
//    .leftSpaceToView(shareImage, 10).rightSpaceToView(self.shareView, 5);
    [self.shareAddLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shareImage.mas_right).offset(4);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(@-5);
    }];
    [self bringSubviewToFront:self.shareView];
    self.shareView.userInteractionEnabled = YES;
    [self.shareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareAction)]];
    
    //升级
    self.supgradeView=[UIImageView new];
    self.supgradeView.hidden=YES;
//    self.supgradeView.image=IMAGE(@"dshare_bj");
    [self addSubview:self.supgradeView];
    self.supgradeView.sd_layout
    .rightEqualToView(self).bottomSpaceToView(self.shareView, 10).heightIs(30).widthRatioToView(self, 0.25);
    
    //升级图片
    UIImageView*supgradeImage = [UIImageView new];
    supgradeImage.cornerRadius=15;
//    supgradeImage.image = IMAGE(@"detail_up");
    [self.supgradeView addSubview:supgradeImage];
//    supgradeImage.sd_layout
//    .leftSpaceToView(self.supgradeView, 0).centerYEqualToView(self.supgradeView).heightIs(30).widthIs(30);
    [supgradeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.width.equalTo(self.supgradeView.mas_height);
        make.height.equalTo(self.supgradeView.mas_height);
        make.centerY.equalTo(@0);
    }];
    //升级文字
    self.supgradeAddLb=[UILabel new];
    self.supgradeAddLb.textColor=[UIColor whiteColor];
    self.supgradeAddLb.numberOfLines=2;
    self.supgradeAddLb.font=kFONT10;
    [self.supgradeView addSubview:self.supgradeAddLb];
//    self.supgradeAddLb.sd_layout.centerYEqualToView(self.supgradeView)
//    .leftSpaceToView(supgradeImage, 10).rightSpaceToView(self.supgradeView, 5);
    [self.supgradeAddLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(supgradeImage.mas_right).offset(4);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(@-5);
    }];
    [self bringSubviewToFront:self.supgradeView];
    self.supgradeView.userInteractionEnabled = YES;
    [self.supgradeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(supgradeAction)]];
}
//分享
-(void)shareAction{
    if (self.shareClicked) {
        self.shareClicked();
    }
}
//升级
-(void)supgradeAction{
    if (self.upgradeClicked) {
        self.upgradeClicked();
    }
    
}

-(void)stopPlaying {
    [_imgscrollview stopPlaying];
}

#pragma mark - DownloadVideo

//videoPath为视频下载到本地之后的本地路径
- (void)saveVideo:(NSString *)videoPath{
    
    [FNTipsView showTips:@"视频下载开始"];
    if (videoPath) {
        [[FNWebVideoManager shareInstance] downloadWithUrl:URL(videoPath) completed:^(UIImage * _Nonnull coverImage, NSURL * _Nonnull fileUrl, NSError * _Nonnull error, BOOL finished) {
            BOOL compatible = UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(fileUrl.path);
            if (compatible)
            {
                //保存相册核心代码
                UISaveVideoAtPathToSavedPhotosAlbum(fileUrl.path, self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
            }
        }];
    }
}


//保存视频完成之后的回调
- (void) savedPhotoImage:(UIImage*)image didFinishSavingWithError: (NSError *)error contextInfo: (void *)contextInfo {
    if (error) {
        NSLog(@"保存视频失败%@", error.localizedDescription);

        [FNTipsView showTips:@"视频保存失败"];
    }
    else {
        NSLog(@"保存视频成功");
        [FNTipsView showTips:@"视频保存成功"];
    }
}

@end
