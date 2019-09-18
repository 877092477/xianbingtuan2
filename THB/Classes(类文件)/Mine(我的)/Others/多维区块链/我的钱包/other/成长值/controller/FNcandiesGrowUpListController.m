//
//  FNcandiesGrowUpListController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcandiesGrowUpListController.h"
#import "FNCustomeNavigationBar.h"
#import "FNcanGrowUpDetailItemCell.h"
#import "FNCanGrowDetailHeadView.h"
@interface FNcandiesGrowUpListController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)NSMutableArray *dataArr;
@end

@implementation FNcandiesGrowUpListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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
    [self.view addSubview:self.jm_collectionview];
    
    [self.jm_collectionview registerClass:[FNcanGrowUpDetailItemCell class] forCellWithReuseIdentifier:@"FNcanGrowUpDetailItemCellID"];
   [self.jm_collectionview registerClass:[FNCanGrowDetailHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNCanGrowDetailHeadViewID"];
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.leftBtn.size = CGSizeMake(40, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 5).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:16];
    self.navigationView.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.titleLabel.text=@"成长明细";
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
    //[self requestCandies];
    
    [self requestBendi];
    
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNcanGrowUpDetailItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcanGrowUpDetailItemCellID" forIndexPath:indexPath];
    cell.model=[FNcandiesGrowGardeDetailModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=84;
    CGFloat itemWith=FNDeviceWidth;
   
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
    return 1;
}
#pragma mark -  Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FNCanGrowDetailHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNCanGrowDetailHeadViewID" forIndexPath:indexPath];
    if(self.dataArr.count>0){
       headerView.titleLB.text=@"成长明细";
    }
    return headerView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=50;
    return CGSizeMake(with,hight);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - request
//成长明细接口
-(FNRequestTool*)requestPayment{
    @weakify(self);
    [SVProgressHUD show];
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dwqkb&ctrl=grow_detail" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        @strongify(self);
        NSArray *array =respondsObject[DataKey];
        if (self.jm_page == 1) {
            if (array.count == 0) {
                [self.dataArr removeAllObjects];
                [self.jm_collectionview reloadData];
                return ;
            }
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.jm_page ++;
                    [self requestPayment];
                }];
            }
        } else {
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                [self.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
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
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
   
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=dwqkb&ctrl=grow_detail" successBlock:^(id responseBody) {
        [SVProgressHUD dismiss];
        @strongify(self);  
        NSArray *array =responseBody[DataKey];
        if (self.jm_page == 1) {
            if (array.count == 0) {
                [self.dataArr removeAllObjects];
                [self.jm_collectionview reloadData];
                return ;
            }
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.jm_page ++;
                    [self requestBendi];
                }];
            }
        } else {
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                [self.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadData];
        }];
    } failureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
    }];
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
