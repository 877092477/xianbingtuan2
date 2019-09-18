//
//  HomeViewController.m
//  THB
//
//  Created by zhongxueyu on 16/4/25.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

//Model
#import "MenuModel.h"
#import "FNBaseProductModel.h"
#import "XYTitleModel.h"
#import "HotSearchHeadColumnModel.h"
#import "FNHomeModel.h"
#import "FNCollectionViewCellIdentifier.h"
#import "FNBNBouncedModel.h"

//View
#import "FNHomeHeaderView.h"
#import "JMHomeProductCell.h"
#import "FNHomeProductCell.h"
#import "FNCustomeNavigationBar.h"
#import "FNHomePromotionalView.h"
#import "FNSectionHeaderView.h"
#import "FNAPIHome.h"
#import "JMAlertView.h"
#import "SDCycleScrollView.h"
#import "QJBigScrollView.h"
#import "QJSlideButtonView.h"
#import "FNBNHomeBouncedView.h"
#import "FNUpPolicyPopupNeView.h"
#import "FNKittyGifNeView.h"

//Controller
#import "HomeViewController.h"
#import "HightRebatesViewController.h"
#import "ShopRebatesViewController.h"
#import "secondViewController.h"
#import "lhScanQCodeViewController.h"
#import "MsgCenterViewController.h"
#import "firstVersionSearchViewController.h"
#import "FNMCouponPurchaseController.h"
#import "SearchViewController.h"
#import "FNHomeSecKillViewController.h"
#import "FNBrandSaleController.h"
#import "FNJDFeaturedController.h"
#import "ALBBDetailsViewController.h"
#import "ProductListViewController.h"
#import "ShakeViewController.h"
#import "FNBannerViewCell.h"
#import "FNSlideBarViewCell.h"
#import "FNGridViewCell.h"
#import "FNBannerViewCell.h"
#import "FNSaleGoodsViewCell.h"
#import "FNMarqueeViewCell.h"
#import "FNADViewCell.h"
#import "FNFunctionviewCell.h"
#import "FNTopNavViewCell.h"
#import "FNHomeProductSingleRowCell.h"
#import "FNPSecKillController.h"
#import "FNNewProDetailController.h"
#import "FNGoodsListViewController.h"
#import "FNpacketRedNeController.h"
#import "FNReckoningSetDeController.h"
#import "FNMemberGradeDeController.h"
#import "FNConnectionsHomeController.h"
//Other
#import "NSString+Times.h"
#import "UIView+KRKit.h"
#import "UINavigationBar+Background.h"

#import "ScreeningView.h"
#import "FNIntelligentSearchNeView.h"

#import "UIImage+GIF.h"
#import "FNJZImageTool.h"
#import "FNParseTbWordModel.h"
#import "SYNoticeBrowseLabel.h"
#import "SDWebImage/UIButton+WebCache.h"
static NSString *headerViewIdentifier = @"headerView";
static NSString *CellIdentifier = @"HomeViewGoodsCell";
static NSString *SingleCellId = @"HomeViewGoodsSingleCell";
#define _quick_menuH  147


#define _quick_pageH   20

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIWebViewDelegate,SDCycleScrollViewDelegate,UISearchBarDelegate,FNBuyProductHeatNViewDelegate, lhScanQCodeViewControllerDelegate>{
    CGFloat headerHeight;
    BOOL singleBool;//单双列
    NSString* sortType;// 排序
    NSInteger storeindex;//商城索引
}

#pragma mark- Model
/** 首页Model **/
@property (nonatomic, strong)FNHomeModel* homeModel;

/** 分类名Model */
@property(retain,nonatomic) XYTitleModel *model;

#pragma mark- View
@property (nonatomic, strong)FNCustomeNavigationBar* cuNaivgationbar;

@property (nonatomic, strong)FNHomeHeaderView* headerView;

@property (nonatomic, strong)CAGradientLayer* barLayer;

@property (nonatomic,strong) UIImageView *toTopImage;

@property (nonatomic,strong) UIImageView *TopImageView;

/** 标题s */
@property (nonatomic,strong) QJSlideButtonView *titleView;
@property (nonatomic,strong) UIView *popupView;
#pragma mark- Array
/** 存放Banner图片的数组 */
@property (nonatomic,strong) NSMutableArray *imageArray;

/** 存放Banner的数组 */
@property (nonatomic,strong) NSMutableArray<MenuModel *> *BannerDataArray;

/** 存放快速入口Model的数组 */
@property (nonatomic,strong) NSMutableArray *menuModelArray;
/** 数据数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 数据数组 */
@property (nonatomic, strong) NSMutableArray *marqueeArray;

/** 存放分类数据的数组 */
@property (retain, nonatomic) NSMutableArray *categoryIdArray;

/** 存放分类的数组 */
@property (retain, nonatomic) NSMutableArray *categoryNameArray;

/** 秒杀商品的数组 */
@property (retain, nonatomic) NSMutableArray *seckillArray;
/** 秒杀商品头部信息 */
@property (retain, nonatomic) NSDictionary *seckillDic;
//商品分类数组(淘宝京东拼多多)
@property (retain, nonatomic) NSMutableArray *ComponentArray;

/** 存放Cell的标识内容 **/
@property (nonatomic, strong) NSMutableArray<NSArray<FNCollectionViewCellIdentifier *> *> *tableSections;

//排序
@property (nonatomic, strong)ScreeningView* screeningView;
@property (nonatomic, strong)FDSlideBar *topSlideBar;//分栏内容
@property (nonatomic, strong)UIView *topSlideBarBgView;//分栏内容
#pragma mark- Data
/**分类Id */
@property (nonatomic,assign) NSNumber *categoryId;

@property (nonatomic,strong) NSString *end_ColorStrr;

@property (nonatomic,strong) NSString *top_bjimg;

@property (nonatomic,strong) NSString *top_str;
@property (nonatomic,strong) NSString *top_img1;
@property (nonatomic,strong) NSString *top_img2;

#pragma mark -property
@property (nonatomic, getter=isPrefetchingEnabled) BOOL prefetchingEnabled NS_AVAILABLE_IOS(10_0);


@property (nonatomic,strong) FNBNBouncedModel *BouncedModel;
@property (nonatomic,assign) CGFloat yPlaceFloat;

@property (nonatomic, strong) UIButton *scanBtn;
@property (nonatomic, strong) UIButton *msgBtn;

@property (nonatomic, strong) UIView *hbView;
@property (nonatomic, strong) UIImageView *hbimgView;
@property (nonatomic, strong) SYNoticeBrowseLabel *noticeLabel;
@property (nonatomic, strong) UIView        *msgView;
@property (nonatomic, strong) UIImageView   *msgBGView;
@property (nonatomic, strong) UIButton *hideGreenBtn;
@property (nonatomic, strong) UIButton *msgimgBtn;
@property (nonatomic, strong) FNHometipRedpacketModel *rbModel;
@property (nonatomic, strong) FNHometipRedpacketModel *rightPacketModel;
@property (nonatomic, assign) CGFloat HBPoinX;

@end

@implementation HomeViewController{
    NSString *ColumnSkipUIIdentifier;
    NSInteger SkipUIIdentifierPitch;
    BOOL isPaomadeng;

}
@synthesize toTopImage;


- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    //[self downloadkittyGif];
    NSString *columnSwitch=[FNBaseSettingModel settingInstance].index_goods_columnSwitch;
    NSInteger singleInt=[columnSwitch integerValue];
    if(singleInt==1){
        singleBool=NO;
    }else{
        singleBool=YES;
    }
    sortType=@"1";
    ColumnSkipUIIdentifier = @"buy_taobao";
    storeindex=0;
    //初始化存放组件的数组
    self.tableSections = [NSMutableArray array];
    
//    [self  apiRequstMarqueeData];

    //请求首页数据
    [self InitHeaderApi];
    
    
    //    [self apiRequestMain];
    
    //    [self initializedSubviews];

    [self apiRequestPromotionalProduct];
    
    [FNNotificationCenter addObserver:self selector:@selector(obserHomeRoll) name:@"HomeRoll" object:nil];
    [FNNotificationCenter addObserver:self selector:@selector(obserHomeEndRoll) name:@"HomeEndRoll" object:nil];
}

#pragma mark - notification
- (void)dealloc
{
    if (![NSString checkIsSuccess:[FNBaseSettingModel settingInstance].indexsearch_onoff andElement:@"1"]) {
        [FNNotificationCenter removeObserver:self name:@"pastedChange" object:nil];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 一些系统的方法
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:self.isPop.boolValue];
    
    NSLog(@"---%f",self.yPlaceFloat);
//    if (self.yPlaceFloat >0){
//        if (self.yPlaceFloat > headerHeight) {
//            [self.navigationController setNavigationBarHidden:NO animated:self.isPop.boolValue];
//        }else{
//            [self.navigationController setNavigationBarHidden:YES animated:self.isPop.boolValue];
//        }
//    }else{
//        [self.navigationController setNavigationBarHidden:YES animated:self.isPop.boolValue];
//    }
    
    self.isPop = @"0";
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    if (![NSString checkIsSuccess:[FNBaseSettingModel settingInstance].indexsearch_onoff andElement:@"1"]) {
        
        [FNNotificationCenter postNotificationName:@"pastedChange" object:nil];
    }
    [self popupPolicyView];
    
    [self.noticeLabel reloadData];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
    [self.noticeLabel releaseNotice];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initializedNavBar 导航栏
- (void)setUpCustomizedNaviBar{
    self.TopImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, SafeAreaTopHeight)];
    self.TopImageView.image=IMAGE(@"");
    self.TopImageView.backgroundColor=[UIColor redColor];//[_end_ColorStrr?[UIColor colorWithHexString:_end_ColorStrr]:FNMainGobalControlsColor colorWithAlphaComponent:0];
    [self.view addSubview:self.TopImageView];
    
    _cuNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithSearchBarFrame:(CGRectMake(80, 27, FNDeviceWidth-80*2, 30)) andPlaceholder:@""];
    //NSLog(@"app_seach_str:%@",[FNBaseSettingModel settingInstance].app_seach_str);
    _cuNaivgationbar.searchBar.cornerRadius = 15;
    _cuNaivgationbar.searchBar.delegate  =self;
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{
                                                                                                 NSFontAttributeName: kFONT14}];
    
    
    _scanBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _scanBtn.frame = CGRectMake(0, 0, 24, 24);
    [_scanBtn addTarget:self action:@selector(scanAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    _msgBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _msgBtn.frame = CGRectMake(0, 0, 24, 24);
    [_msgBtn addTarget:self action:@selector(messageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _cuNaivgationbar.leftButton = _scanBtn;
    _cuNaivgationbar.rightButton = _msgBtn;
    self.scanBtn.imageView.sd_layout
    .centerYEqualToView(self.scanBtn).centerXEqualToView(self.scanBtn).widthIs(20).heightIs(20);
    self.msgBtn.imageView.sd_layout
    .centerYEqualToView(self.msgBtn).centerXEqualToView(self.msgBtn).widthIs(20).heightIs(20);
    
    _barLayer = [CAGradientLayer layer];
    _barLayer.colors = @[(__bridge id)[[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor, (__bridge id)[UIColor clearColor].CGColor];
    _barLayer.startPoint = CGPointMake(0, 0);
    _barLayer.endPoint = CGPointMake(0, 1.0);
    _barLayer.frame = _cuNaivgationbar.bounds;
    [_cuNaivgationbar.layer insertSublayer:_barLayer atIndex:0];
    [self.view addSubview:_cuNaivgationbar];
}

-(void)setUpTitle:(NSMutableArray *)_array _idArray:(NSMutableArray *)_idArray
{
    //    NSArray *titleArr = _array;
    
    _titleView = [[QJSlideButtonView alloc] initWithcontroller:self TitleArr:_array];
    _titleView.hidden = YES;
    //_titleView.backgroundColor=[UIColor cyanColor];
    //_titleView.y = XYNavBarHeigth;
    _titleView.y = 0;
    //默认显示第0个
    self.categoryId = _idArray[0];
    
    @WeakObj(self);
    _titleView.sbBlock = ^(NSInteger index){
        XYLog(@"index is %ld",(long)index);
        //[SVProgressHUD show];
        selfWeak.jm_page = 1;
        selfWeak.categoryId = _idArray[index];
        [selfWeak apiRequestProduct].CompleteBlock = ^(NSString *error) {
#warning jm_bugs - sth. wrong, tbd
//            if ([SVProgressHUD isVisible]) {
//                return ;
//            }
            //[SVProgressHUD dismiss];
        };
        [selfWeak.jm_collectionview setContentOffset:CGPointMake(0,headerHeight-_cuNaivgationbar.height-80) animated:NO];
        selfWeak.titleView.hidden = NO;

        
    };
}
#pragma mark - action 扫描
- (void)scanAction{
//    lhScanQCodeViewController *vc = [[lhScanQCodeViewController alloc]init];
//    vc.delegate = self;
//    [self.navigationController pushViewController:vc animated:YES];
    
    NSArray *listArr = self.homeModel.index_topnav_01List;
    if (listArr.count >= 1) {
        NSDictionary *Dict2 = listArr[0];
        NSArray *array = Dict2[@"imgArr"];
        if (array.count > 0) {
            NSDictionary *dic = array[0];
            [self loadOtherVCWithModel:dic andInfo:nil outBlock:nil];
        }
    }
}
- (void)messageBtnAction{
//    if([UserAccessToken kr_isNotEmpty]){
//        MsgCenterViewController *vc = [[MsgCenterViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }else{
//        [FNTipsView showTips:@"请先登录~"];
//    }
    
    NSArray *listArr = self.homeModel.index_topnav_01List;
    if (listArr.count >= 1) {
        NSDictionary *Dict2 = listArr[0];
        NSArray *array = Dict2[@"imgArr"];
        if (array.count > 1) {
            NSDictionary *dic = array[1];
            [self loadOtherVCWithModel:dic andInfo:nil outBlock:nil];
        }
    }
}

#pragma mark - initializedSubviews
//计算Cell高度
- (CGFloat)heightForComponentInSection:(NSString *)ComponentStr data:(NSArray *)data {
    
    if ([ComponentStr isEqualToString:kIndex_Huandengpian_01_Component]) {
        
        double height =FNDeviceWidth*0.52;
        headerHeight += height;
        
        return height;
    }else if ([ComponentStr isEqualToString:kIndex_Kuaisurukou_01_Component] ||
              [ComponentStr isEqualToString:kIndex_Kuaisurukou_02_Component] ||
              [ComponentStr isEqualToString:kIndex_Kuaisurukou_03_Component] ){
        
        double height ;
        
        if (data.count > 5 && data.count <=10) {
            height = _quick_menuH;
        }else if (data.count > 10){
            height = _quick_menuH + _quick_pageH;
        }else{
            height = _quick_menuH * 0.5;
            
        }
        headerHeight += height;
        return height;
    }else if ([ComponentStr isEqualToString:kIndex_Threemodel_01_Component]){
//        double height ;
//
//        //设置广告模块数据
//        NSMutableArray* images = [NSMutableArray new];
//
//        for (NSDictionary *dict in data) {
//            Index_threemodel_01Model *threemodel=[Index_threemodel_01Model mj_objectWithKeyValues:dict];
//            [images addObject:threemodel.img];
//        }
//
//        CGFloat padding = 0;
//        if (images.count>1) {
//            //padding = 5;
//        }
//        NSLog(@"imagesSST:%@",images[0]);
//        UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:URL(images[0])]];
//        if(image){
//            CGFloat imgW = (JMScreenWidth-(padding*images.count+padding))/images.count;
//            height=image.size.height/image.size.width*imgW+padding*2;
//        }else{
//            height=0;
//        }
//        headerHeight += height;
//        return height;
        return 0;
    }else if ([ComponentStr isEqualToString:kIndex_Paomadeng_01_Component]){
        double height = 45 ;

        headerHeight += height;
        return height;
    }else if ([ComponentStr isEqualToString:kIndex_Tuwenwei_01_Component]){
        double height = 0.53*FNDeviceWidth;
        headerHeight += height;

        return height;
    }else if ([ComponentStr isEqualToString:kIndex_Goods_01_Component]){
        double height = 80 ;
        if(![[FNBaseSettingModel settingInstance].index_cgfjx_ico kr_isNotEmpty]){
            height = 40;
        }
        headerHeight += height;

        return height;
    }
    else if ([ComponentStr isEqualToString:kIndex_Miaosha_01_Component]){
        double height = JMScreenWidth/3+60+50;
        headerHeight += height;
        return height;
    }else{
        return 0;
    }
}
#pragma mark -  单元
- (void)initializedSubviews
{
    [self apiRequestHotSearchHeadColumn];
    self.headerView.homeModel = self.homeModel;
    
    self.view.backgroundColor = FNWhiteColor;
    [self setUpCustomizedNaviBar];
    @WeakObj(self);
    
    
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing=0;
    flowayout.minimumInteritemSpacing=0;
    //flowayout.sectionHeadersPinToVisibleBounds = NO;
    //flowayout.sectionFootersPinToVisibleBounds = NO;
    
    //flowayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    flowayout.estimatedItemSize = CGSizeMake(50, 50);
//    flowayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowayout];
    self.jm_collectionview.userInteractionEnabled = YES;
    //向CollectionView注册所有样式组件
    //商品Cell
    [self.jm_collectionview registerClass:[FNHomeProductCell class] forCellWithReuseIdentifier:CellIdentifier];
    [self.jm_collectionview registerClass:[FNHomeProductSingleRowCell class] forCellWithReuseIdentifier:SingleCellId];
    //导航栏组件
    [self.jm_collectionview registerClass:[FNTopNavViewCell class] forCellWithReuseIdentifier:kIndex_Topnav_01_Component];
    
    //幻灯片组件
    [self.jm_collectionview registerClass:[FNBannerViewCell class] forCellWithReuseIdentifier:kIndex_Huandengpian_01_Component];
    
    //快速入口组件
    [self.jm_collectionview registerClass:[FNFunctionviewCell class] forCellWithReuseIdentifier:kIndex_Kuaisurukou_01_Component];
    [self.jm_collectionview registerClass:[FNFunctionviewCell class] forCellWithReuseIdentifier:kIndex_Kuaisurukou_02_Component];
    [self.jm_collectionview registerClass:[FNFunctionviewCell class] forCellWithReuseIdentifier:kIndex_Kuaisurukou_03_Component];
    
    //第三模块广告位组件
    [self.jm_collectionview registerClass:[FNADViewCell class] forCellWithReuseIdentifier:kIndex_Threemodel_01_Component];
    
    //跑马灯组件
    [self.jm_collectionview registerClass:[FNMarqueeViewCell class] forCellWithReuseIdentifier:kIndex_Paomadeng_01_Component];
    
    //特价商品组件
    [self.jm_collectionview registerClass:[FNSaleGoodsViewCell class] forCellWithReuseIdentifier:kIndex_Miaosha_01_Component];
    
    
    //图文位组件
    [self.jm_collectionview registerClass:[FNGridViewCell class] forCellWithReuseIdentifier:kIndex_Tuwenwei_01_Component];
    
    //商品分栏视图组件
    [self.jm_collectionview registerClass:[FNSlideBarViewCell class] forCellWithReuseIdentifier:kIndex_Goods_01_Component];
    
    //秒杀
    //[self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kIndex_Miaosha_01_Component];
    
    //    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier];
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.delegate=self;
    self.jm_collectionview.dataSource=self;

    self.jm_collectionview.backgroundColor=FNWhiteColor;
    if([self.jm_collectionview respondsToSelector:@selector(setPrefetchingEnabled:)]){
        self.jm_collectionview.prefetchingEnabled = YES;
    }



//    [self.jm_collectionview setPrefetchingEnabled:NO];
   
    //self.jm_collectionview.alwaysBounceHorizontal=YES;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, 0, 0, 0))]; 
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.jm_page = 1;
        [SVProgressHUD show];
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:(UIStatusBarAnimationSlide)];
        [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            selfWeak.cuNaivgationbar.y = -XYTabBarHeight;
        } completion:nil];
        [self InitHeaderApi];
        [selfWeak apiRequestCategory];
        [selfWeak apiRequestSort];
        
    }];
    
    [self.view bringSubviewToFront:self.cuNaivgationbar];
    
    toTopImage = [[UIImageView alloc]initWithFrame:CGRectMake(XYScreenWidth-65, XYScreenHeight-XYTabBarHeight-100, 47, 47)];
    toTopImage.image = IMAGE(@"hddb");
    [toTopImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickToScrollTopMethod:)]];
    [self.view addSubview:toTopImage];
    toTopImage.userInteractionEnabled = YES;
    toTopImage.hidden = YES;
    
    
    
    [self.view bringSubviewToFront:toTopImage];
    //[self.view bringSubviewToFront:_titleView];
    
    self.topSlideBarBgView=[[UIView alloc]init];
    self.topSlideBarBgView.backgroundColor = FNWhiteColor;
    self.topSlideBarBgView.hidden=YES;
    self.topSlideBarBgView.frame=CGRectMake(0, 0, FNDeviceWidth, SafeAreaTopHeight);
    [self.view addSubview:self.topSlideBarBgView];
    
    self.topSlideBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight-40, FNDeviceWidth, 40)];
    self.topSlideBar.backgroundColor = FNWhiteColor;
    self.topSlideBar.is_middle=YES;
    self.topSlideBar.hidden=YES;
    [self.topSlideBar slideBarItemSelectedCallback:^(NSUInteger index) {
        [selfWeak.jm_collectionview setContentOffset:CGPointMake(0,headerHeight-_cuNaivgationbar.height-80) animated:NO];
        storeindex=index;
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0  inSection:self.tableSections.count-1];
        FNSlideBarViewCell* cell = (FNSlideBarViewCell *)[self.jm_collectionview cellForItemAtIndexPath:indexPath];
        [cell.slideBar selectSlideBarItemAtIndex:index];
        
        
        Index_goods_01Model *goodsModel= selfWeak.ComponentArray[index];
        ColumnSkipUIIdentifier=goodsModel.SkipUIIdentifier;
        goodsModel.is_check = @"1";

        selfWeak.jm_page = 1;
        [selfWeak apiRequestCategory];
        [selfWeak apiRequestSort];

    }];
    [self.topSlideBarBgView addSubview:self.topSlideBar];
    //self.navigationItem.titleView = self.topSlideBar;
   
    //_popupView=[[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, 81)];
    _popupView=[[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, 41)];
    _popupView.backgroundColor=[UIColor whiteColor];
    _popupView.hidden=YES;
    
    [self.view addSubview:_popupView];
    [_popupView addSubview:_titleView];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 40, FNDeviceWidth, 1)];
    line.backgroundColor=RGB(246, 246, 246);
    [_popupView addSubview:line];
    _screeningView = [[ScreeningView alloc]initWithFrame:(CGRectMake(0, 41, FNDeviceWidth-60, 40))];
    _screeningView.genreString=@"record";
    _screeningView.backgroundColor  =FNWhiteColor; 
    [_popupView addSubview:_screeningView];
    @weakify(self);
    _screeningView.clickedWithType = ^(NSString *type) {
        @strongify(self);
         sortType=type;
         self.jm_page=1;
         [selfWeak apiRequestProduct];
    };
    _screeningView.sd_layout.bottomSpaceToView(_popupView, 0).leftSpaceToView(_popupView, 0).widthIs(FNDeviceWidth-60).heightIs(40);
    line.sd_layout.bottomSpaceToView(_screeningView, 0).widthIs(FNDeviceWidth).heightIs(1);
    UIView *Screeningline=[[UIView alloc]init];
    Screeningline.backgroundColor=RGB(246, 246, 246);
    [_popupView addSubview:Screeningline];
    UIView *line2=[[UIView alloc]init];
    line2.backgroundColor=RGB(246, 246, 246);
    [_popupView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
        make.top.equalTo(self.screeningView.mas_bottom).offset(0);
    }];
    Screeningline.sd_layout.leftSpaceToView(_screeningView, 0).topEqualToView(_screeningView).widthIs(1).heightIs(40);
    
    UIButton *switchBtn=[[UIButton alloc]init];
    switchBtn.selected=YES;
    [switchBtn setImage:IMAGE(@"list_two") forState:UIControlStateNormal];
    [switchBtn setImage:IMAGE(@"list_one") forState:UIControlStateSelected];
    switchBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    switchBtn.imageEdgeInsets=UIEdgeInsetsMake(8, 0, 8, 0);
    [switchBtn addTarget:self action:@selector(switchButton:) forControlEvents:UIControlEventTouchUpInside];
    [_popupView addSubview:switchBtn];
   
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(5);
        make.bottom.equalTo(line2.mas_top).offset(-5);
        make.left.equalTo(Screeningline.mas_right).offset(0);
        make.right.equalTo(@0);
    }];
    
    [self apiRequestBounced];
    
    [self requestTipList];
    
}
//切换视图
-(void)switchButton:(UIButton *)sender{
    sender.selected=!sender.selected;
    if (sender.selected==YES) {
        singleBool=NO;
    }else{
        singleBool=YES;
    }
   
    [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:_tableSections.count]];
    
}
#pragma mark UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.tableSections.count+1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == self.tableSections.count) {
        return self.dataArray.count;
    }else{
        return 1;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    @WeakObj(self);

    FNCollectionViewCellIdentifier *row;
    if (indexPath.section<self.tableSections.count) {
        row = self.tableSections[indexPath.section][indexPath.row];
        
    }
    self.cuNaivgationbar.searchBar.placeholder=self.top_str;
    [self.scanBtn sd_setImageWithURL:URL(self.top_img1) forState:UIControlStateNormal];
    [self.msgBtn sd_setImageWithURL:URL(self.top_img2) forState:UIControlStateNormal];
    //self.tabBarController.selectedIndex = 3;
    if ([row.cellIdentifier isEqualToString:kIndex_Huandengpian_01_Component]) {
        
        FNBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
        cell.bannerArray = row.data;
        cell.BannerClickedBlock = ^(NSInteger index) {
            [selfWeak loadOtherVCWithModel:selfWeak.homeModel.index_huandengpian_01List[index] andInfo:nil outBlock:nil];
        };
        return cell;
    }else if ([row.cellIdentifier isEqualToString:kIndex_Kuaisurukou_01_Component] ||
              [row.cellIdentifier isEqualToString:kIndex_Kuaisurukou_02_Component] ||
              [row.cellIdentifier isEqualToString:kIndex_Kuaisurukou_03_Component]){
        FNFunctionviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
//        cell.index_kuaisurukou_01List = row.data;
        [cell setIndex_kuaisurukou_01List:row.data withColumn:[row.cellIdentifier isEqualToString:kIndex_Kuaisurukou_01_Component] ? 5 : 4];
        cell.QuickClickedBlock = ^(MenuModel *model) {
            [selfWeak loadOtherVCWithModel:model andInfo:nil outBlock:nil];
        };

        return cell;
    }else if ([row.cellIdentifier isEqualToString:kIndex_Threemodel_01_Component]){
        FNADViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
//        if ( self.jm_collectionview.decelerating == NO){
//            cell.index_threemodel_01List = row.data;
//
//        }
        cell.index_threemodel_01List = row.data;

//        if (self.jm_collectionview.dragging == NO && self.jm_collectionview.decelerating == NO){
//            
//        }

        cell.QuickClickedBlock = ^(MenuModel *model) {
            [selfWeak loadOtherVCWithModel:model andInfo:nil outBlock:nil];
        };
        
        return cell;
    }else if ([row.cellIdentifier isEqualToString:kIndex_Paomadeng_01_Component]){
        FNMarqueeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
        cell.index_paomadeng_01List = row.data;
        
        return cell;
    }else if ([row.cellIdentifier isEqualToString:kIndex_Tuwenwei_01_Component]){
        FNGridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
        cell.index_tuwenwei_01List = row.data;
        cell.QuickClickedBlock = ^(MenuModel *model) {
            [selfWeak loadOtherVCWithModel:model andInfo:nil outBlock:nil];
        };

        return cell;
    }
    else if ([row.cellIdentifier isEqualToString:kIndex_Miaosha_01_Component]){
        FNSaleGoodsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
        
        
        cell.seckillArr=self.seckillArray;
        cell.restsDic=self.seckillDic;
        cell.heatView.delegate=self;
 
        return cell;
    }
    else if ([row.cellIdentifier isEqualToString:kIndex_Goods_01_Component]){
        FNSlideBarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
        cell.index_goods_01List = row.data;
        cell.storeindex=storeindex;
        cell.ColumnClickedAddIntBlock = ^(Index_goods_01Model *model, NSInteger indexing) {
            ColumnSkipUIIdentifier=model.SkipUIIdentifier;
            model.is_check = @"1";
            selfWeak.jm_page = 1;
            [selfWeak apiRequestCategory];
            [selfWeak apiRequestSort];
            [selfWeak.topSlideBar selectSlideBarItemAtIndex:indexing];
        }; 
        
        return cell;
    }else if (indexPath.section == self.tableSections.count){
        FNBaseProductModel *model = self.dataArray[indexPath.row];
        //FNHomeProductSingleRowCell
        //FNHomeProductCell

        
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

            FNHomeProductCell *cell = [FNHomeProductCell cellWithCollectionView:collectionView atIndexPath:indexPath];
            cell.model = model;
//            cell.backgroundColor=[UIColor whiteColor];
            [cell setIsLeft: indexPath.row % 2 == 0];
//            cell.borderWidth=0.5;
            cell.borderColor = FNGlobalTextGrayColor;
            //        cell.cornerRadius=10;
            cell.clipsToBounds = YES;
            cell.sharerightNow = ^(FNBaseProductModel *mod) {

                [self shareProductWithModel:mod];

            };
            return cell;
        }
    }
    
    
    return nil;
}
//- (void)loadImagesForOnscreenRows{
//    if (self.tableSections.count > 0)
//    {
//        NSArray *visiblePaths = [self.jm_collectionview visibleCells];
//        XYLog(@"visiblePaths is %@",visiblePaths);
////        for (NSIndexPath *indexPath in visiblePaths)
////        {
////            AppRecord *appRecord = (self.entries)[indexPath.row];
////
////            if (!appRecord.appIcon)
////                // Avoid the app icon download if the app already has an icon
////            {
////                [self startIconDownload:appRecord forIndexPath:indexPath];
////            }
////        }
//    }
//
//}


#pragma mark - collectionView delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FNCollectionViewCellIdentifier *row;
    if (indexPath.section<self.tableSections.count) {
        row = self.tableSections[indexPath.section][indexPath.row];

    }
    NSLog(@"rowHeight:%f",row.rowHeight);
    if (indexPath.section == self.tableSections.count) {

        if(singleBool==YES){
            //CGFloat singlewidth = FNDeviceWidth/3;
            CGFloat singlewidth=140;
            return CGSizeMake(FNDeviceWidth,  singlewidth);
        }else{
            double w = FNDeviceWidth/2;
            return CGSizeMake(w, w+110);
        }
        
    }else{
        NSArray *jiageArr=self.homeModel.jiangeArr;
        NSString *jiageString=jiageArr[indexPath.section];
        CGFloat jiageFloat=0;
        if([jiageString kr_isNotEmpty]){
            jiageFloat=[jiageString floatValue]/2;
        }
        return CGSizeMake(FNDeviceWidth, row.rowHeight+jiageFloat);
    }
    
    
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
//    if (section == self.tableSections.count) {
//
//         //return UIEdgeInsetsMake(5, 2, 5, 2);
//        if(singleBool==YES){
//           return UIEdgeInsetsMake(0, 0, 0, 0);
//        }else{
//           return UIEdgeInsetsMake(5, 2, 5, 2);
//        }
//
//    }else{
        return UIEdgeInsetsMake(0, 0, 0, 0);
        
//    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == self.tableSections.count) {
        if (self.dataArray.count>0) {
            FNBaseProductModel *model = self.dataArray[indexPath.row];
            [self goProductVCWithModel:model withData:model.data];
        }
    }
    
}


#pragma mark - api request
//首页头部接口
- (void)InitHeaderApi{
    @WeakObj(self);
    NSMutableDictionary*params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    [FNRequestTool requestWithParams:params api:_api_home respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        FNHomeModel *Model=[[FNHomeModel alloc]init];
        NSMutableArray *jiangeArr=[[NSMutableArray alloc]init];
        NSMutableArray *TypeArr=[[NSMutableArray alloc]init];
        NSMutableDictionary *TypeDic=[[NSMutableDictionary alloc]init];
        [self.tableSections removeAllObjects];
        
//        selfWeak.cuNaivgationbar.searchBar.placeholder=@"搜索一下吧";//listArr[0][@"str"];
        
        
        //根据传过来的数据添加对应组件
        for (NSDictionary *Dict in respondsObject) {
            NSString *TypeStr=[Dict objectForKey:typeKey];
//            NSLog(@"11抢购:%@",TypeStr);
            NSArray *listArr=[Dict objectForKey:listKey];
             
            if ([TypeStr isEqualToString:kIndex_Topnav_01_Component]) {//导航栏
                Model.index_topnav_01List=listArr;
                for (NSDictionary *Dict2 in listArr) {
                    _end_ColorStrr=[Dict2 objectForKey:end_colorKey];
                    XYLog(@"_222end_ColorStrr is %@",[Dict2 objectForKey:end_colorKey]);
                    _top_bjimg=[Dict2 objectForKey:@"top_bjimg"];
                    selfWeak.top_str=[Dict2 objectForKey:@"str"];
                    selfWeak.top_img1 =[Dict2 objectForKey:@"img1"];
                    selfWeak.top_img2 =[Dict2 objectForKey:@"img2"];
                }
                    
//                    NSLog(@"%@   %@", URL([Dict2 objectForKey:@"img1"]), URL([Dict2 objectForKey:@"img2"]));
//                NSLog(@"搜索:%@",listArr[0][@"str"]);
                //self.cuNaivgationbar.searchBar.placeholder=self.top_str;//@"搜索一下吧";
                
            }else if ([TypeStr isEqualToString:kIndex_Huandengpian_01_Component]) {//幻灯片
                NSString *banner_bili=[Dict objectForKey:@"banner_bili"];
                CGFloat huandengpianHeight;
                if([banner_bili kr_isNotEmpty]){
                   huandengpianHeight=FNDeviceWidth*[banner_bili floatValue];
                }
                else{
                    huandengpianHeight=[self heightForComponentInSection:kIndex_Huandengpian_01_Component data:listArr];
                }
                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                [TypeDic setObject:self.headerView.bannerView forKey:TypeStr];
                Model.index_huandengpian_01List=listArr;
                FNCollectionViewCellIdentifier *BannerComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:kIndex_Huandengpian_01_Component data:listArr rowHeight:huandengpianHeight];
                [self.tableSections addObject:@[BannerComponent]];
                
            }else if ([TypeStr isEqualToString:kIndex_Kuaisurukou_01_Component] ||
                      [TypeStr isEqualToString:kIndex_Kuaisurukou_02_Component] ||
                      [TypeStr isEqualToString:kIndex_Kuaisurukou_03_Component]) {//快速入口
                
                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                [TypeDic setObject:self.headerView.functionview forKey:TypeStr];
                Model.index_kuaisurukou_01List=listArr;;
                FNCollectionViewCellIdentifier *FunctionComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:TypeStr data:listArr rowHeight:[self heightForComponentInSection:TypeStr data:listArr]];
                [self.tableSections addObject:@[FunctionComponent]];
                
                
            }else if ([TypeStr isEqualToString:kIndex_Threemodel_01_Component]||[TypeStr isEqualToString:kIndex_Threemodel_02_Component]||[TypeStr isEqualToString:kIndex_Threemodel_03_Component]) {//第三模块广告位
                
                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                [TypeDic setObject:self.headerView.adView forKey:TypeStr];
                Model.index_threemodel_01List=listArr;
//                XYLog(@"listArr is %@",listArr);
                FNCollectionViewCellIdentifier *ADViewComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:kIndex_Threemodel_01_Component data:listArr rowHeight:[self heightForComponentInSection:kIndex_Threemodel_01_Component data:listArr]];
                // 异步更新cell高度
                NSMutableArray* images = [NSMutableArray new];
                for (NSDictionary *dict in listArr) {
                    Index_threemodel_01Model *threemodel=[Index_threemodel_01Model mj_objectWithKeyValues:dict];
                    [images addObject:threemodel.img];
                }
                ADViewComponent.imageUrls = images;
                [self.tableSections addObject:@[ADViewComponent]];
                
            }else if ([TypeStr isEqualToString:kIndex_Paomadeng_01_Component]) {//跑马灯，这个数据要另外调接口
//                isPaomadeng=YES;

                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                [TypeDic setObject:self.headerView.FNMarqueeView forKey:TypeStr];
                FNCollectionViewCellIdentifier *MarqueeComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:kIndex_Paomadeng_01_Component data:self.marqueeArray rowHeight:[self heightForComponentInSection:kIndex_Paomadeng_01_Component data:self.marqueeArray]];
                [self.tableSections addObject:@[MarqueeComponent]];

                [self  apiRequstMarqueeData];

                
            }else if ([TypeStr isEqualToString:kIndex_Miaosha_01_Component]) {//特价商品列表，这个数据要另外调接口
                NSLog(@"秒杀Roda:%@",Dict);
                //秒杀
                 self.seckillDic=Dict;
                 [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                 [TypeArr addObject:TypeStr];
                 [TypeDic setObject:self.headerView.specialView forKey:TypeStr];
                // Model.index_tuwenwei_01List=listArr;
                 FNCollectionViewCellIdentifier *GridComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:kIndex_Miaosha_01_Component data:listArr rowHeight:[self heightForComponentInSection:kIndex_Miaosha_01_Component data:listArr]];
                 [self.tableSections addObject:@[GridComponent]];
                 [self apiRequestMiaoShaGoods];
                
                
            }else if ([TypeStr isEqualToString:kIndex_Tuwenwei_01_Component]) {//图文位
                
                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                [TypeDic setObject:self.headerView.specialView forKey:TypeStr];
                //Model.index_tuwenwei_01List=listArr;
                FNCollectionViewCellIdentifier *GridComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:kIndex_Tuwenwei_01_Component data:listArr rowHeight:[self heightForComponentInSection:kIndex_Tuwenwei_01_Component data:listArr]];
                [self.tableSections addObject:@[GridComponent]];
                
                
            }else if ([TypeStr isEqualToString:kIndex_Goods_01_Component]) {//商品分栏视图
                
                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                [TypeDic setObject:self.headerView.slideBarView forKey:TypeStr];
                Model.index_goods_01List=listArr;
               
                FNCollectionViewCellIdentifier *SlideBarComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:kIndex_Goods_01_Component data:listArr rowHeight:[self heightForComponentInSection:kIndex_Goods_01_Component data:listArr]];
                [self.tableSections addObject:@[SlideBarComponent]];
                NSMutableArray *title=[[NSMutableArray alloc]init];
                for (NSDictionary *dictry in listArr){
                     Index_goods_01Model *goodsModel=[Index_goods_01Model mj_objectWithKeyValues:dictry];
                    [title addObject:goodsModel];
                }
                selfWeak.ComponentArray=title;
               
            }
        }
        
        [self requestThreeModelImages];
        
        Model.jiangeArr=jiangeArr;
        Model.TypeArr=TypeArr;
        Model.TypeDic=TypeDic;
        selfWeak.homeModel = Model;
        
        //        [Model.index_goods_01List enumerateObjectsUsingBlock:^(Index_goods_01Model *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //            if ([obj.is_check integerValue]==1) {
        //                ColumnSkipUIIdentifier=@"buy_taobao";
        //            }
        //        }];
        NSMutableArray* goodsIndexArr=[[NSMutableArray alloc]init];
        
        for (NSDictionary *dict in Model.index_goods_01List) {
            Index_goods_01Model *goodsIndexModel=[Index_goods_01Model mj_objectWithKeyValues:dict];
            if ([goodsIndexModel.is_check integerValue]==1) {
                ColumnSkipUIIdentifier=goodsIndexModel.SkipUIIdentifier;
            }
            [goodsIndexArr addObject:goodsIndexModel.SkipUIIdentifier];
        }
        
        //        ColumnSkipUIIdentifier=@"buy_taobao";
        
        if (goodsIndexArr.count>0) {
            ColumnSkipUIIdentifier=goodsIndexArr[0];
        }
        
        
        [selfWeak apiRequestCategory];
        [selfWeak initializedSubviews];
        [selfWeak apiRequestSort];
        [SVProgressHUD dismiss];
        
        
    } failure:^(NSString *error) {
        //
        if(self.tableSections.count==0){
            [self InitHeaderApi]; 
        }
    } isHideTips:YES];
    
}

- (void)requestThreeModelImages {
    for (NSArray *array in self.tableSections) {
        for (FNCollectionViewCellIdentifier *model in array) {
            CGFloat padding = 0;
            NSArray<NSString*> *images = model.imageUrls;
            if ([model.cellIdentifier isEqualToString:kIndex_Threemodel_01_Component]
                && images && images.count > 0) {
                @weakify(model)
                @weakify(self)
                [SDWebImageManager.sharedManager downloadImageWithURL:URL(images[0]) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    @strongify(model)
                    @strongify(self)
                    if(error){
                        model.rowHeight=0;
                        [self.jm_collectionview reloadData];
                    }else{
                        if (finished) {
                            CGFloat imgW = (JMScreenWidth-(padding*images.count+padding))/images.count;
                            model.rowHeight=image.size.height/image.size.width*imgW+padding*2;
                            XYLog(@"images[0]=%@",images[0]);
                            XYLog(@"model.rowHeight=%f",model.rowHeight);
                            [self.jm_collectionview reloadData];
                         }
                    }
                }];
            }
        }
        
    }
}

//获取商品栏目（淘宝，京东，拼多多那几个大栏目）
- (FNAPIHome *)apiRequestHotSearchHeadColumn{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@"2"}];
    return [FNAPIHome apiHomeForHotSearchHeadColumnWithParams:params success:^(id respondsObject) {
        selfWeak.headerView.ColumnArray = respondsObject;
        NSMutableArray *title=[[NSMutableArray alloc]init];
        [respondsObject enumerateObjectsUsingBlock:^(HotSearchHeadColumnModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.is_check integerValue]==1) {
                ColumnSkipUIIdentifier=obj.SkipUIIdentifier;
                SkipUIIdentifierPitch=idx;
            }
             [title addObject:obj.name];
        }];
        if (ColumnSkipUIIdentifier==nil) {
            ColumnSkipUIIdentifier=selfWeak.headerView.ColumnArray[0].SkipUIIdentifier;
        }
        [SVProgressHUD dismiss];
        //[selfWeak.jm_collectionview.mj_header endRefreshing];
        //[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:(UIStatusBarAnimationSlide)];
        //[UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
        //    selfWeak.cuNaivgationbar.y = 0;
        //} completion:nil];
        //selfWeak.jm_collectionview.hidden = NO;
        //[selfWeak.jm_collectionview reloadData];
        //[selfWeak apiRequestCategory];
        
        selfWeak.topSlideBar.itemsTitle = title;
        selfWeak.topSlideBar.itemColor = FNBlackColor;
        selfWeak.topSlideBar.itemSelectedColor = FNMainGobalTextColor;
        selfWeak.topSlideBar.sliderColor = FNMainGobalTextColor;
        selfWeak.topSlideBar.fontSize=13;
        selfWeak.topSlideBar.SelectedfontSize=14;
        [selfWeak.topSlideBar selectSlideBarItemAtIndex:SkipUIIdentifierPitch];
        
    } failure:^(NSString *error) {
        [self apiRequestHotSearchHeadColumn];
    } isHidden:YES];
}
//获取分类数据
- (FNAPIHome *)apiRequestCategory{
    @WeakObj(self);
    NSString* type = @"shouye";

    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":type,@"SkipUIIdentifier":ColumnSkipUIIdentifier}];
    return [FNAPIHome apiHomeForNewNavCategoriesWithParams:params success:^(id respondsObject) {
        [selfWeak.categoryNameArray removeAllObjects];
        [selfWeak.categoryIdArray removeAllObjects];
        NSArray<XYTitleModel *> *titles = respondsObject;
        if (titles.count > 0) {
            [titles enumerateObjectsUsingBlock:^(XYTitleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [selfWeak.categoryNameArray  addObject:obj.category_name];
                [selfWeak.categoryIdArray  addObject:obj.id];
            }];
            [selfWeak setUpTitle:_categoryNameArray _idArray:_categoryIdArray];
            //[selfWeak apiRequestProduct];
            _popupView.size=CGSizeMake(FNDeviceWidth, 81);
        }else{ 
            _popupView.size=CGSizeMake(FNDeviceWidth, 41);
        }
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:(UIStatusBarAnimationSlide)];
        [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
            selfWeak.cuNaivgationbar.y = 0;
        } completion:nil];
        [selfWeak apiRequestProduct];
    } failure:^(NSString *error) {
        if (self.dataArray.count==0) {
            if(![error kr_isNotEmpty]){
               //[self apiRequestCategory];
            } 
        }
    } isHidden:YES];
}
//获取产品
- (FNAPIHome *)apiRequestProduct{
    //[SVProgressHUD show];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{PageNumber:@(self.jm_page),@"sort":sortType,@"is_index":@"1", @"token":UserAccessToken,PageSize:@(_jm_pro_pagesize),@"SkipUIIdentifier":ColumnSkipUIIdentifier}];
    if (self.categoryId) {
        params[@"cid"] = self.categoryId;
    }
    return [FNAPIHome apiHomeForNewProductsWithParams:params success:^(id respondsObject) {
        NSArray* array = respondsObject;
        [SVProgressHUD dismiss];
        [selfWeak.jm_collectionview.mj_footer endRefreshing];
        [selfWeak.jm_collectionview.mj_header endRefreshing];

        if (selfWeak.jm_page == 1) {
            if (array.count == 0) {
                [FNTipsView showTips:@"很抱歉，没有找到该类产品~"];
                return ;
            }
            [selfWeak.dataArray removeAllObjects];
            [selfWeak.dataArray addObjectsFromArray:respondsObject];
            if (array.count >= _jm_pro_pagesize) {
                selfWeak.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiRequestProduct];
                }];
            }else{
                selfWeak.jm_collectionview.mj_footer = nil;
            }
            
        } else {
            [selfWeak.dataArray addObjectsFromArray:respondsObject];
            if (array.count >= _jm_pro_pagesize) {
                [selfWeak.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [selfWeak.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        selfWeak.jm_collectionview.hidden = NO;
//        [selfWeak.jm_collectionview reloadData];
        //只刷新商品列表
        [UIView performWithoutAnimation:^{
            [selfWeak.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:selfWeak.tableSections.count]];
        }];
        
//        [UIView performWithoutAnimation:^{
//            [selfWeak.jm_collectionview reloadData];
//        }];
//
    } failure:^(NSString *error) { 

        selfWeak.jm_collectionview.hidden = NO;
        [selfWeak.jm_collectionview.mj_footer endRefreshing];
    } isHidden:NO];
    
}

//获取快速入口数据
-(FNAPIHome *)apiRequestQuickEntrance{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"is_new_app":@"1"}];
    return [FNAPIHome apiHomeForQuickEntranceWithParams:params success:^(id respondsObject) {
        [selfWeak.menuModelArray removeAllObjects];
        [selfWeak.menuModelArray addObjectsFromArray:respondsObject];
        selfWeak.headerView.quickArray = selfWeak.menuModelArray;
        
    } failure:^(NSString *error) {
        
    } isHidden:YES];
}
//promotional product
- (FNAPIHome *)apiRequestPromotionalProduct{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken}];
    return [FNAPIHome apiHomeForPromotionalProductWithParams:params success:^(id respondsObject) {
        NSArray* results = respondsObject;
        if (results.count > 0) {
            [FNHomePromotionalView showWithModel:[results firstObject] clickedProBlock:^{
                //click
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [selfWeak goProductVCWithModel:[results firstObject] withData:nil];
                });
            }];
        }
        
    } failure:^(NSString *error) {
        
    } isHidden:YES];
}

//获取跑马灯
- (void)apiRequstMarqueeData{
    @WeakObj(self);
    NSMutableDictionary*params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    [FNRequestTool requestWithParams:params api:_api_home_marqueeApi respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        [self.marqueeArray removeAllObjects];
        for (NSDictionary *Dict in respondsObject) {
            Index_paomadeng_01Model *Model=[Index_paomadeng_01Model mj_objectWithKeyValues:Dict];
            [self.marqueeArray addObject:Model];
        }
        
        [selfWeak.jm_collectionview reloadData];

        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
    
}
//获取搜排序文字
- (FNRequestTool *)apiRequestSort{
     @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@"shouye",@"SkipUIIdentifier":ColumnSkipUIIdentifier}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appGoodsCate02&ctrl=getSort" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //
        NSMutableArray *name=[[NSMutableArray alloc]init];
        NSMutableArray *type=[[NSMutableArray alloc]init];
        NSMutableArray *image1=[[NSMutableArray alloc]init];
        NSMutableArray *image2=[[NSMutableArray alloc]init];
        NSArray* array = respondsObject[DataKey];
        if (array.count>0) {
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [name addObject:[obj objectForKey:@"name"]];
                [type addObject:[obj objectForKey:@"type"]];
                [image1 addObject:@""];
                [image2 addObject:@""];
            }];
        }
        //NSLog(@"type:%@",type);
        [selfWeak.screeningView setTitles:name images:image1 selectedImage:image2 types:type];
        
    } failure:^(NSString *error) {
        [self apiRequestSort];
        //
    } isHideTips:YES];
}
- (FNRequestTool *)apiRequestMiaoShaGoods{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"is_index":@"1",@"p":@(self.jm_page),@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dgmiaosha02&ctrl=getgoods" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //NSLog(@"秒杀商品:%@",respondsObject);
        NSArray* arr = respondsObject[DataKey];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dictry in arr) {
            [arrM addObject:[FNBaseProductModel mj_objectWithKeyValues:dictry]];
        }
        selfWeak.seckillArray = arrM;
        //selfWeak.heatView.heatArr=arrM;
        
        [selfWeak.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}
#pragma mark - 弹框广告
-(FNRequestTool *)apiRequestBounced{
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appHigh&ctrl=indexGuanggao" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSLog(@"广告:%@",respondsObject);
        NSArray* dataarr = respondsObject[DataKey];
        if (dataarr.count>=1) {
            self.BouncedModel=[FNBNBouncedModel mj_objectWithKeyValues:[dataarr firstObject]];
            NSDictionary *dictry=[dataarr firstObject];
            [FNBNHomeBouncedView showWithModel:self.BouncedModel view:self.view purchaseblock:^(id model) {
                [self loadOtherVCWithModel:dictry andInfo:nil outBlock:nil];
            }];
        } 
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
-(void)ClickToScrollTopMethod:(UIGestureRecognizer *)sender{
    [self.jm_collectionview setContentOffset:CGPointMake(0,0) animated:YES];
}

#pragma mark - UIScrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    self.yPlaceFloat=scrollView.contentOffset.y;
    //NSLog(@"---%f",offsetY);
//    if (offsetY > headerHeight-XYNavBarHeigth) {
//        //if (_titleView) {
//            if (self.categoryNameArray.count>0) {
//                [_popupView addSubview:_titleView];
//                _titleView.hidden=NO;
//                _popupView.frame=CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, 81);
//            }else{
//                _popupView.frame=CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, 41);
//            }
//
//            _cuNaivgationbar.hidden=YES;
//            [self.TopImageView removeFromSuperview];
//            [_cuNaivgationbar removeFromSuperview];
//            _topSlideBarBgView.hidden=NO;
//            _popupView.hidden=NO;
//            _topSlideBar.hidden=NO;
//            _screeningView.hidden = NO;
//            //[self.navigationController setNavigationBarHidden:NO animated:NO];
//        //}
//        toTopImage.hidden = NO;
//    }else{
//        //if (_titleView) {
//            [_titleView removeFromSuperview];
//            _cuNaivgationbar.y=0;
//            [self.view addSubview:self.TopImageView];
//            [self.view addSubview:_cuNaivgationbar];
//            _titleView.hidden = YES;
//            _screeningView.hidden = YES;
//            _popupView.hidden=YES;
//            _topSlideBarBgView.hidden=YES;
//            _topSlideBar.hidden=YES;
//            _cuNaivgationbar.hidden=NO;
//            //[self.navigationController setNavigationBarHidden:YES animated:NO];
//        //}
//        toTopImage.hidden = YES;
//    }
    if(self.tableSections.count>0){
        NSIndexPath * indexPath =[self.jm_collectionview indexPathForItemAtPoint:scrollView.contentOffset];
        if(indexPath.section<self.tableSections.count){
            [_titleView removeFromSuperview];
            _cuNaivgationbar.y=0;
            [self.view addSubview:self.TopImageView];
            [self.view addSubview:_cuNaivgationbar];
            _titleView.hidden = YES;
            _screeningView.hidden = YES;
            _popupView.hidden=YES;
            _topSlideBarBgView.hidden=YES;
            _topSlideBar.hidden=YES;
            _cuNaivgationbar.hidden=NO;
            toTopImage.hidden = YES;
        }
        else{
            if (self.categoryNameArray.count>0) {
                [_popupView addSubview:_titleView];
                _titleView.hidden=NO;
                _popupView.frame=CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, 81);
            }else{
                _popupView.frame=CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, 41);
            }
            _cuNaivgationbar.hidden=YES;
            [self.TopImageView removeFromSuperview];
            [_cuNaivgationbar removeFromSuperview];
            _topSlideBarBgView.hidden=NO;
            _popupView.hidden=NO;
            _topSlideBar.hidden=NO;
            _screeningView.hidden = NO;
            toTopImage.hidden = NO;
        }
    }
    
    if (offsetY <= 0) {
        //_cuNaivgationbar.backgroundColor = [[UIColor colorWithHexString:_end_ColorStrr] colorWithAlphaComponent:0];
        [_cuNaivgationbar.layer insertSublayer:_barLayer atIndex:0];
        self.TopImageView.backgroundColor= [[UIColor colorWithHexString:_end_ColorStrr] colorWithAlphaComponent:0];
        [self.TopImageView setUrlImg:@""];
        
    }else if (offsetY > 0 && offsetY <= XYNavBarHeigth){
        [_barLayer removeFromSuperlayer];
        //_cuNaivgationbar.backgroundColor = [_end_ColorStrr?[UIColor colorWithHexString:_end_ColorStrr]:FNMainGobalControlsColor colorWithAlphaComponent:offsetY/XYNavBarHeigth];
        
        self.TopImageView.backgroundColor= [_end_ColorStrr?[UIColor colorWithHexString:_end_ColorStrr]:FNMainGobalControlsColor colorWithAlphaComponent:offsetY/XYNavBarHeigth];
        if([self.top_bjimg kr_isNotEmpty]){
           [self.TopImageView setNoPlaceholderUrlImg:self.top_bjimg];
        }else{
           [self.TopImageView setUrlImg:@""];
        }
    }else{
        [_barLayer removeFromSuperlayer];
        //_cuNaivgationbar.backgroundColor =[_end_ColorStrr?[UIColor colorWithHexString:_end_ColorStrr]:FNMainGobalControlsColor colorWithAlphaComponent:1.0];
        
        self.TopImageView.backgroundColor =[_end_ColorStrr?[UIColor colorWithHexString:_end_ColorStrr]:FNMainGobalControlsColor colorWithAlphaComponent:1.0];
        if([self.top_bjimg kr_isNotEmpty]){
            [self.TopImageView setNoPlaceholderUrlImg:self.top_bjimg];
        }else{
            [self.TopImageView setUrlImg:@""];
        }
        
    }
    
    if (offsetY == 0) {
        toTopImage.hidden = YES;
    }
    [FNNotificationCenter postNotificationName:@"HomeRoll" object:nil];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [FNNotificationCenter postNotificationName:@"HomeEndRoll" object:nil];
}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (!decelerate)
//    {
//        [self loadImagesForOnscreenRows];
//    }
//}
//
//// -------------------------------------------------------------------------------
////    scrollViewDidEndDecelerating:scrollView
////  When scrolling stops, proceed to load the app icons that are on screen.
//// -------------------------------------------------------------------------------
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    [self loadImagesForOnscreenRows];
//}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    //[self downloadkittyGif];
    firstVersionSearchViewController *vc = [[firstVersionSearchViewController alloc]init]; 
    [self.navigationController pushViewController:vc animated:YES];
    //[self didFNSkipController:@"FNCommodityFieldDeController"];
    return NO;
}

#pragma mark -  setter && getter

- (NSMutableArray <MenuModel *>*)BannerDataArray {
    if (!_BannerDataArray) {
        _BannerDataArray = [NSMutableArray array];
    }
    return _BannerDataArray;
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)categoryIdArray {
    if (!_categoryIdArray) {
        _categoryIdArray = [NSMutableArray array];
    }
    return _categoryIdArray;
}

- (NSMutableArray *)categoryNameArray {
    if (!_categoryNameArray) {
        _categoryNameArray = [NSMutableArray array];
    }
    return _categoryNameArray;
}

- (NSMutableArray *)menuModelArray {
    if (!_menuModelArray) {
        _menuModelArray = [NSMutableArray array];
    }
    return _menuModelArray;
}

- (NSMutableArray *)marqueeArray {
    if (!_marqueeArray) {
        _marqueeArray = [NSMutableArray array];
    }
    return _marqueeArray;
}
- (NSMutableArray *)seckillArray {
    if (!_seckillArray) {
        _seckillArray = [NSMutableArray array];
        
    }
    return _seckillArray;
}
- (NSMutableArray *)ComponentArray {
    if (!_ComponentArray) {
        _ComponentArray = [NSMutableArray array];
    }
    return _ComponentArray;
}

#pragma mark - FNBuyProductHeatNViewDelegate
- (void)ProductHeatClickAction:(FNBaseProductModel *)item{
    //NSLog(@"首页选择");
    [self goProductVCWithModel:item withData:item.data];
}
- (void)CheckProductAction{
    //NSLog(@"查看全部");
    //[self loadOtherVCWithModel:self.MiaoshaModel andInfo:nil outBlock:nil];
    /*FNPSecKillController* seckill = [FNPSecKillController new];
    seckill.view_type = @"";
    seckill.identifier =  @"";
    seckill.title =  @"今日必抢";
    seckill.titleImg =  @"";
    [self.navigationController pushViewController:seckill animated:YES];*/
    FNHomeSecKillViewController *secKill = [FNHomeSecKillViewController new];
    [self.navigationController pushViewController:secKill animated:YES];
}
#pragma mark - 弹出隐私政策
-(void)popupPolicyView{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSInteger privacy_onoff = [[defaults objectForKey:@"privacy_onoff"] integerValue];
    
    if(privacy_onoff==0 && [[FNBaseSettingModel settingInstance].privacy_onoff isEqualToString:@"1"]){
        FNUpPolicyPopupNeView *policyview=[[FNUpPolicyPopupNeView alloc]initWithFrame:CGRectMake(0, 0, JMScreenWidth, JMScreenHeight) andHeight:JMScreenHeight-200];
        policyview.alpha = 0;
        [[UIApplication sharedApplication].keyWindow addSubview:policyview];
        [policyview showView];
    }
   
}
-(void)downloadkittyGif{
    /*NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSData *imagedata = [defaults objectForKey:@"kittyGif"];
    [SVProgressHUD showImage:[UIImage sd_animatedGIFWithData:imagedata] status:@""];*/
    [FNKittyGifNeView showView:self.view]; 
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [FNKittyGifNeView hideView];
    });
    
}


//#pragma mark - notification
//- (void)observingPastedChange:(NSNotification*)ntf{
//    FNPastedModel* pastedModel = [FNPastedModel pastedModel];
//
//    if (!pastedModel.c_is_closed) {
//        //show
//
//        NSString* string = pastedModel.searchstring;
//
//        if (string && string.length>=1) {
//#if APP_XYJ == 1
//            [XYJObserveSearchView showSearchViewWithKeyword:string searchBlock:^{
//                SuperViewController* vc = (SuperViewController *)[self topViewController];
//                ProductListViewController* product  = [ProductListViewController new];
//                product.searchTitle = string;
//                product.categoryID = @"";
//                [vc.navigationController pushViewController:product animated:YES];
//            }];
//#else
//            JMAlertView * alert = [JMAlertView alertWithTitle:@"是否搜索" content:string firstTitle:@"取消" andSecondTitle:@"去搜索" alertType:(AlertTypeAlert) clickBlock:^(NSInteger index) {
//                if (index == 1) {
//                    SuperViewController* vc = (SuperViewController *)[self topViewController];
//                    ProductListViewController* product  = [ProductListViewController new];
//                    product.searchTitle = string;
//                    product.categoryID = @"";
//                    [vc.navigationController pushViewController:product animated:YES];
//
//                }
//            }];
//            if (alert) {
//                [alert.secondButton setTitleColor:FNMainGobalControlsColor forState:(UIControlStateNormal)];
//                [alert.firstButton setTitleColor:FNGlobalTextGrayColor forState:(UIControlStateNormal)];
//                [alert showAlert];
//            }
//#endif
//            pastedModel.c_is_closed = YES;
//            [FNPastedModel savePastedModel:pastedModel];
//
//        }
//
//    }
////    [FNPastedModel savePastedModel:pastedModel];
//
//
//}
//- (void)dealloc
//{
//    if (![NSString checkIsSuccess:[FNBaseSettingModel settingInstance].indexsearch_onoff andElement:@"1"]) {
//        [FNNotificationCenter removeObserver:self name:@"pastedChange" object:nil];
//    }
//
//}
//- (UIViewController *)topViewController {
//    UIViewController *resultVC;
//    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
//    while (resultVC.presentedViewController) {
//        resultVC = [self _topViewController:resultVC.presentedViewController];
//    }
//    return resultVC;
//}
//
//- (UIViewController *)_topViewController:(UIViewController *)vc {
//    if ([vc isKindOfClass:[UINavigationController class]]) {
//        return [self _topViewController:[(UINavigationController *)vc topViewController]];
//    } else if ([vc isKindOfClass:[UITabBarController class]]) {
//        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
//    } else {
//        return vc;
//    }
//    return nil;
//}

#pragma mark - lhScanQCodeViewControllerDelegate
- (void)didCodeScan:(NSString *)result {
    [self goWebWithUrl:result];
}

#pragma mark - 右下角红包 温馨提示
//首页提示及红包图
-(FNRequestTool*)requestTipList{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=indexTipList&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        [self isRightBottomAddSubViews];
        NSDictionary* dictry = respondsObject[DataKey];
        self.rbModel=[FNHometipRedpacketModel mj_objectWithKeyValues:dictry];
        if(self.rbModel.redpacket.count>0){
            self.hbView.hidden=NO;
            self.rightPacketModel=[FNHometipRedpacketModel mj_objectWithKeyValues:self.rbModel.redpacket[0]];
            [self.hbimgView setUrlImg:self.rightPacketModel.img];
        }
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in self.rbModel.tip_list) {
            FNHometipRedpacketModel *tipModel=[FNHometipRedpacketModel mj_objectWithKeyValues:dic];
            [arrM addObject:tipModel.content];
        }
        if(self.rbModel.tip_list.count>0){
            FNHometipRedpacketModel *tipOneModel=[FNHometipRedpacketModel mj_objectWithKeyValues:self.rbModel.tip_list[0]];
            self.noticeLabel.textColor=[UIColor colorWithHexString:tipOneModel.content_color];
            [self.msgimgBtn sd_setImageWithURL:URL(tipOneModel.msgimg) forState:UIControlStateNormal];
            [self.hideGreenBtn sd_setImageWithURL:URL(tipOneModel.closeimg) forState:UIControlStateNormal];
            [self.msgBGView setUrlImg:tipOneModel.img];
            if([tipOneModel.is_new integerValue]==1){
                self.msgView.hidden=NO;
                [self showAfficheAction];
            }
        }
        if(self.rbModel.tip_list.count>1){
            self.noticeLabel.browseMode = SYNoticeBrowseVerticalScrollWhileMore;
            self.noticeLabel.delayTime=3.0;
            self.noticeLabel.durationTime = 3.0;
        }else{
            self.noticeLabel.browseMode = SYNoticeBrowseHorizontalScrollWhileSingle;
        }
        self.noticeLabel.texts = arrM;
        [self.noticeLabel reloadData];
        
    } failure:^(NSString *error) {
    } isHideTips:YES isCache:NO];
}
//首页温馨提示关闭操作
-(FNRequestTool*)requestTipListClose{
    //@weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=indexTipList&ctrl=close" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //@strongify(self);
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        //NSString *msgStr=respondsObject[MsgKey];
        //[FNTipsView showTips:msgStr];
        if(state==1){
            
        }
    } failure:^(NSString *error) {
    } isHideTips:YES isCache:NO];
}
#pragma mark - 右下 Views 温馨提示和红包
-(void)isRightBottomAddSubViews{
    //不能在这里做刷新UI操作
    self.HBPoinX=FNDeviceWidth-80;
    self.hbView=[[UIView alloc]init];
    self.hbView.hidden=YES;
    [self.view addSubview:self.hbView];
    [self.view bringSubviewToFront:self.hbView];
    self.hbimgView=[[UIImageView alloc]init];
    [self.hbView addSubview:self.hbimgView];
    self.hbView.frame = CGRectMake(self.HBPoinX+50, XYScreenHeight - 280, 74, 62);
    [self.hbimgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.hbView);
    }];
    self.hbView.userInteractionEnabled=YES;
    self.hbimgView.userInteractionEnabled=YES;
    UITapGestureRecognizer *hbimgViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hbimgViewClick)];
    [self.hbimgView addGestureRecognizer:hbimgViewTap];
    self.hbimgView.alpha=0.5f;
    
    self.msgView=[[UIView alloc]init];
    self.msgView.hidden=YES;
    [self.view addSubview:self.msgView];
    self.msgView.frame=CGRectMake(0, FNDeviceHeight, FNDeviceWidth, 33);
    
    self.msgBGView=[[UIImageView alloc]init];
    [self.msgView addSubview:self.msgBGView];
    self.msgBGView.frame=CGRectMake(0, 0, FNDeviceWidth, 33);
    
    self.noticeLabel = [[SYNoticeBrowseLabel alloc] initWithFrame:CGRectMake(33, 0, FNDeviceWidth-70, 33)];
    [self.msgView addSubview:self.noticeLabel];
    self.noticeLabel.frame=CGRectMake(33, 0, FNDeviceWidth-70, 33);
    self.noticeLabel.tag = 100000;
    //self.noticeLabel.backgroundColor =  RGBA(205, 234, 212, 0.7);
    self.noticeLabel.textColor =  RGB(68, 133, 105);
    self.noticeLabel.textFont = [UIFont systemFontOfSize:13.0];
    NSArray *tessArr=@[@""];
    self.noticeLabel.texts = tessArr;
    @weakify(self);
    self.noticeLabel.textClick = ^(NSInteger index){
        //XYLog(@"点击时，暂停动画；点击释放时，恢复动画。");
        @strongify(self);
        NSDictionary *dictry=self.rbModel.tip_list[0];
        [self loadOtherVCWithModel:dictry andInfo:nil outBlock:nil];
    };
    self.noticeLabel.browseMode = SYNoticeBrowseHorizontalScrollWhileSingle;
    
    self.msgimgBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.msgimgBtn setImage:IMAGE(@"FN_homeGTzimg") forState:UIControlStateNormal];
    [self.msgView addSubview:self.msgimgBtn];
    [self.msgimgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.msgView.mas_top).offset(0);
        make.left.equalTo(self.msgView.mas_left).offset(7);
        make.height.mas_equalTo(33);
        make.width.mas_equalTo(33);
    }];
    self.msgimgBtn.imageView.sd_layout
    .centerXEqualToView(self.msgimgBtn).centerYEqualToView(self.msgimgBtn).widthIs(16).heightIs(12);
    
    self.hideGreenBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.hideGreenBtn addTarget:self action:@selector(hideAfficheAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.hideGreenBtn setImage:IMAGE(@"FN_homeGGbimg") forState:UIControlStateNormal];
    [self.msgView addSubview:self.hideGreenBtn];
    [self.hideGreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.msgView.mas_bottom).offset(-4);
        make.right.equalTo(self.msgView.mas_right).offset(-10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(25);
    }];
    self.hideGreenBtn.imageView.sd_layout
    .centerXEqualToView(self.hideGreenBtn).centerYEqualToView(self.hideGreenBtn).widthIs(9).heightIs(9);
}
//点击红包
-(void)hbimgViewClick{
    [self loadOtherVCWithModel:self.rightPacketModel andInfo:nil outBlock:nil];
}
//显示温馨提示
-(void)showAfficheAction{
    @WeakObj(self);
    CGFloat bottomTap=FNDeviceHeight-XYTabBarHeight-33;
    selfWeak.msgView.hidden=NO;
    [UIView animateWithDuration:0.6f animations:^{
        selfWeak.msgView.frame=CGRectMake(0, bottomTap, FNDeviceWidth, 33);
    }];
}
//隐藏温馨提示
-(void)hideAfficheAction{
    CGFloat bottomTap=FNDeviceHeight;
    @WeakObj(self);
    [UIView animateWithDuration:0.6f animations:^{
        selfWeak.msgView.frame=CGRectMake(0, bottomTap, FNDeviceWidth, 33);
    } completion:^(BOOL finished) {
        selfWeak.msgView.hidden=YES;
    }];
    if(![NSString isEmpty:UserAccessToken]){
        [self requestTipListClose];
    }
}
//显示红包
-(void)showHBViewAction{
    @WeakObj(self);
    [UIView animateWithDuration:0.6f animations:^{
        selfWeak.hbView.frame=CGRectMake(self.HBPoinX, self.hbView.frame.origin.y, 74, 62);
        selfWeak.hbimgView.alpha=1.0f;
    } completion:^(BOOL finished) {
    }];
}
//向右移动红包
-(void)hideHBViewAction{
    @WeakObj(self);
    [UIView animateWithDuration:0.6f animations:^{
        selfWeak.hbView.frame=CGRectMake(self.HBPoinX+50, self.hbView.frame.origin.y, 74, 62);
        selfWeak.hbimgView.alpha=0.5f;
    } completion:^(BOOL finished) {
    }];
}
//滑动
-(void)obserHomeRoll{
    [self hideHBViewAction];
}
//滑动结束
-(void)obserHomeEndRoll{
    [self showHBViewAction];
}

@end
