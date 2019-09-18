//
//  FNTeOddpayDaNeController.m
//  69橙子
//
//  Created by Jimmy on 2018/11/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//付款
#import "FNTeOddpayDaNeController.h"
#import "FNTeOddEnsureNeController.h"
#import "FNshopTendPlazaNeController.h"
//其他
#import <AlipaySDK/AlipaySDK.h>
#import "FNUpPaymodelNeView.h"
#import "WXApi.h"

@interface FNTeOddpayDaNeController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField*ratedTF;
@property(nonatomic,strong)UILabel *estimateLb;
@property(nonatomic,strong)UIButton *confirmBtn;
@property(nonatomic,strong)NSString *tendCodeString;
@end

@implementation FNTeOddpayDaNeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"付款";
    self.view.backgroundColor=RGB(246, 246, 246);
    [self constructView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWxSuccess) name:@"Wx_Resp_Success" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)constructView{
    //CGFloat spaceeHeight=SafeAreaTopHeight+20;
    
    FNstoreInformationDaModel *model=[FNstoreInformationDaModel mj_objectWithKeyValues:self.storeDictry];
    CGFloat spaceeHeight=20;
    UIView *whiteBgView=[[UIView alloc]init];
    whiteBgView.frame=CGRectMake(20, spaceeHeight, FNDeviceWidth-40, 250);
    whiteBgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:whiteBgView];
    whiteBgView.sd_layout
    .widthIs(330).heightIs(260).centerXEqualToView(self.view).topSpaceToView(self.view, spaceeHeight);
    
    UIImageView *storeImageView=[[UIImageView alloc]init];
    //storeImageView.backgroundColor=[UIColor lightGrayColor];
    [storeImageView setUrlImg:model.img];
    [whiteBgView addSubview:storeImageView];
    storeImageView.sd_layout
    .widthIs(62).heightIs(62).centerXEqualToView(whiteBgView).topSpaceToView(whiteBgView, 30);
    
    UILabel *storeName=[[UILabel alloc]init];
    //storeName.backgroundColor=[UIColor lightGrayColor];
    storeName.textAlignment=NSTextAlignmentCenter;
    storeName.font=kFONT17;
    storeName.text=model.name;//@"中影国际影城";
    [whiteBgView addSubview:storeName];
    storeName.sd_layout
    .topSpaceToView(storeImageView, 20).heightIs(25).leftSpaceToView(whiteBgView, 20).rightSpaceToView(whiteBgView, 20);
    
    UIView *exportView=[[UIView alloc]init];
    //exportView.backgroundColor=[UIColor lightGrayColor];
    [whiteBgView addSubview:exportView];
    exportView.sd_layout
    .leftSpaceToView(whiteBgView, 20).rightSpaceToView(whiteBgView, 20).bottomSpaceToView(whiteBgView, 30).heightIs(50);
    
    UILabel *wordLb=[[UILabel alloc]init];
    wordLb.text=@"¥";
    wordLb.font=kFONT17;
    //wordLb.backgroundColor=[UIColor whiteColor];
    [exportView addSubview:wordLb];
    wordLb.sd_layout
    .leftEqualToView(exportView).heightIs(25).widthIs(25).centerYEqualToView(exportView);
    
    UITextField*ratedTF = [[UITextField alloc]initWithFrame:CGRectMake(30, 10, 150, 30)];
    wordLb.backgroundColor=[UIColor whiteColor];
    ratedTF.delegate=self;
    ratedTF.placeholder = @"请输入金额";
    //ratedTF.keyboardType = UIKeyboardTypePhonePad;
    [exportView addSubview:ratedTF];
    self.ratedTF=ratedTF;
    ratedTF.sd_layout.centerYEqualToView(exportView).leftSpaceToView(wordLb, 0).rightSpaceToView(exportView, 10).heightIs(30);
    
    UILabel *lineLb=[[UILabel alloc]init];
    lineLb.backgroundColor=RGB(237, 237, 237);
    [exportView addSubview:lineLb];
    lineLb.sd_layout
    .bottomSpaceToView(exportView, 0).leftEqualToView(exportView).rightEqualToView(exportView).heightIs(1);
    
    UILabel *estimateLb=[[UILabel alloc]init];
    //estimateLb.backgroundColor=[UIColor lightGrayColor];
    estimateLb.font=kFONT13;
    estimateLb.textColor=RGB(219, 76, 70);
    estimateLb.text=@"";
    [whiteBgView addSubview:estimateLb];
    self.estimateLb=estimateLb;
    estimateLb.sd_layout
    .bottomSpaceToView(whiteBgView, 5).heightIs(20).leftSpaceToView(whiteBgView, 20).rightSpaceToView(whiteBgView, 20);
    
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20+250+20 , FNDeviceWidth-40, 50)];
    [confirmBtn.layer setMasksToBounds:YES];
    [confirmBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = kFONT16;
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    confirmBtn.backgroundColor = RGB(128, 127, 128);
    [confirmBtn addTarget:self action:@selector(clickBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    self.confirmBtn=confirmBtn;
    confirmBtn.sd_layout
    .topSpaceToView(whiteBgView, 20).leftEqualToView(whiteBgView).rightEqualToView(whiteBgView).heightIs(50);
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textField4 - 结束编辑");
    [self apiRequestPresentOrderShow];
}
#pragma mark -  //输入金额付款页面
- (FNRequestTool *)apiRequestPresentOrderShow{
    //@WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"store_id":self.storeID}];
    if([self.ratedTF.text kr_isNotEmpty]){
        params[@"money"]=self.ratedTF.text;
        self.confirmBtn.backgroundColor = RGB(246, 51, 40);
    }else{
        self.confirmBtn.backgroundColor = RGB(128, 127, 128);
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_underLinePay&ctrl=show_pay" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"小店显示:%@",respondsObject);
        NSDictionary* dataDic = respondsObject[DataKey];
        self.estimateLb.text=dataDic[@"str"];//@"¥";
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark -  输入金额付款操作

- (FNRequestTool *)apiRequestPayType{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_suborder&ctrl=pay_type" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        NSArray *array = respondsObject;
        
        [FNUpPaymodelNeView showWithTitles:array selectIndex:^(NSInteger selectIndex) {
            XYLog(@"选择:%ld",(long)selectIndex);
            NSString *type = array[selectIndex][@"type"];
            if ([type isEqualToString:@"yue"]) {
                
                [self startYuePayment: self.ratedTF.text];
            } else {
                [self apiRequestZFB: type];
            }
        }];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

- (FNRequestTool *)apiRequestZFB: (NSString*)payType{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"type":@"zfb"}];
    if([self.ratedTF.text kr_isNotEmpty]){
        params[@"money"]=self.ratedTF.text;
    }
    if([self.storeID kr_isNotEmpty]){
        params[@"store_id"]=self.storeID;
    }
    if([payType kr_isNotEmpty]){
        params[@"type"]=payType;
    }
    @weakify(self)
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_underLinePay&ctrl=app_payment" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        XYLog(@"支付宝付款结果:%@",respondsObject);
        NSDictionary* dataDic = respondsObject[DataKey];
        if ([payType isEqualToString: @"zfb"]) {
            NSString *codeString=dataDic[@"code"];
            self.tendCodeString=codeString;
            [self startTendPayment];
        } else if ([payType isEqualToString: @"wx"]){
            [self startWxPayment: dataDic];
        } else if ([payType isEqualToString: @"yue"]){
        }
        
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
//支付宝支付
-(void)startTendPayment{
    //NSLog(@"tendCodeString:%@",self.tendCodeString);
    [[AlipaySDK defaultService] payOrder:self.tendCodeString fromScheme:AlisdkSchemes callback:^(NSDictionary *resultDic) {
        XYLog(@"支付:%@",resultDic);
        if ([NSString checkIsSuccess:resultDic[@"resultStatus"] andElement:@"9000"] ) {
            [FNTipsView showTips:ResultStatusDict[@"9000"]];
            [self backViewControllerType];
        }else{
            [SVProgressHUD dismiss];
            [FNTipsView showTips:ResultStatusDict[resultDic[@"resultStatus"] ] withDuration:2.0];
            [self backViewControllerType];
        }
    }];
}


// 微信支付
- (void)startWxPayment:(NSDictionary*) dataDic {
    NSString *partnerid = dataDic[@"partnerid"];
    NSString *nonce_str = dataDic[@"noncestr"];
    NSString *prepay_id = dataDic[@"prepayid"];
    NSString *sign = dataDic[@"sign"];
    NSString *timeStamp = dataDic[@"timestamp"];
    
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = partnerid;
    request.prepayId= prepay_id;
    request.package = @"Sign=WXPay";
    request.nonceStr= nonce_str;
    request.timeStamp= timeStamp.intValue;
    
    request.sign= sign;
    [WXApi sendReq: request];
}

- (void)onWxSuccess {
    
    [self backViewControllerType];
}

- (void)startYuePayment: (NSString*)money {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"type":@"yue"}];
    if([money kr_isNotEmpty]){
        params[@"money"]=money;
    }
    if([self.storeID kr_isNotEmpty]){
        params[@"store_id"]=self.storeID;
    }
    @weakify(self)
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_underLinePay&ctrl=yue_payment" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        if ([respondsObject isEqualToString:@"1"]) {
            [FNTipsView showTips:@"支付成功"];
            [self backViewControllerType];
        }
        
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

-(void)backViewControllerType{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[FNshopTendPlazaNeController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
-(void)clickBtnMethod{
    if(![self.ratedTF.text kr_isNotEmpty]){
        [FNTipsView showTips:@"请输入金额"];
    }
    else if(![NSString isEmpty:UserAccessToken]){
//         [self apiRequestZFB];
        [self.ratedTF resignFirstResponder];
        [self apiRequestPayType];
    }
    
    //FNTeOddEnsureNeController *vc=[[FNTeOddEnsureNeController alloc]init];
    //[self.navigationController pushViewController:vc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
