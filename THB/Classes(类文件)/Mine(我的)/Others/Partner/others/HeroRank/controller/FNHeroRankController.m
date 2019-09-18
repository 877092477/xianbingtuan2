//
//  FNHeroRankController.m
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNHeroRankController.h"
#import "FNHeroRankView.h"
#import "FNHeroRankViewModel.h"
@interface FNHeroRankController ()
@property (nonatomic, strong)FNHeroRankView* rankview;
@property (nonatomic, strong)FNHeroRankViewModel* viewmodel;
@end

@implementation FNHeroRankController
- (FNHeroRankView *)rankview{
    if (_rankview ==nil) {
        _rankview = [[FNHeroRankView alloc]initWithViewModel:self.viewmodel];
    }
    return _rankview;
}
- (FNHeroRankViewModel *)viewmodel{
    if (_viewmodel == nil) {
        _viewmodel = [FNHeroRankViewModel new];
    }
    return _viewmodel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"英雄榜";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    [self.view addSubview:self.rankview];
    [self.rankview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
}
@end
