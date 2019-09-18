//
//  FNMyNetCouponeRechargeController.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/10.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNMyNetCouponeRechargeController.h"
#import "FNNetCouponeRechargeModel.h"
#import "FNNetCouponeRechargeHeaderView.h"
#import "FNNetCouponeRechargeHeaderCell.h"
#import "FNNetCouponeRechargeCardCell.h"
#import "FNNetCouponeRechargePayCell.h"
#import "FNNetCouponeRechargeFooterCell.h"

#import <AlipaySDK/AlipaySDK.h>
#import "WechatOpenSDK/WXApi.h"

@interface FNMyNetCouponeRechargeController()<UITableViewDelegate, UITableViewDataSource, FNNetCouponeRechargeFooterCellDelegate, FNNetCouponeRechargeCardCellDelegate>

@property (nonatomic, strong) FNNetCouponeRechargeModel* model;

@property (nonatomic, strong) FNNetCouponeRechargeHeaderView *headerView;

@property (nonatomic, assign) NSInteger cardIndex;
@property (nonatomic, assign) NSInteger payIndex;

@end

@implementation FNMyNetCouponeRechargeController

- (void)viewDidLoad {
    _cardIndex = 0;
    _payIndex = 0;
    [super viewDidLoad];
    [self configUI];
    [self requestMain];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWxSuccess) name:@"Wx_Resp_Success" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configUI {
    _headerView = [[FNNetCouponeRechargeHeaderView alloc] initWithFrame: CGRectMake(0, 0, XYScreenWidth, 140)];
    
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.backgroundColor=UIColor.clearColor;
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.tableHeaderView = _headerView;
    
    [self.jm_tableview registerClass:[FNNetCouponeRechargeCardCell class] forCellReuseIdentifier:@"FNNetCouponeRechargeCardCell"];
    [self.jm_tableview registerClass:[FNNetCouponeRechargePayCell class] forCellReuseIdentifier:@"FNNetCouponeRechargePayCell"];
    [self.jm_tableview registerClass:[FNNetCouponeRechargeFooterCell class] forCellReuseIdentifier:@"FNNetCouponeRechargeFooterCell"];
    
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.right.bottom.equalTo(@0);
    }];
}

- (void)updateView {
    if (self.model == nil)
        return;
    self.title = self.model.top_title;
    _headerView.lblTitle.text = self.model.str;
    _headerView.lblDesc.text = self.model.str1;
    _headerView.lblCoupone.text = self.model.coupon_str;
    [_headerView.imgIcon sd_setImageWithURL: URL(self.model.img)];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.model.pay_list.count;
    } else {
        return 1;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FNNetCouponeRechargeCardCell *cell = [tableView dequeueReusableCellWithIdentifier: @"FNNetCouponeRechargeCardCell"];
        [cell setCards: self.model.card_list];
        [cell setSelectedAt: _cardIndex];
        cell.delegate = self;
        return cell;
    } else if (indexPath.section == 1) {
        FNNetCouponeRechargePayCell *cell = [tableView dequeueReusableCellWithIdentifier: @"FNNetCouponeRechargePayCell"];
        FNNetCouponeRechargePayModel *pay = self.model.pay_list[indexPath.row];
        [cell.imgIcon sd_setImageWithURL: URL(pay.img)];
        cell.lblTitle.text = pay.name;
        [cell setIsSelected: _payIndex == indexPath.row];
//        cell.delegate = self;
        return cell;
    } else if (indexPath.section == 2) {
        FNNetCouponeRechargeFooterCell *cell = [tableView dequeueReusableCellWithIdentifier: @"FNNetCouponeRechargeFooterCell"];
        [cell.btnPay sd_setBackgroundImageWithURL: URL(self.model.btn_img) forState: UIControlStateNormal];
        cell.lblPolicy.text = self.model.btm_str;
        cell.delegate = self;
        return cell;
    }
    return [[UITableViewCell alloc] init];
    
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)
        return 100;
    else if (indexPath.section == 1)
        return 64;
    else
        return 120;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 1)
        return 44;
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FNNetCouponeRechargeHeaderCell* cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FNNetCouponeRechargeHeaderCell"];
    if (cell == nil) {
        cell = [[FNNetCouponeRechargeHeaderCell alloc]initWithReuseIdentifier:@"FNNetCouponeRechargeHeaderCell"];
    }
    cell.lblTitle.text = section == 0 ? @"充值金额" : self.model.pay_str;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        _payIndex = indexPath.row;
        [self.jm_tableview reloadData];
    }
}

#pragma mark - Networking
- (void)requestMain {
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=coupon_exchange_userlist&ctrl=recharge" respondType:(ResponseTypeModel) modelType:@"FNNetCouponeRechargeModel" success:^(id respondsObject) {
        @strongify(self)
        self.model = respondsObject;
        [self updateView];
        [self.jm_tableview reloadData];
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES isCache: NO];
    
}

- (void)requestRecharge: (NSString*)ID withType: (NSString*)type{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"id": ID, @"type": type}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=coupon_exchange_userlist&ctrl=recharge_doing" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        if ([type isEqualToString:@"zfb"]) {
            [self startBesidesPayment: respondsObject[@"code"]];
        } else if ([type isEqualToString:@"wx"]) {
            [self startWxPayment: respondsObject];
        } else if ([type isEqualToString:@"yue"]) {
            [FNTipsView showTips:@"充值成功"];
            [self requestMain];
        }
        
        
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO];
    
}

//支付宝支付
-(void)startBesidesPayment: (NSString*) code{
    NSLog(@"BalanceoidString:%@",code);
    [[AlipaySDK defaultService] payOrder:code fromScheme:AlisdkSchemes callback:^(NSDictionary *resultDic) {
        XYLog(@"支付:%@",resultDic);
        if ([NSString checkIsSuccess:resultDic[@"resultStatus"] andElement:@"9000"] ) {
            [FNTipsView showTips:ResultStatusDict[@"9000"]];
            [FNTipsView showTips:@"充值成功"];
//            [self backViewControllerType];
//            [UIView animateWithDuration:0.5 animations:^{
//                [self backViewControllerType];
//            }];
            [self requestMain];
        }else{
            [SVProgressHUD dismiss];
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
    [FNTipsView showTips:@"充值成功"];
    [self requestMain];
}

#pragma mark - FNNetCouponeRechargeFooterCellDelegate

- (void)didRechargeClick: (FNNetCouponeRechargeFooterCell*)cell {
    NSLog(@"%ld  %ld", _cardIndex, _payIndex);
    FNNetCouponeRechargeCardModel* card = self.model.card_list[_cardIndex];
    FNNetCouponeRechargePayModel *pay = self.model.pay_list[_payIndex];
    
    [self requestRecharge: card.id withType: pay.type];
}

#pragma mark - FNNetCouponeRechargeCardCellDelegate

- (void)cell: (FNNetCouponeRechargeCardCell*)cell didSelectAt: (NSInteger)index {
    _cardIndex = index;
//    [self.jm_tableview reloadData];
}

@end
