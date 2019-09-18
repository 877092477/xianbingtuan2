//
//  BlindTidViewController.m
//  THB
//
//  Created by zhongxueyu on 16/5/24.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "BlindTidViewController.h"
#import "SizeMacros.h"
#import "UIView+KRKit.h"
#import "JKCountDownButton.h"
#import "NSString+KRKit.h"
#import "XYTabBarViewController.h"
#import "FNAlertWithImgView.h"
@interface BlindTidViewController ()
@property (nonatomic,strong) UITextField *firstTF;

@property (nonatomic,strong) UITextField *secondTF;

@property (nonatomic,strong) UITextField *thirdTF;

@property (nonatomic,strong) UITextField *fourthTF;

@property (strong, nonatomic)  JKCountDownButton *getBtn;
@end

@implementation BlindTidViewController{
    NSString *bind_phone_str;
}
@synthesize firstTF,secondTF,thirdTF,fourthTF,getBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"绑定手机";
    [self apiRequestTop];
}

-(void)initPhoneRegisterView{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(LeftSpace, LeftSpace, XYScreenWidth-LeftSpace*2, 70)];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.text = bind_phone_str;
    CGSize size = [label sizeThatFits:CGSizeMake(label.frame.size.width, MAXFLOAT)];
    label.frame =CGRectMake(LeftSpace, LeftSpace, XYScreenWidth-LeftSpace*2, size.height);
    label.font = kFONT15;
    [self.view addSubview:label];
    
    CGFloat _lsc_tf_height = 40.0f;
    
    UIView* fourthTFview = [UIView new];
    fourthTFview.frame=CGRectMake(LeftSpace, CGRectGetMaxY(label.frame)+20, InputWidth, _lsc_tf_height);
    [self.view addSubview:fourthTFview];
    
    fourthTF = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, InputWidth, _lsc_tf_height)];
    //fourthTF.borderStyle = UITextBorderStyleRoundedRect;
    //    secondTF.backgroundColor = [UIColor redColor];
    //[fourthTF setBackground:IMAGE(TFIMG)];
    NSString *str ;
    if ([[FNBaseSettingModel settingInstance].extendreg isEqualToString:@"1"]) {
        str = @"必填";
    }else{
        str = @"选填";
        
    }
    fourthTF.placeholder = [NSString stringWithFormat:@"推荐人ID,%@",str];
    //fourthTF.keyboardType = UIKeyboardTypeNumberPad;
    //[self.view addSubview:fourthTF];
    [fourthTFview addSubview:fourthTF]; 
    [fourthTF autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
    [fourthTF autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    [fourthTF autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [fourthTF autoSetDimension:(ALDimensionHeight) toSize:40];
    
    UIView* fourthline = [UIView new];
    fourthline.backgroundColor = FNHomeBackgroundColor;
    [fourthTFview addSubview:fourthline];
    [fourthline autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeTop)];
    [fourthline autoSetDimension:(ALDimensionHeight) toSize:1];
    
    UIView* firstview = [UIView new];
    firstview.frame=CGRectMake(LeftSpace, CGRectGetMaxY(fourthTFview.frame)+10, InputWidth, _lsc_tf_height);
    [self.view addSubview:firstview];
    
    UIImageView* firstIcon = [[UIImageView alloc]initWithImage:IMAGE(@"land_accout")];
    [firstIcon sizeToFit];
    [firstview addSubview:firstIcon];
    [firstIcon autoSetDimensionsToSize:firstIcon.size];
    [firstIcon autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [firstIcon autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
    
    firstTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, 0, InputWidth, InputHeight)];
    //firstTF.borderStyle = UITextBorderStyleRoundedRect;
    [firstTF setBackground:IMAGE(TFIMG)];
    firstTF.placeholder = @"请输入手机号";
    firstTF.keyboardType = UIKeyboardTypePhonePad;
    //[self.view addSubview:firstTF];
    [firstview addSubview:firstTF];
    [firstTF autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:firstIcon withOffset:_jmsize_10];
    [firstTF autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    [firstTF autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [firstTF autoSetDimension:(ALDimensionHeight) toSize:firstTF.height];
    
    UIView* firstline = [UIView new];
    firstline.backgroundColor = FNHomeBackgroundColor;
    [firstview addSubview:firstline];
    [firstline autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeTop)];
    [firstline autoSetDimension:(ALDimensionHeight) toSize:1];
    
    UIView* secondview = [UIView new];
    [self.view addSubview:secondview];
    [secondview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:LeftSpace];
    [secondview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:LeftSpace];
    [secondview autoSetDimension:(ALDimensionHeight) toSize:_lsc_tf_height];
    [secondview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:firstview];
    
    UIImageView* secondIcon = [[UIImageView alloc]initWithImage:IMAGE(@"land_password")];
    [secondIcon sizeToFit];
    [secondview addSubview:secondIcon];
    [secondIcon autoSetDimensionsToSize:secondIcon.size];
    [secondIcon autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [secondIcon autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
    
    secondTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, 0, XYScreenWidth/2+20, InputHeight)];
    //secondTF.borderStyle = UITextBorderStyleRoundedRect;
    //    secondTF.backgroundColor = [UIColor redColor];
    [secondTF setBackground:IMAGE(TFIMG)];
    secondTF.placeholder = @"请输入验证码";
    secondTF.keyboardType = UIKeyboardTypeNumberPad;
    //[self.view addSubview:secondTF];
    [secondview addSubview:secondTF];
    [self.secondTF autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:secondIcon withOffset:_jmsize_10];
    [self.secondTF autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [self.secondTF autoSetDimension:(ALDimensionHeight) toSize:self.secondTF.height];
    [self.secondTF autoSetDimension:(ALDimensionWidth) toSize:self.secondTF.width];
    
    UIView* secondline = [UIView new];
    secondline.backgroundColor = FNHomeBackgroundColor;
    [secondview addSubview:secondline];
    [secondline autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeTop)];
    [secondline autoSetDimension:(ALDimensionHeight) toSize:1];
    
    //获取验证码按钮
   // getBtn = [[JKCountDownButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(secondTF.frame)+5, CGRectGetMaxY(firstTF.frame)+20, XYScreenWidth/3, InputHeight)];
    getBtn = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    [getBtn.layer setMasksToBounds:YES];
    [getBtn.layer setCornerRadius:25/2];//设置矩形四个圆角半径
    [getBtn.layer setBorderWidth:1];//设置边界的宽度
    //设置按钮的边界颜色
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){225/255,225/255,225/255,0.1});
    [getBtn.layer setBorderColor:color];
    [getBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //    getBtn.backgroundColor = [UIColor redColor];
    getBtn.titleLabel.font =kFONT13;
    getBtn.tag = 1;
    [getBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [getBtn sizeToFit];
    getBtn.size = CGSizeMake(getBtn.width+_jmsize_10*2, 25);
    //[self.view addSubview:getBtn];
    [secondview addSubview:getBtn];
    [getBtn autoSetDimension:(ALDimensionHeight) toSize:getBtn.height];
    [getBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [getBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [getBtn autoSetDimension:(ALDimensionWidth) toSize:getBtn.width];
    
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(secondview.frame)+15, InputWidth, InputHeight)];
    [confirmBtn.layer setMasksToBounds:YES];
    [confirmBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = kFONT15;
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    confirmBtn.backgroundColor = RED;
    [confirmBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.tag = 2;
    [self.view addSubview:confirmBtn];
    [confirmBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:secondview withOffset:_jmsize_10*2];
    [confirmBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:LeftSpace];
    [confirmBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:LeftSpace];
}
#pragma mark - request
- (FNRequestTool *)requestCombined{
    [SVProgressHUD show];
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":self.token,@"phone":firstTF.text,@"captch":secondTF.text,}];
    if ([fourthTF.text kr_isNotEmpty]) {
        params[@"tgid"] = fourthTF.text;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_zhgl&ctrl=hb_doing" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //
        [SVProgressHUD dismiss];
        [[NSUserDefaults standardUserDefaults] setValue:self.token forKey:XYAccessToken];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        XYTabBarViewController *mainCtrl = [XYTabBarViewController mainViewController];
        [UIApplication sharedApplication].delegate.window.rootViewController = mainCtrl;
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
-(void)postUserInfo{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"tid":fourthTF.text,
                                                                                 
                                                                                 @"phone":firstTF.text,
                                                                                 @"token":self.token          }];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_updateUser successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            
            [SVProgressHUD dismiss];
            //            [FNTipsView showTips:@"修改成功"];
            [[NSUserDefaults standardUserDefaults] setValue:self.token forKey:XYAccessToken];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            XYTabBarViewController *mainCtrl = [XYTabBarViewController mainViewController];
            [UIApplication sharedApplication].delegate.window.rootViewController = mainCtrl;
            
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
//delegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (![firstTF.text kr_isNotEmpty]) {
        getBtn.enabled = YES;
        
    }else{
        getBtn.enabled = NO;
        
    }
    
    
}
-(void)getcodeMethod{
    getBtn.enabled = NO;
    NSNumber *check;
    if ([self.type  isEqual: @2]) {
        check = @1;
    }else{
        check = @0;
    }
    //Type类型 1.手机 2.邮箱
    if (![self checkInput]) {
        getBtn.enabled = YES;
        //        [Tools showMessage:@"请输入手机号码"];
        
    }else{

        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"username":firstTF.text,@"time":[NSString GetNowTimes],@"type":@1, @"source":@"phone_update"}];
        if (_source_type) {
            params[@"source"] = _source_type;
        }
        params[SignKey] = [NSString getSignStringWithDictionary:params];
        [FNTipsView showTips:@"正在获取验证码..."];
        [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_mine_getcode successBlock:^(id responseBody) {
            NSDictionary *dict = responseBody;
            XYLog(@"responseBody2 is %@",responseBody);
            if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
                
                [FNTipsView showTips:@"验证码已下发,请注意查收"];
                [self secondAction:getBtn];
            }else
            {    getBtn.enabled = YES;

                if ([[dict objectForKey:XYMessage] isEqualToString:@"该用户已被注册"]) {
                    [KVNProgress showErrorWithStatus:@"该手机号已被绑定!"];

                }else{
                    [KVNProgress showErrorWithStatus:[dict objectForKey:XYMessage]];

                }

                [XYNetworkAPI cancelAllRequest];
            }
            
            
        } failureBlock:^(NSString *error) {
            XYLog(@" error is %@",error);
            getBtn.enabled = YES;

            [SVProgressHUD dismiss];
            [XYNetworkAPI cancelAllRequest];
        }];
    }
    
}

- (BOOL)checkInput {
    
    
    if (![firstTF.text kr_isNotEmpty]) {
        [FNTipsView showTips:@"请输入手机号码"];
        [firstTF kr_shake];
        return false;
    }
    if (![firstTF.text kr_isPhoneNumber]) {
        [FNTipsView showTips:@"请输入正确的手机号码格式"];
        return false;
    }
    return true;
}
-(BOOL)checkcodeMethod
{
    
    
    if (![self checkInput]) {
        
        //        [Tools showMessage:@"请输入手机号码"];
        
    }else if (![secondTF.text kr_isNotEmpty]){
        [FNTipsView showTips:@"请输入验证码"];
        [secondTF kr_shake];
    }else if ([[FNBaseSettingModel settingInstance].extendreg isEqualToString:@"1"] && ![fourthTF.text kr_isNotEmpty]){
        [FNTipsView showTips:@"请输入推荐人ID"];
        [thirdTF kr_shake];
        
    }
    else{
    
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":self.token,@"phone":firstTF.text,@"time":[NSString GetNowTimes],@"captch":secondTF.text}];
        if ([fourthTF.text kr_isNotEmpty]) {
            params[@"tgid"] = fourthTF.text;
        }
        params[SignKey] = [NSString getSignStringWithDictionary:params];
        [FNTipsView showTips:@"正在验证验证码..."];
        [[XYNetworkAPI sharedManager] postResultWithParameter:params url:@"mod=appapi&act=dg_zhgl&ctrl=checkPhone" successBlock:^(id responseBody) {
            NSDictionary *dict = responseBody;
            XYLog(@"responseBody2 is %@",responseBody);
            if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
                NSDictionary* pa = dict[DataKey];
                if ([NSString checkIsSuccess:pa[@"is_bangding"] andElement:@"1"]) {
//                    [self postUserInfo];
                
                    FNAlertWithImgView * alert = [FNAlertWithImgView alertWithTitle:@"此手机号已注册，是否要将账号合并" content:@"合并后将同步订单/物流信息" firstTitle:@"确定合并" andSecondTitle:@"取消" topImg:@"relation_warn" clickBlock:^(NSInteger index) {
                        if (index == 0) {
                            //
                            [self requestCombined];
                        }
                    }];
                    [alert.firstButton setTitleColor:FNMainGobalTextColor forState:(UIControlStateNormal)];
                    [alert.secondButton setTitleColor:FNMainGobalTextColor forState:(UIControlStateNormal)];
                    [alert showAlert];
                }else{
                    [SVProgressHUD dismiss];
                    [FNTipsView showTips:@"绑定成功"];
                    [[NSUserDefaults standardUserDefaults] setValue:self.token forKey:XYAccessToken];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    XYTabBarViewController *mainCtrl = [XYTabBarViewController mainViewController];
                    [UIApplication sharedApplication].delegate.window.rootViewController = mainCtrl;
                }
                
                
                [SVProgressHUD dismiss];
                _isConfirm = YES;
                
                
                
            }else
            {
                _isConfirm = NO;
                
                [XYNetworkAPI queryFinishTip:dict];
                [XYNetworkAPI cancelAllRequest];
            }
            
            
        } failureBlock:^(NSString *error) {
            [SVProgressHUD dismiss];
            [XYNetworkAPI cancelAllRequest];
        }];
        
    }
    
    return _isConfirm;
}


-(void)clickBtnMethod:(UIButton *)sender
{
    
    NSInteger tag = sender.tag;
    if (tag == 1) {
        XYLog(@"获取验证码");
        
        [self getcodeMethod];
        
    }else if (tag == 2){
        XYLog(@"确定手机");
        [self checkcodeMethod];
        
    }
}
//倒计时
- (void)secondAction:(JKCountDownButton *)sender{
    sender.enabled = NO;
    //button type要 设置成custom 否则会闪动
    [sender startWithSecond:60];
    [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
        NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
        return title;
    }];
    [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        return @"点击重新获取";
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - api request
- (FNRequestTool *)apiRequestTop{
    return [FNRequestTool requestWithParams:nil api:@"mod=appapi&act=dg_app_updatestr&ctrl=bindPhone" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //
        NSDictionary* dict = respondsObject[DataKey];
        bind_phone_str=dict[@"bind_phone_str"];
        [self initPhoneRegisterView];
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}

@end
