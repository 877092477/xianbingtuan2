//
//  FNProfitStatisticsController.m
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNProfitStatisticsController.h"
#import "FNProfitStatisticsViewModel.h"
#import "FNProfitStatisticsView.h"
#import "FNWithdrawController.h"
@interface FNProfitStatisticsController ()
@property (nonatomic, strong)FNProfitStatisticsViewModel* viewmodel;
@property (nonatomic, strong)FNProfitStatisticsView* statisticsview;


@end

@implementation FNProfitStatisticsController
- (void)setIsNotHome:(BOOL)isNotHome{
    [super setIsNotHome:isNotHome];
    if (self.isNotHome) {
        self.btmcons.constant = 0;
    }else{
        self.btmcons.constant = XYTabBarHeight;
    }
}
- (FNProfitStatisticsViewModel *)viewmodel{
    if (_viewmodel == nil) {
        _viewmodel = [FNProfitStatisticsViewModel new];
    }
    return _viewmodel;
}
- (FNProfitStatisticsView *)statisticsview{
    if (_statisticsview == nil) {
        _statisticsview = [[FNProfitStatisticsView alloc]initWithViewModel:self.viewmodel];
    }
    return _statisticsview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"收益报表";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    [self.view addSubview:self.statisticsview];
    [self.statisticsview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    self.btmcons = [self.statisticsview autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:self.isNotHome?0:XYTabBarHeight];
}
- (void)jm_bindViewModel{
    [[self.viewmodel.withdrawsubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        

#if APP_XYJ == 1
        [self goWebDetailWithWebType:@"0" URL:x];
#else
        FNWithdrawController* withdraw = [FNWithdrawController new];
        withdraw.type = @"2";
        [self.navigationController pushViewController:withdraw animated:YES];
#endif
        
    }];
}
@end
