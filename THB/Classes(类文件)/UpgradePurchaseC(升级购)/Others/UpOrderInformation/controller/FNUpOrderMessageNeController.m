//
//  FNUpOrderMessageNeController.m
//  THB
//
//  Created by Jimmy on 2018/9/28.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpOrderMessageNeController.h"

//view
#import "FNUpOrderMessageNeCell.h"
#import "FNUpOrderSiteNeHeaderView.h"
#import "FNUpPaymodelNeView.h"
//#import "FNUpOrderformRestsNeCell.h"
#import "FNOrderForGoodsSingleNeCell.h"
//controller
#import "FNUpAddressNeController.h"
#import "FNUpGoodsDetailsNController.h"
//model
#import "FNUpOrderinformationNModel.h"
//其他
#import <AlipaySDK/AlipaySDK.h>
#import "WechatOpenSDK/WXApi.h"

@interface FNUpOrderMessageNeController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,FNUpOrderMessageNeCellDelegate,FNUpOrderSiteNeHeaderViewDelegate,FNUpAddressNeControllerDelegate>
/**  data **/
@property(nonatomic,strong)FNUpOrderinformationNModel *dataModel;
/**  addressDictry **/
@property(nonatomic,strong)NSDictionary *addressDictry;
/**  支付方式 **/
@property(nonatomic,strong)NSMutableArray *alipayArr;
/**  其他信息 **/
@property(nonatomic,strong)NSMutableArray *restsArr;
/**  地址id **/
@property(nonatomic,strong)NSString *aid;
/**  支付方式 **/
@property(nonatomic,strong)NSString *alipay_type;
/**  oid **/
@property(nonatomic,strong)NSString *oidString;
/**  支付宝使用 **/
@property(nonatomic,strong)NSString *BalanceoidString;
/**  sumLabel **/
@property(nonatomic,strong)UILabel *sumLabel;
/**  sumString **/
@property(nonatomic,strong)NSString *sumString;
@end

@implementation FNUpOrderMessageNeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"订单信息";
    [self apiRequestSiteMessage];
    [self OrderMessageTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWxSuccess) name:@"Wx_Resp_Success" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 单元
-(void)OrderMessageTableView{
    //self.automaticallyAdjustsScrollViewInsets = YES;
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    self.jm_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-50) style:UITableViewStylePlain];
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.sectionHeaderHeight=110;
    [self.view addSubview:self.jm_tableview];
    self.jm_tableview.backgroundColor=FNColor(240, 240, 240);
    UIView *bottomView=[[UIView alloc]init];
    bottomView.backgroundColor=[UIColor whiteColor];
    bottomView.frame=CGRectMake(0, FNDeviceHeight-50, FNDeviceWidth, 50);
    [self.view addSubview:bottomView];
    UIButton *presentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //presentButton.backgroundColor=FNColor(255,19,30);
    presentButton.backgroundColor=RED;
    presentButton.frame=CGRectMake(FNDeviceWidth-FNDeviceWidth/3, 0, FNDeviceWidth/3, 50);
    presentButton.titleLabel.font=kFONT14;
    [presentButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [presentButton addTarget:self action:@selector(presentAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:presentButton];
    self.sumLabel=[UILabel new];
    self.sumLabel.textAlignment=NSTextAlignmentRight;
    self.sumLabel.frame=CGRectMake(10, 0, FNDeviceWidth-FNDeviceWidth/3-20, 50);
    [self.sumLabel sizeToFit];
    self.sumLabel.textColor=FNColor(255,19,30);
    self.sumLabel.font=kFONT14;
    [bottomView addSubview:self.sumLabel];
    
    bottomView.sd_layout
    .bottomSpaceToView(self.view, 0).leftSpaceToView(self.view, 0).heightIs(50).rightSpaceToView(self.view, 0);
    
    self.sumLabel.sd_layout
    .bottomSpaceToView(bottomView, 0).leftSpaceToView(bottomView, 10).heightIs(50).rightSpaceToView(presentButton, 10);
    
}
#pragma mark - 金额
-(void)sumTotalAmount{
    NSString *joint=@"合计金额:";
    NSString *jointString= [NSString stringWithFormat:@"%@%@",joint,self.sumString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: jointString];
    [attributedString addAttribute:NSForegroundColorAttributeName value:FNGlobalTextGrayColor range:NSMakeRange(0, joint.length)];
    self.sumLabel.attributedText = attributedString;
}
#pragma mark - 提交订单
-(void)presentAction{
    [self apiRequestEstablishMessage];
}
#pragma mark - UITableViewDataSource delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 150;
    }else{
        return 40;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.restsArr.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        FNUpOrderMessageNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MessageNeCell"];
        if (cell == nil) {
            cell = [[FNUpOrderMessageNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageNeCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        cell.indexPath=indexPath;
        cell.model=self.dataModel;
        return cell;
    }else{
//        FNUpOrderformRestsNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MessageNeCell"];
//        if (cell == nil) {
//            cell = [[FNUpOrderformRestsNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageNeCell"];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.model=[FNUpOrderMsgNModel mj_objectWithKeyValues:self.restsArr[indexPath.row-1]];
//        return cell;
        FNOrderForGoodsSingleNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OrderForGoodsSingleNeCell"];
        if (cell == nil) {
            cell = [[FNOrderForGoodsSingleNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderForGoodsSingleNeCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model=[FNUpOrderMsgNModel mj_objectWithKeyValues:self.restsArr[indexPath.row-1]];
        return cell;
    }
    
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    FNUpOrderSiteNeHeaderView* HeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HeaderFooterView"];
    if (HeaderView == nil) {
        HeaderView = [[FNUpOrderSiteNeHeaderView alloc]initWithReuseIdentifier:@"HeaderFooterView"];
    }
    HeaderView.model=self.addressDictry;//self.dataModel.address;
    HeaderView.delegate=self;
    return HeaderView;
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 110;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}

#pragma mark -  FNUpOrderMessageNeCellDelegate 选择支付方式

-(void)selectPatternofpaymentAction:(NSIndexPath *)indexPath{
    XYLog(@"选择支付方式");
    @WeakObj(self);
    [FNUpPaymodelNeView showWithTitles:self.alipayArr selectIndex:^(NSInteger selectIndex) {
        XYLog(@"选择:%ld",(long)selectIndex);
        FNUpOrderAlipayNModel *model=[FNUpOrderAlipayNModel mj_objectWithKeyValues:selfWeak.alipayArr[selectIndex]];
         FNUpOrderMessageNeCell* cell = (FNUpOrderMessageNeCell *)[self.jm_tableview cellForRowAtIndexPath:indexPath];
        cell.mannerLB.text=model.str;
        selfWeak.alipay_type=model.type;
    }];
}
#pragma mark -  FNUpOrderSiteNeHeaderViewDelegate 选择地址
- (void)OrderSelectAddressAction{
     XYLog(@"选择地址");
    FNUpAddressNeController *vc=[[FNUpAddressNeController alloc]init];
    vc.delegate=self;
    vc.notchoice=1;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -   FNUpAddressNeControllerDelegate 选择返回地址
-(void)selectChoiceofLocationAction:(id)model{
    self.addressDictry=model;
    self.aid=model[@"id"];
    [self apiRequestSiteMessage];
    [self.jm_tableview reloadData];
}
#pragma mark -  获取提交订单信息
- (FNRequestTool *)apiRequestSiteMessage{
    [SVProgressHUD show];
    @WeakObj(self);
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"num":self.numString,@"id":self.commodityID,@"attr_id":self.attr_idString}];
    if ([_aid kr_isNotEmpty]) {
        params[@"aid"] = _aid;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=update_submitorder&ctrl=show_submitorder" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"提交订单信息:%@",respondsObject);
        NSDictionary *indentDic =  respondsObject [DataKey];
        selfWeak.dataModel=[FNUpOrderinformationNModel mj_objectWithKeyValues:indentDic];
        selfWeak.addressDictry=selfWeak.dataModel.address;
        FNUpOrderAddressNModel *AddressNModel=[FNUpOrderAddressNModel mj_objectWithKeyValues:selfWeak.dataModel.address];
        selfWeak.aid=AddressNModel.address_id;
        NSMutableArray *typeArr=[NSMutableArray array];
        for (NSDictionary *model in selfWeak.dataModel.alipay_type){
            [typeArr addObject:model];
        }
        selfWeak.alipayArr=typeArr;
        NSMutableArray *reArr=[NSMutableArray array];
        for (NSDictionary  *model in selfWeak.dataModel.msg){
            [reArr addObject:model];
        }
        selfWeak.restsArr=reArr;
        selfWeak.sumString=selfWeak.dataModel.payment;
        [selfWeak sumTotalAmount];
        [self.jm_tableview reloadData];
        [UIView animateWithDuration:0.2 animations:^{
            [SVProgressHUD dismiss];
        }];
        
    } failure:^(NSString *error) {
        [self apiRequestSiteMessage];
    } isHideTips:NO];
}
#pragma mark -  获取创建订单
- (void)apiRequestEstablishMessage{
    
    if(![self.aid kr_isNotEmpty]){
        [FNTipsView showTips:@"请选择地址"];
        return;
    }else if(![self.alipay_type kr_isNotEmpty]){
        [FNTipsView showTips:@"请选择支付方式!"];
        return;
    }
    [SVProgressHUD show];
    @WeakObj(self);
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"num":self.numString,@"id":self.commodityID,@"attr_id":self.attr_idString,@"aid":selfWeak.aid,@"alipay_type":selfWeak.alipay_type}];
   [FNRequestTool requestWithParams:params api:@"mod=appapi&act=update_submitorder&ctrl=create" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
       XYLog(@"获取创建订单:%@",respondsObject);
       NSDictionary *dataDic =  respondsObject [DataKey];
       selfWeak.oidString=dataDic[@"oid"];
       
       if([selfWeak.alipay_type isEqualToString:@"yue"]){
           [self apiRequestBalancePayment];
       }else if([selfWeak.alipay_type isEqualToString:@"zfb"] || [selfWeak.alipay_type isEqualToString:@"wx"]){
           [selfWeak apiRequestBesidesPayment];
       }
       
    } failure:^(NSString *error) {
        //[self apiRequestSiteMessage];
    } isHideTips:NO];
}

#pragma mark - 余额支付
- (FNRequestTool *)apiRequestBalancePayment{
    [SVProgressHUD show];
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"oid":self.oidString}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=update_submitorder&ctrl=yue_pay" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"余额支付:%@",respondsObject);
        NSInteger successInt=[respondsObject[@"success"] integerValue];
        NSString *msgString=respondsObject[@"msg"];
        [FNTipsView showTips:msgString];
        [UIView animateWithDuration:1.0 animations:^{
            [SVProgressHUD dismiss];
            if(successInt==1){
                [self backViewControllerType];
            }
        }];
        
    } failure:^(NSString *error) {
        [FNTipsView showTips:@"请重新加载!"];
    } isHideTips:NO];
}
#pragma mark - 支付宝支付
- (FNRequestTool *)apiRequestBesidesPayment{
    @WeakObj(self);
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"oid":self.oidString}];
    if ([self.alipay_type isEqualToString:@"zfb"]) {
        params[@"type"] = @"alipay";
    } else if ([self.alipay_type isEqualToString:@"wx"]) {
        params[@"type"] = @"wx";
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=update_submitorder&ctrl=app_payment" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"另外支付:%@",respondsObject);
        NSDictionary *dataDic =  respondsObject [DataKey];
        selfWeak.BalanceoidString=dataDic[@"code"];
        if ([selfWeak.alipay_type isEqualToString:@"zfb"]) {
            [selfWeak startBesidesPayment];
        } else if ([selfWeak.alipay_type isEqualToString:@"wx"]) {
            [selfWeak startWxPayment: dataDic];
        }
    } failure:^(NSString *error) {
        [FNTipsView showTips:@"请重新加载!"];
    } isHideTips:NO];
}
//支付宝支付
-(void)startBesidesPayment{
    NSLog(@"BalanceoidString:%@",self.BalanceoidString);
    [[AlipaySDK defaultService] payOrder:self.BalanceoidString fromScheme:AlisdkSchemes callback:^(NSDictionary *resultDic) {
        XYLog(@"支付:%@",resultDic);
        if ([NSString checkIsSuccess:resultDic[@"resultStatus"] andElement:@"9000"] ) {
            [FNTipsView showTips:ResultStatusDict[@"9000"]];
            [self backViewControllerType];
            [UIView animateWithDuration:0.5 animations:^{
                    [self backViewControllerType];
            }];
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
    [self backViewControllerType];
    [UIView animateWithDuration:0.5 animations:^{
        [self backViewControllerType];
    }];
}

-(void)backViewControllerType{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[FNUpGoodsDetailsNController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
- (NSMutableArray *)alipayArr{
    if (!_alipayArr) {
        _alipayArr = [NSMutableArray array];
    }
    return _alipayArr;
}
- (NSMutableArray *)restsArr{
    if (!_restsArr) {
        _restsArr = [NSMutableArray array];
    }
    return _restsArr;
}

@end
