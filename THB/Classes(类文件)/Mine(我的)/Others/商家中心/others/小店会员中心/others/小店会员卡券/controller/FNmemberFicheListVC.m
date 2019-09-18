//
//  FNmemberFicheListVC.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmemberFicheListVC.h"
#import "FNCustomeNavigationBar.h"
#import "JXCategoryView.h"
#import "FNmeFicheisModel.h"
#import "FNmemberFicheItemsCell.h"
#import "FNmeMemberNorItemCell.h"
#import "FNNewStoreDetailController.h"
@interface FNmemberFicheListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,JXCategoryViewDelegate,FNmemberFicheItemsCellDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *typeArr;
@property (nonatomic, strong)NSString *typeStr;
@end

@implementation FNmemberFicheListVC

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
    self.navigationView.titleLabel.text=@"我的卡券";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+1, FNDeviceWidth, 43)];
    self.categoryView.delegate = self;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.backgroundColor=[UIColor whiteColor];
    self.categoryView.titleFont=kFONT14;
    self.categoryView.titleSelectedFont=kFONT14;
    self.categoryView.titleColor=RGB(140, 140, 140);
    self.categoryView.titles =@[@"我的红包",@"我的优惠券"];
    self.categoryView.titleSelectedColor=RGB(255, 91, 34);
    [self.view addSubview:self.categoryView];
    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
    //line颜色
    self.lineView.indicatorColor=RGB(255, 91, 34);
    self.lineView.indicatorHeight=2;
    self.categoryView.indicators = @[self.lineView];
    
    self.view.backgroundColor=RGB(250, 250, 250);
    
    CGFloat topGap=SafeAreaTopHeight+44;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, topGap, FNDeviceWidth, FNDeviceHeight-topGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    [self.view addSubview:self.jm_collectionview];
    
    [self.jm_collectionview registerClass:[FNmemberFicheItemsCell class] forCellWithReuseIdentifier:@"FNmemberFicheItemsCellID"];
    [self.jm_collectionview registerClass:[FNmeMemberNorItemCell class] forCellWithReuseIdentifier:@"FNmeMemberNorItemCellID"];
    [self requestFicheHeader];
    
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     
    if(self.dataArr.count>0){
        return self.dataArr.count;
    }else{
        return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.dataArr.count>0){
        FNmemberFicheItemsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmemberFicheItemsCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        FNmeFicheItemisModel *itemModel=[FNmeFicheItemisModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
        cell.model=itemModel;
        cell.delegate=self;
        cell.index=indexPath;
        return cell;
    }else{
        FNmeMemberNorItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmeMemberNorItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=RGB(250, 250, 250);
        cell.imgView.image=IMAGE(@"FN_meMeNorEvimg");
        cell.hintLB.text=@"暂时还没有记录";
        cell.hintLB.font=[UIFont systemFontOfSize:11];
        cell.hintLB.textColor=RGB(153, 153, 153);
        cell.lookBtn.hidden=YES;
        return cell;
    }
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWith=FNDeviceWidth-20;
    CGFloat itemHeight=106;
    if(self.dataArr.count>0){
       itemHeight=106;
    }else{
       CGFloat topGap=SafeAreaTopHeight+44;
       itemHeight=FNDeviceHeight-topGap;
    }
    CGSize  size = CGSizeMake(itemWith, itemHeight);
    return  size;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=10;
    CGFloat leftGap=10;
    CGFloat bottomGap=10;
    CGFloat rightGap=10; 
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
#pragma mark - FNmemberFicheItemsCellDelegate <NSObject>

-(void)inMarketBerFicheItemswithIndex:(NSIndexPath*)index{
    FNmeFicheItemisModel *itemModel=[FNmeFicheItemisModel mj_objectWithKeyValues:self.dataArr[index.row]];
    FNNewStoreDetailController *vc = [[FNNewStoreDetailController alloc] init];
    vc.storeID=itemModel.store_id;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 点击类型
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    XYLog(@"%ld",(long)index);
    if(self.typeArr.count>0){
        FNmeFicheTypeisModel *oneModel=self.typeArr[index];
        self.typeStr=oneModel.type;
        self.jm_page = 1;
        [self requestFicheList];
    } 
}

#pragma mark - request
//我的卡券页面头部
-(FNRequestTool*)requestFicheHeader{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_red_packet&ctrl=my_card_top" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary *dictry = respondsObject[DataKey];
        FNmeFicheisModel *headModel=[FNmeFicheisModel mj_objectWithKeyValues:dictry];
        
        NSArray *catesArr=headModel.cates;
        if(catesArr.count>0){
            NSMutableArray *arrTitle=[NSMutableArray arrayWithCapacity:0];
            self.typeArr=[NSMutableArray arrayWithCapacity:0];
            [catesArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNmeFicheTypeisModel *itemModel=[FNmeFicheTypeisModel mj_objectWithKeyValues:obj];
                [arrTitle addObject:itemModel.str];
                [self.typeArr addObject:itemModel];
            }];
            self.categoryView.titles =arrTitle;
            if([headModel.select_color kr_isNotEmpty]){
                self.categoryView.titleSelectedColor=[UIColor colorWithHexString:headModel.select_color];
                self.lineView.indicatorColor=[UIColor colorWithHexString:headModel.select_color];
            }
            [self.categoryView reloadData];
            FNmeFicheTypeisModel *oneModel=[FNmeFicheTypeisModel mj_objectWithKeyValues:catesArr[0]];
            self.typeStr=oneModel.type;
            [self requestFicheList];
        }
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
//我的卡券
-(FNRequestTool*)requestFicheList{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    if([self.typeStr kr_isNotEmpty]){
        params[@"type"]=self.typeStr;
    }
    [SVProgressHUD show];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_red_packet&ctrl=my_card_list" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
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
                    [self requestFicheList];
                }];
            }else{
            }
            [self.jm_collectionview.mj_footer endRefreshing];
        } else {
            [self.dataArr addObjectsFromArray:array];
            [self.jm_collectionview.mj_footer endRefreshing];
            if (array.count >= _jm_pro_pagesize) {
                [self.jm_collectionview.mj_footer endRefreshing];
            }else{
                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self.jm_collectionview reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:YES isCache:NO];
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSMutableArray *)typeArr {
    if (!_typeArr) {
        _typeArr = [NSMutableArray array];
    }
    return _typeArr;
}
@end
