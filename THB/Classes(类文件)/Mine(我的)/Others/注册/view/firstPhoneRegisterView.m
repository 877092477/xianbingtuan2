//
//  firstPhoneRegisterView.m
//  THB
//
//  Created by zhongxueyu on 16/3/29.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "firstPhoneRegisterView.h"
#import "SizeMacros.h"
#import "SecondPhoneRegisterVC.h"
#import "UIView+KRKit.h"
#import "JKCountDownButton.h"
#import "NSString+KRKit.h"
@interface firstPhoneRegisterView ()


@property (nonatomic,strong) UITextField *secondTF;

//获取验证码按钮
//@property (nonatomic,strong) UIButton *getBtn;
@property (strong, nonatomic)  JKCountDownButton *getBtn;
@property (nonatomic,assign) BOOL isConfirm;



@end
@implementation firstPhoneRegisterView
@synthesize firstTF,secondTF,getBtn;
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initPhoneRegisterView];
    }
    return self;
}

-(void)initPhoneRegisterView{
    
    
    CGFloat _lsc_tf_height = 54.0f;
    
    UIView* firstview = [UIView new];
    firstview.frame=CGRectMake(LeftSpace, LeftSpace, InputWidth, _lsc_tf_height);
    [self addSubview:firstview];
    
    UIImageView* firstIcon = [[UIImageView alloc]initWithImage:IMAGE(@"land_accout")];
    [firstIcon sizeToFit];
    [firstview addSubview:firstIcon];
    [firstIcon autoSetDimensionsToSize:firstIcon.size];
    [firstIcon autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [firstIcon autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
    
    firstTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, LeftSpace, InputWidth, InputHeight)];
    //firstTF.borderStyle = UITextBorderStyleRoundedRect;
    //[firstTF setBackground:IMAGE(TFIMG)];
    firstTF.placeholder = @"请输入手机号";
    firstTF.keyboardType = UIKeyboardTypePhonePad;
    //[self addSubview:firstTF];
    [firstview addSubview:firstTF];
    [self.firstTF autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:firstIcon withOffset:_jmsize_10];
    [self.firstTF autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    [self.firstTF autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [self.firstTF autoSetDimension:(ALDimensionHeight) toSize:self.firstTF.height];
    
    UIView* firstline = [UIView new];
    firstline.backgroundColor = FNHomeBackgroundColor;
    [firstview addSubview:firstline];
    [firstline autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeTop)];
    [firstline autoSetDimension:(ALDimensionHeight) toSize:1];
    
     
    UIView* secondview = [UIView new];
    [self addSubview:secondview];
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
    
    
    secondTF = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, LeftSpace, XYScreenWidth/2+20, InputHeight)];
    //secondTF.borderStyle = UITextBorderStyleRoundedRect;
    //    secondTF.backgroundColor = [UIColor redColor];
    [secondTF setBackground:IMAGE(TFIMG)];
    secondTF.placeholder = @"请输入验证码";
    secondTF.keyboardType = UIKeyboardTypeNumberPad;
    //[self addSubview:secondTF];
    [secondview addSubview:self.secondTF];
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
    //getBtn = [[JKCountDownButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(secondTF.frame)+5, CGRectGetMaxY(firstTF.frame)+20, XYScreenWidth/3, 25)];
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
    getBtn.titleLabel.font = kFONT13;
    getBtn.tag = 1;
    [getBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    //[self addSubview:getBtn];
    [getBtn sizeToFit];
    getBtn.size = CGSizeMake(getBtn.width+_jmsize_10*2, 25);
    [secondview addSubview:getBtn];
    [getBtn autoSetDimension:(ALDimensionHeight) toSize:getBtn.height];
    [getBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [getBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [getBtn autoSetDimension:(ALDimensionWidth) toSize:getBtn.width];
    
    
    self.confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(secondview.frame)+15, InputWidth, InputHeight)];
    [self.confirmBtn.layer setMasksToBounds:YES];
    [self.confirmBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    //[confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.confirmBtn.titleLabel.font = kFONT15;
    self.confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    //confirmBtn.backgroundColor = RED;
    [self.confirmBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.confirmBtn.tag = 2;
    [self addSubview:self.confirmBtn];
    [self.confirmBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:secondview withOffset:_jmsize_10*2];
    [self.confirmBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:LeftSpace];
    [self.confirmBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:LeftSpace];
    [self.confirmBtn autoSetDimension:(ALDimensionHeight) toSize:self.confirmBtn.height];
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
    NSNumber *check;
    if ([self.type  isEqual: @2]) {
        check = @1;
    }else{
        check = @0;
    }
    //Type类型 1.手机 2.邮箱
    if (![self checkInput]) {
        
//        [Tools showMessage:@"请输入手机号码"];
        
    }else{
        NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"username":firstTF.text,
                                                                                     @"time":[NSString GetNowTimes],
                                                                                     @"type":@1,
                                                                                     @"check":check,
                                                                                     @"is_forget":@(self.is_forget),
                                                                                     @"source": @"phone_reg "
                                                                                     }];
        param[SignKey] = [NSString getSignStringWithDictionary:param];
        [FNTipsView showTips:@"正在获取验证码..."];
        [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_getcode successBlock:^(id responseBody) {
            NSDictionary *dict = responseBody;
            XYLog(@"responseBody2 is %@",responseBody);
            [SVProgressHUD dismiss];
            if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
                [FNTipsView showTips:@"验证码已下发,请注意查收"];
                [self secondAction:getBtn];
            }else
            {
                [FNTipsView showTips:dict[@"msg"]];
                [XYNetworkAPI queryFinishTip:dict];
                [XYNetworkAPI cancelAllRequest];
            }
            
            
        } failureBlock:^(NSString *error) {
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
    }
    else{
        NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"username":firstTF.text,
                                                                                     @"time":[NSString GetNowTimes],
                                                                                     @"captch":secondTF.text                     }];
        param[SignKey] = [NSString getSignStringWithDictionary:param];
        [FNTipsView showTips:@"正在验证验证码..."];
        [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_checkcode successBlock:^(id responseBody) {
            NSDictionary *dict = responseBody;
            [SVProgressHUD dismiss];
            XYLog(@"responseBody2 is %@",responseBody);
            if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
                _isConfirm = YES;
                [self.delegate OnClickBtn:firstTF.text];
            }else
            {
                _isConfirm = NO;
                [FNTipsView showTips:dict[@"msg"]];
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
//        if ([self checkcodeMethod]) {
////            [self.delegate OnClickBtn:firstTF.text];
//        }else{
//
//        }
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

@end
