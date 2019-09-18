//
//  FNRMAccountManagementView.m
//  THB
//
//  Created by Jimmy on 2018/1/15.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNRMAccountManagementView.h"
#import "FNRMAccountManagementViewModel.h"
#import "FNRMAccountManagementCell.h"
@interface FNRMAccountManagementView()
@property (nonatomic, strong)FNRMAccountManagementViewModel* viewmodel;
@end
@implementation FNRMAccountManagementView
- (instancetype)initWithViewModel:(id<JMViewModelProtocol>)viewModel{
    self.viewmodel = (FNRMAccountManagementViewModel*) viewModel;
    return [super initWithViewModel:viewModel];
}
- (void)jm_setupViews{
    self.jm_tableview.alpha = 0;
    [self addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
}
- (void)jm_bindViewModel{
    [SVProgressHUD show];
    [self.viewmodel.refreshDataCommand execute:nil];
    [[self.viewmodel.refreshUI takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        [self.jm_tableview reloadData];
        [UIView animateWithDuration:0.5 animations:^{
            self.jm_tableview.alpha = 1;
        }];
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewmodel.list.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNRMAccountManagementCell* cell = [FNRMAccountManagementCell cellWithTableView:tableView atIndexPath:indexPath];
    cell.model = self.viewmodel.list[indexPath.section];
    
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [self.jm_tableview cellHeightForIndexPath:indexPath model:self.viewmodel.list[indexPath.section] keyPath:@"model" cellClass:[FNRMAccountManagementCell class] contentViewWidth:JMScreenWidth];
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 10;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat height = 0.01;
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.viewmodel.cellClickSubject sendNext:self.viewmodel.list[indexPath.section]];
}

@end
