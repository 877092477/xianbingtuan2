//
//  FNOddWelfareNeController.m
//  THB
//
//  Created by Jimmy on 2018/12/18.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//免单 零元购
#import "FNOddWelfareNeController.h"
//controller
#import "secondViewController.h"
#import "FNMendListDeController.h"
#import "FNmakeSingleDeController.h"
#import "FNFreeProductAlertController.h"
#import "FNFreeProductDetailController.h"
//view
#import "FNoddWelfDeCell.h"
#import "FNWelfareFlowDeCell.h"
#import "FNNewPeopleWelfareDeCell.h"
#import "FNNewPeopleWelfareDeNewCell.h"
#import "FNWelfMendDeCell.h"
#import "FNwelfTextNeReusableView.h"
//model
#import "FNwelfDeModel.h"


@interface FNOddWelfareNeController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNoddWelfDeCelllDegate,FNpeopleNewDeViewDegate,FNNewPeopleWelfareDeNewCellDelegate>
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIButton *rightBtn;
@property(nonatomic,strong) NSMutableArray *dataArray;
//福利商品
@property(nonatomic,strong) NSMutableArray *goodsArray;
@property(nonatomic,strong) NSString *regulationURL;
@end

@implementation FNOddWelfareNeController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=self.title?self.title:@"免单福利";
    //[self apiRequestOddWelfare];
    //[self apiRequestGoodsOddWelfare]; 
    [self oddViewCollectionview];
    [self apiStoreMainReqeuest];
    [self showGuide];
    [self setupNav];
}

#pragma mark - //导航栏
-(void)setupNav{
    UIButton *leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [leftBtn setTitleColor:FNBlackColor forState:UIControlStateNormal];
    [leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    [leftBtn sizeToFit];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.size=CGSizeMake(30,  30);
    self.leftBtn=leftBtn;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [rightbutton setTitle:@"补贴订单" forState:UIControlStateNormal];
    rightbutton.titleLabel.font = kFONT13;
    [rightbutton setTitleColor:RGB(129, 129, 129) forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn=rightbutton;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtnAction{
    if(![UserAccessToken kr_isNotEmpty]){
        [self gologin]; //[FNTipsView showTips: @"请先登录"];
        //return;
    }else{
        FNMendListDeController *vc=[[FNMendListDeController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)showGuide {
    NSString *token = UserAccessToken;
    NSString *key = [NSString stringWithFormat:@"%@_had_show_guide", token];
    BOOL hadShow = [[NSUserDefaults standardUserDefaults] boolForKey:key];
    if (hadShow) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    FNFreeProductAlertController *alert = [[FNFreeProductAlertController alloc] init];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - 主视图
-(void)oddViewCollectionview{
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight;
    if(self.understand==YES){
        tableHeight=FNDeviceHeight-SafeAreaTopHeight-XYTabBarHeight;
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 10;
    flowlayout.minimumInteritemSpacing = 10;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, tableHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.hidden=YES;
    [self.view addSubview:self.jm_collectionview];
    
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"mendcellId"];
    //[self.jm_collectionview registerClass:[FNoptionRightCollectionViewCell class] forCellWithReuseIdentifier:@"rightClassifycellId"];
    //新人免单头部
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"elseHeaderID"];
    [self.jm_collectionview registerClass:[FNwelfTextNeReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"miandan_newgoods_01"];
    //福利补贴头部
    [self.jm_collectionview registerClass:[FNwelfTextNeReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"miandan_flgoods_01"];
    //幻灯片 miandan_banner_01
    [self.jm_collectionview registerClass:[FNoddWelfDeCell class] forCellWithReuseIdentifier:@"miandan_banner_01"];
    //免单流程 miandan_flow_01
    [self.jm_collectionview registerClass:[FNWelfareFlowDeCell class] forCellWithReuseIdentifier:@"miandan_flow_01"];
    //新人免单 miandan_newgoods_01
//    [self.jm_collectionview registerClass:[FNNewPeopleWelfareDeCell class] forCellWithReuseIdentifier:@"miandan_newgoods_01"];
      [self.jm_collectionview registerClass:[FNNewPeopleWelfareDeNewCell class] forCellWithReuseIdentifier:@"miandan_newgoods_01"];
    
    //福利补贴 miandan_flgoods_01
    [self.jm_collectionview registerClass:[FNWelfMendDeCell class] forCellWithReuseIdentifier:@"miandan_flgoods_01"];
    
    self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [SVProgressHUD show];
        [self apiRequestGoodsOddWelfare];
    }];
    self.view.backgroundColor=RGB(240, 240, 240);
    self.jm_collectionview.backgroundColor=RGB(240, 240, 240);
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FNwelfDeModel *model=self.dataArray[section];
    NSString *type=model.type;
    NSArray *listArr=model.list;
    if([type isEqualToString:@"miandan_flgoods_01"]){
        return self.goodsArray.count;
    }
    else if([type isEqualToString:@"miandan_newgoods_01"]){
        if(listArr.count>0){
//            return 1;
            return listArr.count;//自己修改
        }
        return 0;
    }
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNwelfDeModel *model=self.dataArray[indexPath.section];
    NSString *type=model.type;
    if([type isEqualToString:@"miandan_banner_01"]){
        FNoddWelfDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"miandan_banner_01" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor]; 
        cell.bannerArray=model.list;
        cell.delegate=self;
        return cell;
    }
    else if([type isEqualToString:@"miandan_flow_01"]){
        FNWelfareFlowDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"miandan_flow_01" forIndexPath:indexPath];
        cell.backgroundColor =RGB(245, 245, 245);
        cell.listArr=model.list;
        cell.model=model;
        return cell;
    }
    else if([type isEqualToString:@"miandan_newgoods_01"]){//新人免单
        FNNewPeopleWelfareDeNewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"miandan_newgoods_01" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
   
        cell.itemDictry = model.list[indexPath.row];
        cell.grabBtn.tag = indexPath.row;
        cell.delegate= self;
        cell.indexPath = indexPath;
//        cell.dataArr=model.list;
//        cell.goodsView.delegate=self;
        return cell;
    }
    else if([type isEqualToString:@"miandan_flgoods_01"]){ 
        FNWelfMendDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"miandan_flgoods_01" forIndexPath:indexPath];
        if(self.goodsArray.count>0){
            FNwelfDeListItemModel *model=[FNwelfDeListItemModel mj_objectWithKeyValues:self.goodsArray[indexPath.row]];
            cell.model=model;
        }
        cell.backgroundColor=RGB(245, 245, 245);
        return cell;
    }
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"mendcellId" forIndexPath:indexPath];
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.5;
} 
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=FNDeviceWidth;
    CGSize size = CGSizeMake(with, 0);
    FNwelfDeModel *model=self.dataArray[indexPath.section];
    NSString *type=model.type;
    if([type isEqualToString:@"miandan_banner_01"]){
        if (model.list.count > 0) {
            FNwelfDeListItemModel *listItemModel=[FNwelfDeListItemModel mj_objectWithKeyValues:model.list[0]];
            CGFloat bili=[listItemModel.banner_bili floatValue];
            return CGSizeMake(with, FNDeviceWidth*bili);
        }
        return CGSizeMake(with, 0.01);
    }
    else if([type isEqualToString:@"miandan_flow_01"]){
        
        return CGSizeMake(with, 145);
    }
    else if([type isEqualToString:@"miandan_newgoods_01"]){
      
//        return CGSizeMake(with, 230);
         return CGSizeMake(XYScreenWidth, 120);
    }
    
    else if([type isEqualToString:@"miandan_flgoods_01"]){
        
        return CGSizeMake(with,170);
    }
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNwelfDeModel *model=self.dataArray[indexPath.section];
    NSString *type=model.type;
    if([type isEqualToString:@"miandan_flgoods_01"]){
       FNBaseProductModel *itemModel=[FNBaseProductModel mj_objectWithKeyValues:self.goodsArray[indexPath.row]];
//       [self goProductVCWithModel:itemModel];
        FNFreeProductDetailController *vc = [[FNFreeProductDetailController alloc] init];
        vc.fnuo_id = itemModel.fnuo_id;
        vc.act_type = itemModel.act_type;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([type isEqualToString:@"miandan_newgoods_01"]){

        [self inSeletedGoodsItemTouchClick:model.list[indexPath.row]];
        
        
        
    }
    
}

#pragma mark-- 马上抢
-(void)inSeletedGoodsItemNewClick:(NSInteger)tag setion:(nonnull NSIndexPath *)indexPath{

    FNwelfDeModel *model=self.dataArray[indexPath.section];
    [self inSeletedGoodsItemTouchClick:model.list[indexPath.row]];
    
////    XYLog(@"dicTryimg=:%@",dicTry);
//    FNBaseProductModel *model=[FNBaseProductModel mj_objectWithKeyValues:dicTry];
//    //    [self goProductVCWithModel:model];
//
//    FNFreeProductDetailController *vc = [[FNFreeProductDetailController alloc] init];
//    vc.fnuo_id = model.fnuo_id;
//    vc.act_type = model.act_type;
//    [self.navigationController pushViewController:vc animated:YES];
//
}




//我自定义的
-(void)inSeletedGoodsItemTouchClick:(NSDictionary*)dicTry{
    XYLog(@"dicTryimg=:%@",dicTry);
    FNBaseProductModel *model=[FNBaseProductModel mj_objectWithKeyValues:dicTry];
    //    [self goProductVCWithModel:model];
    
    FNFreeProductDetailController *vc = [[FNFreeProductDetailController alloc] init];
    vc.fnuo_id = model.fnuo_id;
    vc.act_type = model.act_type;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FNwelfDeModel *model=self.dataArray[indexPath.section];
    NSString *type=model.type;
   if([type isEqualToString:@"miandan_newgoods_01"]){
        self.regulationURL=model.url;
        FNwelfTextNeReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"miandan_newgoods_01" forIndexPath:indexPath];
        headerView.model=model;
        headerView.rightButton.hidden=NO;
        [headerView.rightButton addTarget:self action:@selector(regulationAction)];
        headerView.backgroundColor=RGB(245, 245, 245);
        return headerView;
    }
    
    else if([type isEqualToString:@"miandan_flgoods_01"]){
        FNwelfTextNeReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"miandan_flgoods_01" forIndexPath:indexPath];
        headerView.model=model;
        headerView.rightButton.hidden=YES;
        headerView.backgroundColor=RGB(245, 245, 245);
        return headerView;
    }else{
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"elseHeaderID" forIndexPath:indexPath];
        return headerView;
    }
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    FNwelfDeModel *model=self.dataArray[section];
    NSString *type=model.type;
    if([type isEqualToString:@"miandan_banner_01"]){
        return CGSizeMake(with,0);
    }
    else if([type isEqualToString:@"miandan_flow_01"]){
        return CGSizeMake(with, 0);
    }
    else if([type isEqualToString:@"miandan_newgoods_01"]){
        return CGSizeMake(with, 35);
    }
    else if([type isEqualToString:@"miandan_flgoods_01"]){
        return CGSizeMake(with, 35);
    }
    return CGSizeMake(JMScreenWidth, 0);
}
#pragma mark - 规则详情
-(void)regulationAction{
    XYLog(@"规则详情");
    if([self.regulationURL kr_isNotEmpty]){
        secondViewController *web = [secondViewController new];
        web.url = self.regulationURL;
        //[self.navigationController pushViewController:web animated:YES];
        FNmakeSingleDeController *vc = [FNmakeSingleDeController new];
        vc.url = self.regulationURL;
        vc.title=@"规则详情";
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - FNoddWelfDeCelllegate // 点击幻灯片
- (void)oddWelfBannerClick:(FNwelfDeListItemModel*)model{
    XYLog(@"url=:%@",model.url);
    if([model.url kr_isNotEmpty]){
        FNmakeSingleDeController *web = [FNmakeSingleDeController new];
        web.url = model.url;
        web.title=@"免单福利重要通知";
        [self.navigationController pushViewController:web animated:YES];
    }
    
}
#pragma mark - FNpeopleNewDeViewDegate // 新人
- (void)inSeletedGoodsItemClick:(NSDictionary*)dicTry{
    XYLog(@"dicTryimg=:%@",dicTry);
    FNBaseProductModel *model=[FNBaseProductModel mj_objectWithKeyValues:dicTry];
//    [self goProductVCWithModel:model];
    
    FNFreeProductDetailController *vc = [[FNFreeProductDetailController alloc] init];
    vc.fnuo_id = model.fnuo_id;
    vc.act_type = model.act_type;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Request
- (void)apiStoreMainReqeuest{
    @WeakObj(self);
    [SVProgressHUD show];
    [FNRequestTool startWithRequests:@[[self apiRequestOddWelfare],[self apiRequestGoodsOddWelfare]] withFinishedBlock:^(NSArray *erros) {
        [selfWeak.jm_collectionview reloadData];
        [SVProgressHUD dismiss];
        self.jm_collectionview.hidden=NO;
    }];
}
#pragma mark - Request 免单首页
- (FNRequestTool *)apiRequestOddWelfare{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appMiandan&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSArray* arr = respondsObject[DataKey];
        XYLog(@"免单首页:%@",arr);
        NSMutableArray *typeArr=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dictry in arr) {
            FNwelfDeModel *model=[FNwelfDeModel mj_objectWithKeyValues:dictry];
            [typeArr addObject:model];
        }
        selfWeak.dataArray=typeArr;
        [SVProgressHUD dismiss];
        selfWeak.jm_collectionview.hidden=NO;
        [selfWeak.jm_collectionview reloadData];
    } failure:^(NSString *error) {

    } isHideTips:YES];
}
//福利补贴商品
- (FNRequestTool *)apiRequestGoodsOddWelfare{
    @WeakObj(self);
    [selfWeak.jm_collectionview.mj_footer endRefreshing];
    [selfWeak.jm_collectionview.mj_header endRefreshing];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appMiandan&ctrl=getgoods" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSArray* arr = respondsObject[DataKey];
         XYLog(@"福利补贴商品:%@",arr);
        NSMutableArray *typeArr=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dictry in arr) {
            [typeArr addObject:dictry];
        }
        selfWeak.goodsArray=typeArr;
        [SVProgressHUD dismiss];
        selfWeak.jm_collectionview.hidden=NO;
        [selfWeak.jm_collectionview reloadData];
    } failure:^(NSString *error) {

    } isHideTips:YES];
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)goodsArray{
    if (!_goodsArray) {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}
@end
