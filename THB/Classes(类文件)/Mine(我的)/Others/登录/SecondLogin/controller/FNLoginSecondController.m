//
//  FNLoginSecondController.m
//  THB
//
//  Created by Jimmy on 2018/1/12.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNLoginSecondController.h"
#import "JKCountDownButton.h"
#import "FNHomeFunctionBtn.h"

#import "RegisterViewController.h"
#import "ForgetViewController.h"
#import "FNLoginSecondModel.h"

#import "BQLAuthEngine.h"

#import <UMSocialCore/UMSocialCore.h>
// 引入JPush功能所需头文件
#import "JPUSHService.h"

#import "BlindTidViewController.h"
#if APP_MGXS == 1
#import <HTSDK/HTSDK.h>
#endif

const CGFloat _lsc_tf_height = 44.0f;
const CGFloat _lsc_left_margin = 30.0f;

const CGFloat _lsc_third_H = 70.0f;
@interface FNLoginSecondController ()<UIWebViewDelegate>
{
    BQLAuthEngine *_bqlAuthEngine;
    UIView* titleview;
}
@property (nonatomic, strong)UIScrollView *mainview;
@property (nonatomic, strong)UIView *mainziview;

@property (nonatomic, strong)UIView* logoview;
@property (nonatomic, strong)UIImageView* logoimgview;
@property (nonatomic, strong)UIImageView* logobgimgview;

@property (nonatomic, strong)UIView* loginview;
@property (nonatomic, strong)UIView* logintitleview;
@property (nonatomic, strong)NSLayoutConstraint* logintitleconsh;
@property (nonatomic, strong)UIView* indicatorview;

@property (nonatomic, strong)UITextField* firstTF;
@property (nonatomic, strong)UITextField* secondTF;
@property (nonatomic, strong)JKCountDownButton* codeBtn;
@property (nonatomic, assign)CGFloat codebtnw;
@property (nonatomic, strong)NSLayoutConstraint* codeBtnConsw;
@property (nonatomic, strong)UIButton* loginBtn;
@property (nonatomic, strong)UIButton* forgetBtn;
@property (nonatomic, strong)UIButton* registerBtn;

@property (nonatomic, strong)UIView* thirdLoginView;
@property (nonatomic, strong)UIView* thirdBtnview;
@property (nonatomic, strong)NSMutableArray<FNHomeFunctionBtn *>* btns;

@property (nonatomic, assign)BOOL isAccount;
@property (nonatomic, assign)NSInteger isState;//初始等于1 点击快捷登录=2 
@property (nonatomic, strong)FNLoginSecondModel* model;

//第三方登录要传的参数
@property (nonatomic,strong) NSString *userId;

@property (nonatomic,strong) NSString *userNikeName;

@property (nonatomic,strong) NSString *userHeadImg;

@property (nonatomic,strong) NSNumber *type;
@property (nonatomic, strong)UIWebView* webView;
@end

@implementation FNLoginSecondController

- (BOOL)isFullScreenShow {
    return YES;
}

#pragma mark - setter && getter
- (void)setIsAccount:(BOOL)isAccount{
    _isAccount = isAccount;
    if (_isAccount) {
//        self.firstTF.placeholder = @"用户名/手机号";
//        self.secondTF.placeholder = @"密码";
//        self.codeBtnConsw.constant = 0;
//        self.secondTF.secureTextEntry = YES;
//        self.firstTF.keyboardType = UIKeyboardTypeDefault;
//        self.secondTF.keyboardType = UIKeyboardTypeDefault;
        
        if (self.isState==1) {
            self.firstTF.placeholder = @"用户名/手机号";
            self.secondTF.placeholder = @"密码";
            self.codeBtnConsw.constant = 0;
            self.secondTF.secureTextEntry = YES;
            self.firstTF.keyboardType = UIKeyboardTypeDefault;
            //self.secondTF.keyboardType = UIKeyboardTypeDefault;
        }else{
            self.firstTF.placeholder = @"手机号";
            self.secondTF.placeholder = @"动态验证码";
            self.codeBtnConsw.constant = self.codebtnw;
            self.secondTF.secureTextEntry = NO;
            self.firstTF.keyboardType = UIKeyboardTypePhonePad;
            self.secondTF.keyboardType = UIKeyboardTypePhonePad;
        }
    }else{
//        self.firstTF.placeholder = @"手机号";
//        self.secondTF.placeholder = @"动态验证码";
//        self.codeBtnConsw.constant = self.codebtnw;
//        self.secondTF.secureTextEntry = NO;
//        self.firstTF.keyboardType = UIKeyboardTypePhonePad;
//        self.secondTF.keyboardType = UIKeyboardTypePhonePad;
        self.firstTF.placeholder = @"用户名/手机号";
        self.secondTF.placeholder = @"密码";
        self.codeBtnConsw.constant = 0;
        self.secondTF.secureTextEntry = YES;
        self.firstTF.keyboardType = UIKeyboardTypeDefault;
        self.secondTF.keyboardType = UIKeyboardTypeDefault;
    }
    self.secondTF.text= nil;
    self.firstTF.text= nil;
    [UIView animateWithDuration:0.3 animations:^{
        [self.loginview layoutIfNeeded];
    }];
}
- (void)setModel:(FNLoginSecondModel *)model{
    _model = model;
    if (_model) {
        if (self.model.phone_kj_onoff.boolValue) {
            self.logintitleview.hidden=YES;
            self.logintitleconsh.constant = 0;
            self.isAccount = YES;
        }else{
            self.logintitleview.hidden=NO;
            self.logintitleconsh.constant = _lsc_tf_height+10;
            
        }
        [self.logobgimgview setUrlImg:self.model.img];
        if (![FNCurrentVersion isEqualToString:Setting_checkVersion]) {
            [self setupthirdbtnview];
        }
    }
}
- (NSMutableArray<FNHomeFunctionBtn *> *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray new];
    }
    return _btns;
}
- (UIImageView *)logobgimgview{
    if (_logobgimgview == nil) {
        _logobgimgview = [UIImageView new];
    }
    return _logobgimgview;
}
- (UIImageView *)logoimgview{
    if (_logoimgview == nil) {
        _logoimgview = [UIImageView new];
        _logoimgview.size = CGSizeMake(64, 64);
        _logoimgview.contentMode = UIViewContentModeScaleAspectFit;
        if ([NSString isEmpty:[FNBaseSettingModel settingInstance].AppIcon]) {
            _logoimgview.image = Share_AppIcon;
        }else{
            [_logoimgview setUrlImg:[FNBaseSettingModel settingInstance].AppIcon];
        }
        
        
    }
    return _logoimgview;
}
- (UIView *)logoview{
    if (_logoview == nil) {
        _logoview = [UIView new];
        
        [_logoview addSubview:self.logobgimgview];
        [self.logobgimgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
        
        [_logoview addSubview:self.self.logoimgview];
        [self.logoimgview  autoSetDimensionsToSize:self.logoimgview.size];
        [self.logoimgview autoCenterInSuperview];
    }
    return _logoview;
}

/**
 login view
 title view for switch
 first text field
 second text field
 get code button
 butto for login
 */
- (UIView *)indicatorview{
    if (_indicatorview == nil) {
        _indicatorview = [UIView new];
        _indicatorview.backgroundColor = FNMainGobalControlsColor;
    }
    return _indicatorview;
}
- (UIView *)logintitleview{
    if (_logintitleview == nil) {
        _logintitleview = [UIView new];
        _logintitleview.height = _lsc_tf_height+10;
        _logintitleview.hidden=YES;
        
        NSArray* titles = @[@"账号登录",@"手机快捷登录"];
        CGFloat indicatorH = 2;
        CGFloat btnw = (JMScreenWidth-_lsc_left_margin*2)/titles.count;
        CGFloat btnh = _logintitleview.height- indicatorH;
        
        [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton* btn = [UIButton buttonWithTitle:obj titleColor:FNGlobalTextGrayColor font:kFONT15 target:self action:@selector(btnClicked:)];
            [btn setTitleColor:FNMainGobalControlsColor forState:(UIControlStateSelected)];
            btn.selected = idx == 0;
            btn.tag = idx+1000;
            btn.frame = CGRectMake(_lsc_left_margin+idx*btnw, 0, btnw, btnh);
            [_logintitleview addSubview:btn];
            
        }];
        UIView* line = [UIView new];
        line.backgroundColor = RGB(236, 236, 237);
        [_logintitleview addSubview:line];
        [line autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(_lsc_left_margin, _lsc_left_margin, 0, _lsc_left_margin)) excludingEdge:(ALEdgeTop)];
        [line autoSetDimension:(ALDimensionHeight) toSize:indicatorH];
        
        [_logintitleview addSubview:self.indicatorview];
        self.indicatorview.frame = CGRectMake(_lsc_left_margin, _logintitleview.height-indicatorH, btnw, indicatorH);
    }
    return _logintitleview;
}
- (UITextField *)firstTF{
    if (_firstTF == nil) {
        _firstTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 0, _lsc_tf_height)];
        _firstTF.font = kFONT14;
        if(_isAccount==NO){
            _firstTF.placeholder = @"用户名/手机号";
        }else{
            _firstTF.placeholder = @"手机号";
        }
        _firstTF.keyboardType = UIKeyboardTypePhonePad;
    }
    return _firstTF;
}
- (UITextField *)secondTF{
    if (_secondTF == nil) {
        _secondTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 0, _lsc_tf_height)];
        _secondTF.font = kFONT14;
        if(_isAccount==NO){
           _secondTF.placeholder = @"密码";
        }else{
           _secondTF.placeholder = @"动态密码";
        }
        _secondTF.secureTextEntry = YES;
        //_secondTF.keyboardType = UIKeyboardTypePhonePad;
    }
    return _secondTF;
}
- (JKCountDownButton *)codeBtn{
    if (_codeBtn == nil) {
        _codeBtn = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeBtn.titleLabel.font = kFONT12;
        _codeBtn.borderColor = FNGlobalTextGrayColor;
        _codeBtn.borderWidth = 1;
        
        [_codeBtn setTitleColor:FNGlobalTextGrayColor forState:UIControlStateNormal];
        [_codeBtn sizeToFit];
        _codeBtn.size = CGSizeMake(_codeBtn.width+_jmsize_10*2, 25);
        _codeBtn.cornerRadius = _codeBtn.height*0.5;
        self.codebtnw = _codeBtn.width;
        [_codeBtn addTarget:self action:@selector(clickToGetCode:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _codeBtn;
}
- (UIButton *)loginBtn{
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithTitle:@"登录" titleColor:FNWhiteColor font:kFONT15 target:self action:@selector(loginBtnAction)];
       // _loginBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        //[_loginBtn addTarget:self action:@selector(loginBtnAction)];
        _loginBtn.backgroundColor = FNMainGobalControlsColor;
        _loginBtn.cornerRadius = 5;
        
    }
    return _loginBtn;
}
- (UIButton *)registerBtn{
    if (_registerBtn == nil) {
        _registerBtn = [[UIButton alloc]init];
        [_registerBtn setTitleColor:RED forState:UIControlStateNormal];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = kFONT14;
        [_registerBtn sizeToFit];
        [_registerBtn addTarget:self action:@selector(registerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}
- (UIButton *)forgetBtn{
    if (_forgetBtn == nil) {
        _forgetBtn = [[UIButton alloc]init];
        [_forgetBtn setTitleColor:RED forState:UIControlStateNormal];
        [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        _forgetBtn.titleLabel.font = kFONT14;
        [_forgetBtn sizeToFit];
        [_forgetBtn addTarget:self action:@selector(forgetBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
}
- (UIView *)loginview{
    if (_loginview == nil) {
        _loginview = [UIView new];
        
        [_loginview addSubview:self.logintitleview];
        [self.logintitleview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
        self.logintitleconsh = [self.logintitleview autoSetDimension:(ALDimensionHeight) toSize:self.logintitleview.height];
        
        UIView* firstview = [UIView new];
        [_loginview addSubview:firstview];
        [firstview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_lsc_left_margin];
        [firstview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_lsc_left_margin];
        [firstview autoSetDimension:(ALDimensionHeight) toSize:self.logintitleview.height];
        [firstview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.logintitleview];
        
        UIImageView* firstIcon = [[UIImageView alloc]initWithImage:IMAGE(@"land_accout")];
        [firstIcon sizeToFit];
        [firstview addSubview:firstIcon];
        [firstIcon autoSetDimensionsToSize:firstIcon.size];
        [firstIcon autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [firstIcon autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        
        [firstview addSubview:self.firstTF];
        [self.firstTF autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:firstIcon withOffset:_jmsize_10];
        [self.firstTF autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [self.firstTF autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.firstTF autoSetDimension:(ALDimensionHeight) toSize:self.firstTF.height];
        
        UIView* firstline = [UIView new];
        firstline.backgroundColor = FNHomeBackgroundColor;
        [firstview addSubview:firstline];
        [firstline autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeTop)];
        [firstline autoSetDimension:(ALDimensionHeight) toSize:1];
        
        UIView* secondview = [UIView new];
        [_loginview addSubview:secondview];
        [secondview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_lsc_left_margin];
        [secondview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_lsc_left_margin];
        [secondview autoSetDimension:(ALDimensionHeight) toSize:self.logintitleview.height];
        [secondview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:firstview];
        
        UIImageView* secondIcon = [[UIImageView alloc]initWithImage:IMAGE(@"land_password")];
        [secondIcon sizeToFit];
        [secondview addSubview:secondIcon];
        [secondIcon autoSetDimensionsToSize:secondIcon.size];
        [secondIcon autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [secondIcon autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        
        [secondview addSubview:self.secondTF];
        [self.secondTF autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:secondIcon withOffset:_jmsize_10];
        [self.secondTF autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [self.secondTF autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.secondTF autoSetDimension:(ALDimensionHeight) toSize:self.secondTF.height];
        
        UIView* secondline = [UIView new];
        secondline.backgroundColor = FNHomeBackgroundColor;
        [secondview addSubview:secondline];
        [secondline autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeTop)];
        [secondline autoSetDimension:(ALDimensionHeight) toSize:1];
        
        [secondview addSubview:self.codeBtn];
        self.codeBtnConsw = [self.codeBtn autoSetDimension:(ALDimensionWidth) toSize:self.codeBtn.width];
        if(_isAccount==NO){
            self.codeBtnConsw.constant = 0;
        }else{
            self.codeBtnConsw.constant = self.codebtnw;
        }
        [self.codeBtn autoSetDimension:(ALDimensionHeight) toSize:self.codeBtn.height];
        [self.codeBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [self.codeBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        
        [_loginview addSubview:self.loginBtn];
        [self.loginBtn autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:secondview];
        [self.loginBtn autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:secondview];
        [self.loginBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:secondview withOffset:_jm_leftMargin];
        [self.loginBtn autoSetDimension:(ALDimensionHeight) toSize:_lsc_tf_height];
        
        [_loginview addSubview:self.registerBtn];
        [self.registerBtn autoSetDimensionsToSize:self.registerBtn.size];
        [self.registerBtn autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.loginBtn withOffset:-_jmsize_10];
        [self.registerBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.loginBtn withOffset:_jmsize_10];
        
        [_loginview addSubview:self.forgetBtn];
        [self.forgetBtn autoSetDimensionsToSize:self.forgetBtn.size];
        [self.forgetBtn autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.loginBtn withOffset:_jmsize_10];
        [self.forgetBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.loginBtn withOffset:_jmsize_10];
    }
    return _loginview;
}

/**
 third login view
 */
- (UIView *)thirdBtnview{
    if (_thirdBtnview == nil) {
        _thirdBtnview = [UIView new];
    }
    return _thirdBtnview;
}
- (UIView *)thirdLoginView{
    if (_thirdLoginView == nil) {
        _thirdLoginView = [UIView new];
        _thirdLoginView.height = _lsc_third_H+40;
        CGFloat btnh = _lsc_third_H;
        
        [_thirdLoginView addSubview:self.thirdBtnview];
        [self.thirdBtnview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeTop)];
        [self.thirdBtnview autoSetDimension:(ALDimensionHeight) toSize:btnh];
        
        titleview = [UIView new];
        titleview.hidden= YES;
        [_thirdLoginView addSubview:titleview];
        [titleview autoSetDimension:(ALDimensionHeight) toSize:40];
        [titleview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [titleview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [titleview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:self.thirdBtnview];
        
        UILabel* titleLabel = [UILabel new];
        titleLabel.text = @"快速登录";
        titleLabel.font = kFONT14;
        [titleLabel sizeToFit];
        [titleview addSubview:titleLabel];
        [titleLabel autoCenterInSuperview];
        [titleLabel autoSetDimensionsToSize:titleLabel.size];
        
        UIView* leftline = [UIView new];
        leftline.backgroundColor = FNHomeBackgroundColor;
        [titleview addSubview:leftline];
        [leftline autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        [leftline autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [leftline autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:titleLabel withOffset:-_jmsize_10];
        [leftline autoSetDimension:(ALDimensionHeight) toSize:1];
        
        UIView* rightline = [UIView new];
        rightline.backgroundColor = FNHomeBackgroundColor;
        [titleview addSubview:rightline];
        [rightline autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [rightline autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [rightline autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:titleLabel withOffset:_jmsize_10];
        [rightline autoSetDimension:(ALDimensionHeight) toSize:1];
        
    }
    return _thirdLoginView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    _bqlAuthEngine = [[BQLAuthEngine alloc] init];
    self.isState=1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if ([FNCurrentVersion isEqualToString:Setting_checkVersion]) {
        self.mainview.contentSize=CGSizeMake(JMScreenWidth, self.mainziview.height);
    }else{
        CGFloat mH = JMScreenHeight-JMNavBarHeigth;
        CGFloat vH = CGRectGetMaxY(self.loginview.frame)+self.thirdLoginView.height+50;
        self.mainziview.height=vH>mH?vH:mH;
        self.mainview.contentSize=CGSizeMake(JMScreenWidth, self.mainziview.height);
    }
    
    if (![FNCurrentVersion isEqualToString:Setting_checkVersion]) {
        self.thirdLoginView.hidden=NO;
    }
}
- (void)jm_setupViews{
    [self requestPage];
    self.mainview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, JMScreenWidth, JMScreenHeight-JMNavBarHeigth)];
    self.mainview.showsHorizontalScrollIndicator=NO;
    self.mainview.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.mainview];
    self.mainziview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, JMScreenWidth, JMScreenHeight-JMNavBarHeigth)];
    [self.mainview addSubview:self.mainziview];
    
    [self.mainziview addSubview:self.logoview];
    [self.logoview autoSetDimensionsToSize:(CGSizeMake(JMScreenWidth, JMScreenWidth*0.35))];
    [self.logoview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.logoview autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
    
    [self.mainziview addSubview:self.loginview];
    [self.loginview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.loginview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.logoview];
    [self.loginview autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.logoview];
    [self.loginview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.registerBtn];
    
    [self.loginview layoutIfNeeded];
    
    self.thirdLoginView.hidden=YES;
    [self.mainziview addSubview:self.thirdLoginView];
    [self.thirdLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@-20);
        make.height.equalTo(@(self.thirdLoginView.height));
    }];
}
- (void)setupthirdbtnview{
    if (self.btns.count>=1) {
        [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    CGFloat btnw = JMScreenWidth*0.2;
    CGFloat btnh = _lsc_third_H;
    NSArray* images = @[@"login_qq",@"login_weixin",@"login_taobao"];
    NSArray* titles = @[@"QQ",@"微信",@"淘宝"];
    NSArray* tags = @[@"0",@"1",@"2"];
    NSArray* data = @[self.model.qq?:@"0",self.model.weixin?:@"0",self.model.taobao?:@"0"];
    NSMutableArray* mimages = [NSMutableArray new];
    NSMutableArray* mtitles = [NSMutableArray new];
    NSMutableArray* mtags = [NSMutableArray new];
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([NSString checkIsSuccess:obj andElement:@"1"]) {
            [mimages addObject:images[idx]];
            [mtitles addObject:titles[idx]];
            [mtags addObject:tags[idx]];
        }
    }];
    @weakify(self);
    [mimages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        FNHomeFunctionBtn* btn = [[FNHomeFunctionBtn alloc]initWithFrame:(CGRectMake(btnw*(idx+1), 0, btnw, btnh)) title:mtitles[idx] andImageURL:obj];
        btn.tag = [mtags[idx] integerValue] + 100;
        btn.imgView.contentMode = UIViewContentModeCenter;
        [btn addJXTouchWithObject:^(FNHomeFunctionBtn* button) {
            //
            NSInteger tag = button.tag - 100;
            if (tag == 0) {
                [self clickToLoginWithQQMethod];
            }else if (tag == 1){
                [self clickToLoginWithWeChatMethod];
            }else if (tag == 2){
                [self showTBLogin];
            }
        }];
        if (mimages.count == 3) {
            btn.x = btnw*(idx+1);
        }else if (mimages.count == 2){
            btn.x = btnw*(1+2*idx) ;
        }else if (mimages.count == 1){
            btn.x = btnw*2;
        }
        [self.thirdBtnview addSubview:btn];
        [self.btns addObject:btn];
    }];
    if (mimages.count==0) {
        self.thirdLoginView.hidden= YES;
        titleview.hidden= YES;
        
    }else{
        self.thirdLoginView.hidden= NO;
        titleview.hidden= NO;
    }
}

#pragma mark - action
- (void)btnClicked:(UIButton *)btn{
    NSInteger tag = btn.tag-1000;
    if (tag==1) {
        self.isState=2;
    }
    self.isAccount =tag == 1;
    if (self.logintitleview.subviews.count>=1) {
        [self.logintitleview.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIButton class]]) {
                UIButton* button = obj;
                button.selected = btn == button;
            }
        }];
    }
    [UIView transitionWithView:self.indicatorview duration:0.3 options:(UIViewAnimationOptionCurveLinear) animations:^{
        self.indicatorview.centerX = btn.centerX;
    } completion:nil];
    
}
- (void)clickToGetCode:(JKCountDownButton *)btn{
    [self requestCode];
}
- (void)secondAction:(JKCountDownButton *)sender{
    sender.enabled = NO;
    
    //button type要 设置成custom 否则会闪动
    [sender startWithSecond:60];
    [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
        NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
        return title;
    }];
    [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        
        return @"重新获取";
    }];
}
- (void)registerBtnAction{
    RegisterViewController *vc = [[RegisterViewController alloc]init];
    vc.reg_btn_img=self.model.reg_btn_img;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)forgetBtnAction{
    ForgetViewController *vc = [[ForgetViewController alloc]init];
    vc.reg_btn_img=self.model.reg_btn_img;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)loginBtnAction{
    if (self.isAccount) {
        //账号login
        //[self loginByAccount];
        //手机号login
        if (self.isState==1) {
            [self loginByAccount];
        }else{
            [self loginByPhone];
        }
    }else{
        //手机号login
        //[self loginByPhone];
        //账号login
        [self loginByAccount];
        
    }
}
- (void)loginByPhone{
    if ([NSString isEmpty:self.firstTF.text]) {
        [FNTipsView showTips: @"请输入手机号~"];
        return;
    }
    if ([NSString isEmpty:self.secondTF.text]) {
        [FNTipsView showTips: @"请输入验证码~"];
        return;
    }
    if ([[FNBaseSettingModel settingInstance].extendreg isEqualToString:@"1"]) {
        [self requestCheckIsExist];
    }else{
        [self requestLoginByPhone:nil];
    }
}
- (void)loginByAccount{
    if ([NSString isEmpty:self.firstTF.text]) {
        [FNTipsView showTips: @"请输入用户名/手机号~"];
        return;
    }
    if ([NSString isEmpty:self.secondTF.text]) {
        [FNTipsView showTips: @"请输入密码~"];
        return;
    }
    [self requestLoginByAccount];
}
#pragma mark - request
- (FNRequestTool *)requestPage{
     @WeakObj(self);
    NSMutableDictionary* params= [NSMutableDictionary dictionaryWithDictionary:@{}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_login&ctrl=pic" respondType:(ResponseTypeModel) modelType:@"FNLoginSecondModel" success:^(id respondsObject) {
        //
        self.model = respondsObject;
        //[selfWeak.loginBtn sd_setImageWithURL:URL(self.model.reg_btn_img) forState:UIControlStateNormal];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
- (FNRequestTool *)requestCode{
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"phone":self.firstTF.text}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_login&ctrl=getcode" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //
        [SVProgressHUD dismiss];
        [FNTipsView showTips:@"已成功发送，请注意查收！"];
        [self secondAction:self.codeBtn];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
- (FNRequestTool *)requestCheckIsExist{
    NSMutableDictionary* params= [NSMutableDictionary dictionaryWithDictionary:@{@"phone":self.firstTF.text}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_login&ctrl=checkIsExist" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        //
        NSString *is_exist = [respondsObject valueForKey:@"is_exist"];
        if ([is_exist integerValue]==0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"邀请码" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"请输入邀请码";
            }];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                UITextField *TextField = alertController.textFields.firstObject;
                if (TextField.text.length==0) {
                    [FNTipsView showTips:TextField.placeholder];
                    return;
                }
                [self requestLoginByPhone:TextField.text];
            }]];
            [self presentViewController:alertController animated:true completion:nil];
        }else{
            [self requestLoginByPhone:nil];
        }
    } failure:^(NSString *error) {
        //
    } isHideTips:NO isCache:NO];
}
- (FNRequestTool *)requestLoginByPhone:(NSString *)tgid{
    [SVProgressHUD show];
    NSMutableDictionary* params= [NSMutableDictionary dictionaryWithDictionary:@{@"phone":self.firstTF.text,@"captch":self.secondTF.text}];
    if (tgid) {
        params[@"tgid"]=tgid;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_login&ctrl=login" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        //
        NSString *token = [respondsObject valueForKey:@"token"];
        [[NSUserDefaults standardUserDefaults] setValue:token forKey:XYAccessToken];
        NSString *uid = [respondsObject valueForKey:@"id"];
        [[NSUserDefaults standardUserDefaults] setValue:uid forKey:XYUserID];
        [JPUSHService setAlias:token callbackSelector:(nil) object:(nil)];
#if APP_MGXS == 1
        [[HTSDK defaultPlatform] loginTrackWithUserID:[respondsObject valueForKey:@"id"] userName:@"testName"];
#endif
        if (self.isFromWeb) {
            //这里回调
            [self loadDateMethod];
            
            [self.navigationController popViewControllerAnimated:NO];
            self.callBackBlock(); //返回
            return ;
        }
        [self reqeustBaseSetting];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO isCache:NO];
}
- (FNRequestTool *)requestLoginByAccount{
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"username":self.firstTF.text,@"pwd":[NSString md5:self.secondTF.text]}];
    return [FNRequestTool requestWithParams:params api:_api_login_login respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        //
        NSString *token = [respondsObject valueForKey:@"token"];
        [[NSUserDefaults standardUserDefaults] setValue:token forKey:XYAccessToken];
        NSString *uid = [respondsObject valueForKey:@"id"];
        [[NSUserDefaults standardUserDefaults] setValue:uid forKey:XYUserID];
            [JPUSHService setAlias:token callbackSelector:(nil) object:(nil)];
            
#if APP_MGXS == 1
        [[HTSDK defaultPlatform] loginTrackWithUserID:[respondsObject valueForKey:@"id"] userName:@"testName"];
#endif
        if (self.isFromWeb) {
            //这里回调
            [self loadDateMethod];
            
            [self.navigationController popViewControllerAnimated:NO];
            self.callBackBlock(); //返回
            return ;
        }
        [self reqeustBaseSetting];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO isCache:NO];
}


#pragma mark - 第三方登录方法
-(void)showTBLogin{
    __block FNLoginSecondController *controller = self;
    [[ALBBSDK sharedInstance]auth:self successCallback:^(ALBBSession *session) {
        
        XYLog(@"getUser is %@",[session getUser]);
        controller.userId =[session getUser].openId;
        controller.userNikeName = [session getUser].nick;
        controller.userHeadImg = [session getUser].avatarUrl;
        controller.type = @2;
        [controller postToThirdLogin:controller.userId userNikeName:controller.userNikeName  userSex:nil userAddress:nil userHeadImg:controller.userHeadImg Type:controller.type unionID:nil];
    } failureCallback:^(ALBBSession *session, NSError *error) {
        
    }];
    
}

-(void)clickToLoginWithQQMethod{
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
//
//        NSLog(@"install--");
//        [_bqlAuthEngine authLoginQQWithSuccess:^(id response) {
//
//            NSDictionary *param = response;
//            NSString *province = [param valueForKey:@"province"];
//            NSString *city = [param valueForKey:@"city"];
//            NSString *sex = [param valueForKey:@"gender"];
//
//            [self postToThirdLogin:UserQQOpenID userNikeName:[param valueForKey:@"nickname"]  userSex:sex userAddress:[NSString stringWithFormat:@"%@%@",province,city] userHeadImg:[param valueForKey:@"figureurl_qq_2"] Type:@1];
//        } Failure:^(NSError *error) {
//
//            //            [FNTipsView showTips:[NSString stringWithFormat:@"%@",error]];
//        }];
//
//
//    }else{
    
        NSLog(@"no---");
        //        [FNTipsView showTips:@"您未安装QQ，请使用其它登录方式~"];
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                
            } else {
                UMSocialUserInfoResponse *resp = result;
                // 第三方平台SDK源数据
                NSLog(@"QQ originalResponse: %@", resp.originalResponse);
                NSDictionary *param =  resp.originalResponse;
                NSString *province = [param valueForKey:@"province"];
                NSString *city = [param valueForKey:@"city"];
                NSNumber *sexString = [param valueForKey:@"sex"];
                NSString *sex;
                if ([sexString isEqual:@1]) {
                    sex = @"男";
                }else if ([sexString isEqual:@0]){
                    sex = @"女";
                    
                }
                [self postToThirdLogin:resp.openid userNikeName:resp.name  userSex:sex userAddress:[NSString stringWithFormat:@"%@%@",province,city] userHeadImg:[param valueForKey:@"figureurl_qq_2"] Type:@1 unionID:nil];
            }
        }];
        
        
//    }
    
    
    
}
-(void)clickToLoginWithWeChatMethod{
//    if ([WXApi isWXAppInstalled]) {
//        //判断是否有微信
//        [_bqlAuthEngine authLoginWeChatWithSuccess:^(id response) {
//
//            NSLog(@"WeChatsuccess:%@",response);
//            NSDictionary *param = response;
//            NSString *province = [param valueForKey:@"province"];
//            NSString *city = [param valueForKey:@"city"];
//            NSNumber *sexString = [param valueForKey:@"sex"];
//            NSString *sex;
//            if ([sexString isEqual:@1]) {
//                sex = @"男";
//            }else if ([sexString isEqual:@0]){
//                sex = @"女";
//
//            }
//            [self postToThirdLogin:[param valueForKey:@"openid"] userNikeName:[param valueForKey:@"nickname"]  userSex:sex userAddress:[NSString stringWithFormat:@"%@%@",province,city] userHeadImg:[param valueForKey:@"headimgurl"] Type:@3];
//        } Failure:^(NSError *error) {
//
//            //            [FNTipsView showTips:[NSString stringWithFormat:@"%@",error]];
//        }];
//    }else{
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                
            } else {
                UMSocialUserInfoResponse *resp = result;
                
                NSDictionary *param = resp.originalResponse;
                NSNumber *sexString = [param valueForKey:@"sex"];
                NSString *sex;
                if ([sexString isEqual:@1]) {
                    sex = @"男";
                }else if ([sexString isEqual:@0]){
                    sex = @"女";
                    
                }
                NSString *province = [param valueForKey:@"province"];
                NSString *city = [param valueForKey:@"city"];
                NSString *unionId = [param valueForKey:@"unionid"];
                // 第三方平台SDK源数据
                NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
                [self postToThirdLogin:resp.openid userNikeName:resp.name  userSex:sex userAddress:[NSString stringWithFormat:@"%@%@",province,city] userHeadImg:[param valueForKey:@"headimgurl"] Type:@3 unionID:unionId];
            }
        }];
//    }
    
}
/** 第三方登录
 userId:SDK返回的openid
 userNickName:SDK返回的用户的昵称
 userSex：SDK返回的用户的性别
 userAddress：SDK返回的用户的地址
 userHeadImg：SDK返回的用户的头像
 type:1.qq，2.淘宝，3.微信
 **/
-(void)postToThirdLogin:(NSString *)userId userNikeName:(NSString *)userNikeName userSex:(NSString *)userSex userAddress:(NSString *)userAddress userHeadImg:(NSString *)userHeadImg Type:(NSNumber *)type unionID: (NSString*)unionId{
    NSMutableDictionary *param;
    if ([type isEqualToNumber:@1]&& [userId kr_isNotEmpty]) {
        NSMutableDictionary* _param = [NSMutableDictionary dictionaryWithDictionary:@{@"openid":userId,
                                                                                      @"time":[NSString GetNowTimes],
                                                                                      @"nickname":userNikeName,
                                                                                      @"figureurl_qq_2":userHeadImg,
                                                                                      @"user_address":userAddress,
                                                                                      @"type":type                        }];
        _param[SignKey] = [NSString getSignStringWithDictionary:_param];
        param = _param;
    }else if([type isEqualToNumber:@2]&& [userId kr_isNotEmpty]){
        NSMutableDictionary* _param = [NSMutableDictionary dictionaryWithDictionary:@{@"taobaoid":userId,
                                                                                      @"time":[NSString GetNowTimes],
                                                                                      @"user_nick_name_taobao":userNikeName,
                                                                                      @"taobao_avatar_hd":userHeadImg,
                                                                                      @"type":type                     }];
        _param[SignKey] = [NSString getSignStringWithDictionary:_param];
        param = _param;
        XYLog(@"param is %@",param);
    }else if ([type isEqualToNumber:@3]&& [userId kr_isNotEmpty]){
        NSMutableDictionary* _param = [NSMutableDictionary dictionaryWithDictionary:@{@"weixinid":userId,
                                                                                      @"time":[NSString GetNowTimes],
                                                                                      @"weixin_screen_name":userNikeName,
                                                                                      @"weixin_avatar_hd":userHeadImg,
                                                                                      @"type":type,
                                                                                      @"unionid":unionId
                                                                                      }];
        _param[SignKey] = [NSString getSignStringWithDictionary:_param];
        param = _param;
    }
    if ([userId kr_isNotEmpty]) {
        //    [SVProgressHUD show];
        [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_login_threelogin successBlock:^(id responseBody) {
            NSDictionary *dict = responseBody;
            XYLog(@"responseBody2 is %@",responseBody);
            if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
                
                NSArray *tempArray = [dict objectForKey:XYData];
                if (tempArray) {
                    NSString *token = [tempArray valueForKey:@"token"];
                    
                    
                    NSString *isBind = [tempArray valueForKey:@"phone"];
                    XYLog(@"isBind is %@",isBind);
#if APP_MGXS == 1
                    [[HTSDK defaultPlatform] loginTrackWithUserID:[tempArray valueForKey:@"id"] userName:@"testName"];
#endif
                    if (![isBind kr_isNotEmpty]) {
                        BlindTidViewController *vc = [[BlindTidViewController alloc]init];
                        vc.source_type = @"three_reg";
                        vc.type = @2;
                        vc.token = token;
                        vc.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:vc animated:YES];
                    }else{
                        
                        if (self.isFromWeb) {
                            [self loadDateMethod];
                            
                            
                            //这里回调
                            
                            [self.navigationController popViewControllerAnimated:NO];
                            self.callBackBlock(); //返回
                            return ;
                        }
                        [[NSUserDefaults standardUserDefaults] setValue:token forKey:XYAccessToken];
                        NSString *uid = [tempArray valueForKey:@"id"];
                        [[NSUserDefaults standardUserDefaults] setValue:uid forKey:XYUserID];
                        [JPUSHService setAlias:token callbackSelector:(nil) object:(nil)];

                        [[NSUserDefaults standardUserDefaults] synchronize];
                        [self reqeustBaseSetting];
                    }
                }
            }else
            {
                
                [XYNetworkAPI queryFinishTip:dict];
                [XYNetworkAPI cancelAllRequest];
            }
            
            
        } failureBlock:^(NSString *error) {
            //        [SVProgressHUD dismiss];
            [XYNetworkAPI cancelAllRequest];
        }];
    }
    
    
}
#pragma mark - other method
-(void)loadDateMethod{
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    
    NSString *url =[NSString stringWithFormat:@"%@%@%@",IP,_api_showorder_WirteCache,UserAccessToken];
    NSURL *webUrl = [NSURL URLWithString:url];
    NSURLRequest *request =[NSURLRequest requestWithURL:webUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    __unsafe_unretained UIWebView *webView = self.webView;
    webView.delegate = self;
    [webView loadRequest:request];
    self.webView.hidden = YES;
}

//获取基本设置
- (FNRequestTool *)reqeustBaseSetting{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:_api_others_getset respondType:(ResponseTypeModel) modelType:@"FNBaseSettingModel" success:^(id respondsObject) {
        //
        [SVProgressHUD dismiss];
        FNBaseSettingModel* defaultModel = [FNBaseSettingModel settingInstance];
        FNBaseSettingModel* model = respondsObject;
//        model.tabs = defaultModel.tabs;
        model.ksrk = defaultModel.ksrk;
        model.tw = defaultModel.tw;
        [FNBaseSettingModel saveSetting:model];
        [[NSUserDefaults standardUserDefaults] setValue:model.extendreg forKey:XYextendreg];
        [[NSUserDefaults standardUserDefaults] setValue:model.appopentaobao_onoff forKey:XYappopentaobao_onoff];
        [[NSUserDefaults standardUserDefaults] setValue:model.WeChatAppSecret forKey:XYWeChatAppSecret];
        
        if (![[UIApplication sharedApplication].delegate.window.rootViewController isKindOfClass:[XYTabBarViewController class]]) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            XYTabBarViewController *mainCtrl = [XYTabBarViewController mainViewController];
            [UIApplication sharedApplication].delegate.window.rootViewController = mainCtrl;
        }
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache: NO];
}

@end
