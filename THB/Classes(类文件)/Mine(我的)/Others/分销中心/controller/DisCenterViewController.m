//
//  DisCenterViewController.m
//  THB
//
//  Created by zhongxueyu on 16/7/28.
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

#import "DisCenterViewController.h"
#import "DisCenterFirstCell.h"
#import "QuickMenuCell.h"
#import "FXCenterInfoModel.h"
#import "IncomeViewController.h"
#import "MyTeamViewController.h"
#import "MyCommissionViewController.h"
#import "FXDrawViewController.h"
#import "FXQRCodeViewController.h"
#import "FNWithdrawController.h"
#import "FNMCAgentController.h"
#import "FNPosterController.h"
#import "FNPartnerGoodsController.h"
#import "DrawViewController.h"
#import "DisCenterIconModel.h"
#import "FNDisHeaderView.h"
#import "FNMembershipUpgradeViewController.h"
#import "FNImgTitleCell.h"
#import "FNCustomeNavigationBar.h"
@interface DisCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)FNDisHeaderView *headerView;
@property (nonatomic, strong)FNCustomeNavigationBar* navBar;
@property (nonatomic, strong)UIImageView* bgImgView;
@property (nonatomic, strong)UILabel* timeLabel;

@property (nonatomic, strong)NSMutableArray* IconArr;

@property (nonatomic,strong) FXCenterInfoModel *model;


@end

@implementation DisCenterViewController
- (void)setIsNotHome:(BOOL)isNotHome{
    [super setIsNotHome:isNotHome];
    _navBar.leftButton.hidden = !self.isNotHome;
    self.btmcons.constant = self.isNotHome?0:XYTabBarHeight;
}
- (UIImageView *)bgImgView{
    if (_bgImgView == nil) {
        _bgImgView = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, FNDeviceWidth*0.52))];
        _bgImgView.image = IMAGE(@"distribution_bj");
        [self.view insertSubview:_bgImgView atIndex:0];
    }
    return _bgImgView;
}
- (NSMutableArray *)IconArr
{
    if (_IconArr == nil) {
        _IconArr = [[NSMutableArray alloc]init];;
    }
    return _IconArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bgImgView.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavView];
    
    //初始化表格
    [self initTableView];
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self getFXInfoMethod];
}


#pragma mark - 网络请求
-(void)getFXInfoMethod{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                  @"time":[NSString GetNowTimes],
                                                                                  @"token":UserAccessToken
                                                                                  }];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_threesale_fxzx successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            _model = [FXCenterInfoModel mj_objectWithKeyValues:[dict objectForKey:XYData]];
            _headerView.model = _model;
            _timeLabel.text =[NSString stringWithFormat:@"我的加入时间：%@", _model.time];
            [self getfxicoMethod];
        }else{
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
    } failureBlock:^(NSString *error) {
        self.jm_tableview.hidden = NO;
        [XYNetworkAPI cancelAllRequest];
        [self.jm_tableview.mj_footer endRefreshing];
    }];
}
-(void)getfxicoMethod{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                  @"time":[NSString GetNowTimes],
                                                                                  @"token":UserAccessToken
                                                                                  }];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_threesale_fxico successBlock:^(id responseBody) {
        self.jm_tableview.hidden = NO;
        [self.jm_tableview.mj_header endRefreshing];
        NSDictionary *dict = responseBody;
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            [SVProgressHUD dismiss];
            NSArray *arr=[dict objectForKey:XYData];
            for (NSDictionary *dic in arr) {
                DisCenterIconModel *model=[DisCenterIconModel mj_objectWithKeyValues:dic];
                [self.IconArr addObject:model];
            }
        }else{
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        [self.jm_tableview reloadData];
    } failureBlock:^(NSString *error) {
        self.jm_tableview.hidden = NO;
        [XYNetworkAPI cancelAllRequest];
        [self.jm_tableview.mj_footer endRefreshing];
    }];
}

#pragma tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.IconArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FNImgTitleCell* cell = [FNImgTitleCell cellWithTableView:tableView atIndexPath:indexPath];
    DisCenterIconModel *model=self.IconArr[indexPath.row];
    [cell setImage:model.img andTitle:model.name];
    [cell setImgSize:CGSizeMake(35, 35)];
    cell.subTitleLabel.text = model.content;
    cell.subTitleLabel.font = kFONT12;
    cell.subTitleLabel.textColor = FNMainTextNormalColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DisCenterIconModel *model=self.IconArr[indexPath.row];
    if ([model.SkipUIIdentifier isEqualToString:@"pub_shouyitongji"]){
        //收益统计
        IncomeViewController *vc = [[IncomeViewController alloc]init];
        vc.No_hhr=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self loadOtherVCWithModel:self.IconArr[indexPath.row] andInfo:nil outBlock:nil];
    }
}

-(void)ButtonClickMethod:(NSInteger)tag{
    if (tag == 0){//我的佣金
        MyTeamViewController *vc = [[MyTeamViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (tag == 1) {//查看明细
        FXDrawViewController *vc = [[FXDrawViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (tag == 2){//提现
#if APP_XYJ == 1
        NSString *urlString = [NSString stringWithFormat:@"%@%@%@",IP,_api_mine_Draw,UserAccessToken];
        DrawViewController *vc = [[DrawViewController alloc]init];
        vc.url = urlString;
        [self.navigationController pushViewController:vc animated:YES];
#else
        FNWithdrawController* withdraw = [FNWithdrawController new];
        withdraw.type = @"2";
        [self.navigationController pushViewController:withdraw animated:YES];
#endif
    }
}
#pragma mark - UI
-(void)initTableView
{
    @WeakObj(self);
    _headerView = [[FNDisHeaderView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0))];
    _headerView.tapViewBlock = ^(NSInteger index) {
        if ([FNDisplayName isEqualToString:@"糖果淘"]){
            return;
        }
        [selfWeak ButtonClickMethod:index];
    };
    [_headerView.avatarImgView addJXTouch:^{
        if ([FNDisplayName isEqualToString:@"糖果淘"]){
            return;
        }
        //我的佣金
        MyCommissionViewController *vc = [[MyCommissionViewController alloc]init];
        [selfWeak.navigationController pushViewController:vc animated:YES];
    }];
    
    UIView* footerView = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 100))];
    _timeLabel = [UILabel new];
    _timeLabel.font = kFONT14 ;
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = FNMainTextNormalColor;
    _timeLabel.text = @"我的加入时间：****-**-**";
    [footerView addSubview:_timeLabel];
    [_timeLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_timeLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:10];
    [_timeLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:10];
    self.jm_tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight) style:UITableViewStyleGrouped];
    self.jm_tableview.dataSource=self;
    self.jm_tableview.delegate=self;
    self.jm_tableview.hidden = YES;
    self.jm_tableview.tableHeaderView = _headerView;
    self.jm_tableview.backgroundColor  = [UIColor clearColor];
    self.jm_tableview.tableFooterView = footerView;
    self.jm_tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    self.btmcons = [self.jm_tableview autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:self.isNotHome?0:XYTabBarHeight];
    
    [self.view bringSubviewToFront:_navBar];
    [self.navBar autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navBar autoSetDimension:(ALDimensionHeight) toSize:self.navBar.height];
}
-(void)initNavView
{
    
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage: [UIImage imageNamed:@"return-white"] forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(0, 0, 21, 21);
    [leftbutton addTarget:self action:@selector(LeftBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _navBar = [FNCustomeNavigationBar customeNavigationBarWithTitle:[FNBaseSettingModel settingInstance].hhrshare_flstr];
    _navBar.backgroundColor = [FNMainBarTintColor colorWithAlphaComponent:0];
    [self.view addSubview:_navBar];
    
    _navBar.leftButton = leftbutton;
    _navBar.leftButton.hidden = !self.isNotHome;
}

-(void)LeftBtnMethod:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    if (conY < 0 ) {
        CGFloat scale =(FNDeviceWidth*0.52-conY*2) / (FNDeviceWidth*0.52);
        
        self.bgImgView.transform = CGAffineTransformMakeScale(scale, scale);
    }else{
        self.bgImgView.transform = CGAffineTransformIdentity;
    }
    if (conY>0 && conY <= 64) {
        self.navBar.backgroundColor = [FNMainBarTintColor colorWithAlphaComponent:conY/64];
    }else{
        if (conY <= 0) {
            self.navBar.backgroundColor =  [FNMainBarTintColor colorWithAlphaComponent:0];
        }else{
            self.navBar.backgroundColor =  [FNMainBarTintColor colorWithAlphaComponent:1];
        }
        
    }
}
@end

