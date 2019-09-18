//
//  FNCandiesMyController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCandiesMyController.h"
#import "FNCustomeNavigationBar.h"
#import "FNCandiesMyTopCell.h"
#import "FNcandieslereItemCell.h"
#import "FNcandiesTextHintCell.h"
#import "FNcandiesCountCell.h"
#import "FNCandiesMyModel.h"
#import "FNcandiesIncomeController.h"
#import "FNCandiesRankingController.h"
#import "FNcandiesGrowUpController.h"
#import "FNCandiesConversionController.h"
#import "FNdistrictConvertfeController.h"

@interface FNCandiesMyController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNcandiesTextHintCellDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)FNCandiesMyModel *dataModel;
@end

@implementation FNCandiesMyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self requestBendi];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
#pragma mark - set up views
- (void)jm_setupViews{
    CGFloat topGap=SafeAreaTopHeight;
    CGFloat baseGap=0;
    if(self.understand==YES){
        baseGap=XYTabBarHeight;
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, topGap, FNDeviceWidth, FNDeviceHeight-topGap-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    [self.view addSubview:self.jm_collectionview];
    
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
    [self.jm_collectionview registerClass:[FNCandiesMyTopCell class] forCellWithReuseIdentifier:@"FNCandiesMyTopCellID"];
    [self.jm_collectionview registerClass:[FNcandieslereItemCell class] forCellWithReuseIdentifier:@"FNcandieslereItemCellID"];
    [self.jm_collectionview registerClass:[FNcandiesTextHintCell class] forCellWithReuseIdentifier:@"FNcandiesTextHintCellID"];
    [self.jm_collectionview registerClass:[FNcandiesCountCell class] forCellWithReuseIdentifier:@"FNcandiesCountCellID"];
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.leftBtn.size = CGSizeMake(40, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.size = CGSizeMake(54, 27);
    self.navigationView.rightButton = self.rightBtn;
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightBtn setTitle:@"" forState:UIControlStateNormal];//规则
    [self.rightBtn setTitleColor:RGB(34, 34, 34) forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font=kFONT12;
    
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 5).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:16];
    self.navigationView.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.titleLabel.text=@"我的钱包";
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=RGB(250, 250, 250);
    if(self.understand==YES){
       self.leftBtn.hidden=YES;
    }
    //[self requestCandies];
    
    //[self requestBendi];
    
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *operationArr=self.dataModel.operation;
    NSArray *numerical_valueArr=self.dataModel.numerical_value;
    if(section==1){
       return operationArr.count;
    }
    else if(section==2){
       return numerical_valueArr.count;
    }else{
       return 1;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNCandiesMyTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNCandiesMyTopCellID" forIndexPath:indexPath]; 
        cell.model=self.dataModel;
        [cell.incomeBtn addTarget:self action:@selector(incomeBtnClick)];
        [cell.convertBtn addTarget:self action:@selector(convertBtnClick)];
        return cell;
    }
    else if(indexPath.section==1){
        FNcandieslereItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcandieslereItemCellID" forIndexPath:indexPath]; 
        cell.bgImg=self.dataModel.list_bj;
        cell.model=[FNCandiesMyoperationItemModel mj_objectWithKeyValues:self.dataModel.operation[indexPath.row]];
        cell.titleLB.textColor=[UIColor colorWithHexString:self.dataModel.dwqkb_index_page_color];
        cell.hintLB.textColor=[UIColor colorWithHexString:self.dataModel.dwqkb_index_page_tips_color];
        return cell;
    }
    else if(indexPath.section==2){
        FNcandiesTextHintCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcandiesTextHintCellID" forIndexPath:indexPath];
        cell.bgImg=self.dataModel.list_bj;
        cell.model=[FNCandiesMyoperationItemModel mj_objectWithKeyValues:self.dataModel.numerical_value[indexPath.row]];
        cell.tgImg=self.dataModel.dwqkb_icon;
        cell.delegate=self;
        cell.index=indexPath;
        cell.titleLB.textColor=[UIColor colorWithHexString:self.dataModel.dwqkb_index_page_color];
        cell.hintLB.textColor=[UIColor colorWithHexString:self.dataModel.dwqkb_index_page_tips_color];
        return cell;
    }
    else if(indexPath.section==3){
        FNcandiesTextHintCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcandiesTextHintCellID" forIndexPath:indexPath];
        cell.bgImg=self.dataModel.list_bj;
        cell.daModel=self.dataModel;
        cell.delegate=self;
        cell.index=indexPath;
        return cell;
    }
    else{
        FNcandiesCountCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcandiesCountCellID" forIndexPath:indexPath];
        cell.model=self.dataModel;
        [cell.bottomBtn addTarget:self action:@selector(bottomBtnClick)];
        [cell.imgTextBtn setTitleColor:[UIColor colorWithHexString:self.dataModel.dwqkb_index_page_color] forState:UIControlStateNormal];
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=0;
    CGFloat itemWith=FNDeviceWidth-26;
    if(indexPath.section==0){
        itemWith=FNDeviceWidth-26;
        itemHeight=140;
    }
    if(indexPath.section==1){
        itemWith=(FNDeviceWidth-38)/2;
        itemHeight=76;
    }
    else if(indexPath.section==2){
        itemWith=FNDeviceWidth-26;
        itemHeight=61;
    }
    else if(indexPath.section==3){
        itemWith=FNDeviceWidth-26;
        itemHeight=80;
    }
    else if(indexPath.section==4){
        itemWith=FNDeviceWidth-26;
        itemHeight=387;
    }
    return  CGSizeMake(itemWith, itemHeight);
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if(section==1){
       return 12;
    }
    
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if(section==1){
        return 12;
    }
    else if(section==2){
        return 12;
    }
    return 1;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.section==1){
        NSArray *operationArr=self.dataModel.operation;
        FNCandiesMyoperationItemModel *model=[FNCandiesMyoperationItemModel mj_objectWithKeyValues:operationArr[indexPath.row]];
        if([model.type isEqualToString:@"zhuanzhang"]){ 
            [self didFNSkipController:@"FNdistrictTurnController"];
        }
        if([model.type isEqualToString:@"jiaoyi"]){
            [self didFNSkipController:@"FNdistrictExchangeController"];
        }
    }
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=13;
    CGFloat bottomGap=10;
    CGFloat rightGap=13;
    
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
#pragma mark - FNcandiesTextHintCellDelegate
// 点击
- (void)inCandiesRtightAction:(NSIndexPath*)index{
    if(index.section==2){
        FNdistrictConvertfeController *vc=[[FNdistrictConvertfeController alloc]init];
        vc.understand=NO;
        vc.seletedInt=0;
        vc.type=@"duihuan";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(index.section==3){
        FNcandiesGrowUpController *vc=[[FNcandiesGrowUpController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES]; 
}
//规则
-(void)rightBtnAction{
    
}
//收支明细
-(void)incomeBtnClick{
    FNcandiesIncomeController *vc=[[FNcandiesIncomeController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//兑换任务
-(void)convertBtnClick{
    FNCandiesConversionController *vc=[[FNCandiesConversionController alloc]init];
    [self.navigationController pushViewController:vc animated:YES]; 
}
//查看排行榜
-(void)bottomBtnClick{
    FNCandiesRankingController *vc=[[FNCandiesRankingController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - request
//多维区块链首页接口
-(FNRequestTool*)requestCandies{
    @weakify(self);
    [SVProgressHUD show];
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dwqkb&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        @strongify(self);
        NSDictionary *dictry = respondsObject[DataKey];
        self.dataModel=[FNCandiesMyModel mj_objectWithKeyValues:dictry];
        self.navigationView.titleLabel.text=self.dataModel.qkb_name;
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadData];
        }];
    } failure:^(NSString *error) {
         [SVProgressHUD dismiss];
    } isHideTips:NO isCache:NO];
}

-(void)requestBendi{
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=dwqkb&ctrl=index" successBlock:^(id responseBody) {
        @strongify(self);
        NSDictionary *dictry = responseBody[DataKey];
        self.dataModel=[FNCandiesMyModel mj_objectWithKeyValues:dictry];
        self.navigationView.titleLabel.text=self.dataModel.qkb_name;
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadData];
        }];
    } failureBlock:^(NSString *error) {
         [SVProgressHUD dismiss];
    }];
}
@end
