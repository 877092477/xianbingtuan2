//
//  FNWithdrawController.m
//  SuperMode
//
//  Created by jimmy on 2017/6/15.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNWithdrawController.h"
#import "secondViewController.h"
#import "FNWithdrawViewModel.h"
#import "FNWithdrawView.h"

@interface FNWithdrawController ()
@property (nonatomic, strong) FNWithdrawView* withdrawView;
@property (nonatomic, strong) FNWithdrawViewModel* viewModel;
@end

@implementation FNWithdrawController
- (FNWithdrawViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [FNWithdrawViewModel new];
        _viewModel.type = self.type;
    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    self.withdrawView = [[FNWithdrawView alloc]initWithViewModel:self.viewModel];
    [self.view addSubview:self.withdrawView];
    [self.withdrawView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
}
- (void)jm_bindViewModel{
    @weakify(self);
    [self.viewModel.refreshUI subscribeNext:^(id x) {
        //
        @strongify(self);
        self.title=self.viewModel.model.topStr1;
        UIButton* record = [UIButton buttonWithTitle:self.viewModel.model.topStr2 titleColor:FNGlobalTextGrayColor font:kFONT14 target:self action:@selector(recordAction)];
        [record sizeToFit];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:record];
    }];
    [[self.viewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        //
        @strongify(self);
        [self recordAction];
    }];
}
- (void)recordAction{
    secondViewController *vc = [[secondViewController alloc]init];
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@",IP,_api_mine_DrawHistory,UserAccessToken];
    vc.url = urlString;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
