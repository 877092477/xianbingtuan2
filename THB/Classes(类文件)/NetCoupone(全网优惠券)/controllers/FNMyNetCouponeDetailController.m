//
//  FNMyNetCouponeDetailController.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/10.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNMyNetCouponeDetailController.h"
#import "FNMyNetCouponeDetailModel.h"
#import "HXPhotoTools.h"

@interface FNMyNetCouponeDetailController()

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UIImageView *imgBg;
@property (nonatomic, strong) UIImageView *imgBorder;
@property (nonatomic, strong) UIImageView *imgTitle;
@property (nonatomic, strong) UIImageView *imgCode;
@property (nonatomic, strong) UIButton *btnSave;
@property (nonatomic, strong) UILabel *lblCode;
@property (nonatomic, strong) UIButton *btnCopy;
@property (nonatomic, strong) UILabel *lblTips;

@property (nonatomic, strong) FNMyNetCouponeDetailModel *model;


@end

@implementation FNMyNetCouponeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self requestMain];
}

- (void)configUI {
    _scrollview = [[UIScrollView alloc] init];
    _vContent = [[UIView alloc] init];
    _imgBg = [[UIImageView alloc] init];
    _imgBorder = [[UIImageView alloc] init];
    _imgTitle = [[UIImageView alloc] init];
    _imgCode = [[UIImageView alloc] init];
    _btnSave = [[UIButton alloc] init];
    _lblCode = [[UILabel alloc] init];
    _btnCopy = [[UIButton alloc] init];
    _lblTips = [[UILabel alloc] init];
    
    [self.view addSubview:_scrollview];
    [_scrollview addSubview:_vContent];
    [_vContent addSubview:_imgBg];
    [_vContent addSubview:_imgBorder];
    [_vContent addSubview:_imgTitle];
    [_vContent addSubview:_imgCode];
    [_vContent addSubview:_btnSave];
    [_vContent addSubview:_lblCode];
    [_vContent addSubview:_btnCopy];
    [_vContent addSubview:_lblTips];
    
    [_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view);
    }];
    [_imgBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_imgBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(337);
        make.height.mas_equalTo(480);
        make.top.equalTo(@30);
    }];
    [_imgTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.imgBorder).offset(22);
        make.width.mas_equalTo(211);
        make.height.mas_equalTo(87);
    }];
    [_imgCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.width.height.mas_equalTo(130);
        make.top.equalTo(self.imgTitle.mas_bottom).offset(20);
    }];
    [_btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgCode.mas_bottom).offset(17);
        make.left.greaterThanOrEqualTo(self.imgBorder).offset(20);
        make.right.lessThanOrEqualTo(self.imgBorder).offset(-20);
        make.centerX.equalTo(@0);
        make.height.mas_equalTo(10);
    }];
    [_lblCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnSave.mas_bottom).offset(20);
        make.left.greaterThanOrEqualTo(self.imgBorder).offset(20);
        make.right.lessThanOrEqualTo(self.imgBorder).offset(-20);
        make.centerX.equalTo(@0);
    }];
    [_btnCopy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.imgBorder).offset(-50);
        make.left.equalTo(self.imgBorder).offset(44);
        make.right.equalTo(self.imgBorder).offset(-44);
        make.centerX.equalTo(@0);
    }];
    [_lblTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imgBorder).offset(-14);
        make.left.greaterThanOrEqualTo(self.imgBorder).offset(20);
        make.right.lessThanOrEqualTo(self.imgBorder).offset(-20);
        make.centerX.equalTo(@0);
    }];
    
    _scrollview.bounces = NO;
    if (@available(iOS 11.0, *)) {
        _scrollview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _imgBg.contentMode = UIViewContentModeScaleAspectFill;
    
    _btnSave.titleLabel.font = kFONT10;
//    _btnSave addtarget
    [_btnSave addTarget:self action:@selector(onSaveClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnCopy addTarget:self action:@selector(onCopyClick) forControlEvents:UIControlEventTouchUpInside];
    
    _lblCode.font = [UIFont boldSystemFontOfSize:24];
    _lblTips.font = kFONT13;
}

- (void)updateView {
    if (self.model == nil)
        return;
    
    self.title = self.model.top_title;
    
    [self.imgBg sd_setImageWithURL: URL(self.model.bj_img)];
    [self.imgBorder sd_setImageWithURL: URL(self.model.bj_img1)];
    [self.imgTitle sd_setImageWithURL: URL(self.model.font_img)];
    [self.imgCode sd_setImageWithURL: URL(self.model.url)];
    
    [self.btnSave setTitle: self.model.str forState: UIControlStateNormal];
    [self.btnSave setTitleColor: [UIColor colorWithHexString: self.model.str_color] forState: UIControlStateNormal];
    
    [self.btnCopy setBackgroundImageWithURL: URL(self.model.btn_img) forState: UIControlStateNormal];
    
    self.lblTips.text = self.model.info_str;
    self.lblTips.textColor = [UIColor colorWithHexString:self.model.info_color];
    
    self.lblCode.text = self.model.code;
    self.lblCode.textColor = [UIColor colorWithHexString:self.model.code_color];
}

#pragma mark - Networking
- (void)requestMain{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    if ([_cardID kr_isNotEmpty]) {
        params[@"id"] = _cardID;
    }
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=coupon_exchange_userlist&ctrl=detail" respondType:(ResponseTypeModel) modelType:@"FNMyNetCouponeDetailModel" success:^(id respondsObject) {
        @strongify(self)
        
        self.model = respondsObject;
        [self updateView];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES];
    
}

#pragma mark - Action

- (void)onSaveClick {
    if (self.model == nil)
        return;
    
//    [FNTipsView showTips:@"兑换码复制成功"];
//    [[UIPasteboard generalPasteboard] setString:self.model.code];
//    [SVProgressHUD show];
    
    [XYNetworkAPI downloadImages:@[self.model.url] withIndexBlock:^(UIImage *image, NSInteger index) {
        NSString *name = [NSString stringWithFormat:@"%lf", [NSDate dateWithTimeIntervalSinceNow:0].timeIntervalSince1970];
        [HXPhotoTools savePhotoToCustomAlbumWithName:name photo: image];
        if (index == 0) {
            
            [SVProgressHUD dismiss];
            [FNTipsView showTips:@"保存成功～"];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)onCopyClick {
    if (self.model && [self.model.code kr_isNotEmpty]) {
        UIPasteboard *pab = [UIPasteboard generalPasteboard];
        [pab setString:self.model.code];
        if (pab == nil) {
            [FNTipsView showTips:@"复制失败"];
        }else{
            [FNTipsView showTips:@"复制成功"];
        }
    }
}

@end
