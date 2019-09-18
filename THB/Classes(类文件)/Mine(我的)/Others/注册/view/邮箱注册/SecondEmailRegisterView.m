//
//  SecondEmailRegisterView.m
//  THB
//
//  Created by zhongxueyu on 16/3/29.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "SecondEmailRegisterView.h"
#import "SizeMacros.h"
@implementation SecondEmailRegisterView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initPhoneRegisterView];
    }
    return self;
}

-(void)initPhoneRegisterView{
    UITextField *firstTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, LeftSpace, InputWidth, InputHeight)];
    [firstTF setBackground:IMAGE(TFIMG)];
    firstTF.placeholder = @"设置登录用户名";
    
    [self addSubview:firstTF];
    
    UITextField *secondTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(firstTF.frame)+20, InputWidth, InputHeight)];
    //    secondTF.backgroundColor = [UIColor redColor];
    [secondTF setBackground:IMAGE(TFIMG)];
    secondTF.placeholder = @"8-25位密码，包含英文和数字";
    [self addSubview:secondTF];
    
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(secondTF.frame)+15, InputWidth, InputHeight)];
    [confirmBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = kFONT15;
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    confirmBtn.backgroundColor = RED;
    [confirmBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.tag = 4;
    [self addSubview:confirmBtn];
    
    UIButton *agreementBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(confirmBtn.frame)+3, InputWidth, InputHeight)];
    [agreementBtn setTitle:@"《返利用户使用协议》" forState:UIControlStateNormal];
    agreementBtn.titleLabel.font = kFONT14;
    //    agreementBtn.backgroundColor = [UIColor redColor];
    [agreementBtn setTitleColor:RED forState:UIControlStateNormal];
    [agreementBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    agreementBtn.tag = 5;
    [self addSubview:agreementBtn];
}

-(void)clickBtnMethod:(UIButton *)sender
{
    
    NSInteger tag = sender.tag;
    if(tag == 1){
        XYLog(@"13");
    }else if (tag == 2){
        
    }
}

@end
