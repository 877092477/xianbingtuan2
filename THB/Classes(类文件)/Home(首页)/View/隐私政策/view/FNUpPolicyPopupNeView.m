//
//  FNUpPolicyPopupNeView.m
//  THB
//
//  Created by 李显 on 2018/10/8.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpPolicyPopupNeView.h"

@implementation FNUpPolicyPopupNeView
{
    UIButton *agreeButton;
    UIButton *noagreeButton;
    UIView *view;
    UIView *bgView;
    
}
-(instancetype)initWithFrame:(CGRect)frame andHeight:(float)height {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //半透明view
        view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = FNBlackColorWithAlpha(0.4);//(0, 0, 0, 0.4);
        [self addSubview:view];
        //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];
        //[view addGestureRecognizer:tap];
        //白色底view
        bgView = [[UIView alloc] initWithFrame:CGRectMake(40, JMScreenHeight, JMScreenWidth-80, height)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.userInteractionEnabled = YES;
        bgView.cornerRadius=5;
        [self addSubview:bgView];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        CFShow((__bridge CFTypeRef)(infoDictionary));
        // app名称
        NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        app_Name=[FNBaseSettingModel settingInstance].AppDisplayName;
        UILabel *titleLB=[[UILabel alloc]init];
        //titleLB.text=@"欢迎来到 袋鼠优品 ";
        titleLB.text=[NSString stringWithFormat:@"欢迎来到%@",app_Name];
        titleLB.textAlignment=NSTextAlignmentCenter;
        titleLB.font=kFONT14;
        titleLB.textColor=[UIColor orangeColor];
        [bgView addSubview:titleLB];
        
        //不同意
        noagreeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [noagreeButton setTitle:@"不同意" forState:UIControlStateNormal];
        [noagreeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        noagreeButton.titleLabel.font=kFONT12;
        noagreeButton.backgroundColor=[UIColor whiteColor];
        [noagreeButton addTarget:self action:@selector(noagreeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:noagreeButton];
        
        //同意并继续
        agreeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        agreeButton.titleLabel.font=kFONT12;
        [agreeButton setTitle:@"同意并继续" forState:UIControlStateNormal];
        [agreeButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        agreeButton.backgroundColor=[UIColor whiteColor];
        [agreeButton addTarget:self action:@selector(agreeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:agreeButton];
        
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectZero];
        webView.scrollView.scrollEnabled=YES;
        //webView.backgroundColor = [UIColor clearColor];
        //webView.delegate = self;
        [bgView addSubview:webView];
        NSString *url=[FNBaseSettingModel settingInstance].privacy_url;//@"https://public.immmmmm.com/app/yinsi.html?name=app&from=singlemessage&isappinstalled=0";
        if(![url kr_isNotEmpty]){
//            url=@"http://www.hairuyi.com/?act=gototaobao&gid=38713797470&js=on";
            url = @"https://public.immmmmm.com/app/yinsi.html?name=app&from=singlemessage&isappinstalled=0";
        }
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [webView loadRequest:request];
        
        titleLB.sd_layout
         .topSpaceToView(bgView, 0).leftSpaceToView(bgView, 0).rightSpaceToView(bgView, 0).heightIs(40);
        
        agreeButton.sd_layout
        .bottomSpaceToView(bgView, 0).rightSpaceToView(bgView, 0).heightIs(40).widthIs(bgView.frame.size.width/2);
        
        noagreeButton.sd_layout
        .bottomSpaceToView(bgView, 0).leftSpaceToView(bgView, 0).heightIs(40).widthIs(bgView.frame.size.width/2);
 
        webView.sd_layout.topSpaceToView(titleLB, 0).leftSpaceToView(bgView, 0).rightSpaceToView(bgView, 0).bottomSpaceToView(agreeButton, 0);
        
        
    }
    return self;
}
-(void)webShopURL{
   
}
-(void)agreeButtonClick{ 
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"privacy_onoff"];
    [defaults synchronize];
    [self hideView];
}
-(void)noagreeButtonClick{
    [FNTipsView showTips:@"请先同意协议!"];
    //[self hideView];
}
#pragma mark - 消失
-(void)hideView
{
    [UIView animateWithDuration:0.25 animations:^
     {
         bgView.centerY = bgView.centerY+CGRectGetHeight(bgView.frame);
         
     } completion:^(BOOL fin){
         [self removeFromSuperview];
         
     }];
    
}
#pragma mark - 隐藏
-(void)showView
{
    self.alpha = 1;
    [UIView animateWithDuration:0.25 animations:^
     {
         bgView.centerY = bgView.centerY-CGRectGetHeight(bgView.frame)-100;
         
     } completion:^(BOOL fin){}];
}
@end
