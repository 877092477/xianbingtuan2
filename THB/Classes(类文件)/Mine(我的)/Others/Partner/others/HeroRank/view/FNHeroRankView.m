//
//  FNHeroRankView.m
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNHeroRankView.h"
#import "FNHeroRankCell.h"
#import "FNHeroRankViewModel.h"

@interface FNHeroRankView()
@property (nonatomic, strong)FNHeroRankViewModel* viewmodel;
@property (nonatomic, strong)UIView* header;

@end
@implementation FNHeroRankView
- (UIView *)header{
    if (_header == nil) {
        _header = [UIView new];
        UIImage* img = IMAGE(@"hero_top");
        UIImageView* imgview = [[UIImageView alloc]initWithImage:img];
        [_header addSubview:imgview];
        [imgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
        [imgview autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionWidth) ofView:imgview withMultiplier:img.size.height/img.size.width];
        
        UIButton* familybtn = [UIButton buttonWithTitle:@"家族成员排名" titleColor:FNWhiteColor font:kFONT14 target:self action:@selector(btnClicked:)];
        familybtn.selected = YES;
        [familybtn setBackgroundImage:[UIImage createImageWithColor:FNMainGobalControlsColor] forState:(UIControlStateNormal)];
        [familybtn setBackgroundImage:[UIImage createImageWithColor:FNWhiteColor] forState:(UIControlStateSelected)];
        [familybtn setTitleColor:FNMainGobalControlsColor forState:(UIControlStateSelected)];
        [_header addSubview:familybtn];
        [familybtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:imgview];
        [familybtn autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_header withMultiplier:0.5];
        [familybtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [familybtn autoSetDimension:(ALDimensionHeight) toSize:44];
        
        UIButton* commissionbtn = [UIButton buttonWithTitle:[NSString stringWithFormat:@"获得%@排名",[FNBaseSettingModel settingInstance].CustomUnit] titleColor:FNWhiteColor font:kFONT14 target:self action:@selector(btnClicked:)];
        [commissionbtn setBackgroundImage:[UIImage createImageWithColor:FNMainGobalControlsColor] forState:(UIControlStateNormal)];
        [commissionbtn setBackgroundImage:[UIImage createImageWithColor:FNWhiteColor] forState:(UIControlStateSelected)];
        [commissionbtn setTitleColor:FNMainGobalControlsColor forState:(UIControlStateSelected)];
        [_header addSubview:commissionbtn];
        [commissionbtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:imgview];
        [commissionbtn autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_header withMultiplier:0.5];
        [commissionbtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [commissionbtn autoSetDimension:(ALDimensionHeight) toSize:44];
        
        _header.height =img.size.height/img.size.width*JMScreenWidth+44;
        
    }
    return _header;
}
- (instancetype)initWithViewModel:(id<JMViewModelProtocol>)viewModel{
    self.viewmodel =(FNHeroRankViewModel*) viewModel;
    return  [super initWithViewModel:viewModel];
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    [self addSubview:self.header];
   [self.header autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.header autoSetDimension:(ALDimensionHeight) toSize:self.header.height];
    self.jm_tableview.alpha = 0;
    [self addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [self.jm_tableview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.header];
    
    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
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

#pragma mark - action
- (void)btnClicked:(UIButton *)btn{
    if ([btn.currentTitle containsString:@"家族"]) {
        //
        self.viewmodel.index = 0;
    }else{
        self.viewmodel.index = 1;
    }
    
    if (self.header.subviews.count>=1) {
        [self.header.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIButton class]]) {
                UIButton* btnview = obj;
                btnview.selected = btn == btnview;
            }
        }];
    }
    [SVProgressHUD show];
    self.viewmodel.jm_page = 1;
    [self.viewmodel.refreshDataCommand execute:nil];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewmodel.ranks.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNHeroRankCell* cell = [FNHeroRankCell cellWithTableView:tableView atIndexPath:indexPath];
    cell.model = self.viewmodel.ranks[indexPath.row];
    if (self.viewmodel.index == 0) {
        cell.moneyLabel.text = [NSString stringWithFormat:@"%ld家族成员",[self.viewmodel.ranks[indexPath.row].count integerValue]];
    }else{
        cell.moneyLabel.text = [NSString stringWithFormat:@"%.2lf元",self.viewmodel.ranks[indexPath.row].commission.floatValue];
    }
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImage* img = IMAGE(@"hero_one");
    UIView *sectionview = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 44))];
    sectionview.backgroundColor = FNWhiteColor;
    UILabel* label1 = [UILabel new];
    label1.textColor = FNGlobalTextGrayColor;
    label1.text = @"排名";
    label1.font = kFONT14;
    label1.textAlignment = NSTextAlignmentCenter;
    [sectionview addSubview:label1];
    [label1 autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [label1 autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [label1 autoSetDimension:(ALDimensionWidth) toSize:img.size.width+20];
    
    UILabel* label2 = [UILabel new];
    label2.textColor = FNGlobalTextGrayColor;
    label2.text = @"成员ID";
    label2.font = kFONT14;
    label2.textAlignment = NSTextAlignmentCenter;
    [sectionview addSubview:label2];
    [label2 autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:img.size.width+20+_hrc_cell_height-20+10];
    [label2 autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    
    UILabel* label3 = [UILabel new];
    label3.textColor = FNGlobalTextGrayColor;
    label3.text = self.viewmodel.index == 0? @"家族成员(个)":[NSString stringWithFormat:@"获得%@",[FNBaseSettingModel settingInstance].CustomUnit];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = kFONT14;
    [sectionview addSubview:label3];
    [label3 autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    [label3 autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    return sectionview;
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = _hrc_cell_height;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
@end
