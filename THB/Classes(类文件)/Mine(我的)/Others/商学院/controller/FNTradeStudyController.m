//
//  FNTradeStudyController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNTradeStudyController.h"
#import "FNtradePlayClassifyController.h"
#import "FNtradeVideoDetailsController.h"
#import "FNtradeArticleDetailsController.h"
#import "FNCustomeNavigationBar.h"
#import "FNTradeImgHeadView.h"
#import "FNtradeSlideCell.h"
#import "FNtradeMenusCell.h"
#import "FNtradeRecommendCell.h"
#import "UIImage+GIF.h"
#import "FNtradeHomeModel.h"
@interface FNTradeStudyController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNtradeMenusCellDelegate,FNtradeSlideCellDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)FNtradeHomeModel *dataModel;
@property (nonatomic, strong)NSMutableArray *dataArr;
@end

@implementation FNTradeStudyController

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
    CGFloat baseGap=SafeAreaTopHeight+1;
    CGFloat bottomGap=0;
    if(self.understand==YES){
       bottomGap=XYTabBarHeight;
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    //flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, baseGap, FNDeviceWidth, FNDeviceHeight-baseGap-bottomGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
    [self.jm_collectionview registerClass:[FNtradeSlideCell class] forCellWithReuseIdentifier:@"FNtradeSlideCellID"];
    [self.jm_collectionview registerClass:[FNtradeRecommendCell class] forCellWithReuseIdentifier:@"FNtradeRecommendCellID"];
    [self.jm_collectionview registerClass:[FNtradeMenusCell class] forCellWithReuseIdentifier:@"FNtradeMenusCellID"];
    
    [self.jm_collectionview registerClass:[FNTradeImgHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNTradeImgHeadViewID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewHeadID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableViewFootID"];
    
    
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
    self.navigationView.titleLabel.text=self.keyWord ? self.keyWord:@"商学院";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    if(self.understand==YES){
       self.leftBtn.hidden=YES;
    } 
    self.view.backgroundColor=RGB(238, 238, 238);
    self.jm_collectionview.hidden=YES;
    
  
//    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//
//    footer.stateLabel.hidden=YES;
//    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
//    for (NSInteger i=1; i<32; i++) {
//        [arrM addObject:[UIImage imageNamed:[NSString stringWithFormat:@"FN_bottom_loading－%ld",(long)i]]];
//    }
//    //[footer setImages:arrM  forState:MJRefreshStateRefreshing];
//    [footer setImages:arrM duration:arrM.count * 0.04 forState:MJRefreshStateRefreshing];
//    self.jm_collectionview.mj_footer=footer;
    
    [self requestTradeCollege];
    [self requestRecommendList];
}
//上拉更多
-(void)loadMoreData{
    if (self.dataArr.count >= _jm_pro_pagesize) {
        self.jm_page ++;
        [self requestRecommendList];
    }else{
        [self.jm_collectionview.mj_footer endRefreshing];
    }
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0 || section==1){
      return 1;
    }
    else{
      return self.dataArr.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{ 
    if(indexPath.section==0){
       FNtradeSlideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNtradeSlideCellID" forIndexPath:indexPath];
        cell.model=self.dataModel;
        cell.delegate=self;
       return cell;
    }
    else if(indexPath.section==1){
        FNtradeMenusCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNtradeMenusCellID" forIndexPath:indexPath];
        cell.delegate=self;
        cell.model=self.dataModel;
        return cell;
    }
    else{
       FNtradeRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNtradeRecommendCellID" forIndexPath:indexPath];
        cell.model=[FNtradeHomeRecommendItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
       return cell;
    } 
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=0;
    CGFloat itemWith=FNDeviceWidth;
    if(indexPath.section==0){
        NSString *bannerBili=self.dataModel.banner_bili;
        CGFloat bannerHight;
        if([bannerBili kr_isNotEmpty]){
            bannerHight=[bannerBili floatValue] *FNDeviceWidth+68;
        }else{
            bannerHight=196;
        }
       itemHeight=bannerHight;
    }
    else if(indexPath.section==1){
        NSArray *arrList=self.dataModel.cate;
//        itemHeight = XYScreenWidth / 1.8 - 24 + (arrList.count>6 ? 20 : 0);
        if(arrList.count>3){
            itemHeight=190;
        }else{
            itemHeight=92;
        }
    }
    else if(indexPath.section==2){
        itemHeight=112;
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
    return 0;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        if(indexPath.section==2){
            FNTradeImgHeadView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FNTradeImgHeadViewID" forIndexPath:indexPath];
            [view.titleImgView setUrlImg:self.dataModel.recommend_icon];
            return view;
        }else{
            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableViewHeadID" forIndexPath:indexPath];
            return view;
        }
    }else{
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableViewFootID" forIndexPath:indexPath];
        view.backgroundColor=RGB(240, 240, 240);
        return view;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat sectionHeight=0;
    if(section==2){
       sectionHeight=40;
    }
    return CGSizeMake(FNDeviceWidth, sectionHeight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGFloat sectionFooterHeight=0;
    if(section==1){
       sectionFooterHeight=5;
    }
    return CGSizeMake(FNDeviceWidth, sectionFooterHeight);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==2){
        FNtradeHomeRecommendItemModel *model=[FNtradeHomeRecommendItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
        if([model.atricle_url kr_isNotEmpty]){
           [self goWebDetailWithWebType:@"0" URL:model.atricle_url];
        } 
//        if([model.type isEqualToString:@"2"]){
//            FNtradeVideoDetailsController *vc=[[FNtradeVideoDetailsController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//        else{
//            if([model.atricle_url kr_isNotEmpty]){
//                FNtradeArticleDetailsController *vc=[[FNtradeArticleDetailsController alloc]init];
//                vc.urlString=model.atricle_url;
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//        }
    }
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - FNtradeSlideCellDelegate
// 点击
- (void)inTradeSlideClick:(NSInteger)index{
    NSArray *bannerList=self.dataModel.banner;
    FNtradeHomeBannerItemModel *model=[FNtradeHomeBannerItemModel mj_objectWithKeyValues:bannerList[index]];
    [self loadOtherVCWithModel:model andInfo:nil outBlock:nil];
}
//编辑
- (void)inTradeSlideCompileAction:(NSString*)content{
    XYLog(@"编辑=%@",content);
    FNtradePlayClassifyController *vc=[[FNtradePlayClassifyController alloc]init];
    vc.keyWord=content;
    vc.is_video=@"2";
    vc.kwString=content;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - FNtradeMenusCellDelegate
// 点击菜单分类
- (void)inTradeMenusSeletedAction:(NSInteger)index{
    XYLog(@"点击=%ld",(long)index);
    NSArray *arrList=self.dataModel.cate;
    FNtradeHomeCateItemModel *itemModel=[FNtradeHomeCateItemModel mj_objectWithKeyValues:arrList[index]];
    FNtradePlayClassifyController *vc=[[FNtradePlayClassifyController alloc]init];
    vc.keyWord=itemModel.name;
    vc.is_video=itemModel.is_video;
    vc.cateId=itemModel.id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - request
//商学院首页顶部接口
-(FNRequestTool*)requestTradeCollege{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=college&ctrl=index_top" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary *dictry = respondsObject[DataKey];
        self.dataModel=[FNtradeHomeModel mj_objectWithKeyValues:dictry];
        self.navigationView.titleLabel.text=self.dataModel.title;
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadData];
        }];
        self.jm_collectionview.hidden=NO;
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
//推荐列表
-(FNRequestTool*)requestRecommendList{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=college&ctrl=recommend_list" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
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
                    [self requestRecommendList];
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
        [self.jm_collectionview reloadData];
        
    } failure:^(NSString *error) {
        [self.jm_collectionview.mj_footer endRefreshing];
    } isHideTips:YES isCache:NO];
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
