//
//  FirstEmailRegisterView.m
//  THB
//
//  Created by zhongxueyu on 16/3/29.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "FirstEmailRegisterView.h"
#import "SizeMacros.h"
#import "UIView+KRKit.h"
#import "JKCountDownButton.h"
#import "NSString+KRKit.h"
@interface  FirstEmailRegisterView ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *firstTF;

@property (nonatomic,strong) UITextField *secondTF;

//获取验证码按钮
@property (nonatomic,strong) JKCountDownButton *getBtn;

@property (nonatomic,assign) BOOL isConfirm;

@end
@implementation FirstEmailRegisterView
@synthesize firstTF,secondTF,getBtn;
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isConfirm = NO;
        [self initPhoneRegisterView];
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [self.firstTF becomeFirstResponder];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.firstTF resignFirstResponder];
}
-(void)initPhoneRegisterView{
    firstTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, LeftSpace, InputWidth, InputHeight)];
    firstTF.borderStyle = UITextBorderStyleRoundedRect;
    [firstTF setBackground:IMAGE(TFIMG)];
    firstTF.placeholder = @"请输入邮箱";
    firstTF.keyboardType = UIKeyboardTypeEmailAddress;
    
    [self addSubview:firstTF];
    
    secondTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(firstTF.frame)+20, XYScreenWidth/2+20, InputHeight)];
    secondTF.borderStyle = UITextBorderStyleRoundedRect;
    //    secondTF.backgroundColor = [UIColor redColor];
    [secondTF setBackground:IMAGE(TFIMG)];
    
    secondTF.placeholder = @"请输入验证码";
    secondTF.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:secondTF];
    
    //获取验证码按钮
    getBtn = [[JKCountDownButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(secondTF.frame)+5, CGRectGetMaxY(firstTF.frame)+20, XYScreenWidth/3, InputHeight)];
    [getBtn.layer setMasksToBounds:YES];
    [getBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    [getBtn.layer setBorderWidth:1];//设置边界的宽度
    //设置按钮的边界颜色
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){225/255,225/255,225/255,0.1});
    [getBtn.layer setBorderColor:color];
    [getBtn setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    
    [getBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //    getBtn.backgroundColor = [UIColor redColor];
    getBtn.titleLabel.font = kFONT13;
    getBtn.tag = 1;
    [getBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:getBtn];
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(secondTF.frame)+15, InputWidth, InputHeight)];
    [confirmBtn.layer setMasksToBounds:YES];
    [confirmBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = kFONT15;
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    confirmBtn.backgroundColor = RED;
    [confirmBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.tag = 2;
    [self addSubview:confirmBtn];
}

//delegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (![firstTF.text kr_isNotEmpty]) {
        getBtn.enabled = YES;
        
    }else{
        getBtn.enabled = NO;
        
    }
    
    
}
-(void)getcodeMethod{
    
    NSNumber *check;
    if ([self.type  isEqual: @2]) {
        check = @1;
    }else{
        check = @0;
    }
    //Type类型 1.手机 2.邮箱
    if (![self checkInput]) {
        
//        [Tools showMessage:@"请输入邮箱号码"];
        
    }else{
        NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"username":firstTF.text,
                                                                                     @"time":[NSString GetNowTimes],
                                                                                     @"type":@2,
                                                                                     @"check":check                    }];
        param[SignKey] = [NSString getSignStringWithDictionary:param];
        [FNTipsView showTips:@"正在获取验证码..."];
        [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_getcode successBlock:^(id responseBody) {
            NSDictionary *dict = responseBody;

            XYLog(@"responseBody2 is %@",responseBody);
            
            if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
                
                [FNTipsView showTips:@"验证码已下发"];
                [self secondAction:getBtn];

            }else
            {
                [XYNetworkAPI queryFinishTip:dict];
                [XYNetworkAPI cancelAllRequest];
            }
            
            
        } failureBlock:^(NSString *error) {
            [SVProgressHUD dismiss];
            [XYNetworkAPI cancelAllRequest];
        }];
    }
    
}

-(BOOL)checkcodeMethod
{
    
    //Type类型 1.手机 2.邮箱
    if (![self checkInput]) {
        
//        [Tools showMessage:@"请输入邮箱号码"];
    
    }else if (![secondTF.text kr_isNotEmpty]){
        [FNTipsView showTips:@"请输入验证码"];
        [secondTF kr_shake];
    }
    else{
        NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"username":firstTF.text,
                                                                                     @"time":[NSString GetNowTimes],
                                                                                     @"captch":secondTF.text                  }];
        param[SignKey] = [NSString getSignStringWithDictionary:param];
        [FNTipsView showTips:@"正在验证验证码..."];
        [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_checkcode successBlock:^(id responseBody) {
            NSDictionary *dict = responseBody;
            XYLog(@"responseBody2 is %@",responseBody);
            if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
                
                [SVProgressHUD dismiss];
                _isConfirm = YES;
                [self.delegate OnClickEmailBtn:firstTF.text];
                
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
        
    }
    
    return _isConfirm;
}
-(void)clickBtnMethod:(UIButton *)sender
{
    
    NSInteger tag = sender.tag;
    if (tag == 1) {
        XYLog(@"获取验证码");
        
        [self getcodeMethod];
        
    }else if (tag == 2){
        XYLog(@"确定邮箱");
        [self checkcodeMethod];
//        if ([self checkcodeMethod]) {
//            [self.delegate OnClickEmailBtn:firstTF.text];
//        }else{
////            [FNTipsView showTips:_msgStr];
//        }
        
        
        
    }
}

- (BOOL)checkInput {
    
    
    if (![firstTF.text kr_isNotEmpty]) {
        [FNTipsView showTips:@"请输入邮箱号码"];
        [firstTF kr_shake];
        return false;
    }
    if (![firstTF.text kr_isEmail]) {
        [FNTipsView showTips:@"请输入正确的邮箱格式"];
        return false;
    }
    return true;
}
//倒计时
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
        return @"点击重新获取";
    }];
}
@end
