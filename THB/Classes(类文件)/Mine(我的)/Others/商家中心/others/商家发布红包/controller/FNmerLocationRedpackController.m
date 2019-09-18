//
//  FNmerLocationRedpackController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/30.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNmerLocationRedpackController.h"
#import "FNCustomeNavigationBar.h"
#import "FNStoreManagerGoodsAddHeaderView.h"
#import "FNStoreManagerGoodsAddAdImageView.h"
#import "FNStoreManagerGoodsAddAdLinkView.h"
#import "FNcalendarPopDeView.h"
#import "TZImagePickerController.h"
#import "PGDatePicker.h"
#import "PGDatePickManager.h"
#import "FNStoreLocationRedpackPayAlertView.h"
#import "FNStoreLocationRedpackPayModel.h"
#import "FNStoreLocationRedpackPayModel.h"
#import "FNUpPaymodelNeView.h"
#import "FNmerLocationRedpackModel.h"

#import <AlipaySDK/AlipaySDK.h>
#import "WechatOpenSDK/WXApi.h"

@interface FNmerLocationRedpackController()<UITextFieldDelegate, FNcalendarPopDeViewDegate, TZImagePickerControllerDelegate, PGDatePickerDelegate>

@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UIView *vContent;

@property (nonatomic, strong) FNStoreManagerGoodsAddHeaderView *addName;

@property (nonatomic, strong) FNStoreManagerGoodsAddHeaderView *addDistance;
@property (nonatomic, strong) FNStoreManagerGoodsAddHeaderView *addPrice;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) FNStoreManagerGoodsAddHeaderView *addCount;
@property (nonatomic, strong) FNStoreManagerGoodsAddHeaderView *addAd;
@property (nonatomic, strong) UIButton *btnSwitch;

@property (nonatomic, strong) UIView *vAd;
@property (nonatomic, strong) FNStoreManagerGoodsAddHeaderView *addAdTime;
@property (nonatomic, strong) FNStoreManagerGoodsAddAdImageView *addAdImage;
@property (nonatomic, strong) FNStoreManagerGoodsAddAdLinkView *addAdLink;

@property (nonatomic, strong) FNStoreManagerGoodsAddHeaderView *addStarTime;
@property (nonatomic, strong) FNStoreManagerGoodsAddHeaderView *addEndTime;
@property (nonatomic, strong) UILabel *lblDescTime;

@property (nonatomic, strong) UIButton *btnPost;

@property (nonatomic, assign) int dateState;
@property (nonatomic, assign) BOOL is_luck;
@property (nonatomic, copy) NSString *start_time;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, strong) UIImage *redpackImage;

@property (nonatomic, strong) FNStoreLocationRedpackPayAlertView* alert;
@property (nonatomic, strong) FNStoreLocationRedpackPayModel *payModel;

@property (nonatomic, copy) NSString *payId;
@property (nonatomic, copy) NSString *payType;

@property (nonatomic, strong) FNmerLocationRedpackModel* model;

@end

@implementation FNmerLocationRedpackController

- (FNStoreLocationRedpackPayAlertView *)alert {
    if (_alert == nil) {
        _alert = [[FNStoreLocationRedpackPayAlertView alloc] init];
        
        _alert.delegate = self;
        [self.view addSubview:_alert];
        [_alert mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return _alert;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    
    if ([self.redpackId kr_isNotEmpty]) {
        [self requestMain];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWxSuccess) name:@"Wx_Resp_Success" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
#pragma mark - set up views
- (void)configUI{
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 10).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    
    self.view.backgroundColor=RGB(246, 245, 245);

    self.navigationView.titleLabel.text=@"发布位置红包";
 
    self.scrollview = [[UIScrollView alloc] init];
    _scrollview = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollview];
    
    _scrollview = [[UIScrollView alloc]init];
    _scrollview.backgroundColor=RGB(248, 248, 248);
    _scrollview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollview];
    
    _vContent = [[UIView alloc] init];
    [_scrollview addSubview:_vContent];
    
    [_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        make.bottom.equalTo(@-80);
        make.left.right.equalTo(@0);
    }];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.width.mas_equalTo(XYScreenWidth);
    }];
    
    _addName = [[FNStoreManagerGoodsAddHeaderView alloc] init];
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc] initWithString:@"*红包名称" attributes:@{NSFontAttributeName: kFONT14,NSForegroundColorAttributeName: RGB(255, 102, 102)}];
    [name addAttributes:@{NSForegroundColorAttributeName: RGB(24, 24, 24)} range:NSMakeRange(1, 4)];
    _addName.lblTitle.attributedText = name;
    _addName.txfTitle.placeholder = @"请输入红包名称";
    _addName.txfTitle.delegate = self;
    [_addName.txfTitle addTarget:self action:@selector(didNameChanged) forControlEvents:UIControlEventEditingChanged];
    [_vContent addSubview:_addName];
    [_addName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    
    _addDistance = [[FNStoreManagerGoodsAddHeaderView alloc] init];
    NSMutableAttributedString *distance = [[NSMutableAttributedString alloc] initWithString:@"*选择领取范围" attributes:@{NSFontAttributeName: kFONT14,NSForegroundColorAttributeName: RGB(255, 102, 102)}];
    [distance addAttributes:@{NSForegroundColorAttributeName: RGB(24, 24, 24)} range:NSMakeRange(1, 6)];
    _addDistance.lblTitle.attributedText = distance;
    _addDistance.txfTitle.placeholder = @"";
    _addDistance.txfTitle.delegate = self;
    _addDistance.txfTitle.keyboardType = UIKeyboardTypeNumberPad;
    _addDistance.lblUnit.text = @"公里";
    _addDistance.txfTitle.placeholder = @"0";
    [_addDistance.txfTitle addTarget:self action:@selector(didNameChanged) forControlEvents:UIControlEventEditingChanged];
    [_vContent addSubview:_addDistance];
    [_addDistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addName.mas_bottom).offset(14);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _addPrice = [[FNStoreManagerGoodsAddHeaderView alloc] init];
    NSMutableAttributedString *price = [[NSMutableAttributedString alloc] initWithString:@"*面值总金额" attributes:@{NSFontAttributeName: kFONT14,NSForegroundColorAttributeName: RGB(255, 102, 102)}];
    [price addAttributes:@{NSForegroundColorAttributeName: RGB(24, 24, 24)} range:NSMakeRange(1, 5)];
    _addPrice.lblTitle.attributedText = price;
    _addPrice.txfTitle.placeholder = @"";
    _addPrice.txfTitle.delegate = self;
    _addPrice.txfTitle.keyboardType = UIKeyboardTypeNumberPad;
    _addPrice.lblUnit.text = @"元";
    _addPrice.txfTitle.placeholder = @"请输入红包面额";
    [_addPrice.txfTitle addTarget:self action:@selector(didNameChanged) forControlEvents:UIControlEventEditingChanged];
    [_vContent addSubview:_addPrice];
    [_addPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addDistance.mas_bottom).offset(14);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _lblDesc = [[UILabel alloc] init];
    _lblDesc.text = @"当前为拼手气红包，改为普通红包";
    _lblDesc.font = kFONT11;
    _lblDesc.textColor = RGB(153, 153, 153);
    [_vContent addSubview:_lblDesc];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addPrice.mas_bottom).offset(4);
        make.left.equalTo(@33);
        make.right.lessThanOrEqualTo(@-33);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    @weakify(self);
    [_lblDesc addJXTouch:^{
        @strongify(self);
        self.is_luck = !self.is_luck;
        if (self.is_luck) {
            _lblDesc.text = @"当前为普通红包，改为拼手气红包";
        } else {
            _lblDesc.text = @"当前为拼手气红包，改为普通红包";
        }
        
    }];
    
    _addCount = [[FNStoreManagerGoodsAddHeaderView alloc] init];
    NSMutableAttributedString *count = [[NSMutableAttributedString alloc] initWithString:@"*总发行量" attributes:@{NSFontAttributeName: kFONT14,NSForegroundColorAttributeName: RGB(255, 102, 102)}];
    [count addAttributes:@{NSForegroundColorAttributeName: RGB(24, 24, 24)} range:NSMakeRange(1, 4)];
    _addCount.lblTitle.attributedText = count;
    _addCount.txfTitle.placeholder = @"";
    _addCount.txfTitle.delegate = self;
    _addCount.txfTitle.keyboardType = UIKeyboardTypeNumberPad;
    _addCount.lblUnit.text = @"个";
    _addCount.txfTitle.placeholder = @"请输入总发行量";
    [_addCount.txfTitle addTarget:self action:@selector(didNameChanged) forControlEvents:UIControlEventEditingChanged];
    [_vContent addSubview:_addCount];
    [_addCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblDesc.mas_bottom).offset(12);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _addAd = [[FNStoreManagerGoodsAddHeaderView alloc] init];
    NSMutableAttributedString *ad = [[NSMutableAttributedString alloc] initWithString:@"*是否加入广告" attributes:@{NSFontAttributeName: kFONT14,NSForegroundColorAttributeName: RGB(255, 102, 102)}];
    [ad addAttributes:@{NSForegroundColorAttributeName: RGB(24, 24, 24)} range:NSMakeRange(1, 6)];
    _addAd.lblTitle.attributedText = ad;
//    _addAd.txfTitle.enabled = NO;
    _addAd.txfTitle.delegate = self;
    [_addAd.txfTitle addTarget:self action:@selector(didNameChanged) forControlEvents:UIControlEventEditingChanged];
    [_vContent addSubview:_addAd];
    [_addAd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addCount.mas_bottom).offset(14);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _btnSwitch = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 30, 18)];
    [_btnSwitch setImage: IMAGE(@"FN_xdSJ_kqim") forState: UIControlStateSelected];
    [_btnSwitch setImage: IMAGE(@"FN_xdSJ_gbim") forState: UIControlStateNormal];
    [_btnSwitch addTarget:self action:@selector(onSwithClick) forControlEvents:UIControlEventTouchUpInside];
    _addAd.txfTitle.rightView = _btnSwitch;
    _addAd.txfTitle.rightViewMode = UITextFieldViewModeAlways;
    
    _vAd = [[UIView alloc] init];
    _vAd.hidden = YES;
    [_vContent addSubview:_vAd];
    [_vAd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addAd.mas_bottom);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
//        make.height.mas_equalTo(300);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _addAdTime = [[FNStoreManagerGoodsAddHeaderView alloc] init];
    NSMutableAttributedString *adTime = [[NSMutableAttributedString alloc] initWithString:@"*广告展示时间" attributes:@{NSFontAttributeName: kFONT14,NSForegroundColorAttributeName: RGB(255, 102, 102)}];
    [adTime addAttributes:@{NSForegroundColorAttributeName: RGB(24, 24, 24)} range:NSMakeRange(1, 6)];
    _addAdTime.lblTitle.attributedText = adTime;
    _addAdTime.txfTitle.placeholder = @"";
    _addAdTime.txfTitle.delegate = self;
    _addAdTime.txfTitle.keyboardType = UIKeyboardTypeNumberPad;
    _addAdTime.lblUnit.text = @"秒";
    _addAdTime.txfTitle.placeholder = @"请填入整数，建议5";
    [_addAdTime.txfTitle addTarget:self action:@selector(didNameChanged) forControlEvents:UIControlEventEditingChanged];
    [_vAd addSubview:_addAdTime];
    [_addAdTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@14);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _addAdImage = [[FNStoreManagerGoodsAddAdImageView alloc] init];
    NSMutableAttributedString *adImage = [[NSMutableAttributedString alloc] initWithString:@"*添加一张广告图" attributes:@{NSFontAttributeName: kFONT14,NSForegroundColorAttributeName: RGB(255, 102, 102)}];
    [adImage addAttributes:@{NSForegroundColorAttributeName: RGB(24, 24, 24)} range:NSMakeRange(1, 7)];
    _addAdImage.lblTitle.attributedText = adImage;
    [_vAd addSubview:_addAdImage];
    [_addAdImage.btnImage addTarget:self action:@selector(onImageSelect) forControlEvents:UIControlEventTouchUpInside];
    [_addAdImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addAdTime.mas_bottom).offset(14);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _addAdLink = [[FNStoreManagerGoodsAddAdLinkView alloc] init];
    NSMutableAttributedString *adLink = [[NSMutableAttributedString alloc] initWithString:@"*请输入链接地址" attributes:@{NSFontAttributeName: kFONT14,NSForegroundColorAttributeName: RGB(255, 102, 102)}];
    [adLink addAttributes:@{NSForegroundColorAttributeName: RGB(24, 24, 24)} range:NSMakeRange(1, 7)];
    _addAdLink.lblTitle.attributedText = adLink;
    _addAdLink.textfield.placeholder = @"示例：http://xxx.com";
    _addAdLink.textfield.delegate = self;
    [_addAdLink.textfield addTarget:self action:@selector(didNameChanged) forControlEvents:UIControlEventEditingChanged];
    [_vAd addSubview:_addAdLink];
    [_addAdLink mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addAdImage.mas_bottom).offset(14);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _addStarTime = [[FNStoreManagerGoodsAddHeaderView alloc] init];
    NSMutableAttributedString *starTime = [[NSMutableAttributedString alloc] initWithString:@"*开始有效期" attributes:@{NSFontAttributeName: kFONT14,NSForegroundColorAttributeName: RGB(255, 102, 102)}];
    [starTime addAttributes:@{NSForegroundColorAttributeName: RGB(24, 24, 24)} range:NSMakeRange(1, 5)];
    _addStarTime.lblTitle.attributedText = starTime;
    _addStarTime.txfTitle.delegate = self;
    [_addStarTime.txfTitle addTarget:self action:@selector(didNameChanged) forControlEvents:UIControlEventEditingChanged];
    [_vContent addSubview:_addStarTime];
    [_addStarTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addAd.mas_bottom).offset(14);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    UIImageView *img1 = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 18, 18)];
    img1.image = IMAGE(@"store_manager_redpack_calendar");
    img1.contentMode = UIViewContentModeCenter;
    _addStarTime.txfTitle.rightView = img1;
    _addStarTime.txfTitle.rightViewMode = UITextFieldViewModeAlways;
    
    _addEndTime = [[FNStoreManagerGoodsAddHeaderView alloc] init];
    NSMutableAttributedString *endTime = [[NSMutableAttributedString alloc] initWithString:@"*结束有效期" attributes:@{NSFontAttributeName: kFONT14,NSForegroundColorAttributeName: RGB(255, 102, 102)}];
    [endTime addAttributes:@{NSForegroundColorAttributeName: RGB(24, 24, 24)} range:NSMakeRange(1, 5)];
    _addEndTime.lblTitle.attributedText = endTime;
    _addEndTime.txfTitle.delegate = self;
    [_addEndTime.txfTitle addTarget:self action:@selector(didNameChanged) forControlEvents:UIControlEventEditingChanged];
    [_vContent addSubview:_addEndTime];
    [_addEndTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addStarTime.mas_bottom).offset(1);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    UIImageView *img2 = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 18, 18)];
    img2.image = IMAGE(@"store_manager_redpack_calendar");
    img2.contentMode = UIViewContentModeCenter;
    _addEndTime.txfTitle.rightView = img2;
    _addEndTime.txfTitle.rightViewMode = UITextFieldViewModeAlways;
    
    
    _lblDescTime = [[UILabel alloc] init];
    _lblDescTime.text = @"满减活动将于 0 天后开始，有效期 7 天";
    _lblDescTime.font = kFONT11;
    _lblDescTime.textColor = RGB(153, 153, 153);
    [_vContent addSubview:_lblDescTime];
    [_lblDescTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addEndTime.mas_bottom).offset(4);
        make.left.equalTo(@33);
        make.right.lessThanOrEqualTo(@-33);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    
    _btnPost = [[UIButton alloc] init];
    [_btnPost setTitle: @"确认支付并发布" forState: UIControlStateNormal];
    [_btnPost setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
    [_btnPost setBackgroundImage:IMAGE(@"FN_yhqANhbNobg") forState:UIControlStateDisabled];
    [_btnPost setBackgroundImage:IMAGE(@"FN_zhekouBCimg") forState:UIControlStateNormal];
    
    [_vContent addSubview:_btnPost];
    [_btnPost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblDescTime.mas_bottom).offset(30);
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
        make.bottom.lessThanOrEqualTo(@-50);
    }];
    [_btnPost addTarget:self action:@selector(onPostClick) forControlEvents:UIControlEventTouchUpInside];
    _btnPost.enabled = [self checkBtnEnable];
    
}

- (BOOL)checkBtnEnable {
    if (![_addName.txfTitle.text kr_isNotEmpty] && self.model == nil) {
//        [FNTipsView showTips:@"请输入红包名称"];
//        [_addName.txfTitle kr_shake];
        return NO;
    }
    
    if (![_addDistance.txfTitle.text kr_isNotEmpty] && self.model == nil) {
//        [FNTipsView showTips:@"请输入领取范围"];
//        [_addDistance.txfTitle kr_shake];
        return NO;
    }
    
    if (![_addPrice.txfTitle.text kr_isNotEmpty]) {
//        [FNTipsView showTips:@"请输入红包面额"];
//        [_addPrice.txfTitle kr_shake];
        return NO;
    }
    
    if (![_addCount.txfTitle.text kr_isNotEmpty]) {
//        [FNTipsView showTips:@"请输入总发行量"];
//        [_addCount.txfTitle kr_shake];
        return NO;
    }
    
    if (_btnSwitch.isSelected) {
        
        if (![_addAdTime.txfTitle.text kr_isNotEmpty]) {
//            [FNTipsView showTips:@"请输入展示时间"];
//            [_addAdTime.txfTitle kr_shake];
            return NO;
        }
        
        if (_redpackImage == nil) {
//            [FNTipsView showTips:@"请选择广告图"];
            return NO;
        }
        if (![_addAdLink.textfield.text kr_isNotEmpty]) {
//            [FNTipsView showTips:@"请输入链接地址"];
//            [_addAdLink.textfield kr_shake];
            return NO;
        }
    }
    
    if (![_addStarTime.txfTitle.text kr_isNotEmpty]) {
//        [FNTipsView showTips:@"请选择开始时间"];
//        [_addStarTime.txfTitle kr_shake];
        return NO;
    }
    
    if (![_addEndTime.txfTitle.text kr_isNotEmpty]) {
//        [FNTipsView showTips:@"请选择结束时间"];
//        [_addEndTime.txfTitle kr_shake];
        return NO;
    }
    
    return YES;
}

- (void) didNameChanged {
    _btnPost.enabled = [self checkBtnEnable];
}

#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)onSwithClick {
    _btnSwitch.selected = !_btnSwitch.selected;
    
    _vAd.hidden = !_btnSwitch.isSelected;
    if (_btnSwitch.isSelected) {
        [_addStarTime mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.vAd.mas_bottom).offset(14);
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
            make.height.mas_equalTo(44);
            make.bottom.lessThanOrEqualTo(@-10);
        }];
    } else {
        [_addStarTime mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.addAd.mas_bottom).offset(14);
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
            make.height.mas_equalTo(44);
            make.bottom.lessThanOrEqualTo(@-10);
        }];
    }
    
    _btnPost.enabled = [self checkBtnEnable];
}

- (void)onPostClick {
    
    if (![self checkBtnEnable]) {
        return;
    }
    
    if (self.model) {
        [self requestEdit];
    } else {
        [self requestAdd_red_packet];
    }
}

- (void)onImageSelect {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowTakePicture = YES;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowCrop = NO;
    //    CGFloat height = XYScreenWidth * 3.0 / 4.0;
    //    imagePickerVc.cropRect = CGRectMake(0, (XYScreenHeight - height) / 2, XYScreenWidth, height);
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {

    if (photos.count > 0) {
        [_addAdImage.btnImage setBackgroundImage:photos[0] forState: UIControlStateNormal];
        _redpackImage = photos[0];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:_addAd.txfTitle]) {
        return NO;
    }
    if ([textField isEqual:_addStarTime.txfTitle] || [textField isEqual:_addEndTime.txfTitle]) {
        self.dateState = [textField isEqual:_addStarTime.txfTitle] ? 1 : 2;
        FNcalendarPopDeView *calendarView = [[FNcalendarPopDeView alloc]init];
        calendarView.delegate=self;
        [[UIApplication sharedApplication].delegate.window addSubview:calendarView];
        return NO;
    }
    return YES;
}

#pragma mark - FNcalendarPopDeViewDegate // 选择日期

- (void)popSeletedDateClick:(NSString *)date{

    if(self.dateState==1){
        self.start_time=date;
        //        [self.customView.startBtn setTitle:date forState:UIControlStateNormal];
//        _addStarTime.txfTitle.text = date;
    }
    if(self.dateState==2){
        self.end_time=date;
        //        [self.customView.endBtn setTitle:date forState:UIControlStateNormal];
//        _addEndTime.txfTitle.text = date;
    }
    XYLog(@"选择日期=:%@",date);
    
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    PGDatePicker *datePicker = datePickManager.datePicker;
    //    datePicker.isOnlyHourFlag = YES;
    datePicker.delegate = self;
    datePicker.datePickerMode = PGDatePickerModeTimeAndSecond;
    [self presentViewController:datePickManager animated:YES completion:nil];
    
}

- (void)calcTime {
    _lblDescTime.text = @"";
    if (![_addStarTime.txfTitle.text kr_isNotEmpty] ||
        ![_addEndTime.txfTitle.text kr_isNotEmpty]) {
        return;
    }
    
    NSDate *sTime=[self StringToDate:_addStarTime.txfTitle.text inPattern:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *eTime=[self StringToDate:_addEndTime.txfTitle.text inPattern:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *today = [self inGainCurrentTimeAddTimeZone];
    CGFloat timeCha=[self inGainTimeDifferenceWithAtPresent:today toSeleted:sTime];
    NSMutableString *desc = [[NSMutableString alloc] init];
    if (timeCha < 0) {
        [desc appendString:@"活动立即开始，"];
    } else if(timeCha/24<1){
        [desc appendString:[NSString stringWithFormat:@"活动%.0f小时后开始，",timeCha]];
    }else{
        CGFloat downFloat=floorf(timeCha/24);
        CGFloat hourFloat=(timeCha/24-downFloat)*24;
        [desc appendString:[NSString stringWithFormat:@"活动%.0f 天 %.0f 小时后开始，",downFloat, hourFloat]];
    }
    
    CGFloat timeLTCha=[self inGainTimeDifferenceWithAtPresent:sTime toSeleted:eTime];
    if(timeLTCha/24<1){
        [desc appendString:[NSString stringWithFormat:@"有效期%.0f 小时",timeLTCha]];
    }else{
        int downFloat=floorf(timeLTCha/24);
        [desc appendString:[NSString stringWithFormat:@"有效期%d 天",downFloat]];
    }
    
    self.lblDescTime.text=desc;
}

//计算时间差2 时间一  时间二
-(CGFloat)inGainTimeDifferenceWithAtPresent:(NSDate *)presentDate toSeleted:(NSDate*)seletedDate{
    NSTimeInterval timeInterval = [seletedDate timeIntervalSinceDate:presentDate];
    CGFloat badFloat=timeInterval/3600.00;
    return badFloat;
}
//获取本时区时间
-(NSDate *)inGainCurrentTimeAddTimeZone{
    NSDate *nowDate = [NSDate date];
    // 设置系统时区为本地时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 计算本地时区与 GMT 时区的时间差
    NSInteger interval = [zone secondsFromGMT];
    // 在 GMT 时间基础上追加时间差值，得到本地时间
    nowDate = [nowDate dateByAddingTimeInterval:interval];
    NSLog(@"现在时间: nowDate=%@",nowDate);
    return nowDate;
    //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSString *nowDateString = [dateFormatter stringFromDate:nowDate];
}

-(NSDate *)stringDateWithString:(NSString *)strDate pattern:(NSString *)pattern{
    NSDateFormatter *poformatter = [[NSDateFormatter alloc]init];
    //formatter.dateFormat = pattern;
    [poformatter setDateFormat:pattern];
    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    return  [poformatter dateFromString:strDate];
}
-(NSDate*)StringToDate:(NSString*)curdate inPattern:(NSString*)pattern{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    
    NSString *inputDate = curdate;//[NSString stringWithFormat:@"%@ %@",curdate,curtime];
    
    [inputFormatter setDateFormat:pattern];  //@"yyyy-MM-dd HH:mm:ss"   //注意格式符的大小写。HH为24小时的小时数据格式
    
    NSDate *date = [inputFormatter dateFromString:inputDate];
    
    //  默认的 NSDate Date的显示的是格林威治标准时间GMT，在中国存在时差，所以要转换为中国时区+8。
    
    NSTimeInterval timeZoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMT];
    
    date = [date dateByAddingTimeInterval: timeZoneOffset];
    
    return date;
    
}

#pragma mark - PGDatePickerDelegate  选择时间  (时分HH:mm:ss)
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    XYLog(@"dateComponents = %@", dateComponents);
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * date = [calendar dateFromComponents:dateComponents];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm:ss";
    NSString * str = [formatter stringFromDate:date];
    if(self.dateState==1){
        NSString* replacedStr = [self.start_time stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
        NSString *start_Hour=[NSString stringWithFormat:@"%@ %@",replacedStr,str];
        _addStarTime.txfTitle.text = start_Hour;
    }
    if(self.dateState==2){
        NSString* replacedStr = [self.end_time stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
        NSString* end_Hour=[NSString stringWithFormat:@"%@ %@",replacedStr,str];
        _addEndTime.txfTitle.text = end_Hour;
    }
    _btnPost.enabled = [self checkBtnEnable];
    [self calcTime];
}


//参数一：range，要被替换的字符串的range，如果是新输入的，就没有字符串被替换，range.length = 0
//参数二：替换的字符串，即键盘即将输入或者即将粘贴到textField的string
//返回值为BOOL类型，YES表示允许替换，NO表示不允许
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    
    if ([textField isEqual:_addName.txfTitle] ||
        [textField isEqual:_addAdLink.textfield]) {
        return YES;
    }
    
    //新输入的
    if (string.length == 0) {
        return YES;
    }
    
    NSString *checkStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    //正则表达式（只支持两位小数）
    NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
    
    if ([textField isEqual:_addCount.txfTitle] ||
        [textField isEqual:_addAdTime.txfTitle]) {
        regex = @"^[1-9]\\d*$";
    }
    
    //判断新的文本内容是否符合要求
    return [self isValid:checkStr withRegex:regex];
    
}

//检测改变过的文本是否匹配正则表达式，如果匹配表示可以键入，否则不能键入
- (BOOL) isValid:(NSString*)checkStr withRegex:(NSString*)regex
{
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:checkStr];
}

#pragma mark - request

//商家中心-发布位置红包
-(void)requestAdd_red_packet{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{}];

    params[@"type"]=@"position_hongbao";

    params[@"name"]=self.addName.txfTitle.text;
    params[@"kilometre"] = self.addDistance.txfTitle.text;
    params[@"price"]=self.addPrice.txfTitle.text;
    params[@"counts"]=self.addCount.txfTitle.text;
    params[@"is_luck"]=self.is_luck ? @(1) : @(0);
    params[@"is_advertising"]=self.btnSwitch.isSelected ? @(1) : @(0);
    
    
    params[@"allow_cates"]=@"";
    params[@"allow_goods"]=@"";

    params[@"start_time"]=self.addStarTime.txfTitle.text;
    params[@"end_time"]=self.addEndTime.txfTitle.text;
    
    if (self.btnSwitch.isSelected) {
        params[@"adv_url"] = self.addAdLink.textfield.text;
        params[@"adv_seconds"] = self.addAdTime.txfTitle.text;
        
        [SVProgressHUD show];
        NSData *data= [UIImage scaleData:_redpackImage toKb:MAX_IMAGE_SIZE];
        NSString * fileName = [NSString stringWithFormat:@"%@_image.jpg",[NSString GetNowMillisecond]];
        [FNRequestTool uploadDataWithParams:params api:@"mod=appapi&act=small_store&ctrl=add_red_packet" data:data withKey:@"adv_img" fileName:fileName success:^(id respondsObject) {
            @strongify(self);
            [SVProgressHUD dismiss];
            NSDictionary *data = respondsObject[@"data"];
            NSString *payId = data[@"id"];
            NSString *is_need_pay = data[@"is_need_pay"];
            if ([is_need_pay isEqualToString:@"1"]) {
                self.payId = payId;
                [self requestPay];
            } else {
                [self.navigationController popViewControllerAnimated: YES];
            }
            
        } failure:^(NSString *error) {
            
            [SVProgressHUD dismiss];
            
        }];
    } else {
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=add_red_packet" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
            @strongify(self);
            
            NSString *payId = respondsObject[@"id"];
            NSString *is_need_pay = respondsObject[@"is_need_pay"];
            if ([is_need_pay isEqualToString:@"1"]) {
                self.payId = payId;
                [self requestPay];
            }else {
                [self.navigationController popViewControllerAnimated: YES];
            }
            
        } failure:^(NSString *error) {
        } isHideTips:NO isCache:NO];
    }
    
}

- (void) requestToPay{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{@"id": self.payId, @"type": self.payType}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=position_redpacket&ctrl=topay" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);

        if ([self.payType isEqualToString:@"zfb"]) {
            [self startBesidesPayment: respondsObject[@"code"]];
        } else if ([self.payType isEqualToString:@"wx"]) {
            [self startWxPayment: respondsObject];
        } else if ([self.payType isEqualToString:@"yue"]) {
            [FNTipsView showTips:@"充值成功"];
            [self.navigationController popViewControllerAnimated: YES];
        }
        
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
    
}

- (void) requestPay{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{@"id": self.payId}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=position_redpacket&ctrl=show_info" respondType:(ResponseTypeModel) modelType:@"FNStoreLocationRedpackPayModel" success:^(id respondsObject) {
        @strongify(self);
        //        [self.navigationController popViewControllerAnimated:YES];
        self.payModel = respondsObject;
        [self.alert setPay: respondsObject];
        [self.alert show: @"aaa"];
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
    
}

- (void) requestEdit{
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{}];
    
    params[@"id"]=self.model.id;
    params[@"type"]=@"position_hongbao";
    
    params[@"now_price"]=self.addPrice.txfTitle.text;
    params[@"now_counts"]=self.addCount.txfTitle.text;
    params[@"is_advertising"]=self.btnSwitch.isSelected ? @(1) : @(0);
    
    
    params[@"allow_cates"]=@"";
    params[@"allow_goods"]=@"";
    
    params[@"start_time"]=self.addStarTime.txfTitle.text;
    params[@"end_time"]=self.addEndTime.txfTitle.text;
    @weakify(self)
    if (self.btnSwitch.isSelected) {
        params[@"adv_url"] = self.addAdLink.textfield.text;
        params[@"adv_seconds"] = self.addAdTime.txfTitle.text;
        
        [SVProgressHUD show];
        NSData *data= [UIImage scaleData:_redpackImage toKb:MAX_IMAGE_SIZE];
        NSString * fileName = [NSString stringWithFormat:@"%@_image.jpg",[NSString GetNowMillisecond]];
        [FNRequestTool uploadDataWithParams:params api:@"mod=appapi&act=small_store&ctrl=edit_red_packet" data:data withKey:@"adv_img" fileName:fileName success:^(id respondsObject) {
            @strongify(self);
            [SVProgressHUD dismiss];
            NSDictionary *data = respondsObject[@"data"];
            NSString *payId = data[@"id"];
            NSString *is_need_pay = data[@"is_need_pay"];
            if ([is_need_pay isEqualToString:@"1"]) {
                self.payId = payId;
                [self requestPay];
            } else {
                [self.navigationController popViewControllerAnimated: YES];
            }
            
        } failure:^(NSString *error) {
            
            [SVProgressHUD dismiss];
            
        }];
    } else {
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=add_red_packet" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
            @strongify(self);
            
            NSString *payId = respondsObject[@"id"];
            NSString *is_need_pay = respondsObject[@"is_need_pay"];
            if ([is_need_pay isEqualToString:@"1"]) {
                self.payId = payId;
                [self requestPay];
            }else {
                [self.navigationController popViewControllerAnimated: YES];
            }
            
        } failure:^(NSString *error) {
        } isHideTips:NO isCache:NO];
    }
    
}

- (void) requestMain{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{@"id": self.redpackId}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=red_packet_detail" respondType:(ResponseTypeModel) modelType:@"FNmerLocationRedpackModel" success:^(id respondsObject) {
        @strongify(self);
        
        [self setModel:respondsObject];
        
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
    
}


//支付宝支付
-(void)startBesidesPayment: (NSString*) code{
    NSLog(@"BalanceoidString:%@",code);
    [[AlipaySDK defaultService] payOrder:code fromScheme:AlisdkSchemes callback:^(NSDictionary *resultDic) {
        XYLog(@"支付:%@",resultDic);
        if ([NSString checkIsSuccess:resultDic[@"resultStatus"] andElement:@"9000"] ) {
            [FNTipsView showTips:ResultStatusDict[@"9000"]];
            [FNTipsView showTips:@"充值成功"];
            //            [self backViewControllerType];
            //            [UIView animateWithDuration:0.5 animations:^{
            //                [self backViewControllerType];
            //            }];
            [self.navigationController popViewControllerAnimated: YES];
        }else{
            [SVProgressHUD dismiss];
            [FNTipsView showTips:ResultStatusDict[resultDic[@"resultStatus"] ] withDuration:2.0];
        }
    }];
}

// 微信支付
- (void)startWxPayment:(NSDictionary*) dataDic {
    NSString *partnerid = dataDic[@"partnerid"];
    NSString *nonce_str = dataDic[@"noncestr"];
    NSString *prepay_id = dataDic[@"prepayid"];
    NSString *sign = dataDic[@"sign"];
    NSString *timeStamp = dataDic[@"timestamp"];
    
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = partnerid;
    request.prepayId= prepay_id;
    request.package = @"Sign=WXPay";
    request.nonceStr= nonce_str;
    request.timeStamp= timeStamp.intValue;
    
    request.sign= sign;
    [WXApi sendReq: request];
}

- (void)onWxSuccess {
    [FNTipsView showTips:@"充值成功"];
//    [self requestMain];
    [self.navigationController popViewControllerAnimated: YES];
}


#pragma mark - FNStoreLocationRedpackPayAlertViewDelegate

- (void)onAlertPayTypeClick {
    NSArray *array = self.payModel.alipay_type;
    @weakify(self)
    [FNUpPaymodelNeView showWithTitles:array selectIndex:^(NSInteger selectIndex) {
        @strongify(self)
        XYLog(@"选择:%ld",(long)selectIndex);
        NSString *type = array[selectIndex][@"type"];
        self.payType = type;
        [self.alert setPayType: array[selectIndex][@"str"]];
    }];
}
- (void)onAlertPayClick {
    if (![self.payType kr_isNotEmpty]) {
        [self onAlertPayTypeClick];
        return;
    }
    
    [self requestToPay];
}

- (void)setModel: (FNmerLocationRedpackModel*)model {
    _model = model;
    _addName.hidden = YES;
    _addDistance.hidden = YES;
    
    [_addPrice mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    
    _addPrice.txfTitle.text = model.now_price;
    _addPrice.lblTitle.text = @"增加红包金额";
    _addCount.txfTitle.text = model.now_counts;
    _addCount.lblTitle.text = @"剩余红包";
    
    _btnSwitch.selected = [model.is_advertising isEqualToString:@"1"];
    _vAd.hidden = !_btnSwitch.selected;
    if (_btnSwitch.isSelected) {
        [_addStarTime mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.vAd.mas_bottom).offset(14);
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
            make.height.mas_equalTo(44);
            make.bottom.lessThanOrEqualTo(@-10);
        }];
    } else {
        [_addStarTime mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.addAd.mas_bottom).offset(14);
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
            make.height.mas_equalTo(44);
            make.bottom.lessThanOrEqualTo(@-10);
        }];
    }
    
    _addAdTime.txfTitle.text = model.adv_seconds;
    _addAdLink.textfield.text = model.adv_url;
    @weakify(self)
    [_addAdImage.btnImage sd_setBackgroundImageWithURL:URL(model.adv_img) forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            self.redpackImage = image;
        }
    }];
    
    _addStarTime.txfTitle.text = model.start_time;
    _addEndTime.txfTitle.text = model.end_time;
    _btnPost.enabled = [self checkBtnEnable];
}

@end
