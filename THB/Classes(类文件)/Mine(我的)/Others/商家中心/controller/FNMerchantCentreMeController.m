//
//  FNMerchantCentreMeController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMerchantCentreMeController.h"
#import "FNmerchantIndentListController.h"
#import "FNmerchentOrderDetailsController.h"
#import "FNmerDiscountsSController.h"
#import "FNmerSetingsController.h"
#import "FNMerActivityToolController.h"
#import "FNCustomeNavigationBar.h"
#import "FNMerchantNewsCell.h"
#import "FNMeStoreIncomeCell.h"
#import "FNmerchantImgItemCell.h"
#import "FNMerchantOrderMeCell.h"
#import "FNStoreImgTextsCell.h"
#import "FNMerchantMeModel.h"
#import "FNStoreJoinContriller.h"
#import "FNStoreJoinResultController.h"
@interface FNMerchantCentreMeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNmeStoreIncomeViewDelegate,FNmerchantOrderListViewDelegate,FNmeStoreImgTextViewDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIImageView *imgHeader;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)FNMerchantHeadMeModel *headModel;
@property (nonatomic, copy) NSString* status;
@end

@implementation FNMerchantCentreMeController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    
    if ([_status isEqualToString:@"no_store"] || [_status isEqualToString:@"in_check"]) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - set up views
- (void)jm_setupViews{ 
    CGFloat baseGap=0;
    if(self.understand==YES){
       baseGap=XYTabBarHeight;
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    self.jm_collectionview.alpha = 1;
    self.jm_collectionview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
    [self.jm_collectionview registerClass:[FNMerchantNewsCell class] forCellWithReuseIdentifier:@"FNMerchantNewsCellID"];
    [self.jm_collectionview registerClass:[FNMeStoreIncomeCell class] forCellWithReuseIdentifier:@"FNMeStoreIncomeCellID"];
    [self.jm_collectionview registerClass:[FNmerchantImgItemCell class] forCellWithReuseIdentifier:@"FNmerchantImgItemCellID"];
    [self.jm_collectionview registerClass:[FNMerchantOrderMeCell class] forCellWithReuseIdentifier:@"FNMerchantOrderMeCellID"];
    [self.jm_collectionview registerClass:[FNStoreImgTextsCell class] forCellWithReuseIdentifier:@"FNStoreImgTextsCellID"];
    
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
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
    
    [self configHeader];
    if(self.understand==YES){
       self.leftBtn.hidden=YES;
    }
    //if ([NSString isEmpty:UserAccessToken]) {
        self.view.backgroundColor = RGB(246, 245, 245);
        self.navigationView.titleLabel.text=@"商家中心";
        [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
        self.navigationView.backgroundColor=[UIColor whiteColor];
        self.navigationView.titleLabel.textColor=[UIColor blackColor];
    //}
    if([UserAccessToken kr_isNotEmpty]){
       [self requestMerchantHeader];
       //[self requestBendi];
    } 
}
- (void)configHeader{
    CGFloat imgH=165+20;
    self.imgHeader = [[UIImageView alloc] init];
    [self.view insertSubview:_imgHeader atIndex:0];
    [self.imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(imgH);
    }];
    self.imgHeader.contentMode = UIViewContentModeScaleAspectFill;
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FNMerchantMeModel *itemModel=self.dataArr[section];
    NSArray *sectionArr=itemModel.list;
    if([itemModel.type isEqualToString:@"member_two_banner"]){
        return sectionArr.count;
    }else{
        return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNMerchantMeModel *itemModel=self.dataArr[indexPath.section];
    if([itemModel.type isEqualToString:@"headUser"]){
        FNMerchantNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNMerchantNewsCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        cell.model=self.headModel;
        [cell.rightBtn addTarget:self action:@selector(rightBtnClick)];
        return cell;
    }
    else if([itemModel.type isEqualToString:@"store_income"]){
        FNMeStoreIncomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNMeStoreIncomeCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        cell.model=itemModel;
        cell.listView.delegate=self;
        return cell;
    }
    else if([itemModel.type isEqualToString:@"member_mem_ico"]){
        FNStoreImgTextsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNStoreImgTextsCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        cell.model=itemModel;
        cell.listView.delegate=self;
        return cell;
    }
    else if([itemModel.type isEqualToString:@"member_two_banner"]){
        NSArray *sectionArr=itemModel.list;
        FNMerchantItemMeModel *rowModel=[FNMerchantItemMeModel mj_objectWithKeyValues:sectionArr[indexPath.row]];
        FNmerchantImgItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerchantImgItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        cell.daModel=rowModel;
        return cell;
    }
    else if([itemModel.type isEqualToString:@"store_order"] || [itemModel.type isEqualToString:@"store_yjkb"]){
        FNMerchantOrderMeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNMerchantOrderMeCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        cell.model=itemModel;
        cell.listView.delegate=self;
        if([itemModel.type isEqualToString:@"store_order"]){
            [cell.moreBtn addTarget:self action:@selector(moreBtnClick)];
        }
        return cell;
    }
    else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        return cell;
    } 
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNMerchantMeModel *itemModel=self.dataArr[indexPath.section];
    NSArray *listArr=itemModel.list;
    CGFloat itemHeight=0;
    CGFloat itemWith=0;
    if([itemModel.type isEqualToString:@"headUser"]){
         itemHeight=145;
         itemWith=FNDeviceWidth;
    }
    else if([itemModel.type isEqualToString:@"store_income"]){
        itemHeight=70;
        itemWith=FNDeviceWidth-20;
    }
    else if([itemModel.type isEqualToString:@"member_mem_ico"]){
        CGFloat row=listArr.count;
        CGFloat coFloat=row/4;
        CGFloat secInt=ceil(coFloat);
        itemHeight=90*secInt+45;
        itemWith=FNDeviceWidth-20;
    }
    else if([itemModel.type isEqualToString:@"member_two_banner"]){
        itemHeight=100;
        itemWith=(FNDeviceWidth-30)/2;
    }
    else if([itemModel.type isEqualToString:@"store_order"] ){
        itemHeight=60*listArr.count+46;
        itemWith=FNDeviceWidth-20;
    }
    else if([itemModel.type isEqualToString:@"store_yjkb"]){
        CGFloat row=listArr.count;
        CGFloat coFloat=row/2;
        CGFloat secInt=ceil(coFloat);
        itemHeight=100*secInt+46;
        itemWith=FNDeviceWidth-20;
    }
    CGSize  size = CGSizeMake(itemWith, itemHeight);
    return  size;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    FNMerchantMeModel *itemModel=self.dataArr[section];
    if([itemModel.type isEqualToString:@"member_mem_ico"]){
       return 10;
    }
    else{
       return 0;
    }
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=10;
    CGFloat bottomGap=0;
    CGFloat rightGap=10;
    FNMerchantMeModel *itemModel=self.dataArr[section];
    CGFloat jiageFloat=[itemModel.jiange floatValue];
    bottomGap=jiageFloat;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNMerchantMeModel *itemModel=self.dataArr[indexPath.section];
    NSArray *listaArr=itemModel.list;
    FNMerchantItemMeModel *model=listaArr[indexPath.row];
    if([itemModel.type isEqualToString:@"member_two_banner"]){
       [self loadOtherVCWithModel:model andInfo:nil outBlock:nil];
    }
}
#pragma mark -  FNmeStoreIncomeViewDelegate // 点击
- (void)inMeStoreIncomeAction:(id)model isType:(NSString *)type{
    
}
#pragma mark - FNmerchantOrderListViewDelegate // 点击
- (void)inMerchantOrderListAction:(id)model isType:(NSString *)type{
    if([type isEqualToString:@"store_order"]){
        XYLog(@"点击订单");
        //FNMerchantItemMeModel *itemModel=model;
        //FNmerchentOrderDetailsController *vc=[[FNmerchentOrderDetailsController alloc]init];
        //vc.orderId=itemModel.order_id;
        //[self.naviController pushViewController:vc animated:YES];
    }
}

#pragma mark - FNmeStoreImgTextViewDelegate
// 点击图文菜单
- (void)inMeStoreImgTextAction:(id)model{
    [self loadOtherVCWithModel:model andInfo:nil outBlock:nil];
}
#pragma mark - 点击
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtnClick{
    XYLog(@"设置"); 
    FNmerSetingsController *vc=[[FNmerSetingsController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    //[self didFNSkipController:@"FNmerConsumeScanController"];
}
-(void)moreBtnClick{
    XYLog(@"更多");
    FNmerchantIndentListController *vc=[[FNmerchantIndentListController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark - 滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    CGFloat imgH=185;
    if (conY<0) {
        [_imgHeader mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
            make.height.mas_equalTo(imgH - conY);
        }];
    }else{
        [_imgHeader mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(-conY);
            make.height.mas_equalTo(imgH);
        }];
    }
    if (conY>0 && conY<=JMNavBarHeigth) {
        //滚动中 
        self.navigationView.backgroundColor = [RGB(255, 68, 58) colorWithAlphaComponent:conY/JMNavBarHeigth];
    }else if (conY > JMNavBarHeigth){
        self.navigationView.backgroundColor = RGB(255, 68, 58);
    }else{
        self.navigationView.backgroundColor = [UIColor clearColor];
    }
}
#pragma mark - request
//商家中心头部
-(FNRequestTool*)requestMerchantHeader{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes], @"success_jump": @"1"}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=admin_index_top" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary *dictry = respondsObject[DataKey];
        NSString *status = dictry[@"status"];
        self.status = status;
        if ([status isEqualToString:@"no_store"]) {
            FNStoreJoinContriller *vc = [[FNStoreJoinContriller alloc] init];
            [self.navigationController pushViewController:vc animated:YES];

            return;
        } else if ([status isEqualToString:@"in_check"]) {
            FNStoreJoinResultController *vc = [[FNStoreJoinResultController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
            return;
        }
        self.headModel=[FNMerchantHeadMeModel mj_objectWithKeyValues:dictry];
        NSString *statusStr=self.headModel.status;
        if(![statusStr isEqualToString:@"no_store"]){
            [self.imgHeader setUrlImg:self.headModel.top_bj];
            self.navigationView.titleLabel.text=self.headModel.title;
            [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
            self.navigationView.titleLabel.textColor=[UIColor colorWithHexString:self.headModel.color];
            self.navigationView.backgroundColor=[UIColor clearColor];
            [self requestMerchantList];
            [UIView performWithoutAnimation:^{
                [self.jm_collectionview reloadData];
            }];
        }
        if([statusStr isEqualToString:@"no_store"]){
            NSString *msgStr=respondsObject[MsgKey];
            [FNTipsView showTips:msgStr];
        }
    } failure:^(NSString *error) {
        
        
        
    } isHideTips:NO isCache:NO];
}
//商家中心列表数据
-(FNRequestTool*)requestMerchantList{
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=admin_index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        NSArray *arrM = respondsObject[DataKey];
        @strongify(self);
        if(arrM.count>0){
            NSMutableArray *typeArray=[NSMutableArray arrayWithCapacity:0];
            FNMerchantMeModel *oneModel=[[FNMerchantMeModel alloc]init];
            oneModel.type=@"headUser";
            oneModel.jiange=@"0";
            [typeArray addObject:oneModel];
            [arrM enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNMerchantMeModel *model=[FNMerchantMeModel mj_objectWithKeyValues:obj];
                [typeArray addObject:model];
            }];
            self.dataArr=typeArray;
            [UIView performWithoutAnimation:^{
                [self.jm_collectionview reloadData];
            }];
        }
    } failure:^(NSString *error) {
        
    } isHideTips:NO isCache:NO];
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(void)requestBendi{
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=small_store&ctrl=admin_index_top" successBlock:^(id responseBody) {
        @strongify(self);
        NSDictionary *dictry = responseBody[DataKey];
        self.headModel=[FNMerchantHeadMeModel mj_objectWithKeyValues:dictry];
        [self.imgHeader setUrlImg:self.headModel.top_bj];
        self.navigationView.titleLabel.text=self.headModel.title;
        [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
        self.navigationView.titleLabel.textColor=[UIColor colorWithHexString:self.headModel.color];
        self.navigationView.backgroundColor=[UIColor clearColor];
        [self requestBendiList];
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadData];
        }];
    } failureBlock:^(NSString *error) {
        
    }];
}
//商家中心列表数据
-(void)requestBendiList{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=small_store&ctrl=admin_index" successBlock:^(id responseBody) {
        XYLog(@"responseBody=%@",responseBody);
        @strongify(self);
        NSArray *arrM = responseBody[DataKey];
        if(arrM.count>0){
            NSMutableArray *typeArray=[NSMutableArray arrayWithCapacity:0];
            FNMerchantMeModel *oneModel=[[FNMerchantMeModel alloc]init];
            oneModel.type=@"headUser";
            oneModel.jiange=@"0";
            [typeArray addObject:oneModel];
            [arrM enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNMerchantMeModel *model=[FNMerchantMeModel mj_objectWithKeyValues:obj];
                [typeArray addObject:model];
            }];
            self.dataArr=typeArray;
            [UIView performWithoutAnimation:^{
                [self.jm_collectionview reloadData];
            }];
        }
    } failureBlock:^(NSString *error) {
        
    }];
}


@end
