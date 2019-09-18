//
//  RenameViewController.m
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

#import "RenameViewController.h"
#import "SizeMacros.h"
@interface RenameViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField *firstTF;
@end

@implementation RenameViewController
@synthesize firstTF;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改昵称";
    
    [self initView];
}

-(void)initView{
    firstTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace,  LeftSpace, InputWidth, InputHeight)];
    firstTF.borderStyle = UITextBorderStyleRoundedRect;
    firstTF.text = [[NSUserDefaults standardUserDefaults] valueForKey:XYUserNick];
    firstTF.delegate =self;
    firstTF.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:firstTF];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(firstTF.frame)+20, XYScreenWidth-LeftSpace*2, 70)];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = kFONT14;
    label.text = @"20个字节以内，支持中英文、数字、\"_\"一个中文为2个字符";
    CGSize size = [label sizeThatFits:CGSizeMake(label.frame.size.width, MAXFLOAT)];
    label.frame =CGRectMake(LeftSpace, CGRectGetMaxY(firstTF.frame)+20, XYScreenWidth-LeftSpace*2, size.height);
    [self.view addSubview:label];
    
    UIButton *btnDone = [[UIButton alloc] initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(label.frame)+20, XYScreenWidth-LeftSpace*2, 40)];
    btnDone.backgroundColor = FNMainGobalControlsColor;
    btnDone.cornerRadius = 5;
    [btnDone setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    [btnDone setTitle:@"保存" forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(onDoneClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDone];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //返回一个BOOL值，指明是否允许在按下回车键时结束编辑
    //如果允许要调用resignFirstResponder 方法，这回导致结束编辑，而键盘会被收起
    [textField resignFirstResponder];//查一下resign这个单词的意思就明白这个方法了
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
}

- (void)onDoneClick {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
    [[NSUserDefaults standardUserDefaults] setValue:firstTF.text forKey:XYUserNick];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSNotification *notification =[NSNotification notificationWithName:@"EditProfile" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
