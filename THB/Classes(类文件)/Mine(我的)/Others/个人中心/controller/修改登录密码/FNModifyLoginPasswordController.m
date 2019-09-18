//
//  FNModifyLoginPasswordController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/5.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNModifyLoginPasswordController.h"
#import "FNModifyLoginPasswordSetViewController.h"

@interface FNModifyLoginPasswordController ()

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblTips;
@property (nonatomic, strong) UITextField *txfCode;
@property (nonatomic, strong) UIButton *btnCode;
@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) UIButton *btnConfirm;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int second;

@end

@implementation FNModifyLoginPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI {
    _lblTitle = [[UILabel alloc] init];;
    _lblTips = [[UILabel alloc] init];;
    _txfCode = [[UITextField alloc] init];;
    _btnCode = [[UIButton alloc] init];;
    _vLine = [[UIView alloc] init];;
    _btnConfirm = [[UIButton alloc] init];;
    
    [self.view addSubview:_lblTitle];
    [self.view addSubview:_lblTips];
    [self.view addSubview:_txfCode];
    [self.view addSubview:_btnCode];
    [self.view addSubview:_vLine];
    [self.view addSubview:_btnConfirm];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.right.lessThanOrEqualTo(@-36);
        make.top.equalTo(@60);
    }];
    [_lblTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.right.lessThanOrEqualTo(@-36);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(16);
    }];
    [_txfCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(self.lblTips.mas_bottom).offset(30);
        make.right.equalTo(self.btnCode.mas_left).offset(-10);
        make.height.mas_equalTo(30);
    }];
    [_btnCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-36);
        make.centerY.equalTo(self.txfCode);
        make.width.mas_equalTo(78);
        make.height.mas_equalTo(28);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.right.equalTo(@-36);
        make.bottom.equalTo(self.txfCode).offset(4);
        make.height.mas_equalTo(1);
    }];
    [_btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.right.equalTo(@-36);
        make.top.equalTo(self.vLine.mas_bottom).offset(28);
        make.height.mas_equalTo(48);
    }];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"设置密码";
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = [UIFont systemFontOfSize:18];
    _lblTitle.text = @"为了确认您的身份，需要验证手机号";
    
    _lblTips.textColor = RGB(150, 150, 150);
    _lblTips.font = kFONT13;
    
    _txfCode.placeholder = @"填写验证码";
    _txfCode.font = kFONT13;
    
    _btnCode.backgroundColor = RGB(255, 186, 0);
    _btnCode.titleLabel.font = kFONT10;
    _btnCode.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_btnCode setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
    [_btnCode setTitle: @"获取验证码" forState: UIControlStateNormal];
    _btnCode.cornerRadius = 8.5;
    
    _vLine.backgroundColor = RGB(240, 240, 240);
    
    _btnConfirm.backgroundColor = RGB(255, 52, 101);
    _btnConfirm.cornerRadius = 24;
    [_btnConfirm setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
    [_btnConfirm setTitle: @"确定" forState: UIControlStateNormal];
    
    [_btnCode addTarget:self action:@selector(onCodeClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnConfirm addTarget:self action:@selector(onConfirmClick) forControlEvents:UIControlEventTouchUpInside];
    
//    NSString *rightString = [[NSUserDefaults standardUserDefaults] valueForKey:XYUserPhone];
}

#pragma mark - Action

- (void)onCodeClick {
    NSString *rightString = [[NSUserDefaults standardUserDefaults] valueForKey:XYUserPhone];
    if ([rightString kr_isNotEmpty]) {
        [self requestCode];
    } else {
        [FNTipsView showTips:@"未绑定手机号，暂时无法修改密码"];
    }
}

- (void)onConfirmClick {
    NSString *rightString = [[NSUserDefaults standardUserDefaults] valueForKey:XYUserPhone];
    if ([rightString kr_isNotEmpty]) {
        if ([_txfCode.text kr_isNotEmpty]) {
            [self requestCheckCode];
        } else {
            [FNTipsView showTips:@"请输入验证码"];
            [_txfCode kr_shake];
        }
    } else {
        [FNTipsView showTips:@"未绑定手机号，暂时无法修改密码"];
    }
}

- (void)updateTime {
    _second --;
    [_btnCode setTitle: [NSString stringWithFormat:@"%ds后重新发送", _second] forState: UIControlStateNormal];
    
    if (_second <= 0) {
        [_timer invalidate];
        _timer = nil;
        _btnCode.enabled = YES;
        [_btnCode setTitle: @"获取验证码" forState: UIControlStateNormal];
        _btnCode.backgroundColor = RGB(255, 186, 0);
    }
    
    
}

#pragma mark - Networking
- (void)requestCode{
    _btnCode.enabled = NO;
    _btnCode.backgroundColor = RGBA(255, 186, 0, 0.4);
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    NSString *phone = [[NSUserDefaults standardUserDefaults] valueForKey:XYUserPhone];
    params[@"phone"] = phone;
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appSetPwd&ctrl=getcode" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
//        self.model = respondsObject;
//        [self updateView];
        
        self.lblTips.text = [NSString stringWithFormat:@"验证码发送至您的手机%@", [[NSUserDefaults standardUserDefaults] valueForKey:XYUserPhone]];
        
        self.second = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
        
    } failure:^(NSString *error) {
        
        self.btnCode.enabled = YES;
    } isHideTips:NO];
    
}

- (void)requestCheckCode{
    
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    NSString *phone = [[NSUserDefaults standardUserDefaults] valueForKey:XYUserPhone];
    NSString *code = _txfCode.text;
    params[@"phone"] = phone;
    params[@"captch"] = code;
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appSetPwd&ctrl=check_code" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        FNModifyLoginPasswordSetViewController *vc = [[FNModifyLoginPasswordSetViewController alloc] init];
        vc.code = code;
        vc.phone = phone;
        [self.navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
    
}

@end
