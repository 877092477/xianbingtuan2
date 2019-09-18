//
//  SecondPhoneRegisterView.m
//  THB
//
//  Created by zhongxueyu on 16/3/29.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "SecondPhoneRegisterView.h"
#import "SizeMacros.h"
#import "NSString+KRKit.h"
#import "UIView+KRKit.h"
@interface SecondPhoneRegisterView ()
@property (nonatomic,strong) UITextField *firstTF;

@property (nonatomic,strong) UITextField *secondTF;

@property (nonatomic,strong) UITextField *thirdTF;

@property (nonatomic,strong) UITextField *fourthTF;

@property (nonatomic,assign) BOOL isConfirm;
@end

@implementation SecondPhoneRegisterView
@synthesize firstTF,secondTF,thirdTF,fourthTF;
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initPhoneRegisterView];
    }
    return self;
}

-(void)initPhoneRegisterView{
    
    
    secondTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, LeftSpace, InputWidth, InputHeight)];
    secondTF.borderStyle = UITextBorderStyleRoundedRect;
    //    secondTF.backgroundColor = [UIColor redColor];
    [secondTF setBackground:IMAGE(TFIMG)];
    secondTF.placeholder = @"8-25位密码，包含英文和数字";
    secondTF.secureTextEntry = YES;
    [self addSubview:secondTF];
    
    thirdTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(secondTF.frame)+20, InputWidth, InputHeight)];
    thirdTF.borderStyle = UITextBorderStyleRoundedRect;
    //    secondTF.backgroundColor = [UIColor redColor];
    [thirdTF setBackground:IMAGE(TFIMG)];
    thirdTF.placeholder = @"请再次输入您的密码";
    thirdTF.secureTextEntry = YES;
    [self addSubview:thirdTF];
    
    fourthTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(thirdTF.frame)+20, InputWidth, InputHeight)];
    fourthTF.borderStyle = UITextBorderStyleRoundedRect;
    //    secondTF.backgroundColor = [UIColor redColor];
    [fourthTF setBackground:IMAGE(TFIMG)];
    NSString *str ;
    if ([[FNBaseSettingModel settingInstance].extendreg isEqualToString:@"1"]) {
       str = @"必填";
    }else{
        str = @"选填";
    }
    fourthTF.placeholder = [NSString stringWithFormat:@"%@",FNBaseSettingModel.settingInstance.tgid_str];
    [self addSubview:fourthTF];
    fourthTF.hidden = [[FNBaseSettingModel settingInstance].extend_onoff isEqualToString:@"0"];
    
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(fourthTF.frame)+15, InputWidth, InputHeight)];
    [confirmBtn.layer setMasksToBounds:YES];
    [confirmBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    [confirmBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = kFONT15;
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    confirmBtn.backgroundColor =RED;
    [confirmBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.tag = 1;
    [self addSubview:confirmBtn];
    
    UIButton *agreementBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(confirmBtn.frame)+3, InputWidth, InputHeight)];
    [agreementBtn setTitle:@"《返利用户使用协议》" forState:UIControlStateNormal];
    agreementBtn.titleLabel.font = kFONT14;
    //    agreementBtn.backgroundColor = [UIColor redColor];
    [agreementBtn setTitleColor:RED forState:UIControlStateNormal];
    [agreementBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    agreementBtn.tag = 2;
//    [self addSubview:agreementBtn];
}

-(BOOL)RegisterMethod
{
    XYLog(@"username is %@",self.userName);
    
    if (![secondTF.text kr_isNotEmpty]||secondTF.text.length<8){
        [FNTipsView showTips:@"密码长度至少为8位"];
       
       [secondTF kr_shake];
    }
    else if (![thirdTF.text kr_isNotEmpty]||thirdTF.text.length<8){
        [FNTipsView showTips:@"请再次确认您的密码"];
        [thirdTF kr_shake];
    }else if ([[FNBaseSettingModel settingInstance].extendreg isEqualToString:@"1"] && ![fourthTF.text kr_isNotEmpty]){
        [FNTipsView showTips:@"请输入推荐人ID"];
        [thirdTF kr_shake];
        
    }else{
        if([secondTF.text isEqualToString:thirdTF.text]){
            NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{
                                                          @"username":self.userName,
                                                          @"time":[NSString GetNowTimes],
                                                          @"pwd":[NSString md5:secondTF.text],
                                                          @"type":self.type,
                                                          @"tid":fourthTF.text?fourthTF.text:@""
                                                          }];
            params[SignKey] = [NSString getSignStringWithDictionary:params];
            
            [SVProgressHUD show];
            [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_register_register successBlock:^(id responseBody) {
                [FNTipsView showTips:responseBody[@"msg"]];
                NSDictionary *dict = responseBody;
                XYLog(@"responseBody2 is %@",responseBody);
                if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
                    
                    [SVProgressHUD dismiss];
//                    [FNTipsView showTips:@"注册成功"];
                    _isConfirm = YES;
                    [self.delegate OnClickRegisterBtn:1];
                    [SVProgressHUD dismiss];
                }else
                {
                    _isConfirm = NO;
                    
                    [XYNetworkAPI queryFinishTip:dict];
                    [XYNetworkAPI cancelAllRequest];
                }
                
                
            } failureBlock:^(NSString *error) {
                [SVProgressHUD dismiss];
                [XYNetworkAPI cancelAllRequest];
            }];
            
        }else{
            [FNTipsView showTips:@"您两次输入的密码不一致"];
            [secondTF kr_shake];
            [thirdTF kr_shake];
        }
        
    }
    
    return _isConfirm;
}

-(void)clickBtnMethod:(UIButton *)sender
{
    
    NSInteger tag = sender.tag;
    if (tag == 1) {
        [self RegisterMethod];
    }else if (tag == 2){
        
    }
    
}

@end
