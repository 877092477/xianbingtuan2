//
//  FNArticleNewNaController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNArticleNewNaController.h"
#import "FNArticleDetailsXController.h"
#import "FNArticleHomepageDController.h"

#import "FNCustomeNavigationBar.h"
#import "JXCategoryView.h"
#import "FNExpertSortNaNodel.h"
#import "FNArtcleRecommendItemNEWCell.h"
#import "FNArtcleAroundSlideCell.h"
#import "FNArticleHeaderNEWView.h"
@interface FNArticleNewNaController ()<UICollectionViewDelegate,UICollectionViewDataSource,JXCategoryViewDelegate,FNArtcleAroundSlideCellDelegate,FNArtcleRecommendItemNEWCellDelegate>
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)FNExpertNaModel *dataModel;
@property (nonatomic, strong)NSString *cidString;

@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIImageView *imgHeader;
@property (nonatomic, strong)UIImageView *topImage;
@property (nonatomic, strong)UIImageView *topBgImage;
@property (nonatomic, strong)UIButton *topBtn;
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)JXCategoryIndicatorLineView *lineView;

@end

@implementation FNArticleNewNaController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
   
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
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+40, FNDeviceWidth, FNDeviceHeight-SafeAreaTopHeight-40-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    //self.jm_collectionview.alpha = 1;
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [self.jm_collectionview registerClass:[FNArtcleRecommendItemNEWCell class] forCellWithReuseIdentifier:@"FNArtcleRecommendItemNEWCellID"];
    
    [self.jm_collectionview registerClass:[FNArtcleAroundSlideCell class] forCellWithReuseIdentifier:@"FNArtcleAroundSlideCellID"];
    
    
    [self.jm_collectionview registerClass:[FNArticleHeaderNEWView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNArticleHeaderNEWView"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView1"];
    
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self setTopViews];
    [self requestExpert];
    
}

#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }
    else{
        return self.dataArr.count;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        FNArtcleAroundSlideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNArtcleAroundSlideCellID" forIndexPath:indexPath];
        cell.backgroundColor=RGB(250, 250, 250);
        cell.delegate=self;
        cell.dataModel=self.dataModel;
        [cell.bgImgView setNoPlaceholderUrlImg:self.dataModel.bg_img];
        return cell;
    }else{
        FNEssayItemDModel *model=self.dataArr[indexPath.row];
        FNArtcleRecommendItemNEWCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNArtcleRecommendItemNEWCellID" forIndexPath:indexPath];
        cell.model=model;
        cell.backgroundColor=RGB(250, 250, 250);
        cell.delegate=self;
        cell.indexS=indexPath;
        return cell;
    }  
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=0;
    CGFloat with=FNDeviceWidth;
    if(indexPath.section==0){
        height=245;
    }
    else{
        FNEssayItemDModel *model=self.dataArr[indexPath.row];
        if([model.article kr_isNotEmpty]){
          height=300;
        }else{
          height=245;
        }
    }
    CGSize size = CGSizeMake(with, height);
    return size;
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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        FNEssayItemDModel *model=self.dataArr[indexPath.row];
        FNArticleDetailsXController *vc=[[FNArticleDetailsXController alloc]init];
        vc.articleID=model.id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1){
        FNArticleHeaderNEWView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNArticleHeaderNEWView" forIndexPath:indexPath];
        headerView.titleLB.text=self.dataModel.extend_title;//@"推荐好物";
        headerView.backgroundColor=RGB(250, 250, 250);
        
        return headerView;
    }else{
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView1" forIndexPath:indexPath];
        return headerView;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=45;
    if(section==0){
        hight=0;
    }else{
        hight=40;
    }
    return CGSizeMake(with,hight);
}

#pragma mark - set top views
- (void)setTopViews{
    
    CGFloat imgH=SafeAreaTopHeight+40;//343;
    self.imgHeader = [[UIImageView alloc] init];
    self.imgHeader.backgroundColor=[UIColor whiteColor];
    [self.view insertSubview:_imgHeader atIndex:0];
    [self.imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(imgH);
    }];
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.view addSubview:self.navigationView];
    [self.view bringSubviewToFront:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 18);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    
    [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor clearColor];
    
    self.leftBtn.imageView.sd_layout
    .centerYEqualToView(self.leftBtn).widthIs(8).heightIs(16).leftSpaceToView(self.leftBtn, 10);
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
    self.topImage=[[UIImageView alloc]init];
    //self.topImage.contentMode=UIViewContentModeCenter;
    [self.navigationView addSubview:self.topImage];
    self.topImage.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).widthIs(55).heightIs(20);
    
    self.topBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.topBtn addTarget:self action:@selector(topBtnAction)];
    [self.topBtn setImage:IMAGE(@"FN_DR_redTopimg") forState:UIControlStateNormal];
    self.topBtn.hidden=YES;
    [self.view addSubview:self.topBtn];
    self.topBtn.sd_layout
    .rightSpaceToView(self.view, 10).bottomSpaceToView(self.view, 100).widthIs(40).heightIs(40);
    
    [self cateTopView];
    
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)topBtnAction{
    [self.jm_collectionview setContentOffset:CGPointMake(0,0) animated:YES];
}
#pragma mark -  //分类view
-(void)cateTopView{
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, 36)];
    self.categoryView.backgroundColor=[UIColor clearColor];
    self.categoryView.delegate = self;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.contentEdgeInsetLeft=10;
    self.categoryView.cellSpacing=15;
    self.categoryView.averageCellSpacingEnabled=NO;
    [self.view addSubview:self.categoryView];
    
    //lineView
    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
    //line颜色
    self.lineView.indicatorColor=RGB(251, 155, 31);
    self.lineView.indicatorHeight=4;
    self.categoryView.indicators = @[self.lineView];
    
}
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    XYLog(@"选择%ld",(long)index);
    NSArray *cateArr=self.dataModel.cate;
    FNExpertSortNaNodel *model=[FNExpertSortNaNodel mj_objectWithKeyValues:cateArr[index]];
    self.cidString=model.cid;
    if([self.cidString kr_isNotEmpty]){
        self.jm_page=1;
        [self requestEssayList]; 
    }
}
#pragma mark - FNArtcleAroundSlideCellDelegate // 点击横向滚动
- (void)tendAroundSlideCellAction:(NSInteger)index{
    NSArray *bannerArray=self.dataModel.topdata;
    NSDictionary *dictry=bannerArray[index];
     
    //FNEssayItemDModel *model=[FNEssayItemDModel mj_objectWithKeyValues:dictry];
    //FNArticleDetailsXController *vc=[[FNArticleDetailsXController alloc]init];
    //vc.articleID=model.id;
    //[self.navigationController pushViewController:vc animated:YES];
    [self loadOtherVCWithModel:dictry andInfo:nil outBlock:nil];
    
}
#pragma mark - FNArtcleRecommendItemNEWCellDelegate // 点击头像或者名字
- (void)didRecommendItemNEWCellAction:(NSIndexPath*)indexS{
    FNEssayItemDModel *model=self.dataArr[indexS.row];
    FNArticleHomepageDController *vc=[[FNArticleHomepageDController alloc]init];
    vc.understand=NO;
    vc.talentID=model.talent_id;
    vc.dataDictry=self.dataArr[indexS.row];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - // 达人说
-(FNRequestTool*)requestExpert{
    @WeakObj(self);
    //@weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=talentTalk&ctrl=index" respondType:(ResponseTypeModel) modelType:@"FNExpertNaModel" success:^(id respondsObject) {
        //@strongify(self);
        selfWeak.dataModel=respondsObject; 
        [UIView performWithoutAnimation:^{
            [selfWeak.jm_collectionview reloadData];
        }];
        [selfWeak.imgHeader setNoPlaceholderUrlImg:selfWeak.dataModel.bg_navimg];
        [selfWeak.topImage setUrlImg:self.dataModel.top_img];
        NSArray *cateArr=selfWeak.dataModel.cate;
        if(cateArr.count>0){
            FNExpertSortNaNodel *model=[FNExpertSortNaNodel mj_objectWithKeyValues:cateArr[0]];
            selfWeak.cidString=model.cid;
            [selfWeak requestEssayList];
            NSMutableArray *nameArray=[NSMutableArray arrayWithCapacity:0];
            [cateArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNExpertSortNaNodel *model=[FNExpertSortNaNodel mj_objectWithKeyValues:obj];
                [nameArray addObject:model.name];
            }];
            selfWeak.categoryView.titleFont=kFONT16;
            selfWeak.categoryView.titleSelectedFont=kFONT16;
            selfWeak.categoryView.titleColor=[UIColor colorWithHexString:model.color];
            selfWeak.categoryView.titleSelectedColor=[UIColor colorWithHexString:model.check_color];
            selfWeak.lineView.indicatorColor=[UIColor colorWithHexString:model.check_color];
            selfWeak.lineView.indicatorHeight=2;
            selfWeak.categoryView.titles =nameArray; 
            [selfWeak.categoryView reloadData];
        }
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:YES];
}
#pragma mark - // 达人说文章
-(FNRequestTool*)requestEssayList{
    //@WeakObj(self);
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    if([self.cidString kr_isNotEmpty]){
        params[@"cid"]=self.cidString;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=talentTalk&ctrl=info_list" respondType:(ResponseTypeArray) modelType:@"FNEssayItemDModel" success:^(id respondsObject) {
        @strongify(self);
        //XYLog(@"文章:%@",respondsObject);
        NSArray *array =respondsObject;
        if (self.jm_page == 1) {
            if (array.count == 0) {
                return ;
            }
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.jm_page ++;
                    [self requestEssayList];
                }];
            }else{
            }
        } else {
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                [self.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - Table view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    CGFloat topY=SafeAreaTopHeight+40;
    if (conY <= topY) {
        self.jm_collectionview.bounces = NO; 
    }else if (conY > topY){
        self.jm_collectionview.bounces = YES;
    }
    
    if(conY>FNDeviceHeight+50){
        self.topBtn.hidden=NO;
    }else{
        self.topBtn.hidden=YES;
    }
//    if (conY>0 && conY<=343) {
//        //self.topImage.image=IMAGE(@"FN_DRtop_img");
//        [self.topImage setUrlImg:self.dataModel.top_checkimg];
//        [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
//        //滚动中FNMainGobalControlsColor
//        self.navigationView.backgroundColor = [FNWhiteColor colorWithAlphaComponent:conY/JMNavBarHeigth];
//    }else if (conY > 343){
//        self.navigationView.backgroundColor = FNWhiteColor;
//        [self.topImage setUrlImg:self.dataModel.top_checkimg];
//        [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
//    }
//    else{
//        self.navigationView.backgroundColor = [UIColor clearColor];
//        [self.topImage setUrlImg:self.dataModel.top_img];
//        [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
//    }
    
    
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
