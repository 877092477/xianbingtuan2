//
//  FNTeamPromoteView.m
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNTeamPromoteView.h"
#import "JMTitleScrollView.h"
#import "FNPromotePublicCell.h"
#import "FNTeamPromoteViewModel.h"
@interface FNTeamPromoteView()<JMTitleScrollViewDelegate>
@property (nonatomic, strong)JMTitleScrollView* cateview;
@property (nonatomic, strong)FNTeamPromoteViewModel* viewmodel;

@end
@implementation FNTeamPromoteView
- (JMTitleScrollView *)cateview{
    if (_cateview == nil) {
        _cateview = [[JMTitleScrollView alloc ]initWithFrame:CGRectMake(0, 0, JMScreenWidth, 50) titleArray:self.viewmodel.titles fontSize:14 _textLength:5 andButtonSpacing:_jmsize_10 type:(StableType)];
        _cateview.tDelegate = self;
    }
    return _cateview;
}
- (instancetype)initWithViewModel:(id<JMViewModelProtocol>)viewModel{
    self.viewmodel =(FNTeamPromoteViewModel*) viewModel;
    return  [super initWithViewModel:viewModel];
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    [self addSubview:self.cateview];
    [self.cateview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.cateview autoSetDimension:(ALDimensionHeight) toSize:self.cateview.height];
    
    
    self.jm_tableview.alpha = 0;
    [self addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeTop)];
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
        self.cateview.titleArray = self.viewmodel.titles;
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
#pragma mark - JMTitleScrollViewDelegate
- (void)clickedTitleView:(JMTitleScrollView *)titleView atIndex:(NSInteger)index{
    self.viewmodel.type = index;
    self.viewmodel.jm_page = 1;
    [SVProgressHUD show];
    [self.viewmodel.refreshDataCommand execute:nil];
}
@end
