//
//  FNPartnerCenterController.m
//  SuperMode
//
//  Created by jimmy on 2017/10/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPartnerCenterController.h"
#import "FNPartnerCenterView.h"
#import "FNPartnerCenterViewModel.h"
#import "FNNormalNavigaitonBar.h"
#import "FXQRCodeViewController.h"
#import "FNPosterController.h"
#import "FNMCAgentApplyController.h"

@interface FNPartnerCenterController ()
@property (nonatomic, strong)FNPartnerCenterView* centerview;
@property (nonatomic, strong)FNPartnerCenterViewModel *viewmodel;
@property (nonatomic, strong)FNNormalNavigaitonBar* navigationbar;

@end

@implementation FNPartnerCenterController

- (BOOL)isFullScreenShow {
    return YES;
}

- (BOOL) needLogin {
    return YES;
}

- (void)setIsNotHome:(BOOL)isNotHome{
    [super setIsNotHome:isNotHome];
    if (self.isNotHome) {
        self.navigationbar.backbtn.hidden = NO;
        self.btmcons.constant = 0;
    }else{
        self.navigationbar.backbtn.hidden = YES;
        self.btmcons.constant = XYTabBarHeight;
    }
    [self.view layoutIfNeeded];
}
- (FNNormalNavigaitonBar *)navigationbar{
    if (_navigationbar == nil) {
        _navigationbar = [[FNNormalNavigaitonBar alloc]initWithFrame:(CGRectZero)];
        [_navigationbar.backbtn addTarget:self action:@selector(backbtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        _navigationbar.backgroundColor = [UIColor clearColor];
    }
    return _navigationbar;
}
- (FNPartnerCenterViewModel *)viewmodel{
    if (_viewmodel == nil) {
        _viewmodel = [FNPartnerCenterViewModel new];
    }
    return _viewmodel;
}
- (FNPartnerCenterView *)centerview{
    if (_centerview == nil) {
        _centerview = [[FNPartnerCenterView alloc]initWithViewModel:self.viewmodel];
    }
    return _centerview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_navigationbar.backbtn setImage:IMAGE(@"return1") forState:(UIControlStateNormal)];
    if(self.understand==YES){
        _navigationbar.backbtn.hidden=NO;
    }else{
        _navigationbar.backbtn.hidden=YES;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - action
- (void)backbtnAction{
    if(self.understand==YES){
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
 
    [self.view addSubview:self.centerview];
    [self.centerview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    self.btmcons = [self.centerview autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:self.isNotHome?0:XYTabBarHeight];
    
    [self.view addSubview:self.navigationbar];
    [self.navigationbar autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.navigationbar autoSetDimension:(ALDimensionHeight) toSize:JMNavBarHeigth];
    
    if (@available(iOS 11.0, *)) {
        self.centerview.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}
- (void)jm_bindViewModel{
    [[self.viewmodel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        //
        [self loadOtherVCWithModel:x andInfo:nil outBlock:nil];
    }];
}

@end
