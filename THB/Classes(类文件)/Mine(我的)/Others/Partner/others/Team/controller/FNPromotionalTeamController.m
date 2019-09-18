//
//  FNPromotionalTeamController.m
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPromotionalTeamController.h"
#import "FNPromotionalTeamView.h"
#import "FNPromotionalTeamViewModel.h"
@interface FNPromotionalTeamController ()
@property (nonatomic, strong)FNPromotionalTeamView* teamview;
@property (nonatomic, strong)FNPromotionalTeamViewModel *viewmodel;
@end

@implementation FNPromotionalTeamController
- (FNPromotionalTeamView *)teamview{
    if (_teamview == nil) {
        _teamview = [[FNPromotionalTeamView alloc]initWithViewModel:self.viewmodel];
    }
    return _teamview;
}
- (FNPromotionalTeamViewModel *)viewmodel{
    if (_viewmodel == nil) {
        _viewmodel = [FNPromotionalTeamViewModel new];
    }
    return _viewmodel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的推广团队";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    [self.view addSubview:self.teamview];
    [self.teamview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
}

@end
