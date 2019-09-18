//
//  FNRushPurchaseNeController.m
//  69橙子
//
//  Created by Jimmy on 2018/11/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//立即抢购 结算
#import "FNRushPurchaseNeController.h"
//view
#import "FNRushConsumeHeaderNeView.h"
#import "FNRushConsumeTextHeaderView.h"
#import "FNRushMealFooterNeView.h"
#import "FNRushArriveDateFooterView.h"
#import "FNRushRelationStoreFooterView.h"
#import "FNRushStoreSiteNeCell.h"
#import "FNRushDeliveryLocationNeCell.h"
#import "FNRushPaylDaNeCell.h"
#import "FNRushCommodityMeNeCell.h"
#import "FNRushPackagingMeNeCell.h"
#import "FNRushNoLocationDaNeCell.h"
#import "FNRushPaySelectionCell.h"
#import "FNNewStorePayTypeAlertView.h"
#import "FNNewStorePayConfirmAlertView.h"
//controller
#import "FNRushSiteListDaNeController.h"
#import "FNshopTendPlazaNeController.h"
#import "FNTeOrderDetailsDeController.h"
#import "FNStoreMyCouponeController.h"

#import "FNNewStorePayTypeModel.h"
//其他
#import <AlipaySDK/AlipaySDK.h>
#import "WechatOpenSDK/WXApi.h"
@interface FNRushPurchaseNeController ()<UITableViewDelegate,UITableViewDataSource,FNRushConsumeHeaderNeViewDelegate,FNRushMealFooterNeViewDelegate,FNRushRelationStoreFooterViewDelegate,FNRushNoLocationDaNeCellDelegate,FNRushSiteListDaNeControllerDelegate, FNNewStorePayTypeAlertViewDelegate, FNStoreMyCouponeControllerDelegate>
/**  消费模式 1:到店消费  2:外卖配送   **/
//@property(nonatomic,assign)NSInteger consumptionModel;
/**  支付方式   **/
@property(nonatomic,strong)NSMutableArray *payArr;
//@property(nonatomic,strong)NSArray *payArr;
/**  头部类型   **/
@property(nonatomic,strong)NSArray *headerBuyArr;
/**  头部购买类型   buy_type     到店消费:toStore  外卖配送:takeOut  **/
@property(nonatomic,strong)NSString *headerType;
/**   提交订单显示页面  **/
@property(nonatomic,strong)NSMutableDictionary *orderData;

/**  商品   **/
@property(nonatomic,strong)NSMutableArray *cartArr;
/**  标识   **/
@property(nonatomic,strong)UILabel *markLB;
/**  底部金额   **/
@property(nonatomic,strong)UILabel *priceLB;
/**  底部预计   **/
@property(nonatomic,strong)UILabel *antipateLB;
/**  底部立即下单   **/
@property(nonatomic,strong)UIButton *bootmLeftButton;

/**   提交订单显示页面  **/
@property(nonatomic,strong)NSDictionary *buyMsgDicTry;
/**  buymsg      **/
@property(nonatomic, strong) FNrushBuyMsgModel *buymsg;
/**   付款类型  **/
@property(nonatomic,strong)NSString *pay_typeString;
@property (nonatomic, copy) NSString *payStr;

/**   手机号 如不是到店消费可不传  **/
@property(nonatomic,strong)NSString *phone;
/**   收货地址id  **/
@property(nonatomic,strong)NSString *aid;
/**   订单编号  **/
@property(nonatomic,strong)NSString *establishOid;
/**   支付宝识别  **/
@property(nonatomic,strong)NSString *tendCodeString;

@property (nonatomic, strong) FNNewStorePayTypeAlertView *payTypeAlert;
@property (nonatomic, strong) FNNewStorePayConfirmAlertView *confirmAlert;

//记录跳转选择优惠券还是红包
@property (nonatomic, copy) NSString *couponeType;
@property (nonatomic, copy) NSString *yhq_id;
@property (nonatomic, copy) NSString *red_packet_id;

@end

@implementation FNRushPurchaseNeController

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

- (FNNewStorePayConfirmAlertView *)confirmAlert {
    if (_confirmAlert == nil) {
        _confirmAlert = [[FNNewStorePayConfirmAlertView alloc] init];
        _confirmAlert.delegate = self;
        [self.view addSubview: _confirmAlert];
        [_confirmAlert mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    [self.view bringSubviewToFront:_confirmAlert];
    return _confirmAlert;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSArray* Arr=@[@{@"image":@"pay_tanb_Wechat",@"name":@"微信",@"state":@"1",@"aid":@"1"},@{@"image":@"pay_tanb_Alipay",@"name":@"微信",@"state":@"0",@"aid":@"2"}];
//    self.payArr=[NSMutableArray arrayWithCapacity:0];
//    for (NSDictionary *dic in Arr) {
//        FNTePayDaNeModel *mode=[FNTePayDaNeModel mj_objectWithKeyValues:dic];
//        [self.payArr addObject:mode];
//    }
    _payStr = @"请选择支付方式";
//    self.consumptionModel=1;
    self.headerType=@"toStore";
    self.pay_typeString=@"";
    self.title=self.storeName;//@"茶语休闲连锁(南屏店)";
    [self apiRequestHeaderType];
    [self subRushBottomView];
    [self distributionReckoningView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWxSuccess) name:@"Wx_Resp_Success" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWxCancle) name:@"Wx_Resp_Cancle" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWxFailed) name:@"Wx_Resp_Failed" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([_establishOid kr_isNotEmpty]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)distributionReckoningView{
    self.jm_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-50) style:UITableViewStylePlain];
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.hidden = YES;
    self.jm_tableview.showsVerticalScrollIndicator=NO;
    self.jm_tableview.showsHorizontalScrollIndicator=NO;

    [self.jm_tableview registerClass:[FNRushPaySelectionCell class] forCellReuseIdentifier:@"FNRushPaySelectionCell"];
    
    [self.view addSubview:self.jm_tableview];
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.estimatedRowHeight = 0;
        self.jm_tableview.estimatedSectionFooterHeight = 0;
        self.jm_tableview.estimatedSectionHeaderHeight= 0;
        self.jm_tableview.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
    self.jm_tableview.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, isIphoneX ? 84 :50).topSpaceToView(self.view, 0);
    self.jm_tableview.backgroundColor=RGB(237, 237, 237);
    
}

- (void)showOrder {
    FNTeOrderDetailsDeController *vc=[[FNTeOrderDetailsDeController alloc]init];
//    vc.state=indexPath.row;
    vc.oidString=self.establishOid;
    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==1){
//        return self.payArr.count;
        return 1;
    }
    if(section==2){
        return self.cartArr.count;
    }
    if (section == 3) {
//        return 2;
        FNrushPurchaseNeModel *model=[FNrushPurchaseNeModel mj_objectWithKeyValues:self.orderData];
        return model.red_packets.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNrushPurchaseNeModel *model=[FNrushPurchaseNeModel mj_objectWithKeyValues:self.orderData];
        
        if([self.headerType isEqualToString:@"toStore"]){//到店消费
           FNRushStoreSiteNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"RushStoreSiteNeCellID"];
           if (cell == nil) {
                cell = [[FNRushStoreSiteNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RushStoreSiteNeCellID"];
           }
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
           cell.model=self.orderData;
           return cell;
        }else{
            //FNrushBuyMsgModel *buyModel=[FNrushBuyMsgModel mj_objectWithKeyValues:model.buy_msg];
            FNrushBuyMsgModel *buyModel=[FNrushBuyMsgModel mj_objectWithKeyValues:self.buyMsgDicTry];
            
            if([buyModel.name kr_isNotEmpty]){
                //外卖配送
                FNRushDeliveryLocationNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"DeliveryLocationNeCellID"];
                if (cell == nil) {
                    cell = [[FNRushDeliveryLocationNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DeliveryLocationNeCellID"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model=self.buyMsgDicTry;
                return cell;
            }else{
                FNRushNoLocationDaNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"NoLocationDaNeCellID"];
                if (cell == nil) {
                    cell = [[FNRushNoLocationDaNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoLocationDaNeCellID"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate=self;
                cell.model=self.buyMsgDicTry;
                return cell;
            }
        } 
    }else if(indexPath.section==1){
        
        FNRushPaySelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNRushPaySelectionCell"];
        
        cell.lblTitle.text = @"支付方式";
        cell.lblDesc.text = _payStr;
        
        return cell;
    }
    else if(indexPath.section==2){
        FNrushPurchCartNeModel *model=self.cartArr[indexPath.row];
        if([model.type isEqualToString:@"goods"]){
            FNRushCommodityMeNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CommodityMeNeCellID"];
            if (cell == nil) {
                cell = [[FNRushCommodityMeNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommodityMeNeCellID"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model=model;
            return cell;
        }else{
            //配送费=>extra_costs 优惠=>discount
            FNRushPackagingMeNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PackagingMeNeCellID"];
            if (cell == nil) {
                cell = [[FNRushPackagingMeNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PackagingMeNeCellID"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model=model;
            return cell;
        }
        
    }
    
    if (indexPath.section == 3) {
        FNRushPaySelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNRushPaySelectionCell"];
        FNrushPurchaseNeModel *model=[FNrushPurchaseNeModel mj_objectWithKeyValues:self.orderData];

        
        cell.lblTitle.text = model.red_packets[indexPath.row].str;
        cell.lblDesc.text = model.red_packets[indexPath.row].counts_str;
        cell.lblDesc.textColor = [UIColor colorWithHexString:model.red_packets[indexPath.row].color];
        
        return cell;
    }
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TePayModelDaNeCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TePayModelDaNeCellID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if(section==0){
        FNRushConsumeHeaderNeView* HeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ConsumeHeaderNeView"];
        if (HeaderView == nil) {
            HeaderView = [[FNRushConsumeHeaderNeView alloc]initWithReuseIdentifier:@"ConsumeHeaderNeView"];
        }
        HeaderView.backgroundColor=[UIColor whiteColor];
        HeaderView.delegate=self;
        HeaderView.buyArr=self.headerBuyArr;
        for (NSInteger index = 0; index < self.headerBuyArr.count; index ++) {
            if ([self.headerBuyArr[index][@"type"] isEqualToString:self.headerType]) {
                [HeaderView setSelectAt: index];
                break;
            }
        }
        return HeaderView;
    }
    else if(section==1){
        return [[UIView alloc] init];
    } else if (section == 3) {
        return [[UIView alloc] init];
    }
    else{ 
        FNRushConsumeTextHeaderView* HeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"twoRushConsumeTextHeaderView"];
        if (HeaderView == nil) {
            HeaderView = [[FNRushConsumeTextHeaderView alloc]initWithReuseIdentifier:@"twoRushConsumeTextHeaderView"];
        }
        FNrushPurchaseNeModel *model=[FNrushPurchaseNeModel mj_objectWithKeyValues:self.orderData];
        HeaderView.titleName.text=[NSString stringWithFormat:@"  %@",model.storename];//@"  茶语休闲连锁(南屏店)";
        HeaderView.backgroundColor=RGB(237, 237, 237);
        HeaderView.lineLb.backgroundColor=[UIColor whiteColor];
        return HeaderView;
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section==0){
        if([self.headerType isEqualToString:@"toStore"]){
           FNRushMealFooterNeView* footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RushMealFooterNeViewID"];
           if (footerView == nil) {
                footerView = [[FNRushMealFooterNeView alloc]initWithReuseIdentifier:@"RushMealFooterNeViewID"];
           }
            footerView.backgroundColor=[UIColor whiteColor];
            footerView.delegate=self;
            //footerView.dicModel=self.orderData;
            footerView.buymsg=self.buymsg;
           return footerView;
        }else{
            FNRushArriveDateFooterView* footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RushArriveDateFooterID"];
            if (footerView == nil) {
                footerView = [[FNRushArriveDateFooterView alloc]initWithReuseIdentifier:@"RushArriveDateFooterID"];
            }
            footerView.backgroundColor=[UIColor whiteColor];
            footerView.dicModel=self.orderData;
            return footerView;
        }
    }else if(section==3){
        FNRushRelationStoreFooterView* footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RushRelationStoreFooterID"];
        if (footerView == nil) {
            footerView = [[FNRushRelationStoreFooterView alloc]initWithReuseIdentifier:@"RushRelationStoreFooterID"];
        }
        footerView.delegate=self;
        footerView.dataModel=self.orderData;
        footerView.topLineLb.backgroundColor=[UIColor whiteColor];
        return footerView;
    }else{
        return [UIView new];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        //FNrushPurchaseNeModel *model=[FNrushPurchaseNeModel mj_objectWithKeyValues:self.orderData];
        //FNrushBuyMsgModel *buyModel=[FNrushBuyMsgModel mj_objectWithKeyValues:model.buy_msg];
        FNrushBuyMsgModel *buyModel=[FNrushBuyMsgModel mj_objectWithKeyValues:self.buyMsgDicTry];
        if([buyModel.address kr_isNotEmpty]){
            XYLog(@"选择地址");
            FNRushSiteListDaNeController *vc=[[FNRushSiteListDaNeController alloc]init];
            vc.delegate=self;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if(indexPath.section==1){
        [self.payTypeAlert show];
    }
    
    if (indexPath.section == 3) {
        FNrushPurchaseNeModel *model=[FNrushPurchaseNeModel mj_objectWithKeyValues:self.orderData];
        if (model.red_packets[indexPath.row].list.count == 0) {
            return;
        }
        _couponeType = model.red_packets[indexPath.row].discount_type;
        FNStoreMyCouponeController *vc = [[FNStoreMyCouponeController alloc] init];
        vc.coupones = model.red_packets[indexPath.row].list;
        vc.title = model.red_packets[indexPath.row].str;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
        if ([model.red_packets[indexPath.row].discount_type isEqualToString:@"hongbao"]) {
            
        } else if ([model.red_packets[indexPath.row].discount_type isEqualToString:@"yhq"]) {
//            FNStoreMyCouponeController *vc = [[FNStoreMyCouponeController alloc] init];
//            vc.coupones = model.red_packets[indexPath.row].list;
//            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return 10;
    }
    else if (section == 3) {
        return 0;
    }
    return 60;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==1 || section == 2){
        return 0;
    }
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if([self.headerType isEqualToString:@"toStore"]){
            return  50;
        }else{
            return  60;
        }
    }
    else if(indexPath.section==1){
        return  40;
    }
    else if (indexPath.section == 3) {
        return 40;
    }
    else{
        return 35;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView == self.jm_tableview) {
        CGFloat sectionHeaderHeight = 60;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
        
//        CGFloat sectionHeaderHeight = 60;
//        CGFloat sectionFooterHeight = 60;
//        CGFloat offsetY = self.jm_tableview.contentOffset.y;
//        if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
//        {
//            self.jm_tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
//        } else if (offsetY >= sectionHeaderHeight && offsetY <= self.jm_tableview.contentSize.height - self.jm_tableview.frame.size.height - sectionFooterHeight)
//        {
//            self.jm_tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
//        } else if (offsetY >= self.jm_tableview.contentSize.height - self.jm_tableview.frame.size.height - sectionFooterHeight && offsetY <= self.jm_tableview.contentSize.height - self.jm_tableview.frame.size.height)
//        {
//            self.jm_tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(self.jm_tableview.contentSize.height - self.jm_tableview.frame.size.height - sectionFooterHeight), 0);
//        }
    }
}

#pragma mark - FNRushConsumeHeaderNeViewDelegate  点击切换模式: 到店消费  外卖配送
- (void)consumeHeader: (FNRushConsumeHeaderNeView*)view didItemSelectedAt: (NSInteger)index {
    FNrushBuyTypeNeModel *model=[FNrushBuyTypeNeModel mj_objectWithKeyValues:self.headerBuyArr[index]];
    self.headerType=model.type;
//    self.consumptionModel=index + 1;
    _yhq_id = @"";
    _red_packet_id = @"";
    [self apiRequestPresentOrderShow];
    [self.jm_tableview reloadData];
}
//// 点击到店消费
//- (void)storeReachClickAction{
//    XYLog(@"到店消费");
//    FNrushBuyTypeNeModel *model=[FNrushBuyTypeNeModel mj_objectWithKeyValues:self.headerBuyArr[0]];
//    self.headerType=model.type;
//    self.consumptionModel=1;
//    _yhq_id = @"";
//    _red_packet_id = @"";
//    [self apiRequestPresentOrderShow];
//    [self.jm_tableview reloadData];
//}
//// 点击外卖配送
//- (void)storeDeliveryClickAction{
//    XYLog(@"外卖配送");
//    if (self.headerBuyArr.count < 2) {
//        return;
//    }
//    FNrushBuyTypeNeModel *model=[FNrushBuyTypeNeModel mj_objectWithKeyValues:self.headerBuyArr[1]];
//    self.headerType=model.type;
//    self.consumptionModel=2;
//    _yhq_id = @"";
//    _red_packet_id = @"";
//    [self apiRequestPresentOrderShow];
//    [self.jm_tableview reloadData];
//}
#pragma mark - FNRushMealFooterNeViewDelegate 到店消费 - 编辑手机号码
// 编辑手机号码
- (void)storeCopyreaderCellphoneAction{
    XYLog(@"编辑手机号码");
//    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"请输入手机号码"
//                                                         message:nil delegate:self
//                                               cancelButtonTitle:@"取消"
//                                               otherButtonTitles:@"确定", nil];
//    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
//    UITextField *_phoneTextField = [alertView textFieldAtIndex:0];
//    _phoneTextField.placeholder = @"请输入手机号码";
//    //_phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
//    [alertView show];
//    FNrushPurchaseNeModel *model=[FNrushPurchaseNeModel mj_objectWithKeyValues:self.orderData];
//    FNrushBuyMsgModel *buymsg=[FNrushBuyMsgModel mj_objectWithKeyValues:model.buy_msg];
//
//    self.phone=buymsg.phone;
    @WeakObj(self);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"编辑预留手机号码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入手机号码";
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField * firstKeywordTF = [[UITextField alloc]init];
        NSArray * textFieldArr = @[firstKeywordTF];
        textFieldArr = alertController.textFields;
        UITextField * phoneText = alertController.textFields[0];
        NSLog(@" %@",phoneText.text);
            self.buymsg.phone=phoneText.text;
            self.phone=phoneText.text;
            [selfWeak.jm_tableview reloadData];
    }]];
    [self presentViewController:alertController animated:true completion:nil];
}
#pragma mark - FNRushRelationStoreFooterViewDelegate 联系商家
// 联系商家
- (void)storeRelationPhoneAction{
    XYLog(@"联系商家");
    FNrushPurchaseNeModel *model=[FNrushPurchaseNeModel mj_objectWithKeyValues:self.orderData];
    if([model.phone kr_isNotEmpty]){
        NSString *str = [NSString stringWithFormat:@"tel:%@",model.phone];
        
        UIWebView *callWebView = [[UIWebView alloc]init];
        
        [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        
        [self.view addSubview:callWebView];
    }
}
#pragma mark - @protocol FNRushNoLocationDaNeCellDelegate 添加地址
- (void)rushAddLoctionAction{
    //XYLog(@"添加地址");
    FNRushSiteListDaNeController *vc=[[FNRushSiteListDaNeController alloc]init];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - FNRushSiteListDaNeControllerDelegate // 地址界面选择地址

- (void)siteListSelectAddressAction:(NSDictionary*)send{
    XYLog(@"选择地址结果:%@",send);
    self.buyMsgDicTry =send;
    FNrushBuyMsgModel *model=[FNrushBuyMsgModel mj_objectWithKeyValues:send];
    if([model.name kr_isNotEmpty]){
        self.aid=model.id;
    }
    [self apiRequestPresentOrderShow];
//    [self.jm_tableview reloadData];
}
#pragma mark -  底部view
-(void)subRushBottomView{
    UIView *bootmRushView=[[UIView alloc]init];
    bootmRushView.frame=CGRectMake(0, FNDeviceHeight-50, FNDeviceWidth, 50);
    bootmRushView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bootmRushView];
    
    UIView *bootmRightView=[[UIView alloc]init];
    bootmRightView.backgroundColor=[UIColor whiteColor];
    [bootmRushView addSubview:bootmRightView];
    
    UILabel *markLB=[[UILabel alloc]init];
    markLB.textColor=RGB(255, 155, 48);
    markLB.font=kFONT12;
    [bootmRightView addSubview:markLB];
    
    UILabel *priceLB=[[UILabel alloc]init];
    priceLB.textColor=RGB(255, 155, 48);
    priceLB.font=kFONT15;
    [bootmRightView addSubview:priceLB];
    
    
    UILabel *antipateLB=[[UILabel alloc]init];
    antipateLB.textColor=RGB(200, 200, 200);
    antipateLB.font=kFONT12;
    [bootmRightView addSubview:antipateLB];
    
    
    UIButton *bootmLeftButton=[[UIButton alloc]init];
    bootmLeftButton.backgroundColor=RGB(246, 51, 40);
    bootmLeftButton.titleLabel.font=kFONT14;
    [bootmLeftButton addTarget:self action:@selector(bootmLeftButtonClick)];
    [bootmRushView addSubview:bootmLeftButton];
    
    
    CGFloat RrightThan =375 / 520;
    double  rightBi=375/520;
    CGFloat leftThan=0.35;//145/520;
    CGFloat space_10=10;
    CGFloat space_20=20;
    CGFloat space_5=5;
    CGFloat rightWith=FNDeviceWidth*0.65;
    
    bootmRushView.sd_layout
    .bottomSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).leftSpaceToView(self.view, 0).heightIs(isIphoneX ? 84 : 50);
    
    bootmRightView.sd_layout
    .topSpaceToView(bootmRushView, 0).leftSpaceToView(bootmRushView, 0).heightIs(50).widthIs(rightWith);
    NSString *markString=@"¥";
    CGFloat markLBW =  [self getWidthWithText:markString height:20 font:12];
    markLB.sd_layout
    .topSpaceToView(bootmRightView, space_5).leftSpaceToView(bootmRightView, space_20+space_5).widthIs(markLBW).heightIs(20);
    
    priceLB.sd_layout
    .topSpaceToView(bootmRightView, space_5).leftSpaceToView(markLB, space_5).rightSpaceToView(bootmRightView, space_10).heightIs(20);
    
    antipateLB.sd_layout
    .topSpaceToView(priceLB, space_5).leftSpaceToView(bootmRightView, space_20+space_5).rightSpaceToView(bootmRightView, space_10).heightIs(15);
    
    bootmLeftButton.sd_layout
    .topSpaceToView(bootmRushView, 0).leftSpaceToView(bootmRightView, 0).rightSpaceToView(bootmRushView, 0).heightIs(50);
    self.markLB=markLB;
    self.priceLB=priceLB;
    self.antipateLB=antipateLB;
    self.bootmLeftButton=bootmLeftButton;
}
#pragma mark -  //下单
-(void)bootmLeftButtonClick{
    XYLog(@"下单");
    if (![_pay_typeString kr_isNotEmpty]) {
        [self.payTypeAlert show];
        return;
    }
    FNrushPurchaseNeModel *model=[FNrushPurchaseNeModel mj_objectWithKeyValues:self.orderData];
    [self.confirmAlert setModel: model payType: _payStr];
    [self.confirmAlert show];
    
}
#pragma mark -  Request
//获取提交订单头部类型
- (FNRequestTool *)apiRequestHeaderType{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"store_id":self.storeID}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_suborder&ctrl=show_order_type" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"小店:%@",respondsObject);
        NSDictionary* dataDic = respondsObject[DataKey];
        NSArray *typearr=dataDic[@"buy_type"];
        selfWeak.headerBuyArr=typearr;
        self.headerType=typearr[0][@"type"];
        [self apiRequestPresentOrderShow];
        [selfWeak.jm_tableview reloadData];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark -  //提交订单显示页面
- (FNRequestTool *)apiRequestPresentOrderShow{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"store_id":self.storeID}];
    if([self.headerType kr_isNotEmpty]){
        params[@"type"]=self.headerType;
    }
    if ([_yhq_id kr_isNotEmpty]) {
        params[@"yhq_id"] = _yhq_id;
    }
    if ([_red_packet_id kr_isNotEmpty]) {
        params[@"red_packet_id"] = _red_packet_id;
    }
    if ([_aid kr_isNotEmpty]) {
        params[@"aid"] = _aid;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_suborder&ctrl=show_order" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"小店:%@",respondsObject);
        NSMutableDictionary* dataDic = respondsObject[DataKey];
        FNrushPurchaseNeModel *model=[FNrushPurchaseNeModel mj_objectWithKeyValues:dataDic];
        FNrushBuyMsgModel *buymsg=[FNrushBuyMsgModel mj_objectWithKeyValues:model.buy_msg];
        selfWeak.buyMsgDicTry =model.buy_msg;
        selfWeak.buymsg =buymsg;
        selfWeak.aid=buymsg.aid;//model.buy_msg[@"aid"];
        selfWeak.phone=buymsg.phone;
        selfWeak.orderData=dataDic;
        //selfWeak.headerBuyArr=dataDic[@"buy_type"];
        NSArray *cartArray=model.cart;
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in cartArray) {
            [arrM addObject:[FNrushPurchCartNeModel mj_objectWithKeyValues:dic]];
        }
        selfWeak.cartArr=arrM;
        NSArray *payArray=model.pay_type;
        NSMutableArray *payAry=[NSMutableArray arrayWithCapacity:0];
        for(NSInteger i=0;i<payArray.count;i++){
            FNTePayDaNeModel *model=[FNTePayDaNeModel mj_objectWithKeyValues:payArray[i]];
            model.state=0;
            if(i==0){
               model.state=1;
//                selfWeak.pay_typeString=model.type;
            }
            [payAry addObject:model];
        }
        selfWeak.payArr=payAry;
        selfWeak.markLB.text=@"¥";
        selfWeak.priceLB.text=model.sum;
        selfWeak.antipateLB.text=model.str;//@"预计可得赏金¥8.9";
        [selfWeak.bootmLeftButton setTitle:model.str1 forState:UIControlStateNormal];
        [selfWeak.jm_tableview reloadData];
        self.jm_tableview.hidden = NO;
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark -  创建订单
- (FNRequestTool *)apiRequestEstablishIndent{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"store_id":self.storeID}];
    if([self.headerType kr_isNotEmpty]){
        params[@"buy_type"]=self.headerType;
    }
    if([self.headerType isEqualToString:@"toStore"]){
        params[@"phone"]= self.buymsg.phone;
    }
    if([self.aid kr_isNotEmpty]){
        params[@"aid"]=self.aid;
    }
    if([self.pay_typeString kr_isNotEmpty]){
        params[@"pay_type"]=self.pay_typeString;
    }
    if ([_yhq_id kr_isNotEmpty]) {
        params[@"yhq_id"] = _yhq_id;
    }
    if ([_red_packet_id kr_isNotEmpty]) {
        params[@"red_packet_id"] = _red_packet_id;
    }
    @weakify(self)
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_suborder&ctrl=createOrder" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        XYLog(@"创建订单结果:%@",respondsObject);
        NSDictionary* dataDic = respondsObject[DataKey];
        selfWeak.establishOid=dataDic[@"oid"];
        if([self.pay_typeString isEqualToString:@"zfb"] || [self.pay_typeString isEqualToString:@"wx"]){
            [self apiRequestZfbWx: self.pay_typeString];
        }
        if([self.pay_typeString isEqualToString:@"yue"]){
           [self apiRequestYUE];
        }
        
        [self.confirmAlert dismiss];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

//
#pragma mark -  购买商品余额支付
- (FNRequestTool *)apiRequestYUE{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    if([self.establishOid kr_isNotEmpty]){
        params[@"oid"]=self.establishOid;
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

#pragma mark -  购买商品微信支付
- (FNRequestTool *)apiRequestZfbWx : (NSString*)payType{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    if([self.establishOid kr_isNotEmpty]){
        params[@"oid"]=self.establishOid;
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
    [FNTipsView showTips:@"支付成功"];
    [self backViewControllerType];
}

- (void)onWxCancle {
    [FNTipsView showTips:@"取消支付"];
    [self backViewControllerType];
}

- (void)onWxFailed {
    [FNTipsView showTips:@"支付失败"];
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
    [self showOrder];
}
- (NSMutableArray *)cartArr {
   if (!_cartArr) {
        _cartArr = [NSMutableArray array];
    }
    return _cartArr;
}
- (NSMutableArray *)payArr {
    if (!_payArr) {
        _payArr = [NSMutableArray array];
    }
    return _payArr;
}
//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}


#pragma mark - FNNewStorePayTypeAlertViewDelegate

- (void)payTypeAlert: (FNNewStorePayTypeAlertView*)view didSelected: (FNNewStorePayTypeModel*) type {
    _pay_typeString = type.type;
    _payStr = type.str;
    
    [self.jm_tableview reloadData];
}

#pragma mark - FNNewStorePayConfirmAlertViewDelegate

- (void)didPayClick: (FNNewStorePayConfirmAlertView*)view {
    if([self.headerType isEqualToString:@"toStore"]){
        if([self.phone kr_isNotEmpty]){
            [self apiRequestEstablishIndent];
        }else{
            [FNTipsView showTips:@"请设置预留手机号!" withDuration:2.0];
        }
    }else if([self.headerType isEqualToString:@"takeOut"]){
        if([self.aid kr_isNotEmpty]){
            [self apiRequestEstablishIndent];
        }else{
            [FNTipsView showTips:@"请添加收货地址!" withDuration:2.0];
        }
    }
}

#pragma mark - FNStoreMyCouponeControllerDelegate

- (void) couponeVc: (FNStoreMyCouponeController*)vc didSelected: (FNStoreMyCouponeModel*)coupone {
    if ([_couponeType isEqualToString:@"hongbao"]) {
        _red_packet_id = coupone.id;
    } else if ([_couponeType isEqualToString:@"yhq"]) {
        _yhq_id = coupone.id;
    }
    
    [self apiRequestPresentOrderShow];
}


@end
