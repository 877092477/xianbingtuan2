//
//  ModifyPaymentPasswordController.m
//  THB
//
//  Created by Weller Zhao on 2019/2/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "ModifyPaymentPasswordController.h"
#import "ModifyPasswordController.h"

@interface ModifyPaymentPasswordController ()<ModifyPasswordControllerDelegate>

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblPhone;
@property (nonatomic, strong) UITextField *txfCode;
@property (nonatomic, strong) UIButton *btnCode;
@property (nonatomic, strong) UIButton *btnOK;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int time;

@end

@implementation ModifyPaymentPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改支付密码";
    [self configUI];
}

- (void)configUI {
    _lblTitle = [[UILabel alloc] init];
    _lblPhone = [[UILabel alloc] init];
    _txfCode = [[UITextField alloc] init];
    _btnCode = [[UIButton alloc] init];
    _btnOK = [[UIButton alloc] init];
    
    [self.view addSubview:_lblTitle];
    [self.view addSubview:_lblPhone];
    [self.view addSubview:_txfCode];
    [self.view addSubview:_btnCode];
    [self.view addSubview:_btnOK];
    
    @weakify(self)
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@20);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_lblPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self_weak_.lblTitle.mas_bottom);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_txfCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(self_weak_.lblPhone.mas_bottom).offset(10);
        make.right.equalTo(self_weak_.btnCode.mas_left).offset(-10);
        make.height.mas_equalTo(40);
    }];
    [_btnCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self_weak_.txfCode);
        make.right.equalTo(@-10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
    [_btnOK mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self_weak_.txfCode.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
    }];
    
    _lblTitle.font = kFONT12;
    _lblTitle.text = @"请验证您的绑定手机";
    _lblTitle.textColor = RGB(50, 50, 50);
    
    _lblPhone.font = [UIFont systemFontOfSize:24];
    _lblPhone.textColor = RGB(50, 50, 50);
    _lblPhone.text = UserPhone;
    
    _txfCode.borderColor = RGB(50, 50, 50);
    _txfCode.cornerRadius = 4;
    _txfCode.placeholder = @"请输入验证码";
    _txfCode.borderWidth = 1;
    _txfCode.keyboardType = UIKeyboardTypeNumberPad;
    _txfCode.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
    _txfCode.leftViewMode = UITextFieldViewModeAlways;
    
    [_btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_btnCode setTitleColor:RGB(90, 90, 90) forState:UIControlStateNormal];
    _btnCode.titleLabel.font = kFONT12;
    _btnCode.borderColor = RGB(50, 50, 50);
    _btnCode.cornerRadius = 4;
    _btnCode.borderWidth = 1;
    [_btnCode addTarget:self action:@selector(onCodeSend)];
    
    [_btnOK setTitle:@"确定" forState:UIControlStateNormal];
    [_btnOK setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    _btnOK.cornerRadius = 4;
    [_btnOK addTarget:self action:@selector(onOkSend)];
    _btnOK.backgroundColor = RED;
//    _btnOK.enabled = NO;
}

#pragma mark - Action

- (void)onCodeSend {
    [self requestCode];
}

- (void)onOkSend {
    if ([_txfCode.text kr_isNotEmpty]) {
        [self requestCheckCode];
    }
}

- (void)codeSchedule {
    
    if (_time <= 0) {
        [self.timer invalidate];
        self.timer = nil;
        [self.btnCode setTitle:@"重新获取" forState:UIControlStateNormal];
        return;
    }
    _time --;
    [self.btnCode setTitle:[NSString stringWithFormat:@"重新获取(%d)", _time] forState:UIControlStateNormal];
    _btnCode.enabled = time <= 0;
}

#pragma mark - Network

- (void) requestCode{
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"phone": UserPhone}];
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appSetPwd&ctrl=getcode" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        [SVProgressHUD dismiss];
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(codeSchedule) userInfo:nil repeats:YES];
        self.timer = timer;
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        self.time = 60;
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO isCache:NO];
}

- (void) requestCheckCode{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"phone": UserPhone, @"captch": _txfCode.text}];
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appSetPwd&ctrl=check_code" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        
        @strongify(self);
        ModifyPasswordController *vc = [[ModifyPasswordController alloc] init];
        vc.code = _txfCode.text;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:NO isCache:NO];
    
}

#pragma mark - ModifyPasswordControllerDelegate
- (void)didModify:(BOOL)success {
    if (success)
        [self.navigationController popViewControllerAnimated:YES];
}

@end
