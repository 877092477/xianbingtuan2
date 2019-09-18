//
//  FNmerchantMembersController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerchantMembersController.h"
#import "FNCustomeNavigationBar.h"
#import "FNmerMembersHeadView.h"
#import "FNmerMembersUsersCell.h"
#import "FNmerMemberOrderItemCell.h"
#import "FNmerMembersModel.h"
#import "FNmeMembersIndentSController.h"
#import "FNmeMeEvaluateListVC.h"
#import "FNmerInformationsController.h"
#import "FNmemberFicheListVC.h"
#import "FNRushSiteListDaNeController.h"
@interface FNmerchantMembersController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNmerMembersHeadViewDelegate,FNRushSiteListDaNeControllerDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)FNmerMembersUserModel *dataModel;
@property (nonatomic, strong)UIImageView *imgBgView;
@end

@implementation FNmerchantMembersController

- (BOOL)isFullScreenShow {
    return YES;
}

- (BOOL)needLogin {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
}
#pragma mark - set up views
- (void)jm_setupViews{
    
    [self reloadModels:@[]];
    [self inAddSubViewImg];
    CGFloat baseGap=0;
    if(self.understand==YES){
        baseGap=XYTabBarHeight;
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    self.jm_collectionview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.jm_collectionview];
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.jm_collectionview.sd_layout
    .leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, 0).bottomSpaceToView(self.view, baseGap);
    [self.jm_collectionview registerClass:[FNmerMembersUsersCell class] forCellWithReuseIdentifier:@"FNmerMembersUsersCellID"];
    [self.jm_collectionview registerClass:[FNmerMemberOrderItemCell class] forCellWithReuseIdentifier:@"FNmerMemberOrderItemCellID"];
    
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
 
    [self.jm_collectionview registerClass:[FNmerMembersHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNmerMembersHeadViewID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewHeadID"];
    
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView"];
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 10).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.titleLabel.text=@"会员中心";
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.view.backgroundColor = RGB(246, 245, 245);
    if([UserAccessToken kr_isNotEmpty]){
       [self requestMemberHeader];
    }
}
- (void)inAddSubViewImg{
    CGFloat imgHight=110+SafeAreaTopHeight;
    self.imgBgView = [[UIImageView alloc] init];
    [self.view insertSubview:self.imgBgView atIndex:0];
    [self.imgBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(imgHight);
    }];
    self.imgBgView.contentMode = UIViewContentModeScaleAspectFill;
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FNmerMembersModel *model=self.dataArr[section];
    NSArray *arrList=model.list;
    return arrList.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNmerMembersModel *model=self.dataArr[indexPath.section];
    NSArray *arrList=model.list;
    if([model.type isEqualToString:@"user"]){
        FNmerMembersUsersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerMembersUsersCellID" forIndexPath:indexPath];
        [cell.headImg setUrlImg:self.dataModel.head_img];
        cell.nameLB.text=self.dataModel.user_name;
        return cell;
    }
    else if([model.type isEqualToString:@"order"]){
        FNmerMemberOrderItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerMemberOrderItemCellID" forIndexPath:indexPath];
        cell.model=[FNmerMembersOrderItemModel mj_objectWithKeyValues:arrList[indexPath.row]];
        return cell;
    }
    else{
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
            return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat itemHeight=0;
    CGFloat itemWith=FNDeviceWidth;
    FNmerMembersModel *model=self.dataArr[indexPath.section];
    if([model.type isEqualToString:@"user"]){
        itemHeight=SafeAreaTopHeight+70;
    }
    else if([model.type isEqualToString:@"order"]){
        itemHeight=60;
    }else{
        itemHeight=0;
    }
    return  CGSizeMake(itemWith, itemHeight);
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
         FNmerMembersModel *model=self.dataArr[indexPath.section];
        if([model.type isEqualToString:@"user"]){
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewHeadID" forIndexPath:indexPath];
            headerView.backgroundColor=[UIColor clearColor];
            return headerView;
        }else{
            FNmerMembersHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNmerMembersHeadViewID" forIndexPath:indexPath];
            headerView.backgroundColor=[UIColor clearColor];
            headerView.model=model;
            headerView.index=indexPath;
            headerView.delegate=self;
            return headerView;
        }
    }
    else{
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView" forIndexPath:indexPath];
        footView.backgroundColor=[UIColor clearColor];
        return footView;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=45;
    FNmerMembersModel *model=self.dataArr[section];
    if([model.type isEqualToString:@"user"]){
        hight=0;
    }
    else{
        hight=45;
    }
    return CGSizeMake(with,hight);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=15;
    FNmerMembersModel *model=self.dataArr[section];
    if([model.type isEqualToString:@"user"]){
        hight=0;
    }
    else{
        hight=15;
    }
    return CGSizeMake(with,hight);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - FNmerMembersHeadViewDelegate
- (void)didMerHeaderLucencySeletedClickIndex:(NSIndexPath*)index{
    FNmerMembersModel *model=self.dataArr[index.section];
    if([model.type isEqualToString:@"order"]){
       //我的订单
        FNmeMembersIndentSController *vc=[[FNmeMembersIndentSController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if([model.type isEqualToString:@"evaluate"]){
        //我的评价
        FNmeMeEvaluateListVC *vc=[[FNmeMeEvaluateListVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if([model.type isEqualToString:@"arch"]){
      //优惠券
        FNmemberFicheListVC *vc=[[FNmemberFicheListVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if([model.type isEqualToString:@"bag"]){
        //红包
        FNmemberFicheListVC *vc=[[FNmemberFicheListVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if([model.type isEqualToString:@"word"]){
        //消息通知
        FNmerInformationsController *vc=[[FNmerInformationsController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if([model.type isEqualToString:@"site"]){
        //我的收货地址
        FNRushSiteListDaNeController *vc=[[FNRushSiteListDaNeController alloc]init];
        vc.delegate=self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
#pragma mark - FNRushSiteListDaNeControllerDelegate // 地址界面选择地址  
- (void)siteListSelectAddressAction:(NSDictionary*)send{
    XYLog(@"选择地址结果:%@",send);
//    self.buyMsgDicTry =send;
//    FNrushBuyMsgModel *model=[FNrushBuyMsgModel mj_objectWithKeyValues:send];
//    if([model.name kr_isNotEmpty]){
//        self.aid=model.id;
//    }
    
}
#pragma mark - 点击
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    CGFloat imgH=110+SafeAreaTopHeight;
    if (conY<0) {
        [self.imgBgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
            make.height.mas_equalTo(imgH - conY);
        }];
    }else{
        [self.imgBgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(-conY);
            make.height.mas_equalTo(imgH);
        }];
    }
    if (conY>0 && conY<=JMNavBarHeigth) {
        //滚动中
        self.navigationView.backgroundColor = [RGB(255, 142, 45) colorWithAlphaComponent:conY/JMNavBarHeigth];
    }else if (conY > JMNavBarHeigth){
        self.navigationView.backgroundColor = RGB(255, 142, 45);
    }else{
        self.navigationView.backgroundColor = [UIColor clearColor];
    }
}
#pragma mark - request
//小店会员中心页面接口
-(FNRequestTool*)requestMemberHeader{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_store_other&ctrl=center" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary *dictry = respondsObject[DataKey];
        self.dataModel=[FNmerMembersUserModel mj_objectWithKeyValues:dictry];
        [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
        [self.imgBgView setUrlImg:self.dataModel.top_bj];
        self.navigationView.titleLabel.text=self.dataModel.title;
        self.navigationView.titleLabel.textColor=[UIColor colorWithHexString:self.dataModel.top_color];
        self.navigationView.backgroundColor=[UIColor clearColor]; 
        NSArray *orderList=self.dataModel.orders;
        if(orderList.count>0){
            [self reloadModels:orderList];
        }
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}

-(void)reloadModels:(NSArray*)arr{
    NSArray *arrM=@[@{@"type":@"user",@"hint":@"",@"name":@"",@"img":@"",@"list":@[@""]}, @{@"type":@"order",@"hint":@"更多",@"name":@"我的订单",@"img":@"FJ_xY_img",@"list":arr},
                    @{@"type":@"evaluate",@"hint":@"",@"name":@"我的评价",@"img":@"FJ_xY_img",@"list":@[]},
                    @{@"type":@"arch",@"hint":@"",@"name":@"优惠券",@"img":@"FJ_xY_img",@"list":@[]},
                    @{@"type":@"bag",@"hint":@"",@"name":@"红包",@"img":@"FJ_xY_img",@"list":@[]},
                    @{@"type":@"word",@"hint":@"",@"name":@"消息通知",@"img":@"FJ_xY_img",@"list":@[]},
                    @{@"type":@"site",@"hint":@"编辑",@"name":@"我的收货地址",@"img":@"FJ_xY_img",@"list":@[]}];
    self.dataArr=[NSMutableArray arrayWithCapacity:0];
    [arrM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FNmerMembersModel *model=[FNmerMembersModel mj_objectWithKeyValues:obj];
        [self.dataArr addObject:model];
    }];
    [UIView performWithoutAnimation:^{
       [self.jm_collectionview reloadData];
    }];
}
@end
