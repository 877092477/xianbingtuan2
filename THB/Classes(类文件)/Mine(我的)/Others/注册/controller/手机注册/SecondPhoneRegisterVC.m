//
//  SecondPhoneRegisterVC.m
//  THB
//
//  Created by zhongxueyu on 16/3/29.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "SecondPhoneRegisterVC.h"
#import "SecondPhoneRegisterView.h"
#import "SizeMacros.h"
#import "LoginViewController.h"
@interface SecondPhoneRegisterVC ()<RegisterBtnClickDelegate>

@property (nonatomic,strong) UIButton *phoneBtn;

@property (nonatomic,strong) UIButton *emailBtn;

@property (nonatomic,strong) UIView *line;
@end

@implementation SecondPhoneRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户注册";
//    [self initHeadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initPhoneRegisterView];
    
}
//外部代理方法
-(void)OnClickRegisterBtn:(NSInteger)sender{
     
    if (sender == 1) {
        XYLog(@"注册成功跳转");
//        LoginViewController *vc = [[LoginViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
        [self gologin];
    }else if (sender == 2){
        
    }
}
/**
-(void)initHeadView{
    
    UIView *headBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, HEADH)];
    [self.view addSubview:headBg];
    //手机注册按钮
    _phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth/2, HEADH-3)];
    _phoneBtn.titleLabel.font = kFONT13;
    _phoneBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_phoneBtn setBackgroundColor:[UIColor whiteColor]];
    [_phoneBtn setTitle:@"手机注册" forState:UIControlStateNormal];
    _phoneBtn.tag = 1;
    [_phoneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [_phoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_phoneBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    //邮箱注册按钮
    _emailBtn = [[UIButton alloc]initWithFrame:CGRectMake(XYScreenWidth/2, 0, XYScreenWidth/2, HEADH-3)];
    _emailBtn.titleLabel.font = kFONT13;
    [_emailBtn setBackgroundColor:[UIColor whiteColor]];
    [_emailBtn setTitle:@"邮箱注册" forState:UIControlStateNormal];
    _emailBtn.tag = 2;
    [_emailBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_emailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_emailBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    _line = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_phoneBtn.frame), CGRectGetWidth(_phoneBtn.frame), 3)];
    _line.backgroundColor = [UIColor brownColor];
    [headBg addSubview:_line];
    [headBg addSubview:_phoneBtn];
    [headBg addSubview:_emailBtn];
    
}
**/

//初始化注册页面
-(void)initPhoneRegisterView{
    SecondPhoneRegisterView *view = [[SecondPhoneRegisterView alloc]initWithFrame:CGRectMake(0, 15, XYScreenWidth, XYScreenHeight)];
    view.type = self.type;
    view.userName = self.userName;
    view.delegate = self;
    [self.view addSubview:view];
}

-(void)clickBtnMethod:(UIButton *)sender
{
    
    NSInteger tag = sender.tag;
    if (tag == 1)
    {
        
    }else if (tag == 2)
    {
        
    }else if (tag == 3)
    {
        
    }
    else if (tag == 4)
    {
        
    }
}
@end
