//
//  FNIntegralMallOrderController.m
//  THB
//
//  Created by Weller Zhao on 2019/1/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNIntegralMallOrderController.h"
#import "FNIntegralMallAddressCell.h"
#import "FNIntegralMallOrderGoodsCell.h"
#import "FNIntegralMallOrderTextCell.h"
#import "FNIntegralMallOrdelModel.h"
#import "FNIntegralMallAddressController.h"
#import "FNAddressModel.h"
#import "FNPaymentSelectorAlert.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

@interface FNIntegralMallOrderController () <UITableViewDelegate, UITableViewDataSource, FNIntegralMallAddressControllerDelegate>

@property (nonatomic, strong) UIView *vBottom;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UIButton *btnSubmit;

@property (nonatomic, strong) FNIntegralMallOrdelModel* model;

@property (nonatomic, copy) NSString *aid;

@end

@implementation FNIntegralMallOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self apiRequestOrder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWxSuccess) name:@"Wx_Resp_Success" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configUI {
    self.title = @"订单信息";
    
    self.vBottom = [[UIView alloc] init];
    self.lblPrice = [[UILabel alloc] init];
    self.btnSubmit = [[UIButton alloc] init];
    
    [self.view addSubview: self.vBottom];
    [self.vBottom addSubview: self.lblPrice];
    [self.vBottom addSubview: self.btnSubmit];
    
    [self.vBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0).offset(isIphoneX ? -34 : 0);
    }];
    [self.lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
        make.right.equalTo(self.vBottom).multipliedBy(0.7);
//        make.width.equalTo(@0).multipliedBy(0.7);
    }];
    [self.btnSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblPrice.mas_right);
        make.top.right.bottom.equalTo(@0);
    }];
    
    self.lblPrice.textAlignment = NSTextAlignmentCenter;
    self.lblPrice.textColor = RGB(24, 24, 24);
    self.lblPrice.backgroundColor = UIColor.whiteColor;
    
    self.btnSubmit.backgroundColor = RGB(255, 131, 20);
    [self.btnSubmit setTitle:@"提交订单" forState:UIControlStateNormal];
    [self.btnSubmit setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.btnSubmit addTarget:self action:@selector(onSubmitClick)];
    
    
    self.jm_tableview = [[UITableView alloc] init];
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.bottom.equalTo(self.vBottom.mas_top);
    }];
    self.jm_tableview.backgroundColor = FNHomeBackgroundColor;
    self.jm_tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    self.jm_tableview.delegate = self;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.rowHeight = UITableViewAutomaticDimension;
    self.jm_tableview.estimatedRowHeight = 500;
    [self.jm_tableview registerClass:[FNIntegralMallAddressCell class] forCellReuseIdentifier:@"FNIntegralMallAddressCell"];
    [self.jm_tableview registerClass:[FNIntegralMallOrderGoodsCell class] forCellReuseIdentifier:@"FNIntegralMallOrderGoodsCell"];
    [self.jm_tableview registerClass:[FNIntegralMallOrderTextCell class] forCellReuseIdentifier:@"FNIntegralMallOrderTextCell"];
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma Network
- (void)apiRequestOrder {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"id": self.goodsId, TokenKey: UserAccessToken, @"attr_id": self.val, @"num": @(self.count)}];
    if ([_aid kr_isNotEmpty]) {
        params[@"aid"] = _aid;
    }
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_suborder&ctrl=subOrder" respondType:(ResponseTypeModel) modelType:@"FNIntegralMallOrdelModel" success:^(id respondsObject) {
        @strongify(self);
        self.model = respondsObject;
        [self.jm_tableview reloadData];
        
        NSString *string = [NSString stringWithFormat:@"合计金额:%@", self.model.payment];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
        [attrString addAttribute:NSForegroundColorAttributeName value:RGB(255, 131, 20) range:NSMakeRange(5, self.model.total.length)];
//        self.lblPrice.text = self.model.total;
        self.lblPrice.attributedText = attrString;
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO isCache:NO];
}

- (void)apiRequestCreateOrder: (NSString*)payType {
//    if (![payType kr_isNotEmpty])
//        return;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"id": self.goodsId, TokenKey: UserAccessToken, @"attr_id": self.val, @"num": @(self.count), @"aid": self.model.address.address_id, @"pay_type": payType}];
    [SVProgressHUD show];
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_suborder&ctrl=createOrder" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSString *orderId = [respondsObject objectForKey:@"orderId"];
        [SVProgressHUD dismiss];
        [self apiRequestPayment: orderId payType: payType];
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO isCache:NO];
}

- (void)apiRequestPayment: (NSString*)orderId payType: (NSString*)payType {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey: UserAccessToken, @"orderId": orderId}];
    
    if ([payType isEqualToString:@"wx"]) {
        params[@"type"] = @"wx";
    } else if ([payType isEqualToString:@"zfb"]) {
        params[@"type"] = @"alipay";
    } else {
        params[@"type"] = @"yue";
    }
    
    [SVProgressHUD show];
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_payment&ctrl=paydoing" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        
        [SVProgressHUD dismiss];
        NSString *type = [respondsObject objectForKey:@"type"];
        NSString *code = [respondsObject objectForKey:@"code"];
        if ([payType isEqualToString:@"zfb"]) {
            [self startBesidesPayment:code];
        } else if ([payType isEqualToString:@"wx"]) {
            [self startWxPayment:respondsObject];
        } else {
            [FNTipsView showTips:@"兑换成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO isCache:NO];
}

//支付宝支付
-(void)startBesidesPayment: (NSString*)code{
    NSLog(@"BalanceoidString:%@",code);
    [[AlipaySDK defaultService] payOrder:code fromScheme:AlisdkSchemes callback:^(NSDictionary *resultDic) {
        XYLog(@"支付:%@",resultDic);
        [SVProgressHUD dismiss];
        if ([NSString checkIsSuccess:resultDic[@"resultStatus"] andElement:@"9000"] ) {
            [FNTipsView showTips:ResultStatusDict[@"9000"]];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [FNTipsView showTips:ResultStatusDict[resultDic[@"resultStatus"] ] withDuration:2.0];
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
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.model == nil)
        return 0;
    return self.model.msg.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        FNIntegralMallAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNIntegralMallAddressCell"];
        [cell setName:self.model.address.name withPhone:self.model.address.phone andAddress:self.model.address.address_msg];
        return cell;
    } else if (indexPath.row == 1) {
        FNIntegralMallOrderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNIntegralMallOrderGoodsCell"];
        
        [cell.imgGoods sd_setImageWithURL:URL(self.model.goodsInfo.img)];
        cell.lblTitle.text = self.model.goodsInfo.title;
        cell.lblDesc.text = self.model.goodsInfo.attr;
        cell.lblPrice.text = self.model.goodsInfo.price;
        cell.lblCount.text = self.model.goodsInfo.num;
        
        return cell;
    } else {
        FNIntegralMallOrderTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNIntegralMallOrderTextCell"];
        FNIntegralMallOrdelMsgModel *msg = self.model.msg[indexPath.row - 2];
        [cell setTitle:msg.str withDesc:msg.val];
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        FNIntegralMallAddressController *vc = [[FNIntegralMallAddressController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark - Action

- (void)onSubmitClick {
    if ([self.model.address.address_id isEqualToString:@""]) {
        [FNTipsView showTips:@"请填写收货信息"];
        return;
    }
    
    if (self.model.is_need_pay.integerValue == 1) {
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        NSMutableArray *imageUrls = [[NSMutableArray alloc] init];
        for (FNIntegralMallOrdelPayModel *pay in self.model.alipay_type) {
            [titles addObject:[NSString stringWithFormat:@"%@%@", pay.str, pay.val]];
            [imageUrls addObject:pay.img];
        }
        @weakify(self);
        [FNPaymentSelectorAlert show:titles
                      withImagesUrls:imageUrls onItemSelected:^(NSInteger index) {
                          
                          [FNPaymentSelectorAlert dismiss];
                          [self_weak_ apiRequestCreateOrder:self_weak_.model.alipay_type[index].type];
        }];
    } else {
        [self apiRequestCreateOrder:@""];
    }
}

#pragma mark - FNIntegralMallAddressControllerDelegate

- (void)didAddressSelected:(FNAddressModel *)address {
    self.model.address.address_id = address.ID;
    self.model.address.address_msg = address.address;
    self.model.address.name = address.name;
    self.model.address.phone = address.phone;
    _aid = address.ID;
    [self.jm_tableview reloadData];
    
    [self apiRequestOrder];
}

@end
