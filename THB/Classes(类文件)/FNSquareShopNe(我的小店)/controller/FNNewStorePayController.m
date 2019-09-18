//
//  FNNewStorePayController.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/26.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStorePayController.h"
#import "FNStorePayModel.h"
#import "FNNewStorePayAlertView.h"
#import "FNUpPaymodelNeView.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "FNStoreMyCouponeController.h"
#import "FNStoreMyCouponeModel.h"

@interface FNNewStorePayController()<UITextFieldDelegate, FNNewStorePayAlertViewDelegate, FNStoreMyCouponeControllerDelegate>

@property (nonatomic, strong) FNstoreInformationDaModel* model;
@property (nonatomic, strong) FNStorePayModel *pay;
@property (nonatomic, strong) FNStorePayConfirmModel *payConfirm;
@property (nonatomic, strong) FNStoreMyCouponeModel *redpack;
@property (nonatomic, strong) FNStoreMyCouponeModel *coupone;


@property (nonatomic, strong) UIImageView *imgLocation;
@property (nonatomic, strong) UILabel *lblLocation;
@property (nonatomic, strong) UIView *vPrice;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UITextField *txfPrice;
@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) UILabel *lblDiscount;
@property (nonatomic, strong) UITextField *txfDiscount;

@property (nonatomic, strong) UILabel *lblEstimate;

@property (nonatomic, strong) UIView *vDesc;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UITextField *txfDesc;

@property (nonatomic, strong) UIView *vInfo;
@property (nonatomic, strong) UIView *vLine1;
@property (nonatomic, strong) UILabel *lblZhekouTitle;
@property (nonatomic, strong) UILabel *lblZhekou;
@property (nonatomic, strong) UIView *vLine2;
@property (nonatomic, strong) UILabel *lblShijiTitle;
@property (nonatomic, strong) UILabel *lblShiji;
@property (nonatomic, strong) UILabel *lblInfo;

@property (nonatomic, strong) UIButton *btnPay;

@property (nonatomic, strong) NSDecimalNumber *nPrice;
@property (nonatomic, strong) NSDecimalNumber *nDiscount;

@property (nonatomic, strong) FNNewStorePayAlertView *payAlertView;

@property (nonatomic, copy) NSString *payType;

@end

@implementation FNNewStorePayController

- (FNNewStorePayAlertView *)payAlertView {
    if (_payAlertView == nil) {
        _payAlertView = [[FNNewStorePayAlertView alloc] init];
        
        _payAlertView.delegate = self;
        [self.view addSubview:_payAlertView];
        [_payAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return _payAlertView;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    _nPrice = [NSDecimalNumber decimalNumberWithString:@"0"];
    _nDiscount = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    [self configUI];
    [self requestMain];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWxSuccess) name:@"Wx_Resp_Success" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configUI{
    _imgLocation = [[UIImageView alloc] init];
    _lblLocation = [[UILabel alloc] init];
    _vPrice = [[UIView alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _txfPrice = [[UITextField alloc] init];
    _vLine = [[UIView alloc] init];
    _lblDiscount = [[UILabel alloc] init];
    _txfDiscount = [[UITextField alloc] init];
    _lblEstimate = [[UILabel alloc] init];
    _vDesc = [[UIView alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _txfDesc = [[UITextField alloc] init];
    _btnPay = [[UIButton alloc] init];
    
    [self.view addSubview:_imgLocation];
    [self.view addSubview:_lblLocation];
    [self.view addSubview:_vPrice];
    [_vPrice addSubview:_lblPrice];
    [_vPrice addSubview:_txfPrice];
    [_vPrice addSubview:_vLine];
    [_vPrice addSubview:_lblDiscount];
    [_vPrice addSubview:_txfDiscount];
    
    [self.view addSubview:_lblEstimate];
    
    [self.view addSubview:_vDesc];
    [_vDesc addSubview:_lblDesc];
    [_vDesc addSubview:_txfDesc];
    [self.view addSubview:_btnPay];
    
    _vInfo = [[UIView alloc] init];
    _vLine1 = [[UIView alloc] init];
    _lblZhekouTitle = [[UILabel alloc] init];
    _lblZhekou = [[UILabel alloc] init];
    _vLine2 = [[UIView alloc] init];
    _lblShijiTitle = [[UILabel alloc] init];
    _lblShiji = [[UILabel alloc] init];
    _lblInfo = [[UILabel alloc] init];
    
    [self.view addSubview:_vInfo];
    [_vInfo addSubview:_vLine1];
    [_vInfo addSubview:_lblZhekouTitle];
    [_vInfo addSubview:_lblZhekou];
    [_vInfo addSubview:_vLine2];
    [_vInfo addSubview:_lblShijiTitle];
    [_vInfo addSubview:_lblShiji];
    [_vInfo addSubview:_lblInfo];
    
    [_imgLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@24);
        make.top.equalTo(@13);
        
    }];
    [_lblLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.imgLocation.mas_right).offset(2);
        make.centerY.equalTo(self.imgLocation);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_vPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@18);
        make.top.equalTo(self.lblLocation.mas_bottom).offset(14);
        make.right.equalTo(@-18);
        make.height.mas_equalTo(120);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@13);
        make.centerY.equalTo(self.vPrice.mas_top).offset(30);
        make.right.lessThanOrEqualTo(self.txfPrice.mas_left).offset(-10);
    }];
    [_txfPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-13);
        make.height.mas_equalTo(24);
        make.centerY.equalTo(self.vPrice.mas_top).offset(34);
        make.width.mas_equalTo(140);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.right.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    [_lblDiscount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@13);
        make.centerY.equalTo(self.vPrice.mas_bottom).offset(-30);
        make.right.lessThanOrEqualTo(self.txfDiscount.mas_left).offset(-10);
    }];
    [_txfDiscount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-13);
        make.height.mas_equalTo(24);
        make.centerY.equalTo(self.vPrice.mas_bottom).offset(-34);
        make.width.mas_equalTo(140);
    }];
    
    [_lblEstimate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vPrice.mas_bottom).offset(6);
        make.left.equalTo(@18);
        make.right.equalTo(@-18);
    }];
    
    [_vDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblEstimate.mas_bottom).offset(6);
        make.left.equalTo(@18);
        make.right.equalTo(@-18);
        make.height.mas_equalTo(55);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@13);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(self.txfDiscount.mas_left).offset(-10);
    }];
    [_txfDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-13);
        make.height.mas_equalTo(24);
        make.centerY.equalTo(@0);
        make.width.mas_equalTo(240);
    }];
    [_btnPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vInfo.mas_bottom).offset(18);
        make.left.equalTo(@18);
        make.right.equalTo(@-18);
        
    }];
    
    _imgLocation.image = IMAGE(@"store_pay_location_image");
    
    _lblLocation.textColor = RGB(153, 153, 153);
    _lblLocation.font = kFONT12;
    
    _vPrice.layer.borderColor = RGB(240, 240, 240).CGColor;
    _vPrice.layer.borderWidth = 1;
    _vPrice.layer.backgroundColor = UIColor.whiteColor.CGColor;
    _vPrice.layer.cornerRadius = 7;
    
    _lblPrice.textColor = RGB(51, 51, 51);
    _lblPrice.font = kFONT14;
    _lblPrice.text = @"订单金额(元)";
    
    _txfPrice.placeholder = @"请询问服务员后输入";
    _txfPrice.textColor = RGB(51, 51, 51);
    _txfPrice.font = kFONT14;
    _txfPrice.textAlignment = NSTextAlignmentRight;
    
    _vLine.backgroundColor = RGB(240, 240, 240);

    _lblDiscount.textColor = RGB(51, 51, 51);
    _lblDiscount.font = kFONT14;
    _lblDiscount.text = @"不参与优惠金额(元)";
    
    _txfDiscount.placeholder = @"请询问服务员后输入";
    _txfDiscount.textColor = RGB(51, 51, 51);
    _txfDiscount.font = kFONT14;
    _txfDiscount.textAlignment = NSTextAlignmentRight;
    
    _lblEstimate.font = kFONT12;
    _lblEstimate.textColor = RGB(244, 47, 25);
    
    _vDesc.layer.borderColor = RGB(240, 240, 240).CGColor;
    _vDesc.layer.borderWidth = 1;
    _vDesc.layer.backgroundColor = UIColor.whiteColor.CGColor;
    _vDesc.layer.cornerRadius = 7;
    
    _lblDesc.textColor = RGB(51, 51, 51);
    _lblDesc.font = kFONT14;
    _lblDesc.text = @"备注";
    
    _txfDesc.placeholder = @"如包房号、服务员号等";
    _txfDesc.textColor = RGB(51, 51, 51);
    _txfDesc.font = kFONT14;
    _txfDesc.textAlignment = NSTextAlignmentRight;
    
    [_btnPay setImage: IMAGE(@"store_pay_button_normal") forState: UIControlStateNormal];
    [_btnPay setImage: IMAGE(@"store_pay_button_disable") forState: UIControlStateDisabled];
    _btnPay.enabled = NO;
    [_btnPay addTarget:self action:@selector(onPayClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self updateView];
    
    [self.txfPrice addTarget:self action:@selector(priceChange) forControlEvents:UIControlEventEditingChanged];
    [self.txfDiscount addTarget:self action:@selector(discountChange) forControlEvents:UIControlEventEditingChanged];
    [self.txfDesc addTarget:self action:@selector(descChange) forControlEvents:UIControlEventEditingChanged];
    
    self.txfPrice.keyboardType = UIKeyboardTypeDecimalPad;
    self.txfDiscount.keyboardType = UIKeyboardTypeDecimalPad;
    
    self.txfPrice.delegate = self;
    self.txfDiscount.delegate = self;
    
    [_vInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vDesc.mas_bottom).offset(12);
        make.left.equalTo(@18);
        make.right.equalTo(@-18);
        make.height.mas_equalTo(@0);
    }];
    [_vLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    [_lblZhekouTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@13);
        make.top.equalTo(@16);
        make.right.lessThanOrEqualTo(self.lblZhekou.mas_left).offset(-10);
    }];
    [_lblZhekou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-13);
        make.centerY.equalTo(self.lblZhekouTitle);
    }];
    [_vLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.vLine1.mas_bottom).offset(42);
        make.height.mas_equalTo(1);
    }];
    [_lblShijiTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@13);
        make.top.equalTo(self.vLine2).offset(16);
        make.right.lessThanOrEqualTo(self.lblShiji.mas_left).offset(-10);
    }];
    [_lblShiji mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-13);
        make.centerY.equalTo(self.lblShijiTitle);
    }];
    [_lblInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@13);
        make.top.equalTo(self.vLine2).offset(48);
        make.right.lessThanOrEqualTo(@-13);
    }];
    
    _vInfo.hidden = YES;
    
    _vLine1.backgroundColor = RGB(240, 240, 240);
    
    _lblZhekouTitle.textColor = RGB(51, 51, 51);
    _lblZhekouTitle.font = kFONT12;
    _lblZhekouTitle.text = @"折扣";
    
    _lblZhekou.textColor = RGB(51, 51, 51);
    _lblZhekou.font = [UIFont boldSystemFontOfSize:14];
    
    _vLine2.backgroundColor = RGB(240, 240, 240);
    
    _lblShijiTitle.textColor = RGB(51, 51, 51);
    _lblShijiTitle.font = kFONT12;
    _lblShijiTitle.text = @"实际付款(元)";
    
    _lblShiji.textColor = RGB(244, 47, 25);
    _lblShiji.font = [UIFont boldSystemFontOfSize:24];
    
    _lblInfo.textColor = RGB(204, 204, 204);
    _lblInfo.font = kFONT10;
}

- (void)setModel: (FNstoreInformationDaModel*)model {
    _model = model;
    [self updateView];
}

- (void)updateView {
    _lblLocation.text = _model.address;
    self.title = _model.name;
}

- (void)calcPrice {
    _lblEstimate.text = @"";
    if (_pay == nil)
        return;
    
    _btnPay.enabled = [_txfPrice.text kr_isNotEmpty];
//    _lblEstimate.text = _pay.commission_str
    
    _vInfo.hidden = ![_txfPrice.text kr_isNotEmpty];
    [_vInfo mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_vInfo.hidden ? 0 : 110);
    }];
    
    NSString *discount_bili = _pay.discount_bili;
    NSDecimalNumber *zhekou = [NSDecimalNumber decimalNumberWithString:@"1"];
    if ([discount_bili kr_isNotEmpty]) {
        NSDecimalNumber *bili = [NSDecimalNumber decimalNumberWithString:discount_bili];
        if (bili && ![bili isEqualToNumber:NSDecimalNumber.notANumber]) {
            zhekou = bili;
        }
    }
    
    if ([zhekou compare: [NSDecimalNumber decimalNumberWithString:@"0"]] == NSOrderedSame) {
        _lblZhekou.text = @"无折扣";
        zhekou = [NSDecimalNumber decimalNumberWithString:@"1"];
    } else {
        _lblZhekou.text = [NSString stringWithFormat:@"%@%%", [zhekou decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100"]]];
    }
    
    NSDecimalNumber *result = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    if ([_nPrice compare:_nDiscount] == NSOrderedAscending) {
        _nDiscount = _nPrice;
    }
    
    NSDecimalNumber *subNum = [_nPrice decimalNumberBySubtracting:_nDiscount];
    subNum = [subNum decimalNumberByMultiplyingBy:zhekou];
    subNum = [subNum decimalNumberByAdding:_nDiscount];
    
    result = subNum;
 
    NSString *commission_bili = _pay.commission_bili;
    NSDecimalNumber *commission = [NSDecimalNumber decimalNumberWithString:@"0"];
    if ([commission_bili kr_isNotEmpty]) {
        commission = [NSDecimalNumber decimalNumberWithString:commission_bili];
    }
    NSDecimalNumber *multiNum = [_nPrice decimalNumberByMultiplyingBy:commission];
    
    _lblEstimate.text = [NSString stringWithFormat:@"%@%@", _pay.commission_str, multiNum];
    _lblInfo.text = _pay.tips;
    _lblShiji.text = [NSString stringWithFormat:@"%@", result];
    
}

#pragma mark - Networking

- (void)requestMain{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"store_id": _store_id}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_underLinePay&ctrl=show_pay" respondType:(ResponseTypeModel) modelType:@"FNStorePayModel" success:^(id respondsObject) {
        @strongify(self)
        
        self.pay = respondsObject;
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES];
    
}

- (void)requestPayDetail{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"store_id": _store_id, @"money": _lblShiji.text}];
    if (_redpack) {
        params[@"red_packet_id"] = _redpack.id;
    }
    if (_coupone) {
        params[@"yhq_id"] = _coupone.id;
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_underLinePay&ctrl=show_pay_confirm" respondType:(ResponseTypeModel) modelType:@"FNStorePayConfirmModel" success:^(id respondsObject) {
        @strongify(self)
        
        self.payConfirm = respondsObject;
        [self.payAlertView setPay:respondsObject];
        [self.payAlertView show: self.model.name];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES];
    
}

- (FNRequestTool *)apiRequestPayType{
    @weakify(self)
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_suborder&ctrl=pay_type" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        NSArray *array = respondsObject;
        [SVProgressHUD dismiss];
        [FNUpPaymodelNeView showWithTitles:array selectIndex:^(NSInteger selectIndex) {
            @strongify(self)
            XYLog(@"选择:%ld",(long)selectIndex);
            NSString *type = array[selectIndex][@"type"];
            self.payType = type;
            [self.payAlertView setPayType: array[selectIndex][@"str"]];
        }];
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:YES];
}

- (FNRequestTool *)apiRequestZFB: (NSString*)payType{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"type":@"zfb"}];
    if([self.lblShiji.text kr_isNotEmpty]){
        params[@"money"]=self.lblShiji.text;
    }
    if([self.store_id kr_isNotEmpty]){
        params[@"store_id"]=self.store_id;
    }
    if([payType kr_isNotEmpty]){
        params[@"type"]=payType;
    }
    if (_redpack) {
        params[@"red_packet_id"] = _redpack.id;
    }
    if (_coupone) {
        params[@"yhq_id"] = _coupone.id;
    }
    if (_pay && [_pay.discount_id kr_isNotEmpty]) {
        params[@"discount_id"] = _pay.discount_id;
    }
    [SVProgressHUD show];
    @weakify(self)
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_underLinePay&ctrl=app_payment" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        @strongify(self)
        XYLog(@"支付宝付款结果:%@",respondsObject);
        NSDictionary* dataDic = respondsObject[DataKey];
        if ([payType isEqualToString: @"zfb"]) {
            NSString *codeString=dataDic[@"code"];
            [self startTendPayment: codeString];
        } else if ([payType isEqualToString: @"wx"]){
            [self startWxPayment: dataDic];
        } else if ([payType isEqualToString: @"yue"]){
        }
        
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:YES];
}
//支付宝支付
-(void)startTendPayment: (NSString*) tendCodeString{
    //NSLog(@"tendCodeString:%@",self.tendCodeString);
    [[AlipaySDK defaultService] payOrder:tendCodeString fromScheme:AlisdkSchemes callback:^(NSDictionary *resultDic) {
        XYLog(@"支付:%@",resultDic);
        if ([NSString checkIsSuccess:resultDic[@"resultStatus"] andElement:@"9000"] ) {
            [FNTipsView showTips:ResultStatusDict[@"9000"]];
            [self backViewControllerType];
        }else{
            [SVProgressHUD dismiss];
            [FNTipsView showTips:ResultStatusDict[resultDic[@"resultStatus"] ] withDuration:2.0];
//            [self backViewControllerType];
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
    if([self.store_id kr_isNotEmpty]){
        params[@"store_id"]=self.store_id;
    }
    if (_pay && [_pay.discount_id kr_isNotEmpty]) {
        params[@"discount_id"] = _pay.discount_id;
    }
    @weakify(self)
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_underLinePay&ctrl=yue_payment" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        if ([respondsObject isEqualToString:@"1"]) {
            [FNTipsView showTips:@"支付成功"];
            [self backViewControllerType];
        }
        
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache: NO];
}

-(void)backViewControllerType{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Action

- (void)priceChange {
    //https://www.jianshu.com/p/c8feb12ecba5
    _nPrice = [NSDecimalNumber decimalNumberWithString:@"0"];
    if ([_txfPrice.text kr_isNotEmpty]) {
        NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:_txfPrice.text];
        if (number && ![number isEqualToNumber:NSDecimalNumber.notANumber]) {
            _nPrice = number;
        }
    }
    
    [self calcPrice];
 
}

- (void)discountChange {
    _nDiscount = [NSDecimalNumber decimalNumberWithString:@"0"];
    if ([_txfDiscount.text kr_isNotEmpty]) {
        NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:_txfDiscount.text];
        if (number && ![number isEqualToNumber:NSDecimalNumber.notANumber]) {
            _nDiscount = number;
        }
    }
    
    [self calcPrice];
}

- (void)descChange {
    
}

- (void)onPayClick {
    [self requestPayDetail];
    
}

#pragma mark - UITextFieldDelegate

//参数一：range，要被替换的字符串的range，如果是新输入的，就没有字符串被替换，range.length = 0
//参数二：替换的字符串，即键盘即将输入或者即将粘贴到textField的string
//返回值为BOOL类型，YES表示允许替换，NO表示不允许
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    //新输入的
    if (string.length == 0) {
        return YES;
    }
    
    //第一个参数，被替换字符串的range
    //第二个参数，即将键入或者粘贴的string
    //返回的是改变过后的新str，即textfield的新的文本内容
    NSString *checkStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    //正则表达式（只支持两位小数）
    NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
    //判断新的文本内容是否符合要求
    return [self isValid:checkStr withRegex:regex];
    
}

//检测改变过的文本是否匹配正则表达式，如果匹配表示可以键入，否则不能键入
- (BOOL) isValid:(NSString*)checkStr withRegex:(NSString*)regex
{
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:checkStr];
}


#pragma mark - FNNewStorePayAlertViewDelegate

- (void)onAlertPayClick {
    if (![_payType kr_isNotEmpty]) {
        [self apiRequestPayType];
    } else {
        if ([_payType isEqualToString: @"yue"]){
            [self startYuePayment:self.lblShiji.text];
        } else {
            [self apiRequestZFB: _payType];
        }
    }
}

- (void)onAlertPayTypeClick {
    [self apiRequestPayType];
}

- (void)onAlertPayCouponeClick {
    FNStoreMyCouponeController *vc = [[FNStoreMyCouponeController alloc] init];
    vc.coupones = _payConfirm.yhq_list;
    vc.title = @"优惠券";
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)onAlertPayRedpackClick {
    FNStoreMyCouponeController *vc = [[FNStoreMyCouponeController alloc] init];
    vc.coupones = _payConfirm.red_packet_list;
    vc.title = @"红包";
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - FNStoreMyCouponeControllerDelegate

- (void) couponeVc: (FNStoreMyCouponeController*)vc didSelected: (FNStoreMyCouponeModel*)coupone {
    if ([vc.title isEqualToString:@"优惠券"]) {
        _coupone = coupone;
    } else if ([vc.title isEqualToString:@"红包"]) {
        _redpack = coupone;
    }
    
    [self requestPayDetail];
}

@end
