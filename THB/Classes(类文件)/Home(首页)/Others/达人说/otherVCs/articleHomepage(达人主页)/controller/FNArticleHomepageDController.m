//
//  FNArticleHomepageDController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNArticleHomepageDController.h"
#import "FNArticleDetailsXController.h"
#import "FNCustomeNavigationBar.h"
#import "FNarticleRecommendItemCell.h"
#import "FNArtcleRecommendItemNEWCell.h"
#import "FNArticleHomeHeaderDView.h"
#import "FNArticleHomepageDModel.h"
#import "FNArticleDeailsXModel.h"

@interface FNArticleHomepageDController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *topBtn;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)FNArticleHomepageDModel *dataModel;
@end

@implementation FNArticleHomepageDController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
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
    self.view.backgroundColor =[UIColor whiteColor];
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
    [self.view addSubview:self.jm_collectionview];
    //[self.jm_collectionview registerClass:[FNarticleRecommendItemCell class] forCellWithReuseIdentifier:@"FNarticleRecommendItemCellID"];
    [self.jm_collectionview registerClass:[FNArtcleRecommendItemNEWCell class] forCellWithReuseIdentifier:@"FNArtcleRecommendItemNEWCellID"];
    
    [self.jm_collectionview registerClass:[FNArticleHomeHeaderDView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNArticleHomeHeaderDViewID"];
    
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self setTopViews];
    if([self.talentID kr_isNotEmpty]){
       [self requestArticleList];
    }
}

#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //NSArray *arrm=self.dataModel.list;
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arrm=self.dataModel.list;
    //FNArticleItemXModel  *model=[FNArticleItemXModel mj_objectWithKeyValues:arrm[indexPath.row]];
//    FNarticleRecommendItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNarticleRecommendItemCellID" forIndexPath:indexPath];
//    cell.model=self.dataArr[indexPath.row];
//    cell.backgroundColor=RGB(250, 250, 250);
//    return cell;
    
    //FNEssayItemDModel *model=self.dataArr[indexPath.row];
    FNArtcleRecommendItemNEWCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNArtcleRecommendItemNEWCellID" forIndexPath:indexPath];
    cell.model=self.dataArr[indexPath.row];
    cell.backgroundColor=RGB(250, 250, 250);
    cell.indexS=indexPath;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNEssayItemDModel *model=self.dataArr[indexPath.row];
    CGFloat height=0;//240;
    if([model.article kr_isNotEmpty]){
        height=300;
    }else{
        height=245;
    }
    CGFloat with=FNDeviceWidth;
    CGSize size = CGSizeMake(with, height);
    return size;
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FNArticleHomeHeaderDView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNArticleHomeHeaderDViewID" forIndexPath:indexPath];
    headerView.dataModel=self.dataModel;
    headerView.twoModel=[FNEssayItemDModel mj_objectWithKeyValues:self.dataDictry];
    headerView.backgroundColor=RGB(250, 250, 250);
    return headerView; 
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=235;
    return CGSizeMake(with,hight);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
        FNEssayItemDModel *model=self.dataArr[indexPath.row];
        FNArticleDetailsXController *vc=[[FNArticleDetailsXController alloc]init];
        vc.articleID=model.id;
        [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - set top views
- (void)setTopViews{
    self.view.backgroundColor =RGB(250, 250, 250);
    CGFloat baseGap=0;
    if(self.understand==YES){
        baseGap=XYTabBarHeight;
    }
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.view addSubview:self.navigationView];
    [self.view bringSubviewToFront:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 10);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor clearColor];
    self.leftBtn.imageView.sd_layout
    .centerYEqualToView(self.leftBtn).widthIs(8).heightIs(16).leftSpaceToView(self.leftBtn, 2);
    
    self.navigationView.titleLabel.textColor=[UIColor clearColor];
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    FNEssayItemDModel *twoModel=[FNEssayItemDModel mj_objectWithKeyValues:self.dataDictry];
    self.navigationView.titleLabel.text=twoModel.talent_name;
    if(self.understand==YES){
       self.leftBtn.hidden=YES;
    }
    
    self.topBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.topBtn addTarget:self action:@selector(topBtnAction)];
    [self.topBtn setImage:IMAGE(@"FN_DR_redTopimg") forState:UIControlStateNormal];
    self.topBtn.hidden=YES;
    [self.view addSubview:self.topBtn];
    self.topBtn.sd_layout
    .rightSpaceToView(self.view, 10).bottomSpaceToView(self.view, 100).widthIs(40).heightIs(40);
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)topBtnAction{
    [self.jm_collectionview setContentOffset:CGPointMake(0,0) animated:YES];
}
#pragma mark - // 达人说作者文章列表
-(FNRequestTool*)requestArticleList{
    //@WeakObj(self);
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    if([self.talentID kr_isNotEmpty]){
        params[@"talent_id"]=self.talentID;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=talentTalk&ctrl=author_list" respondType:(ResponseTypeModel) modelType:@"FNArticleHomepageDModel" success:^(id respondsObject) {
        @strongify(self);
        self.dataModel=respondsObject;
        //NSArray *arrm=self.dataModel.list;
        
        NSArray *array =self.dataModel.list;
        
        NSMutableArray *arrayM=[NSMutableArray arrayWithCapacity:0];
        [array enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNEssayItemDModel  *model=[FNEssayItemDModel mj_objectWithKeyValues:array[idx]];
            [arrayM addObject:model];
        }];
        if (self.jm_page == 1) {
            if (arrayM.count == 0) {
                return ;
            }
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:arrayM];
            if (array.count >= _jm_pro_pagesize) {
                self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.jm_page ++;
                    [self requestArticleList];
                }];
            }else{
            }
        } else {
            [self.dataArr addObjectsFromArray:arrayM];
            if (array.count >= _jm_pro_pagesize) {
                [self.jm_collectionview.mj_footer endRefreshing];
            }else{
                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
#pragma mark - Table view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    
    if (conY>0 && conY<=235) {
        [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
        self.navigationView.titleLabel.textColor=[UIColor clearColor];
        self.navigationView.backgroundColor = [FNWhiteColor colorWithAlphaComponent:conY/JMNavBarHeigth];
        
    }else if (conY > 235){
        self.navigationView.backgroundColor = FNWhiteColor;
        self.navigationView.titleLabel.textColor=[UIColor blackColor];
        [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    }
    else{
        self.navigationView.backgroundColor = [UIColor clearColor];
        self.navigationView.titleLabel.textColor=[UIColor clearColor];
        [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
    }
    
    if(conY>FNDeviceHeight+50){
        self.topBtn.hidden=NO;
    }else{
        self.topBtn.hidden=YES;
    }
    
}

@end
