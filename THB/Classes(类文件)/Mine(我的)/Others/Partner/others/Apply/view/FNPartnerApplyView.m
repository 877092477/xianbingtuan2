//
//  FNPartnerApplyView.m
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPartnerApplyView.h"
#import "FNPartnerApplyViewModel.h"
#import "FNPartnerApplyInputView.h"
#import "FNPartnerApplyCell.h"
@interface FNPartnerApplyView()
@property (nonatomic, strong)FNPartnerApplyViewModel* viewmodel;

@property (nonatomic, strong)UIView* headerview;
@property (nonatomic, strong)UIImageView* adImgView;

@property (nonatomic, strong)FNPartnerApplyInputView* footerview;

@end
@implementation FNPartnerApplyView
- (instancetype)initWithViewModel:(id<JMViewModelProtocol>)viewModel{
    self.viewmodel =(FNPartnerApplyViewModel*) viewModel;
    return  [super initWithViewModel:viewModel];
}
- (UIImageView *)adImgView{
    if (_adImgView == nil) {
        _adImgView = [UIImageView new];
        _adImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _adImgView;
}
- (UIView *)headerview{
    if (_headerview == nil) {
        _headerview = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, JMScreenWidth*0.55))];
        _headerview.backgroundColor = FNWhiteColor;
        
        [_headerview addSubview:self.adImgView];
        [self.adImgView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(_jmsize_10, _jmsize_10, _jmsize_10, _jmsize_10))];
        
    }
    return _headerview;
}
- (FNPartnerApplyInputView *)footerview{
    if (_footerview == nil) {
        _footerview = [[FNPartnerApplyInputView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 0))];
        @weakify(self);
        _footerview.applyBlock = ^{
            @strongify(self);
            [SVProgressHUD show];
            [self.viewmodel.confirmCommand execute:@{@"content":self.footerview.textview.textView.text,
                                                                                    @"name":self.footerview.nameTF.text,
                                                                                    @"qq":self.footerview.qqTF.text,
                                                                                    @"phone":self.footerview.phoneTF.text
                                                     }];
        };
    }
    return _footerview;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    self.jm_tableview.alpha = 0;
    self.jm_tableview.tableFooterView = self.footerview;
    self.jm_tableview.tableHeaderView  = self.headerview;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
}
- (void)jm_bindViewModel{
    @weakify(self);
    [self.viewmodel.refreshDataCommand execute:nil];
    [[self.viewmodel.refreshUI takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.adImgView setUrlImg:self.viewmodel.model.apphhr_img];
        self.footerview.contactLabel.text = [NSString stringWithFormat:@"微信客服：%@",self.viewmodel.model.ContactPhone];
        [self.jm_tableview reloadData];
        [UIView animateWithDuration:1.0 animations:^{
            self.jm_tableview.alpha = 1;
        }];
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewmodel.model.introduce.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNPartnerApplyCell* cell = [FNPartnerApplyCell cellWithTableView:tableView atIndexPath:indexPath];
    cell.model = self.viewmodel.model.introduce[indexPath.row];
    return cell;
}


#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [tableView cellHeightForIndexPath:indexPath model:self.viewmodel.model.introduce[indexPath.row] keyPath:@"model" cellClass:[FNPartnerApplyCell class] contentViewWidth:JMScreenWidth];
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
@end
