//
//  FNdisExTopUpController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdisExTopUpController.h"
#import "FNdisExTopUpListController.h"
#import "FNCustomeNavigationBar.h"
#import "FNdisExTopUpModel.h"
#import <AlipaySDK/AlipaySDK.h>
@interface FNdisExTopUpController ()<UITextFieldDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *priceLB;
@property (nonatomic, strong)UITextField  *compileField;
@property (nonatomic, strong)UILabel   *topUpTitleLB;
@property (nonatomic, strong)UILabel   *payTitleLB;
@property (nonatomic, strong)UILabel   *payLB;
@property (nonatomic, strong)UIButton  *verifyBtn;

@property (nonatomic, strong)FNdisExTopUpModel *dataModel;

@property (nonatomic, strong)NSString *payType;
@property (nonatomic, strong)NSString *money;
@property (nonatomic, strong)NSString *codeString;
@end

@implementation FNdisExTopUpController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - set top views
- (void)setTopViews{
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.view addSubview:self.navigationView];
    [self.view bringSubviewToFront:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 18);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.rightBtn setTitle:@"充值记录" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightBtn sizeToFit];
    self.rightBtn.size = CGSizeMake(self.rightBtn.width+10, self.rightBtn.height+10);
    self.navigationView.rightButton = self.rightBtn;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.navigationView.titleLabel.text=self.keyWord?self.keyWord:@"充值";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.leftBtn.imageView.sd_layout
    .centerYEqualToView(self.leftBtn).widthIs(8).heightIs(16).leftSpaceToView(self.leftBtn, 10);
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightButtonAction{
    FNdisExTopUpListController *vc=[[FNdisExTopUpListController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - set up views
- (void)jm_setupViews{
    [self setTopViews];
    self.view.backgroundColor=RGB(250, 250, 250);
    
    UIView *bgView=[[UIView alloc]init];
    [self.view addSubview:bgView];
    bgView.backgroundColor=[UIColor whiteColor];
    
    self.titleLB=[[UILabel alloc]init];
    [bgView addSubview:self.titleLB];
    
    self.priceLB=[[UILabel alloc]init];
    [bgView addSubview:self.priceLB];
    
    UIView *oneline=[UIView new];
    oneline.backgroundColor=RGB(240, 240, 240);
    [bgView addSubview:oneline];
    
    UIView *twoline=[UIView new];
    twoline.backgroundColor=RGB(240, 240, 240);
    [bgView addSubview:twoline];
    
    self.topUpTitleLB=[[UILabel alloc]init];
    [bgView addSubview:self.topUpTitleLB];
    
    self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(110, 142,FNDeviceWidth-120, 30)];
    self.compileField.delegate=self;
    self.compileField.font = kFONT15; 
    self.compileField.keyboardType = UIKeyboardTypeDecimalPad;//UIKeyboardTypePhonePad;
    self.compileField.textAlignment=NSTextAlignmentRight;
    [bgView addSubview:self.compileField];
    [self.compileField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.payTitleLB=[[UILabel alloc]init];
    [bgView addSubview:self.payTitleLB];
    
    self.payLB=[[UILabel alloc]init];
    [bgView addSubview:self.payLB];
    
    self.verifyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.verifyBtn]; 
    self.verifyBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    self.verifyBtn.cornerRadius=25;
    
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(102, 102, 102);
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    
    self.priceLB.font=[UIFont systemFontOfSize:24];
    self.priceLB.textColor=RGB(51, 51, 51);
    self.priceLB.textAlignment=NSTextAlignmentCenter;
    
    self.topUpTitleLB.font=[UIFont systemFontOfSize:15];
    self.topUpTitleLB.textColor=RGB(51, 51, 51);
    self.topUpTitleLB.textAlignment=NSTextAlignmentLeft;
    
    self.payTitleLB.font=[UIFont systemFontOfSize:15];
    self.payTitleLB.textColor=RGB(51, 51, 51);
    self.payTitleLB.textAlignment=NSTextAlignmentLeft;
    
    self.payLB.font=[UIFont systemFontOfSize:15];
    self.payLB.textColor=RGB(51, 51, 51);
    self.payLB.textAlignment=NSTextAlignmentRight;
    
    [self.verifyBtn addTarget:self action:@selector(verifyBtnClick)];
    
    CGFloat bgTopGap=SafeAreaTopHeight+26;
    bgView.sd_layout
    .leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, bgTopGap).heightIs(243);
    
    self.titleLB.sd_layout
    .leftSpaceToView(bgView, 15).topSpaceToView(bgView, 19).rightSpaceToView(bgView, 15).heightIs(20);
    
    self.priceLB.sd_layout
    .leftSpaceToView(bgView, 15).topSpaceToView(self.titleLB, 18).rightSpaceToView(bgView, 15).heightIs(30);
    
    oneline.sd_layout
    .leftSpaceToView(bgView, 0).topSpaceToView(bgView, 125).rightSpaceToView(bgView, 0).heightIs(1);
    
    twoline.sd_layout
    .leftSpaceToView(bgView, 15).topSpaceToView(bgView, 184).rightSpaceToView(bgView, 0).heightIs(1);
    
    self.topUpTitleLB.sd_layout
    .leftSpaceToView(bgView, 15).topSpaceToView(oneline, 18).widthIs(90).heightIs(20);
    
    self.compileField.sd_layout
    .rightSpaceToView(bgView, 15).centerYEqualToView(self.topUpTitleLB).leftSpaceToView(self.topUpTitleLB, 10).heightIs(30);
    
    self.payTitleLB.sd_layout
    .leftSpaceToView(bgView, 15).topSpaceToView(twoline, 18).widthIs(100).heightIs(20);
    
    self.payLB.sd_layout
    .rightSpaceToView(bgView, 15).topSpaceToView(twoline, 18).widthIs(100).heightIs(20);
    
    self.verifyBtn.sd_layout
    .leftSpaceToView(self.view, 28).topSpaceToView(bgView, 26).rightSpaceToView(self.view, 28).heightIs(50);
    
    if([UserAccessToken kr_isNotEmpty]){
       [self requestRecharge];
       
    }
}
#pragma mark - //编辑
- (void)textFieldDidChange:(id)sender{
    UITextField *field = (UITextField *)sender;
    self.money=field.text;
    if([self.money kr_isNotEmpty]){
        [self.verifyBtn setTitleColor:[UIColor colorWithHexString:self.dataModel.qkb_qr_check_fcolor] forState:UIControlStateNormal];
        [self.verifyBtn sd_setBackgroundImageWithURL:URL(self.dataModel.qkb_qr_check_btn) forState:UIControlStateNormal];
    }else{
        [self.verifyBtn setTitleColor:[UIColor colorWithHexString:self.dataModel.qkb_qr_fcolor] forState:UIControlStateNormal];
        [self.verifyBtn sd_setBackgroundImageWithURL:URL(self.dataModel.qkb_qr_btn) forState:UIControlStateNormal];
    }
}
-(void)verifyBtnClick{
    if([self.money kr_isNotEmpty]){
        CGFloat moneyFloat=[self.money floatValue];
        if(moneyFloat==0 || moneyFloat<0){
            [FNTipsView showTips:@"请输入正确的信息"];
            return;
        }
       [self.compileField resignFirstResponder];
       [self requestReleaseOrder];
    }else{
       [FNTipsView showTips:@"请输入金额"];
    }
}
-(FNRequestTool*)requestRecharge{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=qkb&ctrl=commission_recharge_page" respondType:(ResponseTypeModel) modelType:@"FNdisExTopUpModel" success:^(id respondsObject) {
        @strongify(self);
        self.dataModel=respondsObject;
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}
#pragma mark - //余额充值
-(FNRequestTool*)requestReleaseOrder{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.money kr_isNotEmpty]){
        params[@"money"]=self.money;
    }
    if([self.payType kr_isNotEmpty]){
        params[@"type"]=self.payType;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=commission_recharge&ctrl=commission_recharge" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //XYLog(@"充值%@",respondsObject);
        @strongify(self);
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        NSDictionary* dataDic = respondsObject[DataKey];
        NSString *codeStr=dataDic[@"code"];
        self.codeString=codeStr;
        if(state==1){
            if([self.payType isEqualToString:@"zfb"]){
                if([self.codeString kr_isNotEmpty]){
                   [self startTendPayment];
                }
            }
        }
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}
//支付宝支付
-(void)startTendPayment{
    //XYLog(@"tendCodeString:%@",self.codeString);
    [[AlipaySDK defaultService] payOrder:self.codeString fromScheme:AlisdkSchemes callback:^(NSDictionary *resultDic) {
        //XYLog(@"支付:%@",resultDic);
        if ([NSString checkIsSuccess:resultDic[@"resultStatus"] andElement:@"9000"] ) {
            [FNTipsView showTips:ResultStatusDict[@"9000"]];
            if ([self.delegate respondsToSelector:@selector(didDisExTopUpStateAction)]) {
                [self.delegate didDisExTopUpStateAction];
            } 
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [FNTipsView showTips:ResultStatusDict[resultDic[@"resultStatus"] ] withDuration:2.0];
        }
    }];
}

-(void)setDataModel:(FNdisExTopUpModel *)dataModel{
    _dataModel=dataModel;
    if(dataModel){
        self.payType=dataModel.pay_type;
        self.navigationView.titleLabel.text=dataModel.title;
        self.titleLB.text=dataModel.commission_tips;
        self.priceLB.text=dataModel.commission;
        self.topUpTitleLB.text=dataModel.money_tips;
        self.compileField.placeholder=@"请输入金额";
        self.payTitleLB.text=dataModel.pay_tips;
        self.payLB.text=dataModel.pay_type_font;
        [self.verifyBtn setTitle:dataModel.btn_font forState:UIControlStateNormal];
        [self.verifyBtn setTitleColor:[UIColor colorWithHexString:dataModel.qkb_qr_fcolor] forState:UIControlStateNormal];
        [self.verifyBtn sd_setBackgroundImageWithURL:URL(dataModel.qkb_qr_btn) forState:UIControlStateNormal];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //限制只能输入数字
    BOOL isHaveDian = YES;
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }
    if ([string length] > 0) {
        unichar single = [string characterAtIndex:0];//当前输入的字符
        
        if ((single >= '0' && single <= '9') || single == '.') {
            //数据格式正确
            if([textField.text length] == 0){
                if(single == '.') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            //输入的字符是否是小数点
            if (single == '.') {
                if(!isHaveDian) {
                    //text中还没有小数点
                    isHaveDian = YES;
                    return YES;
                }else{
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                //存在小数点
                if (isHaveDian) {
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    if (range.location - ran.location <= 2) {
                        return YES;
                    }else{
                        return NO;
                    }
                }else{
                    return YES;
                }
            }
        }else{
            //输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
    
    
    return YES;
}
@end
