//
//  ThirdLoginView.m
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

#import "ThirdLoginView.h"

@implementation ThirdLoginView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView
{
    //下面的第三方登录View
    for (int i = 0; i<3; i++) {
        UIView *btnBg = [[UIView alloc]initWithFrame:CGRectMake(i*(XYScreenWidth/3), XYScreenHeight/2, XYScreenWidth/3, XYScreenWidth/3)];
        //        btnBg.backgroundColor = [UIColor redColor];
        [self addSubview:btnBg];
        UIButton *thirdBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnBg.frame.size.width/4, btnBg.frame.size.width-(btnBg.frame.size.width/2), btnBg.frame.size.width/2, btnBg.frame.size.width/2)];
        [thirdBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [thirdBtn setBackgroundImage:IMAGE(@"general-Icon") forState:UIControlStateNormal];
        thirdBtn.tag = i+10;
        //        [thirdBtn setBackgroundColor:[UIColor redColor]];
        [btnBg addSubview:thirdBtn];
        
    }
}

-(void)btnClick:(UIButton *)sender
{
    XYLog(@"sender tag is %ld",sender.tag);
}

@end
