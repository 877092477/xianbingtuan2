//
//  FNWaresMultiNaController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNWaresMultiNaController.h" 
#import "FNCustomeNavigationBar.h"
#import "FNWaresTextHeadNaView.h"
#import "FNWaresScreenHeadNaView.h"
#import "FNWaresTopChunkNaCell.h"
#import "FNHomeProductCell.h"
#import "FNHomeProductSingleRowCell.h"
#import "JXCategoryView.h"
#import "FNWaresMoltiSortView.h"
#import "FNWaresMultiNaModel.h"
@interface FNWaresMultiNaController ()<UICollectionViewDelegate,UICollectionViewDataSource,JXCategoryViewDelegate,FNWaresMoltiSortViewDelegate> 

{
    BOOL singleBool;//单双列
    CGFloat heightY;
}
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIImageView *imgTopHeader;
@property (nonatomic, strong)UIImageView *imgHeader;
@property (nonatomic, strong)UIView *screenView;
@property (nonatomic, strong)FNWaresScreenHeadNaView *screenHeadNaView;
@property (nonatomic, strong)JXCategoryBaseView *categoryBaseView;
@property (nonatomic, strong)JXCategoryTitleImageView *titleImgCategoryView;
//@property (nonatomic, strong)JXCategoryIndicatorLineView *cateLineView;

@property (nonatomic, strong)UIView * pickView;
@property (nonatomic, strong)JXCategoryTitleView *categoryTitleView;
@property (nonatomic, strong)JXCategoryIndicatorLineView *titlelineView;
//@property (nonatomic, strong)JXCategoryBaseView *titleBaseView;

@property (nonatomic, strong)FNWaresMoltiSortView *sortView;
@property (nonatomic, strong)UIButton *switchBtn;


@property (nonatomic, strong) NSMutableArray *sortArr;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSString *show_type;//分类1
@property (nonatomic, strong) NSString *cateId;
@property (nonatomic, strong) NSString *sortType;

@property (nonatomic, strong) FNWaresMultiNaModel *dataModel;
@property (nonatomic, strong) FNWaresScreenAModel *screenAModel;

@property (nonatomic, strong) UIButton *btnScrollToTop;

@end

@implementation FNWaresMultiNaController

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
    heightY=0.01;
    self.cateId=@"0";
    NSString *columnSwitch=[FNBaseSettingModel settingInstance].index_goods_columnSwitch;
    NSInteger singleInt=[columnSwitch integerValue];
    if(singleInt==1){
        singleBool=NO;
    }else{
        singleBool=YES;
    }
    self.view.backgroundColor =[UIColor whiteColor];
    CGFloat baseGap=0;
    if(self.understand==YES){
        baseGap=XYTabBarHeight;
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(5, SafeAreaTopHeight, FNDeviceWidth-10, FNDeviceHeight-baseGap-SafeAreaTopHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(240, 240, 240);
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.alpha = 1;
    self.jm_collectionview.backgroundColor = [UIColor clearColor];
    self.jm_collectionview.hidden=YES;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNWaresTopChunkNaCell class] forCellWithReuseIdentifier:@"FNWaresTopChunkNaCellID"];
    [self.jm_collectionview registerClass:[FNHomeProductCell class] forCellWithReuseIdentifier:@"HomeViewGoodsCell"];
    [self.jm_collectionview registerClass:[FNHomeProductSingleRowCell class] forCellWithReuseIdentifier:@"HomeViewGoodsSingleCell"];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.jm_collectionview registerClass:[FNWaresTextHeadNaView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNWaresTextHeadNaView"];
    [self.jm_collectionview registerClass:[FNWaresScreenHeadNaView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNWaresScreenHeadNaView"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewNU"];
    
    [self setTopViews];
    
    if([self.showTypeStr kr_isNotEmpty]){
       [self apiRequestSort];
       [self requestGoodsChannel];
    }else{
       [FNTipsView showTips:@"请重新加载"];
    }
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
        NSArray *iconArr=self.dataModel.ico_list;
        return iconArr.count; 
    }else if(section==1){
        return 0;
    }
    else{
        return self.dataArray.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNWaresTopChunkNaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNWaresTopChunkNaCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        NSArray *iconArr=self.dataModel.ico_list;
        cell.model=[FNWaresMultiIcoItemModel mj_objectWithKeyValues:iconArr[indexPath.row]];
        return cell;
    }
    else if(indexPath.section==1){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
    else{
        FNBaseProductModel *model = self.dataArray[indexPath.row];
        if(singleBool==YES){
            FNHomeProductSingleRowCell *cell = [FNHomeProductSingleRowCell cellWithCollectionView:collectionView atIndexPath:indexPath];
            cell.model = model;
            cell.backgroundColor=[UIColor whiteColor];
            cell.sharerightNow = ^(FNBaseProductModel *mod) {
                [self shareProductWithModel:mod];
            };
            cell.clipsToBounds = YES;
            return cell;
        }else{
            FNHomeProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeViewGoodsCell" forIndexPath:indexPath];
//            cell.backgroundColor=[UIColor whiteColor];
            [cell setIsLeft: indexPath.row % 2 == 0];
            cell.model=self.dataArray[indexPath.row];
            return cell;
        }
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
       CGFloat height=95;
       CGFloat with= (FNDeviceWidth-10)/2;
       CGSize  size= CGSizeMake(with, height);
       return  size;
    }
    else if(indexPath.section==1){
       return CGSizeMake(FNDeviceWidth-10, 0);
    }
    else{
        if(singleBool==YES){
            CGFloat singlewidth=140;
            return CGSizeMake(FNDeviceWidth-10,  singlewidth);
        }else{
            int w = (FNDeviceWidth-10)/2;
            return CGSizeMake(w, w+110);
        }
    }
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
    if(indexPath.section==0){
        FNWaresTextHeadNaView *headerView= [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNWaresTextHeadNaView" forIndexPath:indexPath];
        headerView.backgroundColor=[UIColor clearColor];
        headerView.titleLB.text=self.dataModel.str;//@"为你挑选最划算的好物";
        headerView.titleLB.textColor=[UIColor colorWithHexString:self.dataModel.font_color];
        return headerView;
    }
    else if(indexPath.section==1){
        FNWaresScreenHeadNaView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNWaresScreenHeadNaView" forIndexPath:indexPath];
        headerView.backgroundColor=[UIColor clearColor];
        self.screenHeadNaView = headerView;
        if (self.screenView.superview == nil) {
            //首次使用VerticalSectionCategoryHeaderView的时候，把pinCategoryView添加到它上面。
            [headerView addSubview:self.screenView];
        }
        return headerView;
    }else{
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewNU" forIndexPath:indexPath];
        
        return headerView;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth-10;
    CGFloat hight=45;
    if(section==0){
        hight=30;
    }else if(section==1){
        hight=145;
    }else{
        hight=0;
    }
    return CGSizeMake(with,hight);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        NSArray *iconArr=self.dataModel.ico_list;
        NSDictionary *itemDic=iconArr[indexPath.row];
        [self loadOtherVCWithModel:itemDic andInfo:nil outBlock:nil];
    }
    if(indexPath.section==2){
        FNBaseProductModel *model = self.dataArray[indexPath.row];
        [self goProductVCWithModel:model withData:model.data];
    }
}

#pragma mark - set top views
- (void)setTopViews{
    
    CGFloat imgH=258-SafeAreaTopHeight;
    CGFloat navImgH=SafeAreaTopHeight;
    self.imgTopHeader = [[UIImageView alloc] init];
    self.imgTopHeader.backgroundColor=[UIColor whiteColor];
    [self.view insertSubview:self.imgTopHeader atIndex:0];
    self.imgTopHeader.sd_layout
    .leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, 0).heightIs(navImgH);
    
    self.imgHeader = [[UIImageView alloc] init];
    self.imgHeader.backgroundColor=[UIColor whiteColor];
    [self.view insertSubview:self.imgHeader atIndex:0];
    self.imgHeader.sd_layout
    .leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, navImgH).heightIs(imgH);
    
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
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.navigationView.titleLabel.text=self.keyWord;
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.leftBtn.imageView.sd_layout
    .centerYEqualToView(self.leftBtn).widthIs(8).heightIs(16).leftSpaceToView(self.leftBtn, 10);
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
    [self addCateViewS];
    
    _btnScrollToTop = [[UIButton alloc] init];
    [self.view addSubview:_btnScrollToTop];
    [_btnScrollToTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.bottom.equalTo(@-120);
    }];
    [_btnScrollToTop setImage:IMAGE(@"hddb") forState:UIControlStateNormal];
    [_btnScrollToTop setHidden:YES];
    [_btnScrollToTop addTarget:self action:@selector(onScrollToTopClick)];
}
#pragma mark - Action
- (void)onScrollToTopClick {
    [self.jm_collectionview scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}
#pragma mark - set cate views
-(void)addCateViewS{
    
    self.screenView=[[UIView alloc]init];
    self.screenView.frame=CGRectMake(0, 0, FNDeviceWidth-10, 145);
    self.screenView.backgroundColor=[UIColor whiteColor];
    UIView *lineV=[[UIView alloc]init];
    lineV.backgroundColor=RGB(250, 250, 250);
    [self.screenView addSubview:lineV];
    lineV.sd_layout
    .leftSpaceToView(self.screenView, 0).rightSpaceToView(self.screenView, 0).topSpaceToView(self.screenView, 69).heightIs(1);
    
    //图文分类
    self.categoryBaseView=(JXCategoryTitleImageView *)[[JXCategoryTitleImageView alloc] init];
    self.categoryBaseView.frame=CGRectMake(0, 0, FNDeviceWidth-10, 70);
    self.categoryBaseView.delegate = self;
    [self.screenView addSubview:self.categoryBaseView];
    self.titleImgCategoryView=(JXCategoryTitleImageView *)self.categoryBaseView; 
    //lineView
//    self.cateLineView = [[JXCategoryIndicatorLineView alloc] init];
//    self.cateLineView.indicatorWidth = 50;// JXCategoryViewAutomaticDimension;
//    self.cateLineView.indicatorHeight=2;
//    self.titleImgCategoryView.indicators = @[self.cateLineView];
    
//    self.titleImgCategoryView.titles = titles;
//    self.titleImgCategoryView.imageNames = imageNames;
//    self.titleImgCategoryView.selectedImageNames = selectedImageNames;
//    self.titleImgCategoryView.imageZoomEnabled = NO;
//    self.titleImgCategoryView.imageZoomScale = 1.1;
//    self.titleImgCategoryView.averageCellSpacingEnabled = YES;
//    self.titleImgCategoryView.imageTypes = types;
    
    self.titleImgCategoryView.imageSize=CGSizeMake(22, 25);
    self.titleImgCategoryView.titleImageSpacing=8; 
    
    self.titleImgCategoryView.titleFont=kFONT14;
    self.titleImgCategoryView.titleSelectedFont=kFONT15;
//    self.titleImgCategoryView.titleColor=RGB(51, 51, 51);
//    self.titleImgCategoryView.titleSelectedColor=RGB(253, 49, 20);
//    self.cateLineView.indicatorColor=RGB(253, 49, 20);
    
//    [self.categoryBaseView reloadData];
    
    
    
    self.pickView=[[UIView alloc]init];
    self.pickView.frame=CGRectMake(0, 70, FNDeviceWidth-10, 75);
    self.pickView.backgroundColor=[UIColor whiteColor];
    [self.screenView addSubview:self.pickView];
    
    
    
    //文本分类
    self.categoryTitleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, FNDeviceWidth-10, 40)];
    self.categoryTitleView.backgroundColor=[UIColor clearColor];
    self.categoryTitleView.delegate = self;
    self.categoryTitleView.titleColorGradientEnabled = YES;
    self.categoryTitleView.contentEdgeInsetLeft=25;
    self.categoryTitleView.cellSpacing=20;
    self.categoryTitleView.averageCellSpacingEnabled=NO;
    self.categoryTitleView.titleFont=kFONT14;
    self.categoryTitleView.titleSelectedFont=kFONT15;
    [self.pickView addSubview:self.categoryTitleView];
    
    //line颜色
    self.titlelineView = [[JXCategoryIndicatorLineView alloc] init];
    self.titlelineView.indicatorWidth = JXCategoryViewAutomaticDimension;
    self.titlelineView.indicatorHeight=1;
    self.categoryTitleView.indicators = @[self.titlelineView];
    
    self.categoryTitleView.titleColor=RGB(51, 51, 51);
    self.categoryTitleView.titleSelectedColor=RGB(253, 49, 20);
    self.titlelineView.indicatorColor=RGB(253, 49, 20);
    //筛选
    self.sortView=[[FNWaresMoltiSortView alloc] init];
    self.sortView.frame=CGRectMake(0, 40, FNDeviceWidth-70, 35);
    self.sortView.delegate=self;
    [self.pickView addSubview:self.sortView];
    
    self.switchBtn=[[UIButton alloc]init];
    self.switchBtn.selected=YES;
    [self.switchBtn setImage:IMAGE(@"list_two") forState:UIControlStateNormal];
    [self.switchBtn setImage:IMAGE(@"list_one") forState:UIControlStateSelected];
    self.switchBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.switchBtn.imageEdgeInsets=UIEdgeInsetsMake(8, 0, 8, 0);
    [self.switchBtn addTarget:self action:@selector(switchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.pickView addSubview:self.switchBtn];
    self.switchBtn.sd_layout
    .rightSpaceToView(self.pickView, 0).topSpaceToView(self.pickView, 40).heightIs(35).widthIs(60);
    
    UIView *lineTwoV=[[UIView alloc]init];
    lineTwoV.backgroundColor=RGB(250, 250, 250);
    [self.pickView addSubview:lineTwoV];
    lineTwoV.sd_layout
    .leftSpaceToView(self.pickView, 0).rightSpaceToView(self.pickView, 0).topSpaceToView(self.pickView, 40).heightIs(1);
    
}
-(void)switchButton:(UIButton*)button{
    button.selected=!button.selected;
    if (button.selected==YES) {
        singleBool=NO;
    }else{
        singleBool=YES;
    }
    [UIView performWithoutAnimation:^{
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:2]];
    }];
}
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    self.jm_page=1;
    if(categoryView==self.categoryTitleView){
      //XYLog(@"选择文本分类:%ld",(long)index);
      NSArray* cateArray =  self.screenAModel.cate;
      if(cateArray.count>0){
         FNWaresSortAModel *model=[FNWaresSortAModel mj_objectWithKeyValues:cateArray[index]];
         self.cateId=model.id;
         [self apiRequestProduct];
      }
    }else{
      //XYLog(@"选择图文分类:%ld",(long)index);
      NSArray *cateList=self.dataModel.cate_list;
      if(cateList.count>0){
         FNWaresMultiCateItemModel *oneModel=[FNWaresMultiCateItemModel mj_objectWithKeyValues:cateList[index]];
         self.show_type=oneModel.show_type_str;
         [self apiRequestSort];
         [self apiRequestProduct];
      }
    }
}
#pragma mark - FNWaresMoltiSortViewDelegate // 点击 筛选
- (void)diWaresMoltiSortViewAction:(NSInteger)index{
    FNWaresSortAModel *model=self.sortArr[index];
    XYLog(@"选择:%@",model.type);
    self.jm_page=1;
    self.sortType=model.type;
    [self apiRequestProduct];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_btnScrollToTop setHidden: scrollView.contentOffset.y < XYScreenHeight];
    if(heightY>1){
        if (scrollView.contentOffset.y >= heightY) {
            //当滚动的contentOffset.y大于了指定sectionHeader的y值，且还没有被添加到self.view上的时候，就需要切换superView
            if (self.pickView.superview != self.view) {
                self.pickView.frame=CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, 75);
                [self.view addSubview:self.pickView];
            }
            
        }else if (self.pickView.superview != self.screenView) {
            //当滚动的contentOffset.y小于了指定sectionHeader的y值，且还没有被添加到sectionCategoryHeaderView上的时候，就需要切换superView
            self.pickView.frame=CGRectMake(0, 70, FNDeviceWidth-10, 75);
            [self.screenView addSubview:self.pickView];
        }
        
        if (!(scrollView.isTracking || scrollView.isDecelerating)) {
            //不是用户滚动的，比如setContentOffset等方法，引起的滚动不需要处理。
            return;
        }
    }
}
#pragma mark - // 商品频道首页
-(FNRequestTool*)requestGoodsChannel{
    @WeakObj(self);
    //@weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.showTypeStr kr_isNotEmpty]){
        params[@"show_type_str"]=self.showTypeStr;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=goodsChannel&ctrl=index" respondType:(ResponseTypeModel) modelType:@"FNWaresMultiNaModel" success:^(id respondsObject) {
        //@strongify(self);
        selfWeak.dataModel=[FNWaresMultiNaModel mj_objectWithKeyValues:respondsObject];
        [selfWeak.imgTopHeader setNoPlaceholderUrlImg:selfWeak.dataModel.bg_navimg];
        [selfWeak.imgHeader setNoPlaceholderUrlImg:selfWeak.dataModel.bg_img];
        
        [selfWeak.leftBtn sd_setImageWithURL:URL(selfWeak.dataModel.return_img) forState:UIControlStateNormal];
        selfWeak.navigationView.titleLabel.textColor=[UIColor colorWithHexString:selfWeak.dataModel.font_color];
        NSArray *cateList=selfWeak.dataModel.cate_list;
        selfWeak.navigationView.backgroundColor=[UIColor clearColor];
        //向上
        NSArray *arrList=selfWeak.dataModel.ico_list;
        CGFloat clieCount=arrList.count;
        CGFloat clie=clieCount/2;
        CGFloat countHC=ceilf(clie);
        heightY=95*countHC+30+70;
        if(cateList.count>0){
            NSMutableArray *titlesM=[NSMutableArray arrayWithCapacity:0];
            NSMutableArray *imageNamesM=[NSMutableArray arrayWithCapacity:0];
            NSMutableArray *selectedImageNamesM=[NSMutableArray arrayWithCapacity:0];
            NSMutableArray *types=[NSMutableArray arrayWithCapacity:0];
            FNWaresMultiCateItemModel *oneModel=[FNWaresMultiCateItemModel mj_objectWithKeyValues:cateList[0]];
            selfWeak.show_type=oneModel.show_type_str;
            [self apiRequestSort];
            [cateList enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNWaresMultiCateItemModel *model=[FNWaresMultiCateItemModel mj_objectWithKeyValues:obj];
                NSURL *urlString=[NSURL URLWithString:model.img];
                NSURL *selectedUrlString=[NSURL URLWithString:model.check_img];
                [SDWebImageManager.sharedManager downloadImageWithURL:urlString options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    if (finished) {
                    }
                }];
                [SDWebImageManager.sharedManager downloadImageWithURL:selectedUrlString options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    if (finished) {
                    }
                }];
                [titlesM addObject:model.name];
                [imageNamesM addObject:urlString];
                [selectedImageNamesM addObject:selectedUrlString];
                [types addObject:@(JXCategoryTitleImageType_TopImage)];
            }];
            
            if(titlesM.count>0){
               self.titleImgCategoryView.titles = titlesM;
            }
            if(imageNamesM.count>0){
                
               self.titleImgCategoryView.imageURLs = imageNamesM;
            }
            if(selectedImageNamesM.count>0){
               self.titleImgCategoryView.selectedImageURLs = selectedImageNamesM;
               self.titleImgCategoryView.loadImageCallback = ^(UIImageView *imageView, NSURL *imageURL) {
                    [imageView sd_setImageWithURL:imageURL];
                };
            }
            if(types.count>0){
               self.titleImgCategoryView.imageTypes = types;
            }
            self.titleImgCategoryView.titleColor= [UIColor colorWithHexString:oneModel.font_color];
            self.titleImgCategoryView.titleSelectedColor=[UIColor colorWithHexString:oneModel.check_font_color];
            //self.cateLineView.indicatorColor=[UIColor colorWithHexString:oneModel.check_font_color];
            
            [selfWeak.categoryBaseView reloadData];
        }
        selfWeak.jm_collectionview.hidden=NO;
        [selfWeak.jm_collectionview reloadData];  
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:YES];
}
//获取搜排序文字
- (FNRequestTool *)apiRequestSort{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.show_type kr_isNotEmpty]){
        params[@"show_type_str"]=self.show_type;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=goodsChannel&ctrl=sort_list" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        
        NSDictionary *dataDictry=respondsObject[DataKey];
        selfWeak.screenAModel=[FNWaresScreenAModel mj_objectWithKeyValues:dataDictry];
        NSArray* cateArray =  selfWeak.screenAModel.cate;
        if(cateArray.count>0){
            NSMutableArray *arrCate=[NSMutableArray arrayWithCapacity:0];
            [cateArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNWaresSortAModel *model=[FNWaresSortAModel mj_objectWithKeyValues:obj];
                [arrCate addObject:model.name];
            }];
            selfWeak.categoryTitleView.titles=arrCate;
            [selfWeak.categoryTitleView reloadData];
            
            [selfWeak.categoryTitleView selectItemAtIndex:0];
        }
        
        NSArray* sortArray = selfWeak.screenAModel.sort;
        if (sortArray.count>0) {
            NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
            [sortArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNWaresSortAModel *model=[FNWaresSortAModel mj_objectWithKeyValues:obj];
                model.sortid=idx;
                if(idx==0){
                    model.state=1;
                }else{
                    model.state=0;
                }
                [arrM addObject:model];
            }];
            XYLog(@"array:%@",sortArray);
            selfWeak.sortArr=arrM;
            selfWeak.sortView.dataArr=arrM;
            selfWeak.jm_collectionview.hidden=NO;
            [selfWeak.jm_collectionview reloadData];
        } 
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:YES];
}
//获取产品
- (FNRequestTool *)apiRequestProduct{
    //[SVProgressHUD show];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{PageNumber:@(self.jm_page), @"token":UserAccessToken,PageSize:@(_jm_pro_pagesize)}];
    if([self.show_type kr_isNotEmpty]){
        params[@"show_type_str"]=self.show_type;
    }
    if ([self.cateId kr_isNotEmpty]) {
        params[@"cid"] = self.cateId;
    }
    if ([self.sortType kr_isNotEmpty]) {
        params[@"sort"] = self.sortType;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=goodsChannel&ctrl=goods" respondType:(ResponseTypeDataKey) modelType:@"FNBaseProductModel" success:^(id resObject) {
//        NSArray* array = respondsObject;
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in resObject) {
            FNBaseProductModel *model = [FNBaseProductModel mj_objectWithKeyValues:dict];
            model.data = dict;
            [array addObject:model];
        }
        
        [SVProgressHUD dismiss];
        [selfWeak.jm_collectionview.mj_footer endRefreshing];
        [selfWeak.jm_collectionview.mj_header endRefreshing];
        
        if (selfWeak.jm_page == 1) {
            if (array.count == 0) {
                return ;
            }
            [selfWeak.dataArray removeAllObjects];
            [selfWeak.dataArray addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                selfWeak.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiRequestProduct];
                }];
            }else{
                selfWeak.jm_collectionview.mj_footer = nil;
            }
        } else {
            [selfWeak.dataArray addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                [selfWeak.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [selfWeak.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [UIView performWithoutAnimation:^{
            [selfWeak.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:2]];
        }];
        selfWeak.jm_collectionview.hidden=NO;
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:YES];
    
}

- (NSMutableArray *)sortArr{
    if (!_sortArr) {
        _sortArr = [NSMutableArray array];
    }
    return _sortArr;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
