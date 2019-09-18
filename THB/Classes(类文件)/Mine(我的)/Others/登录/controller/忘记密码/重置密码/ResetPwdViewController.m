//
//  ResetPwdViewController.m
//  THB
//
//  Created by zhongxueyu on 16/3/30.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "ResetPwdViewController.h"
#import "SizeMacros.h"
#import "LoginViewController.h"
#import "UIView+KRKit.h"
@interface ResetPwdViewController ()
@property (nonatomic,strong) UITextField *thirdTF;

@property (nonatomic,strong) UITextField *secondTF;
@end

@implementation ResetPwdViewController
@synthesize thirdTF,secondTF;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"重置密码";
    [self initViewMethod];
}

-(void)initViewMethod
{
    UILabel *firstLbl = [[UILabel alloc]initWithFrame:CGRectMake(LeftSpace, LeftSpace, InputWidth, 30)];
    firstLbl.textAlignment = NSTextAlignmentLeft;
    firstLbl.font = kFONT14;
    firstLbl.text = @"请输入新密码";
    [self.view addSubview:firstLbl];
    secondTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(firstLbl.frame)+LeftSpace, InputWidth, InputHeight)];
    secondTF.borderStyle = UITextBorderStyleRoundedRect;
    //    secondTF.backgroundColor = [UIColor redColor];
    ;
    secondTF.placeholder = @"8-25位密码，包含英文和数字";
    secondTF.secureTextEntry = YES;
    [self.view addSubview:secondTF];
    
    UILabel *secondLbl = [[UILabel alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(secondTF.frame)+20, InputWidth, 30)];
    secondLbl.text = @"确认新密码";
    secondLbl.textAlignment = NSTextAlignmentLeft;
    secondLbl.font = kFONT14;
    [self.view addSubview:secondLbl];
    
    thirdTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(secondLbl.frame)+LeftSpace, InputWidth, InputHeight)];
    thirdTF.borderStyle = UITextBorderStyleRoundedRect;
    //    secondTF.backgroundColor = [UIColor redColor];
    thirdTF.secureTextEntry = YES;
    thirdTF.placeholder = @"8-25位密码，包含英文和数字";
    [self.view addSubview:thirdTF];
    
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(thirdTF.frame)+15, InputWidth, InputHeight)];
    [confirmBtn.layer setMasksToBounds:YES];
    [confirmBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    [confirmBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = kFONT15;
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    confirmBtn.backgroundColor = RED;
    [confirmBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.tag = 4;
    [self.view addSubview:confirmBtn];

}
-(void)viewDidAppear:(BOOL)animated{
    [self.secondTF becomeFirstResponder];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.secondTF resignFirstResponder];
}
-(void)ComfirmMethod
{
    XYLog(@"username is %@",self.userName);
    
    if (![secondTF.text kr_isNotEmpty]||secondTF.text.length<8){
        [FNTipsView showTips:@"密码至少为8位数"];
        [secondTF kr_shake];
    }
    else if (![thirdTF.text kr_isNotEmpty]||thirdTF.text.length<8){
        [FNTipsView showTips:@"请再次确认您的密码"];
        [thirdTF kr_shake];
    }
    else{
        if([secondTF.text isEqualToString:thirdTF.text]){

            NSMutableDictionary* params= [NSMutableDictionary dictionaryWithDictionary:@{
                                                         @"username":self.userName,
                                                         @"time":[NSString GetNowTimes],
                                                         @"pwd":[NSString md5:secondTF.text]
                                                         }];
            params[SignKey] = [NSString getSignStringWithDictionary:params];
            [SVProgressHUD show];
            [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_mine_forgetPwd successBlock:^(id responseBody) {
                NSDictionary *dict = responseBody;
                XYLog(@"responseBody2 is %@",responseBody);
                if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
                    
                    [SVProgressHUD dismiss];
                    [FNTipsView showTips:@"修改成功"];
//                    LoginViewController *vc = [[LoginViewController alloc]init];
//                    [self.navigationController pushViewController:vc animated:YES];
                    [self gologin];
                }else
                {
                    
                    
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
    
   
}

-(void)clickBtnMethod:(UIButton *)sender
{
    
    NSInteger tag = sender.tag;
    if (tag == 4) {
        [self ComfirmMethod];
    }else if (tag == 2){
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
