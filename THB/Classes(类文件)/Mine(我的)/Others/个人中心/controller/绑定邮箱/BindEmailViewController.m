//
//  BindEmailViewController.m
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

#import "BindEmailViewController.h"
#import "FirstEmailRegisterView.h"
#import "SizeMacros.h"
@interface BindEmailViewController ()<EmailBtnClickDelegate>
/** 邮箱注册视图 */
@property (nonatomic,strong) FirstEmailRegisterView *emailView;
@end

@implementation BindEmailViewController
@synthesize emailView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"绑定邮箱";
    [self initEmailView];
}

-(void)initEmailView
{
    emailView = [[FirstEmailRegisterView alloc]initWithFrame:CGRectMake(0, 15, XYScreenWidth, XYScreenHeight/3)];
    emailView.delegate = self;
    [self.view addSubview:emailView];
}

-(void)OnClickEmailBtn:(NSString *)url
{
    XYLog(@"url is %@",url);
     [[NSUserDefaults standardUserDefaults] setValue:url forKey:XYemail];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSNotification *notification =[NSNotification notificationWithName:@"EditProfile" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [FNTipsView showTips:@"绑定成功"];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
