//
//  BlindPhoneViewController.m
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

#import "BlindPhoneViewController.h"
#import "SizeMacros.h"
#import "firstPhoneRegisterView.h"
@interface BlindPhoneViewController ()<BtnClickDelegate>
/** 手机注册视图 */
@property (nonatomic,strong) firstPhoneRegisterView *phoneview;
@end

@implementation BlindPhoneViewController
@synthesize phoneview;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定手机号码";
    [self initPhoneView];
    // Do any additional setup after loading the view.
}
//接收外部代理方法
-(void)OnClickBtn:(NSString *)url
{
    XYLog(@"url is %@",url);
//    self.navigationController.view.backgroundColor = [UIColor whiteColor];
//    SecondPhoneRegisterVC *vc = [[SecondPhoneRegisterVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    [[NSUserDefaults standardUserDefaults] setValue:url forKey:XYUserPhone];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSDictionary *dataDict = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"isPhone", nil];
    [FNTipsView showTips:@"绑定成功"];
    NSNotification *notification =[NSNotification notificationWithName:@"EditProfile" object:nil userInfo:dataDict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)initPhoneView
{
    phoneview = [[firstPhoneRegisterView alloc]initWithFrame:CGRectMake(0, 15, XYScreenWidth, XYScreenHeight/3)];
    phoneview.is_forget=0; 
    [self.view addSubview:phoneview];
    phoneview.delegate = self;
    phoneview.confirmBtn.backgroundColor = RED;
    [phoneview.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
