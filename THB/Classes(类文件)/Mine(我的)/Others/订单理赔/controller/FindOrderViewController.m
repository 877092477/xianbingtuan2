//
//  FindOrderViewController.m
//  THB
//
//  Created by zhongxueyu on 16/4/23.
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

#import "FindOrderViewController.h"
#import "SizeMacros.h"
#import "UIView+KRKit.h"
#import "NSString+KRKit.h"
@interface FindOrderViewController ()
/** 上方手机注册按钮 */
@property (nonatomic,strong) UIButton *phoneBtn;

/** 上方邮箱注册按钮 */
@property (nonatomic,strong) UIButton *emailBtn;

/** 淘宝订单视图 */
@property (nonatomic,strong) UIView *TBOrderView;

/** 商城订单视图 */
@property (nonatomic,strong) UIView *ShopOrderView;

@property (nonatomic,strong)UITextField *TBOrderTF;

@property (nonatomic,strong)UITextField *ShopOrderTF;

/** 下划线 */
@property (nonatomic,strong) UIView *line;

/** 头部视图 */
@property (nonatomic,strong)UIView *headBg;

@end

@implementation FindOrderViewController
@synthesize headBg;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"丢单理赔";
//    [self initHeadView];
    [self initTBOrderView];
//    [self initShopOrderView];
}

-(void)initTBOrderView{
    self.TBOrderView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headBg.frame), XYScreenWidth, 120)];
    [self.view addSubview:self.TBOrderView];
    
    _TBOrderTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, LeftSpace, InputWidth, InputHeight)];
    _TBOrderTF.borderStyle = UITextBorderStyleRoundedRect;
    _TBOrderTF.placeholder = @"请输入淘宝订单号";
    
    [self.TBOrderView addSubview:_TBOrderTF];
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(_TBOrderTF.frame)+15, InputWidth, InputHeight)];
    [confirmBtn.layer setMasksToBounds:YES];
    [confirmBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    
    [confirmBtn setTitle:@"找回订单" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = kFONT15;
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    confirmBtn.backgroundColor = RED;
//    [confirmBtn setBackgroundImage:IMAGE(@"newest1") forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.tag = 3;
    [self.TBOrderView addSubview:confirmBtn];
}

-(void)initShopOrderView{
    self.ShopOrderView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headBg.frame), XYScreenWidth, 120)];
    [self.view addSubview:self.ShopOrderView];
    
    _ShopOrderTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, LeftSpace, InputWidth, InputHeight)];
    _ShopOrderTF.borderStyle = UITextBorderStyleRoundedRect;
    _ShopOrderTF.placeholder = @"请输商城订单号";
    
    [self.ShopOrderView addSubview:_ShopOrderTF];
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(_TBOrderTF.frame)+15, InputWidth, InputHeight)];
    //    [confirmBtn.layer setMasksToBounds:YES];
    //    [confirmBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    
    [confirmBtn setTitle:@"找回订单" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = kFONT15;
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    //    confirmBtn.backgroundColor = [UIColor redColor];
    [confirmBtn setBackgroundImage:IMAGE(@"newest1") forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.tag = 4;
    [self.ShopOrderView addSubview:confirmBtn];
}
-(void)initHeadView{
    headBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, HEADH)];
    [self.view addSubview:headBg];
    //找回淘宝订单
    _phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth/2, HEADH-3)];
    [_phoneBtn.layer setMasksToBounds:YES];
    [_phoneBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    [_phoneBtn setBackgroundImage:IMAGE(@"logon_btn1") forState:UIControlStateNormal];
    _phoneBtn.titleLabel.font = kFONT13;
    _phoneBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_phoneBtn setBackgroundColor:[UIColor whiteColor]];
    [_phoneBtn setTitle:@"淘宝订单" forState:UIControlStateNormal];
    _phoneBtn.tag = 1;
    [_phoneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [_phoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_phoneBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    _phoneBtn.selected = YES;
    //找回商城订单
    _emailBtn = [[UIButton alloc]initWithFrame:CGRectMake(XYScreenWidth/2, 0, XYScreenWidth/2, HEADH-3)];
    [_emailBtn.layer setMasksToBounds:YES];
    [_emailBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    _emailBtn.titleLabel.font = kFONT13;
    [_emailBtn setBackgroundColor:[UIColor whiteColor]];
    [_emailBtn setBackgroundImage:IMAGE(@"logon_btn1") forState:UIControlStateNormal];
    [_emailBtn setTitle:@"商城订单" forState:UIControlStateNormal];
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

-(void)clickBtnMethod:(UIButton *)sender
{
    
    NSInteger tag = sender.tag;
    if (tag == 1)
    {
        
        
        // 执行动画
        if (!_phoneBtn.selected) {
            _TBOrderView.alpha = 0.f;
            [UIView animateWithDuration:IMGDuration animations:^{
                _line.frame = CGRectMake(0,CGRectGetMaxY(_phoneBtn.frame), CGRectGetWidth(_phoneBtn.frame), 3);
                _TBOrderView.alpha = 1.f;
                _TBOrderView.hidden = NO;
                _ShopOrderView.hidden = YES;
                _phoneBtn.selected = YES;
                _emailBtn.selected = NO;
            }];
        }
        
    }else if (tag == 2)
    {
        
        
        // 执行动画
        if (!_emailBtn.selected) {
            _ShopOrderView.alpha = 0.f;
            [UIView animateWithDuration:IMGDuration animations:^{
                _line.frame = CGRectMake(XYScreenWidth/2,CGRectGetMaxY(_phoneBtn.frame), CGRectGetWidth(_phoneBtn.frame), 3);
                _ShopOrderView.alpha = 1.f;
                _TBOrderView.hidden = YES;
                _ShopOrderView.hidden = NO;
                _phoneBtn.selected = NO;
                _emailBtn.selected = YES;
            }];
        }
        
    }else if (tag == 3) {
        [self FindOrderMethod:1];
    }else if (tag == 4){
        [self FindOrderMethod:2];
    }
}

/**
 *  找回订单
 *
 *  @param type 1.淘宝 2.商城
 */
-(void)FindOrderMethod:(int)type{
    NSString *order ;
    if (type == 1) {
        if (![_TBOrderTF.text kr_isNotEmpty]) {
            [_TBOrderTF kr_shake];
            [FNTipsView showTips:@"请输入您要找回的淘宝订单号~"];
        }else{
            order = _TBOrderTF.text;
            NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken,
                                                                                         @"time":[NSString GetNowTimes],
                                                                                         @"t":[NSNumber numberWithInt:type],
                                                                                         @"oid":order
                                 }];
            param[SignKey] = [NSString getSignStringWithDictionary:param];
            [SVProgressHUD show];
            [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_reorder successBlock:^(id responseBody) {
                NSDictionary *dict = responseBody;
                XYLog(@"responseBody2 is %@",responseBody);
                if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
                    
                    [FNTipsView showTips:@"找回成功，请稍后到我的返利查看订单信息~"];
                    
                }else
                {
                    [XYNetworkAPI queryFinishTip:dict];
                    [XYNetworkAPI cancelAllRequest];
                }
                
                
            } failureBlock:^(NSString *error) {
                
                [XYNetworkAPI cancelAllRequest];
            }];
        }
        
    }else if(type == 2){
        order = _ShopOrderTF.text;
    }
    
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
