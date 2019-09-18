//
//  BlindAliPayViewController.m
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

#import "BlindAliPayViewController.h"
#import "SizeMacros.h"
@interface BlindAliPayViewController ()
@property (nonatomic,strong)UITextField *firstTF;

@property (nonatomic,strong)UITextField *secondTF;

@end

@implementation BlindAliPayViewController
@synthesize firstTF,secondTF;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置支付宝";
    [self initViewMethod];
    
//    if (Userrealname && Userzfb_au) {
//        firstTF.text = Userrealname;
//        secondTF.text = Userzfb_au;
//    }
    
}
-(void)viewDidDisappear:(BOOL)animated{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initViewMethod
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(LeftSpace, LeftSpace, XYScreenWidth-LeftSpace*2, 70)];
    label.numberOfLines = 0;
    
//    NSString *str = @"请输入正确的支付宝账号，姓名、错误的账号将收不到返利!";
//    label.lineBreakMode = NSLineBreakByWordWrapping;
//    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
//    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:[NSString stringWithFormat:@""]].location, [[noteStr string] rangeOfString:[NSString stringWithFormat:@"    支付宝只能绑定一次，如要更改请联系客服"]].length);
//    [noteStr addAttribute:NSForegroundColorAttributeName value:RED range:redRange];
//    [noteStr addAttribute:NSFontAttributeName value:kFONT13 range:redRange];
//    [label setAttributedText:noteStr];

    label.text = @"请输入正确的支付宝账号，姓名、错误的账号将收不到返利!";
    
    CGSize size = [label sizeThatFits:CGSizeMake(label.frame.size.width, MAXFLOAT)];
    
    label.frame =CGRectMake(LeftSpace, LeftSpace, XYScreenWidth-LeftSpace*2, size.height);
    
    label.font =kFONT15;
    
    [self.view addSubview:label];
    
    firstTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(label.frame)+ LeftSpace, InputWidth, InputHeight)];
    if ([Userrealname kr_isNotEmpty]) {
        firstTF.text = Userrealname;
    }
    firstTF.borderStyle = UITextBorderStyleRoundedRect;
    firstTF.placeholder = @"请输入支付宝姓名";
    
    [self.view addSubview:firstTF];
    XYLog(@"Userzfb_au is %@",Userzfb_au);
    
    secondTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(firstTF.frame)+ LeftSpace, InputWidth, InputHeight)];
    secondTF.borderStyle = UITextBorderStyleRoundedRect;
    secondTF.placeholder = @"请输入支付宝账号";
    if ([Userzfb_au kr_isNotEmpty]) {
        secondTF.text = Userzfb_au;
    }
    [self.view addSubview:secondTF];
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(secondTF.frame)+15, InputWidth, InputHeight)];
    [confirmBtn.layer setMasksToBounds:YES];
    [confirmBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = kFONT15;
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    confirmBtn.backgroundColor = RED;
    [confirmBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.tag = 4;
    [self.view addSubview:confirmBtn];
}

-(void)clickBtnMethod:(UIButton *)sender
{
    
//    NSNotification *notification =[NSNotification notificationWithName:@"EditProfile" object:nil userInfo:nil];
//    //通过通知中心发送通知
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    [self postUserInfo];
}

-(void)postUserInfo{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"zfb_au":secondTF.text,
                                                                                 @"realname":firstTF.text,
                                                                                 @"token":UserAccessToken}];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_updateUser successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            [[NSUserDefaults standardUserDefaults] setValue:firstTF.text forKey:XYrealname];
            [[NSUserDefaults standardUserDefaults] setValue:secondTF.text forKey:XYzfb_au];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
//            [SVProgressHUD dismiss];
            NSNotification *notification =[NSNotification notificationWithName:@"EditProfile" object:nil userInfo:nil];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [FNTipsView showTips:@"绑定成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
           
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

@end
