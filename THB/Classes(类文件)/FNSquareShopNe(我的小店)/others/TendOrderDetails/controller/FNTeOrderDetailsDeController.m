//
//  FNTeOrderDetailsDeController.m
//  69橙子
//
//  Created by Jimmy on 2018/12/6.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//订单详情
#import "FNTeOrderDetailsDeController.h"
//view
#import "FNteIndentResultNeCell.h"
#import "FNteIndentBesidesNeCell.h"
#import "FNteIndentAddressNeCell.h"
#import "FNteIndentBrandNeCell.h"
#import "FNteIndentTextNeHeader.h"
#import "FNteIndentPhoneNeHeader.h"
#import "FNRushCommodityMeNeCell.h"
#import "FNRushPackagingMeNeCell.h"
#import "FNteIndentQrcodeNeCell.h"
#import "FNNewStorePayTypeAlertView.h"
//model
#import "FNtendOrderDetailsDeModel.h"
//其他
#import <AlipaySDK/AlipaySDK.h>
#import "WechatOpenSDK/WXApi.h"
//controller
#import "FNshopTendPlazaNeController.h"
#import "FNNewStoreDetailController.h"
@interface FNTeOrderDetailsDeController ()<UITableViewDelegate,UITableViewDataSource,FNteIndentPhoneNeHeaderDelegate,FNteIndentResultNeCellDelegate>
@property(nonatomic,strong)FNtendOrderDetailsDeModel *dataModel;
@property(nonatomic,strong)NSString *recurCodeString;
@property (nonatomic, strong) FNNewStorePayTypeAlertView *payTypeAlert;
@property(nonatomic,strong)NSString *tendCodeString;
@end

@implementation FNTeOrderDetailsDeController

- (FNNewStorePayTypeAlertView *)payTypeAlert {
    if (_payTypeAlert == nil) {
        _payTypeAlert = [[FNNewStorePayTypeAlertView alloc] init];
        _payTypeAlert.delegate = self;
        [self.view addSubview: _payTypeAlert];
        [_payTypeAlert mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    [self.view bringSubviewToFront:_payTypeAlert];
    return _payTypeAlert;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"订单详情";
    [self apiRequestPresentOrderDetails];
    [self detailsDeReckoningView];
}

-(void)detailsDeReckoningView{
    self.jm_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight) style:UITableViewStylePlain];
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.showsVerticalScrollIndicator=NO;
    self.jm_tableview.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.jm_tableview];
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.estimatedRowHeight = 0;
        self.jm_tableview.estimatedSectionFooterHeight = 0;
        self.jm_tableview.estimatedSectionHeaderHeight= 0;
        self.jm_tableview.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
    self.jm_tableview.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0).topSpaceToView(self.view, 0);
    self.jm_tableview.backgroundColor=RGB(237, 237, 237);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWxSuccess) name:@"Wx_Resp_Success" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
       return 1;
    } else if (section == 1) {
        return 1;
    }else if(section==2){
       return self.dataModel.goods.count;
    }else{
       return self.dataModel.order_msg.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNteIndentResultNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"teIndentResultNeID"];
        if (cell == nil) {
            cell = [[FNteIndentResultNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"teIndentResultNeID"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        cell.model=self.dataModel;
        return cell;
    }
    else if(indexPath.section==1){
        if ([self.dataModel.buy_type isEqualToString:@"takeOut"]) {
            FNteIndentAddressNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"teIndentAddressNeID"];
            if (cell == nil) {
                cell = [[FNteIndentAddressNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"teIndentAddressNeID"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model=self.dataModel;
            return cell;
        }else if ([self.dataModel.buy_type isEqualToString:@"toStore"]){
            FNteIndentQrcodeNeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FNteIndentQrcodeNeCell"];
            if (cell == nil) {
                cell = [[FNteIndentQrcodeNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FNteIndentQrcodeNeCell"];
            }
            [cell setModel:self.dataModel];
            return cell;
        }
        
    }
    else if(indexPath.section==2){
        NSArray *goodsArr=self.dataModel.goods;
        FNrushPurchCartNeModel *model=[FNrushPurchCartNeModel mj_objectWithKeyValues:goodsArr[indexPath.row]]; 
        if([model.type isEqualToString:@"goods"]){
            FNRushCommodityMeNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"RushCommodityMeNeID"];
            if (cell == nil) {
                cell = [[FNRushCommodityMeNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RushCommodityMeNeID"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model=model;
            return cell;
        }else{
            //   商品=>goods 配送费=>extra_costs 优惠=>discount
            FNRushPackagingMeNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PackagingMeNeID"];
            if (cell == nil) {
                cell = [[FNRushPackagingMeNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PackagingMeNeID"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model=model;
            return cell;
        }
    }else{
        NSArray *ordermsgArr=self.dataModel.order_msg;
        FNtendDetailsOrderMsgModel *model=[FNtendDetailsOrderMsgModel mj_objectWithKeyValues:ordermsgArr[indexPath.row]];
        FNteIndentBesidesNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"teIndentBesidesNeID"];
        if (cell == nil) {
            cell = [[FNteIndentBesidesNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"teIndentBesidesNeID"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone; 
        cell.model=model;
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section==1){
        if ([self.dataModel.buy_type isEqualToString:@"takeOut"]) {
            FNteIndentTextNeHeader* HeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"teIndentTextID"];
            if (HeaderView == nil) {
                HeaderView = [[FNteIndentTextNeHeader alloc]initWithReuseIdentifier:@"teIndentTextID"];
            }
            HeaderView.backgroundColor=[UIColor whiteColor];
            HeaderView.titleName.text=@"配送信息";
            return HeaderView;
        }
        
    }
    else if(section==2 || section==3 ){
        FNteIndentTextNeHeader* HeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"teIndentTextID"];
        if (HeaderView == nil) {
            HeaderView = [[FNteIndentTextNeHeader alloc]initWithReuseIdentifier:@"teIndentTextID"];
        }
        HeaderView.backgroundColor=[UIColor whiteColor];
        if (section==2) {
            HeaderView.titleName.text=self.dataModel.store_name;//@"茶语休闲连锁(南屏镇)";
        }
        if (section==3) {
            HeaderView.titleName.text=@"订单信息";
        }
        return HeaderView;
    }
    return [UIView new];
    
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section==2){ 
        FNteIndentPhoneNeHeader* footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"teIndentPhoneNeID"];
        if (footerView == nil) {
                footerView = [[FNteIndentPhoneNeHeader alloc]initWithReuseIdentifier:@"teIndentPhoneNeID"];
        }
        footerView.backgroundColor=[UIColor whiteColor];
        footerView.delegate=self;
        footerView.sumLb.text = [NSString stringWithFormat:@"实付￥%@", self.dataModel.payment];
        return footerView;
    }else{
        return [UIView new];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 115;
    }else if (indexPath.section==1){
        if ([self.dataModel.buy_type isEqualToString:@"takeOut"]) {
            return 120;
        } else if ([self.dataModel.buy_type isEqualToString:@"toStore"]){
            FNrushBuyMsgModel *buymsg=[FNrushBuyMsgModel mj_objectWithKeyValues:self.dataModel.buy_msg];
            if ([buymsg.code kr_isNotEmpty]) {
                if ([self.dataModel.t isEqualToString:@"2"]) {
                    return 270;
                } else {
                    return 120;
                }
            }
        }
        
    }else if (indexPath.section==2){
        return 35;
    }else{
        return 25;
    }
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1){
        if ([self.dataModel.buy_type isEqualToString:@"takeOut"]) {
            return 45;
        }
    }
    else if (section==2 || section==3) {
        return 45;
    }
    return 0;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    if (section==2) {
        return 55;
    }else{
        return 0;
    }
}
#pragma mark - FNteIndentResultNeCellDelegate  再来一单
- (void)inTeIndentRecurAction{
    XYLog(@"再来一单");
    [self apiRequestRecurOrder];
}

- (void)inTeIndentPayAction {
    XYLog(@"立即付款");
//    [self apiRequestPay];
    [self.payTypeAlert show];
}

- (void)inTeIndentCancleAction{
    
    if ([_dataModel.apply_refund isEqualToString:@"1"]) {
        [self cancleOrder];
    } else if ([_dataModel.apply_refund isEqualToString:@"2"]) {
        [self cancleRequest];
    }
}

// 申请取消
- (void) cancleOrder {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"确定取消订单吗？"
                                                                   message:@"请先联系商家确认后取消（退款后金额将返还到账户余额）"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    @weakify(self);
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"取消订单" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         @strongify(self);
                                                         [self requestCancle: self.dataModel.id];
                                                     }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
// 取消申请
- (void) cancleRequest {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"确定取消申请吗？"
                                                                   message:@"取消订单申请退款吗？（申请后订单将可以继续使用）"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    @weakify(self);
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"取消申请" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         @strongify(self);
                                                         [self requestCancle: self.dataModel.id];
                                                     }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - FNteIndentPhoneNeHeaderDelegate 联系
- (void)inTeIndentPhoneAction{
     XYLog(@"联系");
    if([self.dataModel.store_phone kr_isNotEmpty]){
        NSString *str = [NSString stringWithFormat:@"tel:%@",self.dataModel.store_phone];
        
        UIWebView *callWebView = [[UIWebView alloc]init];
        
        [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        
        [self.view addSubview:callWebView];
    }
}
#pragma mark -  //我的订单详情
- (FNRequestTool *)apiRequestPresentOrderDetails{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    if([self.oidString kr_isNotEmpty]){
        params[@"oid"]=self.oidString;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_order&ctrl=order_detail" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"订单详情:%@",respondsObject);
        NSDictionary* dataDic = respondsObject[DataKey];
        self.dataModel=[FNtendOrderDetailsDeModel mj_objectWithKeyValues:dataDic];
        [selfWeak.jm_tableview reloadData];
        self.jm_tableview.hidden = NO;
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache: NO];
}

#pragma mark - FNNewStorePayTypeAlertViewDelegate

- (void)payTypeAlert: (FNNewStorePayTypeAlertView*)view didSelected: (FNNewStorePayTypeModel*) type {
    NSString *pay_typeString = type.type;
    if([pay_typeString isEqualToString:@"zfb"] || [pay_typeString isEqualToString:@"wx"]){
        [self apiRequestPay: pay_typeString];
    }
    if([pay_typeString isEqualToString:@"yue"]){
        [self apiRequestYUE];
    }
}

#pragma mark -  //再来一单
- (FNRequestTool *)apiRequestRecurOrder{
    @weakify(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    if([self.oidString kr_isNotEmpty]){
        params[@"oid"]=self.oidString;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_order&ctrl=pay_agent" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        XYLog(@"再来一单:%@",respondsObject);
        @strongify(self);
        NSString *store_id = respondsObject[@"store_id"];
        NSString *store_name = respondsObject[@"store_name"];
        NSString *msg = respondsObject[@"msg"];
        
        if ([msg kr_isNotEmpty]) {
            [FNTipsView showTips: msg];
        }
        
        FNNewStoreDetailController *store = [[FNNewStoreDetailController alloc] init];
        store.storeID = store_id;
        store.storeName = store_name;
        [self.navigationController pushViewController:store animated:YES];
        
    } failure:^(NSString *error) {
        
    } isHideTips:NO isCache: NO];
}

- (void)requestCancle: (NSString*)orderId{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"id": orderId}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_order&ctrl=apply_refund" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        [self apiRequestPresentOrderDetails];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

#pragma mark -  购买商品余额支付
- (FNRequestTool *)apiRequestYUE{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    if([self.dataModel.orderId kr_isNotEmpty]){
        params[@"oid"]=self.dataModel.orderId;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_suborder&ctrl=yue_payment" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"余额支付结果:%@",respondsObject);
        NSString *msgStr=respondsObject[MsgKey];
        NSInteger successInt=[respondsObject[SuccessKey] integerValue];
        if(successInt==1){
            [FNTipsView showTips:msgStr];
            [self backViewControllerType];
        }
        else{
            [FNTipsView showTips:msgStr];
        }
    } failure:^(NSString *error) {
        [self backViewControllerType];
    } isHideTips:NO];
}

#pragma mark -  支付宝付款
- (FNRequestTool *)apiRequestPay: (NSString*)payType{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    if([self.dataModel.orderId kr_isNotEmpty]){
        params[@"oid"]=self.dataModel.orderId;
    }
    if([payType kr_isNotEmpty]){
        params[@"type"]=payType;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_suborder&ctrl=app_payment" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        if ([payType isEqualToString:@"wx"]) {
            [self startWxPayment:respondsObject];
        } else if ([payType isEqualToString:@"zfb"]) {
            NSString *codeString=respondsObject[@"code"];
            selfWeak.tendCodeString=codeString;
            [self startTendPayment];
        }
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
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
    [self backViewControllerType];
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
-(void)backViewControllerType{
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[FNshopTendPlazaNeController class]]) {
//            [self.navigationController popToViewController:controller animated:YES];
//        }
//    }
    [self apiRequestPresentOrderDetails];
}
@end
