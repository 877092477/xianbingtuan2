//
//  FNNetCouponeExchangeController.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/9.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNetCouponeExchangeController.h"
#import "FNNetCouponeExchangeModel.h"
#import "lhScanQCodeViewController.h"
#import "FNMyNetCouponeController.h"
#import "FNNetCouponeReceiveController.h"
#import "FNNetCouponeHeaderView.h"
#import "FNNetCouponeReceiveAlertView.h"

@interface FNNetCouponeExchangeController()<lhScanQCodeViewControllerDelegate>

@property (nonatomic, strong) UIButton *rightbutton;

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UIImageView *imgBg;
@property (nonatomic, strong) UIView *vContent;

@property (nonatomic, strong) FNNetCouponeHeaderView *headerView;

@property (nonatomic, strong) UIView *vInput;
@property (nonatomic, strong) UILabel *lblInput;
@property (nonatomic, strong) UITextField *txfInput;
@property (nonatomic, strong) UIButton *btnScan;

@property (nonatomic, strong) UIButton *btnExchange;
@property (nonatomic, strong) UIButton *btnReceive;

@property (nonatomic, strong) FNNetCouponeExchangeModel *model;

@property (nonatomic, strong) FNNetCouponeReceiveAlertView *alertView;

@end

@implementation FNNetCouponeExchangeController

- (FNNetCouponeReceiveAlertView*) alertView {
    if (_alertView == nil) {
        _alertView = [[FNNetCouponeReceiveAlertView alloc] init];
        _alertView.hidden = YES;
        [self.view addSubview: _alertView];
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return _alertView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self configUI];
    [self requestMain];
}

-(void)setupNav{
    _rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    //    [rightbutton setTitle:@"搜索" forState:UIControlStateNormal];
//    [rightbutton setImage:IMAGE(@"live_coupone_nav_button_search") forState:(UIControlStateNormal)];
    _rightbutton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [_rightbutton setTitleColor:RGB(27, 27, 27) forState:UIControlStateNormal];
    [_rightbutton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_rightbutton];
    
}

- (BOOL)needLogin {
    return YES;
}

- (void)configUI {
    _scrollview = [[UIScrollView alloc] init];
    _imgBg = [[UIImageView alloc] init];
    _vContent = [[UIView alloc] init];

    _headerView = [[FNNetCouponeHeaderView alloc] init];
    
    _vInput = [[UIView alloc] init];
    _lblInput = [[UILabel alloc] init];
    _txfInput = [[UITextField alloc] init];
    _btnScan = [[UIButton alloc] init];
    _btnExchange = [[UIButton alloc] init];
    _btnReceive = [[UIButton alloc] init];
    
    [self.view addSubview:_scrollview];
    [_scrollview addSubview:_vContent];
    [_vContent addSubview:_imgBg];

    [_vContent addSubview:_headerView];
    [_vContent addSubview:_vInput];
    [_vInput addSubview:_lblInput];
    [_vInput addSubview:_txfInput];
    [_vInput addSubview:_btnScan];
    [_vContent addSubview:_btnExchange];
    [_vContent addSubview:_btnReceive];
    
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
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.mas_equalTo(380);
    }];
    [_vInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(280);
        make.height.mas_equalTo(76);
        make.top.equalTo(self.headerView.mas_bottom).offset(20);
        make.centerX.equalTo(@0);
    }];
    [_lblInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_txfInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
        make.centerX.equalTo(@0);
        make.top.equalTo(@20);
        make.bottom.equalTo(@-10);
    }];
    [_btnScan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.centerY.equalTo(self.txfInput);
        make.width.height.mas_equalTo(20);
    }];
    [_btnExchange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.vInput.mas_bottom).offset(40);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(@0);
    }];
    [_btnReceive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.btnExchange.mas_bottom).offset(12);
    }];
    
    _scrollview.bounces = NO;
    if (@available(iOS 11.0, *)) {
        _scrollview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _imgBg.contentMode = UIViewContentModeScaleAspectFill;
    
    
    _vInput.backgroundColor = UIColor.whiteColor;
    _vInput.layer.cornerRadius = 8;
    _vInput.layer.masksToBounds = YES;
    
    _lblInput.font = kFONT12;
    _lblInput.textColor = RGB(192, 192, 195);
    
    _txfInput.font = [UIFont boldSystemFontOfSize:24];
    _txfInput.textAlignment = NSTextAlignmentCenter;
    _txfInput.textColor = RGB(51, 51, 51);
    
    _btnReceive.titleLabel.font = kFONT12;
    
    [self.headerView.btnRule addTarget:self action:@selector(onRuleClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnScan addTarget:self action:@selector(onScanClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnExchange addTarget:self action:@selector(onExchangeClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnReceive addTarget:self action:@selector(onReceiveClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)updateView {
    if (self.model == nil)
        return;
    
    
    self.title = self.model.top_title;
    [self.rightbutton setTitle: self.model.top_right_btn forState: UIControlStateNormal];
    [self.rightbutton sizeToFit];
    
    [self.imgBg sd_setImageWithURL: URL(self.model.bjimg)];
    [self.headerView.imgCoupone sd_setImageWithURL: URL(self.model.coupon_bjimg)];
    @weakify(self)
    [self.headerView.btnRule sd_setBackgroundImageWithURL:URL(self.model.rule_img) forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            [self.headerView.btnRule mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(22 * image.size.width / image.size.height);
            }];
        }
    }];
    
    self.headerView.lblCoupone.text = self.model.str;
    self.headerView.lblCoupone.textColor = [UIColor colorWithHexString:self.model.str_color];
    
    self.headerView.lblMoney.text = self.model.coupon_money;
    self.headerView.lblMoney.textColor = [UIColor colorWithHexString:self.model.coupon_money_color];
    
    self.headerView.lblCouponeDesc.text = self.model.lj_str;
    self.headerView.lblCouponeDesc.textColor = [UIColor colorWithHexString:self.model.lj_str_color];
    
    [self.headerView.imgInfo sd_setImageWithURL: URL(self.model.info_img) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            [self.headerView.imgInfo mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(15 * image.size.width / image.size.height);
            }];
        }
    }];
    
    self.headerView.lblInfo.text = self.model.info_str;
    self.headerView.lblInfo.textColor = [UIColor colorWithHexString:self.model.info_color];
    self.headerView.vInfo.backgroundColor = [UIColor colorWithHexString:self.model.info_bjcolor];
    
    self.lblInput.text = self.model.input_str;
    
    [self.btnScan sd_setBackgroundImageWithURL: URL(self.model.sao_img) forState:UIControlStateNormal];
    [self.btnExchange sd_setBackgroundImageWithURL:URL(self.model.btn_img) forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            [self.btnExchange mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(35 * image.size.width / image.size.height);
            }];
        }
    }];
    if (self.model.btm_str != nil && self.model.btm_str.count > 0) {
        NSDictionary *dict = self.model.btm_str[0];
        [self.btnReceive setTitle: dict[@"str"] forState:UIControlStateNormal];
        [self.btnReceive setTitleColor: [UIColor colorWithHexString:dict[@"color"]] forState:UIControlStateNormal];
    }
}

#pragma mark - Networking
- (void)requestMain{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=coupon_exchange&ctrl=index" respondType:(ResponseTypeModel) modelType:@"FNNetCouponeExchangeModel" success:^(id respondsObject) {
        @strongify(self)
        self.model = respondsObject;
        [self updateView];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES];
    
}

- (void)requestExchange: (NSString*)code{
    
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"code": code}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=coupon_exchange_userlist&ctrl=exchange_doing" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        NSString *border = respondsObject[@"img"];
        NSString *btn_img = respondsObject[@"btn_img"];
        NSString *str = respondsObject[@"str"];
        [self.alertView show:border button: btn_img desc: str];
        @weakify(self);
        self.alertView.btnClickedAction = ^{
            @strongify(self)
            [self.alertView dismiss];
        };
        
        [self requestMain];
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
        
    } isHideTips:NO];
    
}


- (void)onRuleClick {
    if([self.model.rule_url kr_isNotEmpty]){
        [self goWebWithUrl:self.model.rule_url];
    }
}

- (void)onScanClick {
    
    lhScanQCodeViewController *vc = [lhScanQCodeViewController new];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)onExchangeClick {
    if ([self.txfInput.text kr_isNotEmpty]) {
        [self requestExchange:self.txfInput.text];
    } else {
        [FNTipsView showTips:@"请输入兑换码"];
    }
}
- (void)onReceiveClick {
    FNNetCouponeReceiveController *vc = [[FNNetCouponeReceiveController alloc] init];
    [self.navigationController pushViewController:vc animated: YES];
}

- (void)rightBtnAction {
    FNMyNetCouponeController *vc = [[FNMyNetCouponeController alloc] init];
    [self.navigationController pushViewController:vc animated: YES];
}


#pragma mark - lhScanQCodeViewControllerDelegate

- (void)didCodeScan: (NSString*)result {
    if ([result kr_isNotEmpty]) {
        self.txfInput.text = result;
    }
}

@end
