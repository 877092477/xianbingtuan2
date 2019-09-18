//
//  ProductListViewController.m
//  THB
//
//  Created by zhongxueyu on 16/3/31.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "ProductListViewController.h"
#import "ProductCell.h"
#import "ProductCollectionViewCell.h"
#import "SearchViewController.h"
#import "FNBaseProductModel.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "secondViewController.h"

#import "FNHomeSpecialCCell.h"
#import "FNHomeSpecialCell.h"
#define MARGIN 15
#define anTime 0.2
@interface ProductListViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
}

/** TableView */
@property (nonatomic,strong) UITableView *xy_TableView;

/** CollectionView */
@property (nonatomic,strong)   UICollectionView *collectionView;

/** CollectionView布局 */
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;

/** HeadView */
@property (nonatomic,strong) UIView *HeadView;

/** 搜索输入框背景上的Lable */
@property (nonatomic,strong) UILabel *searchLable;

/** 搜索输入框右边的关闭按钮 */
@property (nonatomic,strong) UIButton *closeBtn;

/** 排序按钮 */
@property (nonatomic,strong) UIButton *sortBtn;

/** 排序按钮父视图 */
@property (nonatomic,strong) UIView *sortBtnView;

/** 切换视图按钮 */
@property (nonatomic,strong) UIButton *toggleViewBtn;

/** 筛选的箭头图片 */
@property (nonatomic,strong) UIImageView *arrowImg;

/** 下方分割线 */
@property (nonatomic,strong) UIView *thirdLineView;

/** 最低价格输入框 */
@property (nonatomic,strong) UITextField *minPrice;

/** 最高价格输入框 */
@property (nonatomic,strong) UITextField *maxPrice;

/** 仅看天猫按钮 */
@property (nonatomic,strong) UIButton *onlyTmailBtn;

/** 设置筛选条件视图 */
@property (nonatomic,strong) UIView *sortView;

/** 筛选完成按钮 */
@property (nonatomic,strong) UIButton *confirmBtn;

/** 是否仅看天猫 1.是 */
@property (nonatomic,assign) int is_tm;

/** 商品数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 页数 */
@property (nonatomic, assign) int page;



@property (nonatomic, strong)UIImageView* toTopImage;

@property (nonatomic, strong)UIView* switchView;
@property (nonatomic, strong)UIButton* switchBtn;
@property (nonatomic, assign)BOOL isCoupon;



@end
static NSString * const reuseIdentifier = @"collectionViewCell";

@implementation ProductListViewController
@synthesize xy_TableView,toTopImage;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isCoupon = ![FNBaseSettingModel settingInstance].dgapp_yhq_onoff.boolValue;
    self.page = 1;
    self.sort = 1;
    _is_tm = 0;
    XYLog(@"Title is %@",self.categoryID);
    [self setUpNavView];
    
    //注册通知
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
    [self loadProductListMethod];
    __weak __typeof(self)weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        weakSelf.page = 1;
        [weakSelf loadProductListMethod];
    }];
    
    xy_TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        weakSelf.page = 1;
        [weakSelf loadProductListMethod];
    }];
    [self initTableView];
    [self initCollectionView];
    [self.view bringSubviewToFront:toTopImage];
}
- (void)setUpSwitchView{
    _switchView = [[UIView alloc]initWithFrame:CGRectMake(0, JMNavBarHeigth+36, FNDeviceWidth, 34)];
    [_HeadView addSubview:_switchView];
    
    UIImageView *imgView = [UIImageView new];
    imgView.image = IMAGE(@"my_quan");
    [imgView sizeToFit];
    [self.switchView addSubview:imgView];
    [imgView autoSetDimensionsToSize:CGSizeMake(15, 10)];
    [imgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
    [imgView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    _switchBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _switchBtn.selected = self.isCoupon;
    [_switchBtn setImage:IMAGE(@"rp_switch_off") forState:UIControlStateNormal];
    [_switchBtn setImage:IMAGE(@"rp_switch_on") forState:UIControlStateSelected];
    [_switchBtn addTarget:self action:@selector(switchBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_switchBtn sizeToFit];
    [self.switchView addSubview:_switchBtn];
    [_switchBtn autoSetDimensionsToSize:_switchBtn.size];
    [_switchBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
    [_switchBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    
    UILabel *tmpLabel = [UILabel new];
    tmpLabel.text = @"仅显示优惠券商品";
    tmpLabel.font = kFONT14;
    tmpLabel.textColor = FNGlobalTextGrayColor;
    [self.switchView addSubview:tmpLabel];
    [tmpLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:imgView withOffset:_jm_margin10*0.5];
    [tmpLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    
}
- (void)switchBtnAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.isCoupon = btn.selected;
    self.page = 1;
    [self loadProductListMethod];
}

-(void)postFootPrintMethpd:(NSString *)goodsId{

    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                  @"time":[NSString GetNowTimes],
                                                                                  @"goodsid":goodsId,
                                                                                  @"token":UserAccessToken
                                                                                  }];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_mine_addfootmark successBlock:^(id responseBody) {
        
        
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
    }];
}
/**
 *  接收搜索结果
 *
 *  @param noti
 */
- (void)tongzhi:(NSNotification *)noti{
    XYLog(@"－－－－－接收到通知------");
    NSLog(@"%@",noti.userInfo);
    self.page  = 1;
    _categoryID = @"";
    self.searchTitle = [noti.userInfo objectForKey:@"keyword"];
//    [self setUpNavView];
    [self loadProductListMethod];
}


#pragma 获取数据
-(void)loadProductListMethod
{
    NSString *isTmail ;
    if(_is_tm == 0){
        isTmail = @"false";
    }else if (_is_tm == 1){
        isTmail = @"true";
        
    }
    NSString *endPrice;
    if(self.price2 == 0){
        endPrice = @"";
    }else{
        endPrice = [NSString stringWithFormat:@"%d",self.price2];
    }
    
    NSString *keyword;
    if (self.categoryID.length==0) {
        keyword=self.searchTitle;
    }else{
        keyword=[NSString stringWithFormat:@"%@ %@",self.categoryID,self.searchTitle];
    }
    
    NSInteger pagesize = 8;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{
                                    @"time":[NSString GetNowTimes],
                                    @"sort":[NSNumber numberWithInt:self.sort],
                                    @"page_no":[NSNumber numberWithInt:self.page],
                                    @"start_price":[NSNumber numberWithInt:self.price1],
                                    @"end_price":endPrice,
                                    @"keyword":keyword,
                                    @"token":UserAccessToken,
                                    @"mall_item":isTmail,
                                    @"page_size":@(pagesize),
                                    @"yhq":@(self.isCoupon)
                                                                }];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_showorder_GETATBProductInfo successBlock:^(id responseBody) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [xy_TableView.mj_header endRefreshing];
        [xy_TableView.mj_footer endRefreshing];
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:SuccessValue]) {
            if (self.page == 1) {
                //                _is_tm = 0;
                //                self.price1 = 0;
                //                self.price2 = 0;
                [self.dataArray removeAllObjects];
            }
            
            NSArray *tempArray = [dict objectForKey:XYData];
            
            if (tempArray.count>0) {
                for (int i = 0; i < tempArray.count; i ++) {
                    FNBaseProductModel *model = [FNBaseProductModel mj_objectWithKeyValues:tempArray[i]];
                    model.data = tempArray[i];
                    [self.dataArray addObject:model];
                    
                }
                
                if (tempArray.count < pagesize) {
                    self.collectionView.mj_footer = nil;
                    xy_TableView.mj_footer = nil;
                }else {
                    if (!self.collectionView.mj_footer) {
                        __weak __typeof(self)weakSelf = self;
                        self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                            // 进入刷新状态后会自动调用这个block
                            
                            weakSelf.page += 1;
                            [weakSelf loadProductListMethod];
                        }];
                        
                        if (!xy_TableView.mj_footer) {
                            __weak __typeof(self)weakSelf = self;
                            xy_TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                                // 进入刷新状态后会自动调用这个block
                                weakSelf.page += 1;
                                [weakSelf loadProductListMethod];
                            }];
                        }
                        
                    }
                }
                [SVProgressHUD dismiss];
            }else{
                if(self.page >1 ){
                    [FNTipsView showTips:XYMsg];
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }else if ( self.page == 1){
                    [FNTipsView showTips:@"很抱歉，没有找到该类产品~"];
                }
                
            }
            [self.view addSubview:xy_TableView];
            [self.view addSubview:self.collectionView];
            
            [xy_TableView reloadData];
            [self.collectionView reloadData];
            [self.view addSubview:_sortView];
            [self.view bringSubviewToFront:toTopImage];
            
        }else{
            
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        
        
    } failureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
        [XYNetworkAPI cancelAllRequest];
        [self.collectionView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - 头部视图
-(void)setUpNavView
{
    //头部
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, XYStatusBarHeight, XYScreenWidth, JMNavBarHeigth+36 + 34)];
    _HeadView = headView;
    [self.view addSubview:_HeadView];
    
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage: [UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(MARGIN-5, MARGIN*2, 20, 18);
    leftbutton.centerY = isIphoneX? 64 :44;
    [leftbutton addTarget:self action:@selector(LeftBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [_HeadView addSubview:leftbutton];
    
    
    //搜索框
    UIImageView *titleView=[[UIImageView alloc]initWithFrame:CGRectMake(MARGIN*2+10, CGRectGetMinY(leftbutton.frame)-5, XYScreenWidth-MARGIN*2-15, 28)];
    titleView.image=[UIImage imageNamed:@"goodbg"];
    titleView.userInteractionEnabled = YES;
    [_HeadView addSubview:titleView];
    
    UIImageView *search = [[UIImageView alloc]initWithFrame:CGRectMake(12, 5, 21, 21)];
    search.image = IMAGE(@"cgf_search");
    [titleView addSubview:search];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(search.frame)+10, 0, CGRectGetWidth(titleView.frame)-65, CGRectGetHeight(titleView.frame))];
    lable.text = self.searchTitle;
    lable.textColor = [UIColor blackColor];
    lable.font = kFONT14;
    _searchLable = lable;
    [titleView addSubview:_searchLable];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnTapTitleView:)];
    [titleView addGestureRecognizer:tap];
    
    //搜索框上的关闭按钮
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lable.frame), 7, 14, 14)];
    [closeBtn setBackgroundImage:IMAGE(@"close") forState:UIControlStateNormal];
    [closeBtn setBackgroundImage:IMAGE(@"gwc_close") forState:UIControlStateHighlighted];
    [closeBtn addTarget:self action:@selector(closeBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    _closeBtn = closeBtn;
    [titleView addSubview:_closeBtn];
    
    //分割线
    UIImageView *lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame)+8, XYScreenWidth, 1)];
    lineImg.image = IMAGE(@"member_line1");
    [_HeadView addSubview:lineImg];
    
    CGFloat bgW;
    if (XYScreenWidth<375) {
        bgW = XYScreenWidth - XYScreenWidth/10;
    }else{
        bgW =XYScreenWidth - XYScreenWidth/9;
    }

    _sortBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineImg.frame), bgW, 30)];
    [_HeadView addSubview:_sortBtnView];
    //排序按钮
    UIButton *sortBtn ;
    NSArray *sortArray = [NSArray arrayWithObjects:@"综合",@"人气",@"返利",@"筛选", nil];

    CGFloat btnW = 40;
    CGFloat btnH = 30;
    CGFloat btnY = 3;

    for (int i = 0 ; i<4; i++) {
        CGFloat btnX;
        //cal x

        if(i == 0){
            btnX = i*btnW+15;
        }else{
            if (XYScreenWidth<375) {
                btnX = i*btnW+i*(XYScreenWidth/10)+15;
            }else{
                btnX = i*btnW+i*(XYScreenWidth/8)+15;
            }
        }
        
        
        
        //设置按钮属性
        sortBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnX,btnY, btnW, btnH)];
        
        //在第三个加上筛选图片
        if (i == 3) {
            UIImageView *arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sortBtn.frame)-2, btnY+btnH/2-2, 7, 4)];
            arrowImg.image = IMAGE(@"gg_down");
            _arrowImg = arrowImg;
            [_sortBtnView addSubview:_arrowImg];
        }
        [sortBtn setTitle:sortArray[i] forState:UIControlStateNormal];
        [sortBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sortBtn setTitleColor:RED forState:UIControlStateSelected];
        if (i == 0) {
            sortBtn.selected = YES;
        }
        sortBtn.tag = i;
        sortBtn.titleLabel.font = kFONT14;
        _sortBtn = sortBtn;
        [sortBtn addTarget:self action:@selector(ToClickMethod:) forControlEvents:UIControlEventTouchUpInside];
        
        [_sortBtnView addSubview:_sortBtn];
    }
    
    //分割线
    UIImageView *secondLineImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_sortBtnView.frame)+3, XYScreenWidth, 1)];
    secondLineImg.image = IMAGE(@"member_line1");
    [_HeadView addSubview:secondLineImg];
    
    //切换视图分割线
    CGFloat lineViewX ;
    if (XYScreenWidth<375) {
        lineViewX = XYScreenWidth - XYScreenWidth/10;
    }else{
        lineViewX =XYScreenWidth - XYScreenWidth/9;
    }
    CGFloat lineH = CGRectGetMaxY(secondLineImg.frame) - CGRectGetMaxY(lineImg.frame);
    UIView *thirdLineView = [[UIView alloc]initWithFrame:CGRectMake(lineViewX, CGRectGetMaxY(lineImg.frame), 1, lineH)];
    thirdLineView.backgroundColor = [UIColor grayColor];
    thirdLineView.alpha = 0.4;
    _thirdLineView = thirdLineView;
    [_HeadView addSubview:thirdLineView];
    
    //切换视图按钮
    CGFloat toggleBtnX ;
    if (XYScreenWidth<375) {
        toggleBtnX = CGRectGetMaxX(thirdLineView.frame)+(XYScreenWidth/10)/4;
    }else{
        toggleBtnX = CGRectGetMaxX(thirdLineView.frame)+(XYScreenWidth/9)/4;
    }
    UIButton *toggleViewBtn = [[UIButton alloc]initWithFrame:CGRectMake(toggleBtnX, CGRectGetMaxY(lineImg.frame)+btnY+btnH/4-2, 20, 20)];
    [toggleViewBtn setBackgroundImage:IMAGE(@"ls2") forState:UIControlStateNormal];
    
    [toggleViewBtn setBackgroundImage:IMAGE(@"ls1") forState:UIControlStateSelected];
    _toggleViewBtn = toggleViewBtn;
    _toggleViewBtn.tag = 4;

    [_toggleViewBtn addTarget:self action:@selector(ToClickMethod:) forControlEvents:UIControlEventTouchUpInside];
    [_HeadView addSubview:_toggleViewBtn];
    
    //设置筛选条件视图
    _sortView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_HeadView.frame)-10, XYScreenWidth, 140)];
    
    _sortView.backgroundColor = [UIColor whiteColor];
    _sortView.hidden = YES;
    //    [[[UIApplication  sharedApplication]keyWindow]addSubview:_sortView];
    
    CGFloat TFH = 40;
    CGFloat TFW = XYScreenWidth/4+10;
    CGFloat TFY = 5;
    
    //价格区间Lable
    UILabel *priceLable = [[UILabel alloc]initWithFrame:CGRectMake(MARGIN,TFY , TFW, TFH)];
    priceLable.text = @"价格区间(元)";
    priceLable.font = kFONT15;
    [_sortView addSubview:priceLable];
    
    //商家类型Lable
    UILabel *shopTypeLable = [[UILabel alloc]initWithFrame:CGRectMake(MARGIN,CGRectGetMaxY(priceLable.frame)+TFY , TFW, TFH)];
    shopTypeLable.text = @"商家类型";
    shopTypeLable.font = kFONT16;
    [_sortView addSubview:shopTypeLable];
    
    //最低价格输入框
    _minPrice = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLable.frame)+10, TFY, TFW, 40)];
    _minPrice.background = IMAGE(@"price_btn");
    _minPrice.placeholder = @"最低价格";
    _minPrice.textAlignment = NSTextAlignmentCenter;
    _minPrice.keyboardType = UIKeyboardTypeNumberPad;
    [_sortView addSubview:_minPrice];
    //箭头Lable
    UILabel *toLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_minPrice.frame)+2,TFY , 10, TFH)];
    toLable.text = @"-";
    toLable.font = kFONT16;
    [_sortView addSubview:toLable];
    
    //最高价格输入框
    _maxPrice = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(toLable.frame)+2, TFY, TFW, 40)];
    _maxPrice.background = IMAGE(@"price_btn");
    _maxPrice.placeholder = @"最高价格";
    _maxPrice.textAlignment = NSTextAlignmentCenter;
    _maxPrice.keyboardType = UIKeyboardTypeNumberPad;
    [_sortView addSubview:_maxPrice];
    
    //仅看天猫按钮
    _onlyTmailBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(_minPrice.frame), CGRectGetMinY(shopTypeLable.frame), TFW, TFH)];
    [_onlyTmailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_onlyTmailBtn setTitleColor:RED forState:UIControlStateSelected];
    [_onlyTmailBtn setTitle:@"仅看天猫" forState:UIControlStateNormal];
    _onlyTmailBtn.tag = 9;
    _onlyTmailBtn.titleLabel.font = kFONT14;
    [_onlyTmailBtn setBackgroundImage:IMAGE(@"stroll_btn") forState:UIControlStateNormal];
    [_onlyTmailBtn setBackgroundImage:IMAGE(@"gg-btn_on") forState:UIControlStateSelected];
    [_onlyTmailBtn addTarget:self action:@selector(siftClickMethod:) forControlEvents:UIControlEventTouchUpInside];
    [_sortView addSubview:_onlyTmailBtn];
    
    //完成按钮
    _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(_onlyTmailBtn.frame), CGRectGetMaxY(_onlyTmailBtn.frame)+TFY, 100, 40)];
    [_confirmBtn.layer setMasksToBounds:YES];
    [_confirmBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    [_confirmBtn setTitle:@"完成" forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = kFONT15;
    _confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    //    [_confirmBtn setBackgroundImage:IMAGE(@"newest1") forState:UIControlStateNormal];
    _confirmBtn.backgroundColor = RED;
    
    [_confirmBtn addTarget:self action:@selector(siftClickMethod:) forControlEvents:UIControlEventTouchUpInside];
    _confirmBtn.tag = 10;
    [_sortView addSubview:_confirmBtn];
    
    
    
    toTopImage = [[UIImageView alloc]initWithFrame:CGRectMake(XYScreenWidth-65, XYScreenHeight-XYTabBarHeight-60, 47, 47)];
    toTopImage.image = IMAGE(@"hddb");
    [toTopImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickToScrollTopMethod:)]];
    [self.view addSubview:toTopImage];
    toTopImage.userInteractionEnabled = YES;
    toTopImage.hidden = YES;
    
    [toTopImage autoSetDimensionsToSize:(CGSizeMake(47, 47))];
    [toTopImage autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15];
        [toTopImage autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:+ 20];

    
    [self setUpSwitchView];
}

-(void)siftClickMethod:(UIButton *)sender{
    [self.maxPrice resignFirstResponder];
    [self.minPrice resignFirstResponder];
    NSInteger tag = sender.tag;
    if (tag == 9) {
        sender.selected = !sender.selected;
        if (sender.selected) {
            _is_tm = 1;
        }else{
            _is_tm = 0;
        }
    }else if (tag == 10){
        XYLog(@"收起");
        
        // 执行动画，隐藏筛选视图
        [UIView animateWithDuration:anTime animations:^{
            
            _sortView.frame = CGRectMake(0, CGRectGetMaxY(_HeadView.frame)-10, XYScreenWidth, 140);
            _sortView.backgroundColor = [UIColor whiteColor];
            _sortBtn.selected = NO;
            _sortView.hidden = YES;
        }];
        self.price1 = [_minPrice.text intValue];
        self.price2 = [_maxPrice.text intValue];
        self.page = 1;
        [xy_TableView setContentOffset:CGPointMake(0,0) animated:YES];
        [self.collectionView setContentOffset:CGPointMake(0,0) animated:YES];
        [self loadProductListMethod];
        
    }
}
/**
 *  左边按钮
 *
 *  @param sender sender
 */
-(void)LeftBtnMethod:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    
}

/**
 *  头部搜索响应方法
 *
 *  @param tap tap
 */
-(void)OnTapTitleView:(UIGestureRecognizer *)tap
{
    if (self.type == 1) {
        [self.navigationController popViewControllerAnimated:NO];
    }else{
        SearchViewController *vc = [[SearchViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.navigationController.navigationBarHidden = YES;
        vc.type = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(void)closeBtnMethod:(UIButton *)sender{
    SearchViewController *vc = [[SearchViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.navigationController.navigationBarHidden = YES;
    vc.type = 1;
    [self.navigationController pushViewController:vc animated:YES];
}
//排序按钮响应方法
-(void)ToClickMethod:(UIButton *)sender
{
    [self.maxPrice resignFirstResponder];
    [self.minPrice resignFirstResponder];
    if (sender.tag !=3 && sender.tag != 4) {
        sender.selected = YES;
        UIButton *otherBtn;
        for (otherBtn in _sortBtnView.subviews) {
            if ([otherBtn isKindOfClass:[UIButton class]]) {
                if (otherBtn != sender)
                {
                    otherBtn.selected = NO;
                    //                [otherBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
            }
        }
        XYLog(@"收起");
        // 执行动画
        [UIView animateWithDuration:anTime animations:^{
            
            _sortView.frame = CGRectMake(0, CGRectGetMaxY(_HeadView.frame)-10, XYScreenWidth, 140);
            _sortView.backgroundColor = [UIColor whiteColor];
            _sortView.hidden = YES;
        }];
    }
    
    XYLog(@"sender is %ld",(long)sender.tag);
    NSInteger tag = sender.tag;
    if (tag == 3){
        XYLog(@"筛选按钮");
        sender.selected = !sender.selected;
        if (sender.selected) {
            XYLog(@"展开");
            // 执行动画
            [UIView animateWithDuration:anTime animations:^{
                
                _sortView.frame = CGRectMake(0, CGRectGetMaxY(_HeadView.frame), XYScreenWidth, 140);
                _sortView.backgroundColor = [UIColor whiteColor];
                _sortView.hidden = NO;
            }];
        }else{
            XYLog(@"收起");
            // 执行动画
            [UIView animateWithDuration:anTime animations:^{
                
                _sortView.frame = CGRectMake(0, CGRectGetMaxY(_HeadView.frame)-10, XYScreenWidth, 140);
                _sortView.backgroundColor = [UIColor whiteColor];
                _sortView.hidden = YES;
            }];
        }
        UIButton *otherBtn;
        for (otherBtn in _sortBtnView.subviews) {
            if ([otherBtn isKindOfClass:[UIButton class]]) {
                if (otherBtn != sender)
                {
                    otherBtn.selected = NO;
                    //                [otherBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
            }
        }
        
    }else if (tag == 4){
        XYLog(@"收起");
        // 执行动画
        [UIView animateWithDuration:anTime animations:^{
            
            _sortView.frame = CGRectMake(0, CGRectGetMaxY(_HeadView.frame)-10, XYScreenWidth, 140);
            _sortView.backgroundColor = [UIColor whiteColor];
            _sortView.hidden = YES;
        }];
        _toggleViewBtn.selected = !_toggleViewBtn.selected;
        self.collectionView.hidden = !self.collectionView.hidden;
        
    }else{
        if (sender.tag == 0) {
            self.sort = 1;
        }else if (sender.tag == 1 ){
            if (self.sort == 6) {
                self.sort = 7;
                
            }else if (self.sort == 7){
                self.sort = 6;
            }
            else if (self.sort !=6 && self.sort !=7) {
                self.sort = 6;
            }
        }else if (sender.tag == 2){
            if (self.sort == 4) {
                self.sort = 5;
                
            }else if (self.sort == 5){
                self.sort = 4;
            }
            else if (self.sort !=4 && self.sort !=5) {
                self.sort = 4;
            }
        }
        //        self.sort = (int)sender.tag+1;
        [xy_TableView setContentOffset:CGPointMake(0,0) animated:YES];
        [self.collectionView setContentOffset:CGPointMake(0,0) animated:YES];
        
        self.page = 1;
        [self loadProductListMethod];
    }
}

#pragma - mark TableView
-(void)initTableView
{
    xy_TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_HeadView.frame), XYScreenWidth, XYScreenHeight-CGRectGetHeight(_HeadView.frame)) style:UITableViewStylePlain];
    xy_TableView.dataSource=self;
    xy_TableView.delegate=self;
    xy_TableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.dataArray.count>0){
        return self.dataArray.count;
    }
    return 0;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 102;
#if APP_XYJ == 1
    height = [JMCellTool cellHeightTableview:tableView atIndexPath:indexPath andModel:self.dataArray[indexPath.row]];
#else
    if ([FNBaseSettingModel settingInstance].goods_flstyle.boolValue) {
        height =  FNHSCellImgHeight+10;
    }
#endif
    
    return height;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
#if APP_XYJ == 1
    return [JMCellTool tableView:tableView atIndexPath:indexPath superVC:self andModel:self.dataArray[indexPath.row]];
#endif
    if ([FNBaseSettingModel settingInstance].goods_flstyle.boolValue) {
        FNHomeSpecialCell* cell = [FNHomeSpecialCell cellWithTableView:tableView atIndexPath:indexPath];
        cell.model = self.dataArray[indexPath.row];
        return cell;
        
    }else{

        ProductCell *cell=[ProductCell cellWithTableView:tableView atIndexPath:indexPath];
        if (self.dataArray.count>0) {
            cell.model = self.dataArray[indexPath.row];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XYLog(@"index is %ld",(long)indexPath.row);
    if (self.dataArray.count>0) {
        
        FNBaseProductModel *model = self.dataArray[indexPath.row];
        [self goProductVCWithModel:model withData:model.data];

    }
    
    
}


#pragma mark - CollectionView
-(void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_HeadView.frame), XYScreenWidth, XYScreenHeight-CGRectGetMaxY(_HeadView.frame)) collectionViewLayout:flowLayout];
    
    //设置代理
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
#if APP_XYJ == 1
    self.collectionView.hidden = YES;
#endif
    
    
    
    self.collectionView.backgroundColor = FNHomeBackgroundColor;
    
    //注册cell和ReusableView（相当于头部）
    if ([FNBaseSettingModel settingInstance].goods_flstyle.boolValue) {
        [self.collectionView registerClass:[FNHomeSpecialCCell class] forCellWithReuseIdentifier:@"FNHomeSpecialCCell"];
    }else{
        [self.collectionView registerClass:[ProductCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.dataArray.count>0){
        return self.dataArray.count;
    }
    return 0;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([FNBaseSettingModel settingInstance].goods_flstyle.boolValue) {
        FNHomeSpecialCCell* cell = [FNHomeSpecialCCell cellWithCollectionView:collectionView atIndexPath:indexPath];
        cell.model = self.dataArray[indexPath.item];
        return cell;
    }else{
        static NSString *identify = @"cell";
        ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        cell.backgroundColor = FNWhiteColor;
        [cell sizeToFit];
        if (!cell) {
            NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
        }
        
        if (self.dataArray.count>0) {
            cell.model = self.dataArray[indexPath.row];
        }
        
        return cell;
    }
    
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([FNBaseSettingModel settingInstance].goods_flstyle.boolValue) {
        CGFloat width = (JMScreenWidth-15)*0.5;
        CGFloat height = width + _hscc_btm_h + 34 +30;
        
        CGSize size = CGSizeMake(width, height);
        return size;
    }else{
        //边距占5*4=20 ，2个
        //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
        return CGSizeMake((XYScreenWidth-20)/2, (XYScreenWidth-20)/2+85 + 24);
    }
    
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 5, 5);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count>0) {
        
        FNBaseProductModel *model = self.dataArray[indexPath.row];
        [self goProductVCWithModel:model withData:model.data];

    }
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//    self.navigationController.navigationBar.translucent = NO;
   [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    XYLog(@"收起");
    
    // 执行动画，隐藏筛选视图
    [UIView animateWithDuration:anTime animations:^{
        
        _sortView.frame = CGRectMake(0, CGRectGetMaxY(_HeadView.frame)-10, XYScreenWidth, 140);
        _sortView.backgroundColor = [UIColor whiteColor];
        _sortBtn.selected = NO;
        _sortView.hidden = YES;
    }];
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
//    //导航栏样式设置
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    if (iOS7) { // 判断是否是IOS7
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
//    }
//    //    [self.navigationController.navigationBar cnReset];
//    self.navigationController.navigationBar.translucent = NO;
//
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"---%f",offsetY);
    if (offsetY > FNDeviceHeight) {
        
        toTopImage.hidden = NO;
    }else{
        
        toTopImage.hidden = YES;
    }
    
    if (offsetY == 0) {
        toTopImage.hidden = YES;
    }
    
}

-(void)ClickToScrollTopMethod:(UIGestureRecognizer *)sender{
    [self.collectionView setContentOffset:CGPointMake(0,0) animated:YES];
    [self.xy_TableView setContentOffset:CGPointMake(0,0) animated:YES];
}
#pragma mark -Getter
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
