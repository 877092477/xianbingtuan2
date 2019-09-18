//
//  FNLiveBroadcastGoodsAlert.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveBroadcastGoodsAlert.h"

@interface FNLiveBroadcastGoodsAlert()

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIView *vGoods;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIButton *btnClose;
@property (nonatomic, strong) UIView *vLine;



@end

@implementation FNLiveBroadcastGoodsAlert

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    
    _vBackground = [[UIView alloc] init];;
    _vGoods = [[UIView alloc] init];;
    _lblTitle = [[UILabel alloc] init];;
    _btnClose = [[UIButton alloc] init];;
    _vLine = [[UIView alloc] init];;
    _loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing=0;
    flowayout.minimumInteritemSpacing=0;
    
    _covGoods = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowayout];
    
    [self addSubview: _vBackground];
    [self addSubview: _vGoods];
    [_vGoods addSubview: _lblTitle];
    [_vGoods addSubview: _btnClose];
    [_vGoods addSubview: _vLine];
    [_vGoods addSubview: _covGoods];
    [self addSubview:_loading];
    
    [_vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_vGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.mas_bottom);
        make.height.mas_equalTo(400);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.height.mas_equalTo(@18);
        make.top.equalTo(@18);
        make.centerX.equalTo(@0);
    }];
    [_btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblTitle);
        make.right.equalTo(@-10);
        make.width.height.mas_equalTo(30);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblTitle.mas_bottom).offset(18);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.height.mas_equalTo(1);
    }];
    [_covGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(self.vLine.mas_bottom);
    }];
    [_loading mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.covGoods);
//        make.width.height.mas_equalTo(50);
    }];
    
    _vBackground.backgroundColor = RGBA(0, 0, 0, 0.6);
    
    _vGoods.backgroundColor = UIColor.whiteColor;
    
    _lblTitle.text = @"直播清单";
    
    [_btnClose setImage:IMAGE(@"live_broadcast_button_close") forState:UIControlStateNormal];
    
    _vLine.backgroundColor = RGB(250, 250, 250);
    
    @weakify(self)
    [_vBackground addJXTouch:^{
        @strongify(self)
        [self dismiss];
    }];
    
    [_btnClose addTarget:self action:@selector(dismiss)];
    
    _covGoods.backgroundColor = UIColor.whiteColor;
    
}

- (void)show {
    self.hidden = NO;
    [self.covGoods reloadData];
    
//    [FNKeyWindow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    [_vGoods mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(400);
    }];
    [self setNeedsLayout];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)dismiss {
    
    [_vGoods mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.mas_bottom);
        make.height.mas_equalTo(400);
    }];
    [self setNeedsLayout];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];

}

@end
