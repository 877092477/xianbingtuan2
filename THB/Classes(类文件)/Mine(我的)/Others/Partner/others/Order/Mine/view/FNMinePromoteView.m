//
//  FNMinePromoteView.m
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNMinePromoteView.h"
#import "FNMinePromoteViewModel.h"
#import "FNPromotePublicCell.h"

#import "FNMinePromoteCateView.h"
@interface FNMinePromoteView()
@property (nonatomic, strong)FNMinePromoteViewModel* viewmodel;
@property (nonatomic, strong)FNMinePromoteCateView* cateview;

@end
@implementation FNMinePromoteView
- (instancetype)initWithViewModel:(id<JMViewModelProtocol>)viewModel{
    self.viewmodel =(FNMinePromoteViewModel *) viewModel;
    return  [super initWithViewModel:viewModel];
}
- (FNMinePromoteCateView *)cateview{
    if (_cateview == nil) {
        _cateview = [[FNMinePromoteCateView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 0))];
        _cateview.titles = @[@"粉丝销量(件)",[NSString stringWithFormat:@"即将到账(%@)",[FNBaseSettingModel settingInstance].CustomUnit],[NSString stringWithFormat:@"累计奖励(%@)",[FNBaseSettingModel settingInstance].CustomUnit]];
        @weakify(self);
        _cateview.clickedBlock = ^(NSInteger index) {
            @strongify(self);
            self.viewmodel.index = index;
            [SVProgressHUD show];
            self.viewmodel.jm_page=1;
            [self.viewmodel.refreshDataCommand execute:nil];
        };
    }
    return _cateview;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    [self addSubview:self.cateview];
    [self.cateview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.cateview autoSetDimension:(ALDimensionHeight) toSize:self.cateview.height];
    
    self.jm_tableview.alpha = 0;
    [self addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [self.jm_tableview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.cateview];
    @weakify(self);
    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.viewmodel.jm_page = 1;
        [self.viewmodel.refreshDataCommand execute:nil];
    }];
    
}
- (void)jm_bindViewModel{
    @weakify(self);
    [SVProgressHUD show];
    [self.viewmodel.refreshDataCommand execute:nil];
    [[self.viewmodel.refreshUI takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        self.cateview.contents = self.viewmodel.titles;
        [self.jm_tableview reloadData];
        [UIView animateWithDuration:1.0 animations:^{
            self.jm_tableview.alpha = 1;
        }];
    }];
    [[self.viewmodel.refreshEndSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        JMRefreshDataStatus statu = [x integerValue];
        switch (statu) {
            case JMRefreshHeader_HasMoreData:
            {
                self.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.viewmodel.jm_page ++;
                    [self.viewmodel.refreshDataCommand execute:nil];
                }];
                [self.jm_tableview.mj_header endRefreshing];
                break;
            }
            case JMRefreshHeader_HasNoMoreData:{
                self.jm_tableview.mj_footer = nil;
                [self.jm_tableview.mj_header endRefreshing];
                break;
            }
            case JMRefreshFooter_HasMoreData:
            {
                [self.jm_tableview.mj_footer endRefreshing];
                break;
            }
            case JMRefreshFooter_HasNoMoreData:
            {
                [self.jm_tableview.mj_footer endRefreshingWithNoMoreData];
                break;
            }
            case JMRefreshError:{
                [self.jm_tableview.mj_header endRefreshing];
                [self.jm_tableview.mj_footer endRefreshing];
                break;
            }
                
            default:
                break;
        }
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewmodel.list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNPromotePublicCell* cell = [FNPromotePublicCell cellWithTableView:tableView atIndexPath:indexPath];
    cell.isMine = YES;
    cell.model = self.viewmodel.list[indexPath.section];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = _ppc_cell_height;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
@end
