//
//  FNPorDetailForShareController.m
//  THB
//
//  Created by jimmy on 2017/9/21.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPorDetailForShareController.h"
#import "JMHomeProductCell.h"
#import "FNProDetailForShareView.h"
#import "FNFunctionBtnView.h"
#import "FNHomeSpecialCell.h"
@interface FNPorDetailForShareController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)FNProDetailForShareView* header;
@property (nonatomic, strong)UIView* sectionHeader;
@property (nonatomic, strong)NSMutableArray* products;

@property (nonatomic, strong)UIView* bottomview;
@property (nonatomic, strong)FNFunctionBtnView* collectBtn;
@property (nonatomic, strong)FNFunctionBtnView* shareBtn;

@property (nonatomic, strong)UIView* navigationview;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, weak)UIButton* backBtn;

@property (nonatomic, strong)FNBaseProductModel* model;

@end

@implementation FNPorDetailForShareController
- (UIView *)navigationview{
    if (_navigationview == nil) {
        _navigationview = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 64))];
        _navigationview.backgroundColor = [FNWhiteColor colorWithAlphaComponent:0];
        
        UIButton* backbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backbtn setImage:IMAGE(@"return_white") forState:(UIControlStateNormal)];
        [backbtn sizeToFit];
        [backbtn addTarget:self action:@selector(backbtnAction)];
        [_navigationview addSubview:backbtn];
        [backbtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
        [backbtn autoSetDimensionsToSize:backbtn.size];
        [backbtn autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:_navigationview withOffset:_jm_margin10];
        

        [_navigationview addSubview:self.titleLabel];
        [self.titleLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:backbtn];
        [self.titleLabel autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        
    }
    return _navigationview;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel= [UILabel new];
        _titleLabel.text = self.title;
        _titleLabel.font = kFONT17;
        _titleLabel.alpha = 0;
        
    }
    return _titleLabel;
}
- (NSMutableArray *)products
{
    if (_products == nil) {
        _products = [NSMutableArray new];
    }
    return _products ;
}
- (FNFunctionBtnView *)shareBtn{
    if (_shareBtn == nil) {
        CGFloat width = FNDeviceWidth*0.25;
        _shareBtn = [[FNFunctionBtnView alloc]initWithFrame:(CGRectMake(0, 0, width, 49)) btnImage:IMAGE(@"goos_detail_share_new") andTitle:@"分享"];
        @WeakObj(self);
        [_shareBtn addJXTouch:^{
            //
            [selfWeak umengShare];
        }];
    }
    return _shareBtn;
}
- (FNFunctionBtnView *)collectBtn{
    if (_collectBtn == nil) {
                CGFloat width = FNDeviceWidth*0.25;
        _collectBtn = [[FNFunctionBtnView alloc]initWithFrame:(CGRectMake(0, 0, width, 49)) btnImage:IMAGE(@"goos_detail_collect_off") andTitle:@"收藏"];
        _collectBtn.selectedImage = IMAGE(@"goos_detail_collect_on");
        @WeakObj(self);
        [_collectBtn addJXTouch:^{
            //
            [selfWeak collectBtnAction];
        }];
    }
    return _collectBtn;
}
- (UIView *)bottomview{
    if (_bottomview == nil) {
        _bottomview = [UIView new];
        _bottomview.backgroundColor = FNWhiteColor;
        [_bottomview addSubview:self.collectBtn];
        [self.collectBtn autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeRight)];
        [self.collectBtn autoSetDimension:(ALDimensionWidth) toSize:self.collectBtn.width];
        
        [_bottomview addSubview:self.shareBtn];
        CGFloat width = FNDeviceWidth*0.25;
        [self.shareBtn autoSetDimension:(ALDimensionWidth) toSize:width];
        [self.shareBtn autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.collectBtn];
        [self.shareBtn autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
        [self.shareBtn autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
        
        UIButton* purchaseBtn  =[ UIButton buttonWithTitle:@"立即购买" titleColor:FNWhiteColor font:kFONT14 target:self action:@selector(purchaseBtnAction)];
        purchaseBtn.backgroundColor = FNMainGobalControlsColor;
        [_bottomview addSubview:purchaseBtn];
        [purchaseBtn autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeLeft)];
        [purchaseBtn autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.shareBtn];
    }
    return _bottomview;
}
- (UIView *)sectionHeader{
    if (_sectionHeader == nil) {
        _sectionHeader = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 50))];
        
        UILabel* label = [UILabel new];
        label.font = kFONT14;
        label.textColor = FNGlobalTextGrayColor;
        label.text = @"精品推荐";
        [label sizeToFit];
        [_sectionHeader addSubview:label];
        [label autoCenterInSuperview];
        
        UIView * leftline = [UIView new];
        leftline.backgroundColor = FNGlobalTextGrayColor;
        [_sectionHeader addSubview:leftline];
        [leftline autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:label withOffset:-_jm_leftMargin];
        [leftline autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [leftline autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_sectionHeader withMultiplier:0.16];
        [leftline autoSetDimension:(ALDimensionHeight) toSize:1];
        
        UIView * rightline = [UIView new];
        rightline.backgroundColor = FNGlobalTextGrayColor;
        [_sectionHeader addSubview:rightline];
        [rightline autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:label withOffset:_jm_leftMargin];
        [rightline autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [rightline autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_sectionHeader withMultiplier:0.16];
        [rightline autoSetDimension:(ALDimensionHeight) toSize:1];
    }
    return _sectionHeader;
}
- (FNProDetailForShareView *)header{
    if (_header == nil) {
        _header = [[FNProDetailForShareView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0))];
        
    }
    return _header;
}
- (void)setModel:(FNBaseProductModel *)model{
    _model  =model;
    self.header.model = _model;
    self.collectBtn.button.selected = self.model.is_collect.boolValue;
    [self.header layoutIfNeeded];
    self.jm_tableview.tableHeaderView = self.header;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    // Do any additional setup after loading the view.
    
    [self setupviews];
    if (IOS11) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [SVProgressHUD show];
    [FNRequestTool startWithRequests:@[[self requestDetail],[self requestProduct:YES]] withFinishedBlock:^(NSArray *erros) {
        //
        [UIView animateWithDuration:0.1 animations:^{
            self.jm_tableview.alpha = 1;
        } completion:^(BOOL finished) {
            [self.jm_tableview reloadData];
        }];
        [SVProgressHUD dismiss];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
  [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
}
#pragma mark - initializedSubviews
- (void)setupviews
{
    [self.view addSubview:self.navigationview];
    [self.navigationview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.navigationview autoSetDimension:(ALDimensionHeight) toSize:self.navigationview.height];
    
    
    self.jm_tableview =  [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.alpha = 0;
    self.jm_tableview.tableHeaderView = self.header;
    self.jm_tableview.tableFooterView = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 49))];
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
    [self.view addSubview:self.bottomview];
    [self.bottomview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeTop)];
    [self.bottomview autoSetDimension:(ALDimensionHeight) toSize:49];
    [self.view bringSubviewToFront:self.navigationview];
}

#pragma mark  - request
- (FNRequestTool*)requestDetail{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"tburl":self.url,TokenKey:UserAccessToken}];
    return  [FNRequestTool requestWithParams:params api:_api_home_productdetailtool respondType:(ResponseTypeModel) modelType:@"FNBaseProductModel" success:^(id respondsObject) {
        //
        self.model = respondsObject;
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}
- (FNRequestTool *)requestProduct:(BOOL)ishide{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,PageNumber:@(self.jm_page),PageSize:@(_jm_pro_pagesize)}];
    return  [FNRequestTool requestWithParams:params api:_api_home_recommendproduct respondType:(ResponseTypeArray) modelType:@"FNBaseProductModel" success:^(NSArray* respondsObject) {
        //
        if (self.jm_page == 1) {
            [self.products addObjectsFromArray:respondsObject];
            if (respondsObject.count>=_jm_pro_pagesize) {
                self.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.jm_page ++;
                    [self requestProduct:NO];
                }];
            }else{
                self.jm_tableview.mj_footer = nil;
            }
        }else{
            [self.products removeAllObjects];
            [self.products addObjectsFromArray:respondsObject];
            if (respondsObject.count>=_jm_pro_pagesize) {
                [self.jm_tableview.mj_footer endRefreshing];
                
            }else{
                [self.jm_tableview.mj_footer endRefreshingWithNoMoreData];
            }
        }
    } failure:^(NSString *error) {
        //
        [self.jm_tableview.mj_header endRefreshing];
        [self.jm_tableview.mj_footer endRefreshing];
    } isHideTips:ishide];
}

#pragma mark - action
- (void)backbtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)purchaseBtnAction{
    [self goToProductDetailsWithModel:self.model];
}
- (void)collectBtnAction{
    NSString *token = UserAccessToken;
    if (token == nil  || token.length == 0) {
        //warn user to login
        [FNTipsView showTips:@"登录之后才可以收藏商品"];
    }else{
        if (self.model.is_collect.boolValue) {
            [self deleteMyLikeMethod:self.model.ID];
        }else{
            [self addMyLikeMethod:self.model.ID];
        }
    }
    
}
-(void)deleteMyLikeMethod:(NSString *)goodsId{
    @WeakObj(self);

    NSMutableDictionary* params =[NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"goodsid":goodsId,@"token":UserAccessToken}];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_home_deletemylike successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody is %@",responseBody);
        if ([[dict objectForKey:XYSuccess]  isEqual: @1]) {
            selfWeak.model.is_mylike = NO;
            selfWeak.collectBtn.button.selected = NO;
            [FNTipsView showTips:XYDeleteLikeMsg];
        }else {
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }

    } failureBlock:^(NSString *error) {
        [XYNetworkAPI cancelAllRequest];
    }];
    
}
-(void)addMyLikeMethod:(NSString *)goodsId{
    @WeakObj(self);
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"goodsid":goodsId,
                                                                                 @"token":UserAccessToken                        }];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_home_addmylike successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody is %@",responseBody);
        if ([[dict objectForKey:XYSuccess]  isEqual: @1]) {
            selfWeak.model.is_mylike = YES;
            selfWeak.collectBtn.button.selected = YES;
            [FNTipsView showTips:XYAddLikeMsg];
        }else {
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }

    } failureBlock:^(NSString *error) {
        [XYNetworkAPI cancelAllRequest];
    }];
    
}


-(void)umengShare{
    [self shareProductWithModel:self.model];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.products.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JMCellTool tableView:tableView atIndexPath:indexPath superVC:self andModel:self.products[indexPath.row]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.sectionHeader;
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.sectionHeader.height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [JMCellTool cellHeightTableview:tableView atIndexPath:indexPath andModel:self.products[indexPath.row]];
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FNBaseProductModel *model = self.products[indexPath.row];
    if (model.is_qiangguang.boolValue) {
        [FNTipsView showTips:@"商品太火爆了，已被抢光，赶紧看一下其他商品吧〜"];
    }else{
        //           [self goProductVCWithModel:model];
        [self goProductVCWithModel:model];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat height = 64;
    CGFloat cony = scrollView.contentOffset.y;
    if (cony >0 && cony < height) {
        self.navigationview.backgroundColor = [FNWhiteColor colorWithAlphaComponent:cony/height];
        self.titleLabel.alpha = 0;
        [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    }else if (cony>height){
        self.navigationview.backgroundColor = [FNWhiteColor colorWithAlphaComponent:1];
        self.titleLabel.alpha = 1;
        [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
    }else if (cony == 0){
        self.navigationview.backgroundColor = [FNWhiteColor colorWithAlphaComponent:0];
        self.titleLabel.alpha = 0;
        [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    }
}
@end
