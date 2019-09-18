//
//  FNPhoneCheckController.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/8/24.
//  Copyright © 2016年 jimmy. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "FNPhoneCheckController.h"
#import "FNMMInfoTipsTextField.h"
#import "JKCountDownButton.h"
#import "FNAPIMine.h"
@interface FNPhoneCheckController ()

@property (nonatomic, strong)UILabel* phoneLabel;
@property (nonatomic, weak)UITextField *checkCodeTF;

@property (nonatomic, strong) JKCountDownButton *checkCodeBtn;
@end

@implementation FNPhoneCheckController
@synthesize checkCodeBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //注册通知，绑定成功就返回到个人中心
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];

    [notiCenter addObserver:self selector:@selector(tongzhi:) name:@"EditProfile" object:nil];

    [self initializedSubviews];
}
/**
 *  接收搜索结果
 *
 *  @param noti <#noti description#>
 */
- (void)tongzhi:(NSNotification *)noti{
    XYLog(@"－－－－－修改成功------");
    [self.navigationController popViewControllerAnimated:YES];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    _phoneLabel = [UILabel new];
    _phoneLabel.font = kFONT14;
    
    _phoneLabel.text = [NSString stringWithFormat:@"您当前绑定的手机号是: %@", [UserPhone phoneHiddenPartlyWords]];
    [self.view addSubview:_phoneLabel];
    [_phoneLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(_jm_leftMargin, _jm_leftMargin, 0, _jm_leftMargin)) excludingEdge:(ALEdgeBottom)];
    
    
    UIView * line1 = [UIView new];
    line1.backgroundColor = FNHomeBackgroundColor;
    [self.view addSubview:line1];
    [line1 autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_phoneLabel withOffset:_jm_leftMargin];
    [line1 autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
    [line1 autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin];
    [line1 autoSetDimension:(ALDimensionHeight) toSize:1.0];
    
    
    
    CGFloat margin = 10;
    CGFloat btnH = 40;
    
    checkCodeBtn = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    [checkCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    checkCodeBtn.backgroundColor = FNMainGobalControlsColor;
    checkCodeBtn.cornerRadius = 5.0;
    [checkCodeBtn setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    [checkCodeBtn sizeToFit];
    checkCodeBtn.titleLabel.font = kFONT14;
    [checkCodeBtn addTarget:self action:@selector(clickToGetCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkCodeBtn];
    [checkCodeBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin];
    [checkCodeBtn autoSetDimensionsToSize:(CGSizeMake(checkCodeBtn.width+10, btnH))];
    [checkCodeBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:line1 withOffset:5];
    
    UIImageView* codeImgView = [UIImageView new];
    codeImgView.image = IMAGE(@"code");
    [codeImgView sizeToFit];
    [self.view addSubview:codeImgView];
    [codeImgView autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:line1];
    [codeImgView autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:checkCodeBtn];
    [codeImgView autoSetDimensionsToSize:codeImgView.size];
    
    
    UITextField *checkCodeTF = [[UITextField alloc]initWithFrame:CGRectMake(margin, 0, FNDeviceWidth-2*margin-checkCodeBtn.width-5, 44)];
    checkCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    checkCodeTF.font = kFONT14;
    checkCodeTF.placeholder = @"请输入验证码";
    [self.view addSubview:checkCodeTF];
    _checkCodeTF = checkCodeTF;
    [_checkCodeTF autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:codeImgView withOffset:10];
    [_checkCodeTF autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:checkCodeBtn withOffset:-10];
    [_checkCodeTF autoSetDimension:(ALDimensionHeight) toSize:btnH];
    [_checkCodeTF autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:checkCodeBtn];
    
    UIView * line2 = [UIView new];
    line2.backgroundColor = FNHomeBackgroundColor;
    [self.view addSubview:line2];
    [line2 autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_checkCodeTF withOffset:5];
    [line2 autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
    [line2 autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin];
    [line2 autoSetDimension:(ALDimensionHeight) toSize:1.0];
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.backgroundColor = FNMainGobalControlsColor;
    nextBtn.cornerRadius = 5;
    [nextBtn setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(clickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    [nextBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:line2 withOffset:_jm_leftMargin];
    [nextBtn autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:line2];
    [nextBtn autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:line2];
    [nextBtn autoSetDimension:(ALDimensionHeight) toSize:btnH];
}

- (void)clickToGetCode:(JKCountDownButton *)btn
{
    btn.enabled = NO;
    [btn setBackgroundColor:[UIColor grayColor]];

    if ([UserPhone kr_isNotEmpty]) {
        [self.view endEditing:YES];
        [SVProgressHUD show];
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"username":UserPhone,@"check":@0,TokenKey:UserAccessToken,@"type":@1}];
        if (_sourceType)
            params[@"source"] = _sourceType;
        [FNAPIMine apiMineForGetCodeWithParams:[NSMutableDictionary dictionaryWithDictionary:params]  success:^(id respondsObject) {
            [SVProgressHUD dismiss];
            [FNTipsView showTips:@"已发送验证码,请查收"];
            [self secondAction:checkCodeBtn];
        } failure:^(NSString *error) {
            [SVProgressHUD dismiss];
            btn.enabled = YES;
            btn.backgroundColor = FNMainGobalControlsColor;

        } isHidden:NO];
    }else{
        btn.enabled = YES;
        btn.backgroundColor = FNMainGobalControlsColor;

        [FNTipsView showTips:@"请先绑定手机号码"];
        
    }
    
    
}
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
        checkCodeBtn.backgroundColor = FNMainGobalControlsColor;

        return @"点击重新获取";
    }];
}
- (void)clickNextBtn
{
    if ( _checkCodeTF.text.length == 0) {
        [FNTipsView showTips:@"请输入验证码"];
        return;
    }
    
    [SVProgressHUD show];
    [self.view endEditing:YES];
    @WeakObj(self);
    [FNAPIMine apiMineForCheckCodeWithParams:[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"captch":_checkCodeTF.text,@"username":UserPhone}] success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        if (selfWeak.successCheckBlock) {
            selfWeak.successCheckBlock(_username,selfWeak);
        }
    } failure:^(NSString *error) {
        
    } isHidden:NO];
}
@end
