//
//  FNFansController.m
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNFansController.h"
#import "FNFansViewModel.h"
#import "FNFansView.h"
@interface FNFansController ()
@property (nonatomic, strong)FNFansViewModel* viewmodel;
@property (nonatomic, strong)FNFansView* fansview;
@end

@implementation FNFansController
- (FNFansView *)fansview{
    if (_fansview == nil) {
        _fansview = [[FNFansView alloc]initWithViewModel:self.viewmodel];
    }
    return _fansview;
}
- (FNFansViewModel *)viewmodel{
    if (_viewmodel == nil) {
        _viewmodel = [FNFansViewModel new];
    }
    return _viewmodel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的粉丝";
    
    [self.view addSubview:self.fansview];
    [self.fansview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.fansview autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
}

@end
