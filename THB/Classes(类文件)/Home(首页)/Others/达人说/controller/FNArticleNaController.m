//
//  FNArticleNaController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNArticleNaController.h"
#import "FNArticleDetailsXController.h"
#import "FNArticleHomepageDController.h"
#import "FNCustomeNavigationBar.h"
#import "FNExpertSortNaNodel.h"
#import "FNArtcleTopSlideNCell.h"
#import "FNArtcleHeadCView.h"
#import "FNArtcleEssayItemDCell.h"
#import "FNArtcleHeadCView.h"
#import "JXCategoryView.h"
@interface FNArticleNaController ()<UICollectionViewDelegate,UICollectionViewDataSource,JXCategoryViewDelegate,FNArtcleTopStreamerNViewDelegate,FNArtcleTopSlideNCellDelegate,FNArtcleEssayItemDCellDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIImageView *topImage;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)NSMutableArray *titles;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)FNExpertNaModel *dataModel;
@property (nonatomic, assign)FNArtcleHeadCView *cateHeaderView;
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong)NSString *cidString;


@end

@implementation FNArticleNaController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0  inSection:0];
    FNArtcleTopSlideNCell* cell = (FNArtcleTopSlideNCell *)[self.jm_collectionview cellForItemAtIndexPath:indexPath];
    [cell.pageFlowView stopTimer];
    
    
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
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.jm_collectionview registerClass:[FNArtcleTopSlideNCell class] forCellWithReuseIdentifier:@"FNArtcleTopSlideNCell"];
    [self.jm_collectionview registerClass:[FNArtcleEssayItemDCell class] forCellWithReuseIdentifier:@"FNArtcleEssayItemDCell"];
    [self.jm_collectionview registerClass:[FNArtcleHeadCView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNArtcleHeadCView"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
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
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
       return 1;
    }
    else if(section==1){
        return 0;
    }else{
       return self.dataArr.count;
    }
     
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNArtcleTopSlideNCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNArtcleTopSlideNCell" forIndexPath:indexPath]; 
        cell.dataModel=self.dataModel;
        cell.backgroundColor=[UIColor whiteColor];
        cell.streamerNView.delegate=self;
        cell.delegate=self;
        return cell;
    }
    else if(indexPath.section==1){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
        return cell;
    }else{
        FNEssayItemDModel *model=self.dataArr[indexPath.row];
        FNArtcleEssayItemDCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNArtcleEssayItemDCell" forIndexPath:indexPath];
        cell.backgroundColor=RGB(250, 250, 250);
        cell.model=model;
        cell.indexS=indexPath;
        cell.delegate=self;
        return cell;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=0;
    CGFloat with=FNDeviceWidth;
    if(indexPath.section==0){
       height=527;
    }
    else if(indexPath.section==1){
       height=0;
    }else{
       height=260;
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
    if(indexPath.section==2){
        FNEssayItemDModel *model=self.dataArr[indexPath.row];
        FNArticleDetailsXController *vc=[[FNArticleDetailsXController alloc]init];
        vc.articleID=model.id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        UICollectionReusableView *headerView= [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
        return headerView;
    }
    else if(indexPath.section==1){
        FNArtcleHeadCView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNArtcleHeadCView" forIndexPath:indexPath];
        headerView.backgroundColor=[UIColor whiteColor];
        
        self.cateHeaderView = headerView;
        if (self.categoryView.superview == nil) {
            //首次使用VerticalSectionCategoryHeaderView的时候，把pinCategoryView添加到它上面。
            [headerView addSubview:self.categoryView];
        }
        
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
    }else if(section==1){
        hight=45;
    }else{
       hight=0;
    }
    return CGSizeMake(with,hight);
}

#pragma mark -FNArtcleTopSlideNCellDelegate // 点击轮播图
- (void)tendSlideClickAction:(NSInteger)sender{
    NSArray *newdataArray=self.dataModel.topdata;
    NSDictionary *dictry=newdataArray[sender];
    //FNEssayItemDModel *model=[FNEssayItemDModel mj_objectWithKeyValues:dictry];
    //FNArticleDetailsXController *vc=[[FNArticleDetailsXController alloc]init];
    //vc.articleID=model.id;
    //[self.navigationController pushViewController:vc animated:YES];
    [self loadOtherVCWithModel:dictry andInfo:nil outBlock:nil];
}
#pragma mark -FNArtcleTopStreamerNViewDelegate// 点击横幅文章
- (void)didStreamerItemAction:(NSInteger)sender{
    NSArray *newdataArray=self.dataModel.newdata;
    FNEssayItemDModel *model=[FNEssayItemDModel mj_objectWithKeyValues:newdataArray[sender]];
    FNArticleDetailsXController *vc=[[FNArticleDetailsXController alloc]init];
    vc.articleID=model.id;
    [self.navigationController pushViewController:vc animated:YES];
    XYLog(@"sender=%ld",(long)sender);
}
#pragma mark -// 点击头像或者名字
- (void)didTopStreamerNHeadItemAction:(id)dictry{
    FNEssayItemDModel *model=[FNEssayItemDModel mj_objectWithKeyValues:dictry];
    FNArticleHomepageDController *vc=[[FNArticleHomepageDController alloc]init];
    vc.understand=NO;
    vc.talentID=model.talent_id;
    vc.dataDictry=dictry;
    [self.navigationController pushViewController:vc animated:YES];
} 

#pragma mark -FNArtcleEssayItemDCellDelegate // 点击头像或者名字
- (void)didArtcleEssayHeadItemAction:(NSIndexPath*)indexS{
    FNEssayItemDModel *model=self.dataArr[indexS.row];
    FNArticleHomepageDController *vc=[[FNArticleHomepageDController alloc]init];
    vc.understand=NO;
    vc.talentID=model.talent_id;
    vc.dataDictry=self.dataArr[indexS.row];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - set up views
- (void)setTopViews{
    
    self.view.backgroundColor =RGB(240, 240, 240);
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
    .leftSpaceToView(self.leftBtn, 18);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor clearColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
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
    
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -  //分类view
-(void)cateTopView{ 
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 45)];
    self.categoryView.delegate = self;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.backgroundColor=[UIColor whiteColor];
    
    //lineView
    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
    //line颜色
    self.lineView.indicatorColor=RGB(251, 155, 31);
    self.lineView.indicatorHeight=4;
    self.categoryView.indicators = @[self.lineView];
    //self.categoryView.hidden=YES;
    //[self.view addSubview:self.categoryView];
}
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    XYLog(@"选择%ld",(long)index);
    
    [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
    
    FNExpertSortNaNodel *model=self.titles[index];
    self.cidString=model.cid;
    
    if([self.cidString kr_isNotEmpty]){
        self.jm_page=1;
        [self requestEssayList];
        
    }
    CGFloat twoSection=527;
    if (index == 0) {
        //选中了第一个，特殊处理一下，滚动到sectionHeaer的最上面
        [self.jm_collectionview setContentOffset:CGPointMake(0, twoSection) animated:YES];
    }else {
        //不是第一个，需要滚动到categoryView下面
        if(_dataArr.count<3){
            [self.jm_collectionview setContentOffset:CGPointMake(0, 250) animated:YES];
        }
        else if(_dataArr.count>3&&_dataArr.count<4){
          [self.jm_collectionview setContentOffset:CGPointMake(0, twoSection + 45) animated:YES];
        }else{
           [self.jm_collectionview setContentOffset:CGPointMake(0, twoSection ) animated:YES];
        }
    }
}
#pragma mark - // 达人说
-(FNRequestTool*)requestExpert{
    @WeakObj(self);
    //@weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=talentTalk&ctrl=index" respondType:(ResponseTypeModel) modelType:@"FNExpertNaModel" success:^(id respondsObject) {
        //@strongify(self);
        selfWeak.dataModel=respondsObject;
        [selfWeak.jm_collectionview reloadData];
        
        NSArray *cateArr=selfWeak.dataModel.cate;
        if(cateArr.count>0){
            FNExpertSortNaNodel *model=[FNExpertSortNaNodel mj_objectWithKeyValues:cateArr[0]];
            selfWeak.cidString=model.cid;
            [selfWeak requestEssayList];
            [self cateTopView];
            NSMutableArray *nameArray=[NSMutableArray arrayWithCapacity:0];
            [cateArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNExpertSortNaNodel *model=[FNExpertSortNaNodel mj_objectWithKeyValues:obj];
                [nameArray addObject:model.name];
            }];
            selfWeak.categoryView.titleFont=kFONT15;
            selfWeak.categoryView.titleSelectedFont=kFONT17;
            selfWeak.categoryView.titleColor=[UIColor colorWithHexString:model.color];
            selfWeak.categoryView.titleSelectedColor=[UIColor colorWithHexString:model.check_color];
            selfWeak.lineView.indicatorColor=[UIColor colorWithHexString:model.check_color];
            selfWeak.lineView.indicatorHeight=4;
            selfWeak.categoryView.titles =nameArray;
            [selfWeak.cateHeaderView addSubview:selfWeak.categoryView];
            [selfWeak.categoryView reloadData];
            //[selfWeak.jm_collectionview setContentOffset:CGPointMake(0,1) animated:YES];
        }
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - // 达人说文章
-(FNRequestTool*)requestEssayList{
    //@WeakObj(self);
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize)}];
    if([self.cidString kr_isNotEmpty]){
        params[@"cid"]=self.cidString;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=talentTalk&ctrl=info_list" respondType:(ResponseTypeArray) modelType:@"FNEssayItemDModel" success:^(id respondsObject) {
        @strongify(self);
        XYLog(@"文章:%@",respondsObject);
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
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:2]];
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
-(void)setDataModel:(FNExpertNaModel *)dataModel{
    _dataModel=dataModel;
    if(dataModel){
        NSArray *cateArr=dataModel.cate;
        if(cateArr.count>0){
            NSMutableArray *dataArray=[NSMutableArray arrayWithCapacity:0];
            NSMutableArray *nameArray=[NSMutableArray arrayWithCapacity:0];
            [cateArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNExpertSortNaNodel *model=[FNExpertSortNaNodel mj_objectWithKeyValues:obj];
                [dataArray addObject:model];
                [nameArray addObject:model.name];
            }];
            self.titles=dataArray;
        }
        [self.topImage setUrlImg:dataModel.top_img];
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:0]];
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
    }
}
#pragma mark - Table view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    
    if (conY>0 && conY<=JMNavBarHeigth) {
        
        //self.topImage.image=IMAGE(@"FN_DRtop_img");
        [self.topImage setUrlImg:self.dataModel.top_checkimg];
        [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
        //滚动中FNMainGobalControlsColor
        self.navigationView.backgroundColor = [FNWhiteColor colorWithAlphaComponent:conY/JMNavBarHeigth];
    }else if (conY > JMNavBarHeigth){
        self.navigationView.backgroundColor = FNWhiteColor;
        [self.topImage setUrlImg:self.dataModel.top_checkimg];
        [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    }
    else if (conY < 0){
        self.navigationView.backgroundColor = FNWhiteColor;
        [self.topImage setUrlImg:self.dataModel.top_checkimg];
        [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    }
    else{
        self.navigationView.backgroundColor = [UIColor clearColor];
        [self.topImage setUrlImg:self.dataModel.top_img];
        [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
    }
   
    if(conY>=527-SafeAreaTopHeight){ 
        if (self.categoryView.superview != self.view) {
            self.categoryView.frame=CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, 45);
            [self.view addSubview:self.categoryView];
        }
    }else if (self.categoryView.superview != self.cateHeaderView) {
        self.categoryView.frame=CGRectMake(0, 0, FNDeviceWidth, 45);
        [self.cateHeaderView addSubview:self.categoryView];
        
    }
    if (!(scrollView.isTracking || scrollView.isDecelerating)) {
        //不是用户滚动的，比如setContentOffset等方法，引起的滚动不需要处理。
        return;
    }
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
