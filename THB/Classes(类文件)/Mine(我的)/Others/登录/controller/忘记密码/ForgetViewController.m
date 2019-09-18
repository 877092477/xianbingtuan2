//
//  ForgetViewController.m
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

#import "ForgetViewController.h"
#import "firstPhoneRegisterView.h"
#import "SizeMacros.h"
#import "ResetPwdViewController.h"
#import "FirstEmailRegisterView.h"
#import "SecondPhoneRegisterVC.h"
@interface ForgetViewController ()<BtnClickDelegate,EmailBtnClickDelegate>

@property (nonatomic,strong) firstPhoneRegisterView *phoneview;

/** 邮箱注册视图 */
@property (nonatomic,strong) FirstEmailRegisterView *emailView;

/** 上方手机注册按钮 */
@property (nonatomic,strong) UIButton *phoneBtn;

/** 上方邮箱注册按钮 */
@property (nonatomic,strong) UIButton *emailBtn;

/** 下划线 */
@property (nonatomic,strong) UIView *line;


@end

@implementation ForgetViewController
@synthesize phoneview,emailView;;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"重置密码";
    
//    [self initHeadView];
    [self initRegisterView];

    
}

//接收外部代理方法
-(void)OnClickBtn:(NSString *)url
{
    XYLog(@"url is %@",url);
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    ResetPwdViewController *vc = [[ResetPwdViewController alloc]init];
    vc.userName = url;
//    vc.type = [NSNumber numberWithInt:1];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)OnClickEmailBtn:(NSString *)sender{
    XYLog(@"url is %@",sender);
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    ResetPwdViewController *vc = [[ResetPwdViewController alloc]init];
    vc.userName = sender;
//    vc.type = [NSNumber numberWithInt:2];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)initHeadView{
    UIView *headBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, HEADH)];
    [self.view addSubview:headBg];
    //手机找回按钮
    _phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth/2, HEADH-3)];
    [_phoneBtn.layer setMasksToBounds:YES];
    [_phoneBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    [_phoneBtn setBackgroundImage:IMAGE(@"logon_btn1") forState:UIControlStateNormal];
    _phoneBtn.titleLabel.font = kFONT13;
    _phoneBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_phoneBtn setBackgroundColor:[UIColor whiteColor]];
    [_phoneBtn setTitle:@"手机找回" forState:UIControlStateNormal];
    _phoneBtn.tag = 1;
    [_phoneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [_phoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_phoneBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    _phoneBtn.selected = YES;
    //邮箱找回按钮
    _emailBtn = [[UIButton alloc]initWithFrame:CGRectMake(XYScreenWidth/2, 0, XYScreenWidth/2, HEADH-3)];
    [_emailBtn.layer setMasksToBounds:YES];
    [_emailBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    _emailBtn.titleLabel.font = kFONT13;
    [_emailBtn setBackgroundColor:[UIColor whiteColor]];
    [_emailBtn setBackgroundImage:IMAGE(@"logon_btn1") forState:UIControlStateNormal];
    [_emailBtn setTitle:@"邮箱找回" forState:UIControlStateNormal];
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

-(void)initRegisterView{
    
    phoneview = [[firstPhoneRegisterView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight/3)];
    phoneview.is_forget=1;
    [self.view addSubview:phoneview];
    phoneview.delegate = self;
    emailView = [[FirstEmailRegisterView alloc]initWithFrame:CGRectMake(0, HEADH, XYScreenWidth, XYScreenHeight/3)];
    emailView.delegate = self;
    [self.view addSubview:emailView];
    emailView.hidden = YES;
    if([self.reg_btn_img kr_isNotEmpty]){
        [phoneview.confirmBtn setTitle:@"" forState:UIControlStateNormal];
        [phoneview.confirmBtn sd_setImageWithURL:URL(self.reg_btn_img) forState:UIControlStateNormal];
    }else{
        [phoneview.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        phoneview.confirmBtn.backgroundColor = RED;
    }
    
}

-(void)clickBtnMethod:(UIButton *)sender
{
    
    NSInteger tag = sender.tag;
    if (tag == 1)
    {
        
        
        // 执行动画
        if (!_phoneBtn.selected) {
            phoneview.alpha = 0.f;
            [UIView animateWithDuration:IMGDuration animations:^{
                _line.frame = CGRectMake(0,CGRectGetMaxY(_phoneBtn.frame), CGRectGetWidth(_phoneBtn.frame), 3);
                phoneview.alpha = 1.f;
                phoneview.hidden = NO;
                emailView.hidden = YES;
                _phoneBtn.selected = YES;
                _emailBtn.selected = NO;
            }];
        }
        
    }else if (tag == 2)
    {
        
        
        // 执行动画
        if (!_emailBtn.selected) {
            emailView.alpha = 0.f;
            [UIView animateWithDuration:IMGDuration animations:^{
                _line.frame = CGRectMake(XYScreenWidth/2,CGRectGetMaxY(_phoneBtn.frame), CGRectGetWidth(_phoneBtn.frame), 3);
                emailView.alpha = 1.f;
                phoneview.hidden = YES;
                emailView.hidden = NO;
                _phoneBtn.selected = NO;
                _emailBtn.selected = YES;
            }];
        }
        
    }
}


@end
