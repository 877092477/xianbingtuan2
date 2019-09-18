//
//  FNFansView.m
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNFansView.h"
#import "FNFansViewModel.h"
#import "FNFansCell.h"
#import "FNPromotionalTeamHeader.h"
#import "FNPCFilterView.h"
@interface FNFansView()
@property (nonatomic, strong)FNFansViewModel* viewmodel;
@property (nonatomic, strong)FNPromotionalTeamHeader* header;
@property (nonatomic, strong)FNPCFilterView* filter;
@end
@implementation FNFansView
- (FNPCFilterView *)filter{
    if (_filter == nil) {
        @weakify(self);
        _filter = [[FNPCFilterView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 40))];
        _filter.filterBlock = ^(PFFilterType type) {
            @strongify(self);
            self.viewmodel.jm_page = 1;
            self.viewmodel.sort = @(type);
            [SVProgressHUD show];
            [self.viewmodel.refreshDataCommand execute:nil];
        };
    }
    return _filter;
}
- (FNPromotionalTeamHeader *)header{
    if (_header ==nil) {
        _header = [[FNPromotionalTeamHeader alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 15*4+14+23+20))];
        
    }
    return _header;
}
- (instancetype)initWithViewModel:(id<JMViewModelProtocol>)viewModel{
    self.viewmodel =(FNFansViewModel *) viewModel;
    return  [super initWithViewModel:viewModel];
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    
    UIView * tmp = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, self.header.width, self.header.height+10))];
    [tmp addSubview:self.header];
    
    self.jm_tableview.alpha = 0;
    self.jm_tableview.tableHeaderView = tmp;
    [self addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
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
        self.header.countLabel.text = [NSString stringWithFormat:@"累计%@人数",self.viewmodel.model.count];
        
        NSString * price = [NSString stringWithFormat:@"%.2lf",[self.viewmodel.model.sum floatValue]];
        self.header.moneyLabel.text = [NSString stringWithFormat:@"%@%@",price,[FNBaseSettingModel settingInstance].CustomUnit];
        [self.header.moneyLabel addSingleAttributed:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:23]} ofRange:[self.header.moneyLabel.text rangeOfString:price]];
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
    return self.viewmodel.persons.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNFansCell* cell = [FNFansCell cellWithTableView:tableView atIndexPath:indexPath];
    cell.model =self.viewmodel.persons[indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.filter;
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = _Fans_cell_height;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.filter.height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
@end
