//
//  FNFindOrderController.m
//  SuperMode
//
//  Created by jimmy on 2017/8/3.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNFindOrderController.h"

#import "FNFindOrderView.h"
@interface FNFindOrderController ()

@property (nonatomic, strong)FNFindOrderView* orderView;
@property (nonatomic, assign)BOOL isCheck;
@end

@implementation FNFindOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的订单";
    [FNNotificationCenter addObserver:self selector:@selector(observingCheckOrder) name:_jmntf_order_finished object:nil];
    [self setupviews];
    [self jm_bindViewModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (void)observingCheckOrder{
    if (self.isCheck) {
        [FNTipsView showTips:@"找回订单完成，请返回确认"];
    }
    self.isCheck = NO;
}
- (FNFindOrderView *)orderView{
    if (_orderView == nil) {
        _orderView = [[FNFindOrderView alloc]initWithFrame:(CGRectZero)];
    }
    return _orderView;
}

#pragma mark - initializedSubviews
- (void)setupviews
{
    [self.view addSubview:self.orderView];
    [self.orderView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
}
- (void)jm_bindViewModel{
    @WeakObj(self);
    self.orderView.autoFineOrderBlock = ^{
        [FNTipsView showTips:@"正在找回订单，请稍等..."];
        selfWeak.isCheck = YES;
        selfWeak.updateOrderStatus = YES;
        [selfWeak initWebViewMethod];
    };
    
}
@end
