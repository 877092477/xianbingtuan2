//
//  FNBrandDetailController.m
//  THB
//
//  Created by jimmy on 2017/5/19.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNBrandDetailController.h"

#import "FNAPIHome.h"
#import "FNBrandShopModel.h"

#import "FNBrandShopHeaderView.h"
#import "JMHomeProductCell.h"
#import "MZTimerLabel.h"
#import "FNHomeSpecialCell.h"

@interface FNBrandDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray<FNBaseProductModel *>* products;
@property (nonatomic, strong)FNBrandShopHeaderView* headerView;
@property (nonatomic, strong)UIView* sectionHeader;
@property (nonatomic, strong)MZTimerLabel* timeLabel;
@property (nonatomic, strong)UIImageView* toTopImage;
@end

@implementation FNBrandDetailController
@synthesize toTopImage;
#pragma mark - forcasted loading
- (NSMutableArray<FNBaseProductModel *> *)products
{
    if (_products == nil) {
        _products = [NSMutableArray new];
    }
    return _products ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializedSubviews];
    [SVProgressHUD show];
    [self apiRequestProducts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.title = @"品牌特卖";
    _headerView = [[FNBrandShopHeaderView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0))];
    _headerView.model = self.model;
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.hidden = YES;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.tableHeaderView = _headerView;
    [self.jm_tableview removeEmptyCellRows];
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    @WeakObj(self);
    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.jm_page = 1;
        [selfWeak apiRequestProducts].CompleteBlock = ^(NSString *error) {
            [selfWeak.jm_tableview.mj_header endRefreshing];
        };
    }];
    
    //section header
    _sectionHeader = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 40))];
    _sectionHeader.backgroundColor = FNHomeBackgroundColor;
    
    _timeLabel = [[MZTimerLabel alloc]initWithTimerType:(MZTimerLabelTypeTimer)];
    _timeLabel.font = kFONT14;
    _timeLabel.textColor = FNMainTextNormalColor;
    [_sectionHeader addSubview:_timeLabel];
    
    int second = 0;
    if ([NSString GetNowTimes].intValue > _model.start_time.intValue) {
         second =  [_model.end_time intValue] - [[NSString GetNowTimes] intValue];
        int day = second/(60*60*24);
        if (day<=0) {
            day = 0;
        }
        [_timeLabel setTimeFormat:[NSString stringWithFormat:@"剩%d天 HH时mm分ss秒",day]];
        [_timeLabel setCountDownTime:second];//多少秒 （1分钟 == 60秒）
        [_timeLabel start];

    }else{
        second =  [_model.start_time intValue] - [[NSString GetNowTimes] intValue];

        int day = second/(60*60*24);
        if (day<=0) {
            day = 0;
        }
        [_timeLabel setTimeFormat:[NSString stringWithFormat:@"离开抢剩%d天 HH时mm分ss秒",day]];
        [_timeLabel setCountDownTime:second];//多少秒 （1分钟 == 60秒）
        [_timeLabel start];
    }
    
    [_timeLabel autoCenterInSuperview];


    toTopImage = [[UIImageView alloc]initWithFrame:CGRectMake(XYScreenWidth-65, XYScreenHeight-XYTabBarHeight-60, 47, 47)];
    toTopImage.image = IMAGE(@"hddb");
    [toTopImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickToScrollTopMethod:)]];
    [self.view addSubview:toTopImage];
    toTopImage.userInteractionEnabled = YES;
    toTopImage.hidden = YES;
    
    [toTopImage autoSetDimensionsToSize:(CGSizeMake(47, 47))];
    [toTopImage autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15];
    //    [toTopImage autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:XYTabBarHeight+15 + 20];
    [toTopImage autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.jm_tableview withOffset:-20];
    [self.view bringSubviewToFront:toTopImage];
    
}
#pragma mark - api request
- (FNAPIHome *)apiRequestProducts{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"dp_id":_model.dp_id,@"dp_type":_dp_type}];
    @WeakObj(self);
    return [FNAPIHome apiHomeForProductsWithParams:params success:^(id respondsObject) {
        selfWeak.jm_tableview.hidden = NO;
        //
        [SVProgressHUD dismiss];
        NSArray* result = respondsObject;
        if (selfWeak.jm_page == 1) {
            [selfWeak.products removeAllObjects];
            [selfWeak.products addObjectsFromArray:result];
            if (result.count >= _jm_pageszie) {
                selfWeak.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiRequestProducts];
                }];
            } else {
                selfWeak.jm_tableview.mj_footer = nil;
            }
        } else {
            [selfWeak.products addObjectsFromArray:result];
            if (result.count >= _jm_pageszie) {
                [selfWeak.jm_tableview.mj_footer endRefreshing];
            } else {
                [selfWeak.jm_tableview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [selfWeak.jm_tableview reloadData];
    } failure:^(NSString *error) {
        selfWeak.jm_tableview.hidden = NO;
        [selfWeak.jm_tableview.mj_footer endRefreshing];
        if (error) {
            [FNTipsView showTips:error];
        }
    } isHidden:NO];
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
-(UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return _sectionHeader;
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [JMCellTool cellHeightTableview:tableView atIndexPath:indexPath andModel:self.products[indexPath.row]];
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 40;
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.products.count>0) {
        
        FNBaseProductModel *model = self.products[indexPath.row];
        if (model.is_qiangguang.boolValue) {
            [FNTipsView showTips:@"商品太火爆了，已被抢光，赶紧看一下其他商品吧〜"];
        }else{
            [self goProductVCWithModel:model withData:model.data];
        }
        
    }
    
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
    [self.jm_tableview setContentOffset:CGPointMake(0,0) animated:YES];
}
@end
