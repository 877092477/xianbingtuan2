//
//  FNModifyLoginPasswordSetViewController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/5.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNModifyLoginPasswordSetViewController.h"
#import "ProfileViewController.h"

@interface FNModifyLoginPasswordSetViewController ()

@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UILabel *lblPhone;
@property (nonatomic, strong) UITextField *txfPhone;
@property (nonatomic, strong) UIView *vLine1;

@property (nonatomic, strong) UILabel *lblPassword;
@property (nonatomic, strong) UITextField *txfPassword;
@property (nonatomic, strong) UIView *vLine2;

@property (nonatomic, strong) UILabel *lblConfirm;
@property (nonatomic, strong) UITextField *txfConfirm;
@property (nonatomic, strong) UIView *vLine3;

@property (nonatomic, strong) UIButton *btnConfirm;

@end

@implementation FNModifyLoginPasswordSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置密码";
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self configUI];
}

- (void)configUI {
    _lblTitle = [[UILabel alloc] init];
    _lblPhone = [[UILabel alloc] init];
    _txfPhone = [[UITextField alloc] init];
    _vLine1 = [[UIView alloc] init];
    _lblPassword = [[UILabel alloc] init];
    _txfPassword = [[UITextField alloc] init];
    _vLine2 = [[UIView alloc] init];
    _lblConfirm = [[UILabel alloc] init];
    _txfConfirm = [[UITextField alloc] init];
    _vLine3 = [[UILabel alloc] init];
    _btnConfirm = [[UIButton alloc] init];
    
    [self.view addSubview:_lblTitle];
    [self.view addSubview:_lblPhone];
    [self.view addSubview:_txfPhone];
    [self.view addSubview:_vLine1];
    [self.view addSubview:_lblPassword];
    [self.view addSubview:_txfPassword];
    [self.view addSubview:_vLine2];
    [self.view addSubview:_lblConfirm];
    [self.view addSubview:_txfConfirm];
    [self.view addSubview:_vLine3];
    [self.view addSubview:_btnConfirm];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(@60);
        make.right.lessThanOrEqualTo(@-36);
    }];
    [_lblPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(25);
        make.right.lessThanOrEqualTo(@-36);
    }];
    [_txfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(self.lblPhone.mas_bottom).offset(10);
        make.right.equalTo(@-36);
        make.height.mas_equalTo(24);
    }];
    [_vLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(self.txfPhone.mas_bottom);
        make.right.equalTo(@-36);
        make.height.mas_equalTo(1);
    }];
    [_lblPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(self.vLine1.mas_bottom).offset(15);
        make.right.lessThanOrEqualTo(@-36);
    }];
    [_txfPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(self.lblPassword.mas_bottom).offset(10);
        make.right.equalTo(@-36);
        make.height.mas_equalTo(24);
    }];
    [_vLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(self.txfPassword.mas_bottom);
        make.right.equalTo(@-36);
        make.height.mas_equalTo(1);
    }];
    [_lblConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(self.vLine2.mas_bottom).offset(15);
        make.right.lessThanOrEqualTo(@-36);
    }];
    [_txfConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(self.lblConfirm.mas_bottom).offset(10);
        make.right.equalTo(@-36);
        make.height.mas_equalTo(24);
    }];
    [_vLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(self.txfConfirm.mas_bottom);
        make.right.equalTo(@-36);
        make.height.mas_equalTo(1);
    }];
    [_btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.top.equalTo(self.vLine3.mas_bottom).offset(28);
        make.right.equalTo(@-36);
        make.height.mas_equalTo(48);
    }];
    
    _lblTitle.text = @"身份认证成功\n请设置新的登录密码";
    _lblTitle.numberOfLines = 2;
    
    _lblPhone.text = @"手机号";
    _lblPhone.textColor = RGB(51, 51, 51);
    _lblPhone.font = kFONT12;
    
    _txfPhone.text = _phone;
    _txfPhone.enabled = NO;
    _vLine1.backgroundColor = RGB(240, 240, 240);
    
    _lblPassword.text = @"密码";
    _lblPassword.textColor = RGB(51, 51, 51);
    _lblPassword.font = kFONT12;
    
    _txfPassword.placeholder = @"8-14位，建议英文、数字、下划线组合";
    _txfPassword.secureTextEntry = YES;
    
    _vLine2.backgroundColor = RGB(240, 240, 240);
    
    _lblConfirm.text = @"再次输入确认密码";
    _lblConfirm.textColor = RGB(51, 51, 51);
    _lblConfirm.font = kFONT12;
    
    _txfConfirm.placeholder = @"请再一次输入密码";
    _txfConfirm.secureTextEntry = YES;
    _vLine3.backgroundColor = RGB(240, 240, 240);
    
    _btnConfirm.backgroundColor = RGB(255, 52, 101);
    _btnConfirm.cornerRadius = 24;
    [_btnConfirm setTitle:@"确定" forState: UIControlStateNormal];
    [_btnConfirm setTitleColor:UIColor.whiteColor forState: UIControlStateNormal];
    [_btnConfirm addTarget:self action:@selector(onConfirmClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void) onConfirmClick {
    if ([NSString isEmpty:_txfPassword.text]) {
        [FNTipsView showTips:@"请输入密码"];
        [_txfPassword kr_shake];
        return;
    }
    if ([NSString isEmpty:_txfConfirm.text]) {
        [FNTipsView showTips:@"请再次输入密码"];
        [_txfConfirm kr_shake];
        return;
    }
    
    if ([_txfPassword.text isEqualToString: _txfConfirm.text]) {
        [self requestSetPassword];
    } else {
        [FNTipsView showTips:@"两次密码不一致"];
        [_txfConfirm kr_shake];
    }
}

#pragma mark - Networking

- (void)requestSetPassword{
    
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    params[@"phone"] = _phone;
    params[@"captch"] = _code;
    params[@"password"] = [NSString md5:_txfConfirm.text];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appSetPwd&ctrl=update_pwd" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        [FNTipsView showTips:@"修改成功"];
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[ProfileViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO];
    
}

@end
