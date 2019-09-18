//
//  FNCashActivityNeController.m
//  THB
//
//  Created by Jimmy on 2018/10/23.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNCashActivityNeController.h"
//view
#import "FNCashActivityHeaderView.h"
#import "FNCashActivityFooterNeView.h"
#import "FNcashActivityPictureNeCell.h"
#import "FNActivityNightNeCell.h"
#import "FNCashActivityGoodsListCell.h"
#import "FNCashFootFloorNeView.h"

//model
#import "FNCashActivityNeModel.h"

//controller
#import "FNCashAcShareNeController.h"

@interface FNCashActivityNeController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,FNActivityNightNeCellDelegate,FNCashActivityListNeViewDelegate>
/** 商品data **/
@property(nonatomic,strong)NSMutableArray *dataArray;
/** Settingdata **/
@property(nonatomic,strong)NSDictionary *settingData;
/** Sharefnuo_id **/
@property(nonatomic,strong)NSString *Sharefnuo_id;
@end

@implementation FNCashActivityNeController
#pragma mark - 一些系统的方法
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
    //[[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    [FNNotificationCenter addObserver:self selector:@selector(obserFNTaoLiJinChange) name:@"FNTaoLiJin" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[self.navigationController setNavigationBarHidden:NO animated:NO];
    //[[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"淘礼金";
    //[self apiRequestProduct];
    //[self apiRequestSetting];
    [self apiMainReqeuest];
    [self ActivityTableView];
    [FNNotificationCenter addObserver:self selector:@selector(obserFNTaoLiJinChange) name:@"FNTaoLiJin" object:nil];
}
-(void)obserFNTaoLiJinChange{
    [self apiRequestShareQueen];
}
-(void)dealloc{
    [FNNotificationCenter removeObserver:self];
}
#pragma mark -  单元
-(void)ActivityTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight;
    
    self.jm_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, tableHeight) style:UITableViewStylePlain];
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.backgroundColor=[UIColor whiteColor];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.hidden=YES;
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    self.jm_tableview.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.jm_tableview];
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.estimatedRowHeight = 0;
        self.jm_tableview.estimatedSectionFooterHeight = 0;
        self.jm_tableview.estimatedSectionHeaderHeight= 0;
        self.jm_tableview.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
    [self.jm_tableview registerClass:[FNCashActivityHeaderView class]  forHeaderFooterViewReuseIdentifier:@"CashActivityHeaderView"];
    [self.jm_tableview registerClass:[FNCashActivityFooterNeView class]  forHeaderFooterViewReuseIdentifier:@"CashActivityFooterNe"];
    [self.jm_tableview registerClass:[FNCashFootFloorNeView class]  forHeaderFooterViewReuseIdentifier:@"CashFootFloorNeView"];
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UITableView *tableview = (UITableView *)scrollView;
    CGFloat sectionHeaderHeight = 70;
    CGFloat sectionFooterHeight = 50;
    CGFloat offsetY = tableview.contentOffset.y;
    if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
    {
        tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
    } else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight)
    {
        tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
    } else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)
    {
        tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
    }
}
#pragma mark -  UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count+1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==1){
      FNCashActivityNeModel *model=[FNCashActivityNeModel mj_objectWithKeyValues:self.dataArray[section-1]];
      NSArray *itemArr=model.goods;
      return itemArr.count;
    }else{
      return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNCashActivitySetModel *setModel=[FNCashActivitySetModel mj_objectWithKeyValues:self.settingData];
    if(indexPath.section==0){
        FNcashActivityPictureNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PictureNeCellID"];
        if (cell == nil) {
            cell = [[FNcashActivityPictureNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PictureNeCellID"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor= [UIColor colorWithHexString:setModel.tlj_bj_color];
        cell.itemDic=self.settingData;
        [cell.regulationBtn addTarget:self action:@selector(regulationClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if(indexPath.section==1){
        FNCashActivityNeModel *model=[FNCashActivityNeModel mj_objectWithKeyValues:self.dataArray[indexPath.section-1]];
        NSArray *itemArr=model.goods;
        FNActivityNightNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityNightNeCellID"];
        if (cell == nil) {
            cell = [[FNActivityNightNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityNightNeCellID"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor= [UIColor colorWithHexString:setModel.tlj_bj_color];
        cell.itemModel=itemArr[indexPath.row];
        [cell.bgImageView setUrlImg:model.tlj_goods_img2];
        cell.delegate=self;
        return cell;
    }else{
        FNCashActivityNeModel *model=[FNCashActivityNeModel mj_objectWithKeyValues:self.dataArray[indexPath.section-1]];
        NSArray *itemArr=model.goods;
        FNCashActivityGoodsListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityGoodsListCellID"];
        if (cell == nil) {
            cell = [[FNCashActivityGoodsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityGoodsListCellID"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor= [UIColor colorWithHexString:setModel.tlj_bj_color];
        cell.modelArray=itemArr;
        cell.listNeView.delegate=self;
        [cell.bgTwoImageView setUrlImg:model.tlj_goods_img2];
        cell.modictry=self.dataArray[indexPath.section-1];
        return cell;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FNCashActivitySetModel *setModel=[FNCashActivitySetModel mj_objectWithKeyValues:self.settingData];
    if(section>0){
        FNCashActivityHeaderView *headerView = [[FNCashActivityHeaderView alloc]initWithReuseIdentifier:@"CashActivityHeaderView"];
        headerView.backgroundColor=[UIColor colorWithHexString:setModel.tlj_bj_color];
        FNCashActivityNeModel *model=[FNCashActivityNeModel mj_objectWithKeyValues:self.dataArray[section-1]];
        NSDictionary *dic=self.dataArray[section-1];
        headerView.itemDic=dic;
        [headerView.bgTwoImageView setUrlImg:model.tlj_goods_img1];
        [headerView.headImageView setUrlImg:model.tlj_goods_img4];
        headerView.backgroundColor=[UIColor colorWithHexString:setModel.tlj_bj_color];
        headerView.headTitle.textColor= [UIColor colorWithHexString:model.tlj_goodsfont_color];
        return headerView;
    }else{
        return [UIView new];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    FNCashActivitySetModel *setModel=[FNCashActivitySetModel mj_objectWithKeyValues:self.settingData];
    if(section==0){
        return [UIView new];
    }else if(section==self.dataArray.count){
        FNCashFootFloorNeView *footerView = [[FNCashFootFloorNeView alloc]initWithReuseIdentifier:@"CashFootFloorNeView"];
        footerView.backgroundColor=[UIColor colorWithHexString:setModel.tlj_bj_color];
        FNCashActivityNeModel *model=[FNCashActivityNeModel mj_objectWithKeyValues:self.dataArray[section-1]];
        NSDictionary *dic=self.dataArray[section-1];
        footerView.itemDic=dic;
        [footerView.bgImageView setUrlImg:model.tlj_goods_img3];
        footerView.floortitle.textColor=[UIColor colorWithHexString:setModel.tlj_font_color];
        footerView.rightView.backgroundColor=[UIColor colorWithHexString:setModel.tlj_font_color]; 
        footerView.leftView.backgroundColor=[UIColor colorWithHexString:setModel.tlj_font_color];
        return footerView;
    }else{
        FNCashActivityFooterNeView *footerView = [[FNCashActivityFooterNeView alloc]initWithReuseIdentifier:@"CashActivityFooterNe"];
        footerView.backgroundColor=[UIColor colorWithHexString:setModel.tlj_bj_color];
        FNCashActivityNeModel *model=[FNCashActivityNeModel mj_objectWithKeyValues:self.dataArray[section-1]];
        NSDictionary *dic=self.dataArray[section-1];
        footerView.itemDic=dic;
        [footerView.bgImageView setUrlImg:model.tlj_goods_img3];
        return footerView;
    }
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
       return 200;
    }else if(indexPath.section==1){
       return 140;
    }else{
       FNCashActivityNeModel *model=[FNCashActivityNeModel mj_objectWithKeyValues:self.dataArray[indexPath.section-1]];
       NSArray *itemArr=model.goods;
       if(itemArr.count>0){
            CGFloat count=itemArr.count;
            CGFloat row=count/2;
            CGFloat rowfull=ceilf(row);
            CGFloat hight=(FNDeviceWidth-25-10-5-20)/2 +90+5;
            return  hight*rowfull-5;
       }else{
           return 0;
       }
       
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
      return 0;
    }else{
      return 70;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==0){
        return 0;
    }else if(section==self.dataArray.count){
        return 70;
    }else{
        return 50;
    }
}
#pragma mark - FNActivityNightNeCellDelegate 点击立即购买
- (void)acNightPurchaseAction:(id)sender{
    XYLog(@"立即购买:%@",sender);
    FNCashActivityItemNeModel *model=[FNCashActivityItemNeModel mj_objectWithKeyValues:sender];
    self.Sharefnuo_id=model.fnuo_id;
    NSInteger is_joinInt=[model.is_join integerValue];
    NSString *shareImage=model.share_img;
    if(is_joinInt==1){
       [self goProductVCWithModel:sender];
    }else{
      [self umengShareWithURL:nil image:shareImage shareTitle:nil andInfo:nil];
    }
    
}
#pragma mark - FNCashActivityListNeViewDelegate 点击商品
- (void)caActivityListAction:(id)sender{
    XYLog(@"点击商品:%@",sender);
    [self goProductVCWithModel:sender];
}
#pragma mark - 活动规则
-(void)regulationClick{
    XYLog(@"活动规则");
    FNCashActivitySetModel *mode=[FNCashActivitySetModel mj_objectWithKeyValues:self.settingData];
    if([mode.act_url kr_isNotEmpty]){
       [self goWebWithUrl:mode.act_url];
    } 
}
#pragma mark - api request
- (void)apiMainReqeuest{
    @WeakObj(self);
    [FNRequestTool startWithRequests:@[[self apiRequestSetting],[self apiRequestProduct]] withFinishedBlock:^(NSArray *erros) {
        [selfWeak.jm_tableview reloadData];
        selfWeak.jm_tableview.hidden=NO;
    }];
}
#pragma mark - //获取产品
- (FNRequestTool *)apiRequestProduct{
    [SVProgressHUD show];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.show_type_str kr_isNotEmpty]){
        params[@"show_type_str"]=self.show_type_str;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=taolj_goods02&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSArray* array = respondsObject[DataKey];
        NSMutableArray *itemArr=[NSMutableArray array];
        XYLog(@"respondsObject:%@",respondsObject);
        for (NSDictionary *dictry in array) {
            [itemArr addObject:dictry];
        }
        selfWeak.dataArray=itemArr;
        [selfWeak.jm_tableview reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [selfWeak apiRequestProduct];
    } isHideTips:YES];
}
#pragma mark - //淘礼金相关设置
- (FNRequestTool *)apiRequestSetting{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=taolj_goods02&ctrl=set" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        selfWeak.settingData = respondsObject[DataKey];
        [selfWeak.jm_tableview reloadData];
    } failure:^(NSString *error) {
        [selfWeak apiRequestSetting];
    } isHideTips:YES];
}
#pragma mark - //淘礼金商品分享后调用接口
- (FNRequestTool *)apiRequestShareQueen{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.Sharefnuo_id kr_isNotEmpty]){
        params[@"fnuo_id"]=self.Sharefnuo_id;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=taolj_goods02&ctrl=join_doing" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        
        [selfWeak apiRequestProduct];
    } failure:^(NSString *error) {
    } isHideTips:NO];
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
