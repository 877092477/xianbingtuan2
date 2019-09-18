//
//  ModifyPasswordController.m
//  THB
//
//  Created by Weller Zhao on 2019/2/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "ModifyPasswordController.h"
#import "PasswordInputView.h"

@interface ModifyPasswordController ()<PasswordInputViewDelegate>

@property (nonatomic, strong) UIScrollView *scvPassword;

@property (nonatomic, strong) UIView *vPassword1;
@property (nonatomic, strong) UILabel *lblTitle1;
@property (nonatomic, strong) PasswordInputView *inputPsw1;
@property (nonatomic, strong) UILabel *lblDesc1;


@property (nonatomic, strong) UIView *vPassword2;
@property (nonatomic, strong) UILabel *lblTitle2;
@property (nonatomic, strong) PasswordInputView *inputPsw2;
@property (nonatomic, strong) UILabel *lblDesc2;

@end

@implementation ModifyPasswordController

#define Count 6

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}

- (void) configUI {
    self.title = @"修改支付密码";
    
    _scvPassword = [[UIScrollView alloc] init];
    _vPassword1 = [[UIView alloc] init];
    _lblTitle1 = [[UILabel alloc] init];
    _inputPsw1 = [[PasswordInputView alloc] initWithCount:6];
    _lblDesc1 = [[UILabel alloc] init];
    _vPassword2 = [[UIView alloc] init];
    _lblTitle2 = [[UILabel alloc] init];
    _inputPsw2 = [[PasswordInputView alloc] initWithCount:6];
    _lblDesc2 = [[UILabel alloc] init];
    
    [self.view addSubview:_scvPassword];
    [_scvPassword addSubview:_vPassword1];
    [_vPassword1 addSubview:_lblTitle1];
    [_vPassword1 addSubview:_inputPsw1];
    [_vPassword1 addSubview:_lblDesc1];
    [_scvPassword addSubview:_vPassword2];
    [_vPassword2 addSubview:_lblTitle2];
    [_vPassword2 addSubview:_inputPsw2];
    [_vPassword2 addSubview:_lblDesc2];
    
    @weakify(self)
    [_scvPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_vPassword1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
//        make.width.equalTo(@0);
//        make.width.mas_equalTo(XYScreenWidth);
//        make.height.equalTo(self_weak_.view);
        make.height.mas_equalTo(300);
        make.width.equalTo(self_weak_.view);
    }];
    [_lblTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self_weak_.inputPsw1.mas_top).offset(-40);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.centerX.equalTo(@0);
    }];
    [_inputPsw1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
//        make.width.equalTo(@0).offset(-40);
//        make.height.equalTo(self_weak_.inputPsw1.mas_width).dividedBy(Count);
        make.width.mas_equalTo(40 * Count);
        make.height.mas_equalTo(40);
    }];
    [_lblDesc1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self_weak_.inputPsw1.mas_bottom).offset(20);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.centerX.equalTo(@0);
    }];
    [_vPassword2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self_weak_.vPassword1.mas_right);
        make.top.bottom.equalTo(@0);
//        make.width.equalTo(@0);
//        make.width.mas_equalTo(XYScreenWidth);
//        make.height.equalTo(self_weak_.view);
        make.height.mas_equalTo(300);
        make.width.equalTo(self_weak_.view);
        make.right.equalTo(@0);
    }];
    [_lblTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self_weak_.inputPsw2.mas_top).offset(-40);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.centerX.equalTo(@0);
    }];
    [_inputPsw2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.mas_equalTo(40 * Count);
        make.height.mas_equalTo(40);
    }];
    [_lblDesc2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self_weak_.inputPsw2.mas_bottom).offset(20);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.centerX.equalTo(@0);
    }];
    
    _scvPassword.scrollEnabled = NO;
    
    _lblTitle1.text = @"请设置支付密码";
    _lblTitle1.font = [UIFont systemFontOfSize:18];
    
    _lblDesc1.text = @"设置6位支付密码，该支付密码在支付时使用";
    _lblDesc1.font = kFONT12;
    
    _inputPsw1.delegate = self;
    
    _lblTitle2.text = @"请确认密码";
    _lblTitle2.font = [UIFont systemFontOfSize:18];
    
    _lblDesc2.text = @"请再次输入密码";
    _lblDesc2.font = kFONT12;
    _inputPsw2.delegate = self;
}



- (void) requestSetPassword{
    NSString *psw = [NSString md5:[_inputPsw1 getText]];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"phone": UserPhone, @"payPassword": psw, @"captch": _code}];
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appSetPwd&ctrl=update" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        
        [self.navigationController popViewControllerAnimated:YES];
        if ([self.delegate respondsToSelector:@selector(didModify:)]) {
            [self.delegate didModify:YES];
        }
        
    } failure:^(NSString *error) {
        //
    } isHideTips:NO isCache:NO];
}

#pragma mark - PasswordInputViewDelegate
- (void)inputView:(PasswordInputView *)inputview didFinishedEdit:(NSString *)text {
    if ([inputview isEqual:_inputPsw1]) {
        [_scvPassword setContentOffset:CGPointMake(XYScreenWidth, 0) animated:YES];
        [_inputPsw2 becomeFirstResponder];
    } else {
        NSString *psw1 = [_inputPsw1 getText];
        NSString *psw2 = [_inputPsw2 getText];
        if (![psw1 isEqualToString:psw2]) {
            [FNTipsView showTips:@"两次输入密码不一致"];
            [_scvPassword setContentOffset:CGPointMake(0, 0) animated:YES];
            [_inputPsw1 clearUpPassword];
            [_inputPsw2 clearUpPassword];
            [_inputPsw1 becomeFirstResponder];
        } else {
            [self requestSetPassword];
        }
    }
}

@end
