//
//  FNPartnerApplyController.m
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPartnerApplyController.h"
#import "FNPartnerApplyView.h"
#import "FNPartnerApplyViewModel.h"
@interface FNPartnerApplyController ()
@property (nonatomic, strong)FNPartnerApplyView* applyview;
@property (nonatomic, strong)FNPartnerApplyViewModel* viewmodel;
@end

@implementation FNPartnerApplyController
- (FNPartnerApplyViewModel *)viewmodel{
    if (_viewmodel == nil) {
        _viewmodel = [FNPartnerApplyViewModel new];
    }
    return _viewmodel;
}
- (FNPartnerApplyView *)applyview{
    if (_applyview == nil) {
        _applyview = [[FNPartnerApplyView alloc]initWithViewModel:self.viewmodel];
    }
    return _applyview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"申请合伙人";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    [self.view addSubview:self.applyview];
    [self.applyview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
}
- (void)jm_bindViewModel{
    [self.viewmodel.confirmCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        if ([x boolValue]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
@end
