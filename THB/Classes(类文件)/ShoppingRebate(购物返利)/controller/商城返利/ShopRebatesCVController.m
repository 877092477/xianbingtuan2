//
//  ShopRebatesCVController.m
//  THB
//
//  Created by zhongxueyu on 16/3/24.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "ShopRebatesCVController.h"
#import "JMRebateWebViewController.h"
#import "XYShopRebatesCell.h"
#import "ShopListModel.h"
#import "secondViewController.h"
#import "JMShopRebateCell.h"
#import "JMAlertView.h"

@interface ShopRebatesCVController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)   UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;

/** 商城数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong)NSString* key;//search key


@end

@implementation ShopRebatesCVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [FNNotificationCenter addObserver:self selector:@selector(observingShopSearch:) name:_jm_noti_rebateshopsearch object:nil];
    self.jm_page = 1;
    [SVProgressHUD show];
    [self initializedSubviews];
    [self loadProductListMethod];
}
#pragma mark =  observing
- (void)observingShopSearch:(NSNotification* )ntf{
    NSString* key = ntf.userInfo[@"key"];
    self.key = key;
    self.jm_page = 1;
    [SVProgressHUD show];
    [self loadProductListMethod];
}
- (void)dealloc{
    [FNNotificationCenter removeObserver:self name:_jm_noti_rebateshopsearch object:nil];
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-self.VCheight-(self.isNotHome?0:XYTabBarHeight))) style:(UITableViewStyleGrouped)];
    self.jm_tableview.dataSource =self;
    self.jm_tableview.delegate =self;
    self.jm_tableview.hidden = YES;
    [self.jm_tableview removeEmptyCellRows];
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    @WeakObj(self);
    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.jm_page = 1;
        [selfWeak loadProductListMethod];
    }];
    
}
#pragma 获取数据
-(void)loadProductListMethod
{
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                  @"type":self.categoryId,
                                                                                  @"token":UserAccessToken,
                                                                                  @"time":[NSString GetNowTimes],
                                                                                  PageNumber :@(self.jm_page),
                                                                                  }];
    if (self.key && self.key.length != 0) {
        params[@"key"] = self.key;
    }
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    @WeakObj(self);
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_shoprebate_getmallalliance successBlock:^(id responseBody) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:SuccessValue]) {
            if (selfWeak.jm_page == 1) {
                
                [self.dataArray removeAllObjects];
                
                NSArray *tempArray = [dict objectForKey:XYData];
                
                if (tempArray.count>0) {
                    for (int i = 0; i < tempArray.count; i ++) {
                        ShopListModel *model = [ShopListModel mj_objectWithKeyValues:tempArray[i]];
                        [self.dataArray addObject:model];
                        
                    }
                    
                }
                if (tempArray.count >= _jm_pageszie) {
                    selfWeak.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                        selfWeak.jm_page ++;
                        [selfWeak loadProductListMethod];
                    }];
                }else{
                    selfWeak.jm_tableview.mj_footer = nil;
                }
            }  else{
                NSArray *tempArray = [dict objectForKey:XYData];
                
                if (tempArray.count>0) {
                    for (int i = 0; i < tempArray.count; i ++) {
                        ShopListModel *model = [ShopListModel mj_objectWithKeyValues:tempArray[i]];
                        [self.dataArray addObject:model];
                        
                    }
                    
                }
                if (tempArray.count >= _jm_pageszie) {
                    [selfWeak.jm_tableview.mj_footer endRefreshing];
                }else{
                    [selfWeak.jm_tableview.mj_footer endRefreshingWithNoMoreData];
                }

            }
            
            [self.jm_tableview reloadData];
            [SVProgressHUD dismiss];
        }else{
            
            //            [FNTipsView showTips:msg];
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        selfWeak.jm_tableview.hidden = NO;
        [selfWeak.jm_tableview.mj_header endRefreshing];
    } failureBlock:^(NSString *error) {
        selfWeak.jm_tableview.hidden = NO;
        [selfWeak.jm_tableview.mj_header endRefreshing];
        [selfWeak.jm_tableview.mj_footer endRefreshing];
        [XYNetworkAPI cancelAllRequest];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JMShopRebateCell* cell = [JMShopRebateCell cellWithTableView:tableView atIndexPath:indexPath];
        ShopListModel *model = self.dataArray[indexPath.section];
    cell.model =model;
    return cell;
}
#pragma makr - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height =100;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return _jm_margin10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    @WeakObj(self);
    if(![UserAccessToken kr_isNotEmpty]){
        JMAlertView *alert = [JMAlertView alertWithTitle:@"" content:@"登录后才能获得返利，是否立即登录" firstTitle:nil andSecondTitle:@"去登录" alertType:(AlertTypeAlert) clickBlock:^(NSInteger index) {
            if (index == 1) {
//                LoginViewController *vc= [[LoginViewController alloc]init];
//                vc.hidesBottomBarWhenPushed = true;
//                selfWeak.navigationController.navigationBar.hidden = NO;
//                [selfWeak.navigationController pushViewController:vc animated:YES];
                [self gologin];
            }
        }];
        [alert.secondButton setTitleColor:FNMainGobalControlsColor forState:UIControlStateNormal];
        alert.secondButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [alert showAlert];
        return;
    }
    ShopListModel *model = self.dataArray[indexPath.section];
    JMRebateWebViewController *vc = [[JMRebateWebViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.url = model.scdg_dizhi;
    vc.scxq_url = model.scxq_url;
    vc.scdg_bili = model.scdg_bili;
    vc.scdg_logo = model.scdg_logo;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -Getter
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - 
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -80;
}
@end
