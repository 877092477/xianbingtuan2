//
//  FNRMAccountManagementController.m
//  THB
//
//  Created by Jimmy on 2018/1/15.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNRMAccountManagementController.h"
#import "FNRMAccountManagementViewModel.h"
#import "FNRMAccountManagementView.h"
#import "FNPhoneCheckController.h"

#import "FNPhoneCheckController.h"
#import "JMASBindAlipayController.h"
@interface FNRMAccountManagementController ()
@property (nonatomic, strong)FNRMAccountManagementViewModel* viewmodel;
@property (nonatomic, strong)FNRMAccountManagementView* managementview;
@end

@implementation FNRMAccountManagementController
- (FNRMAccountManagementViewModel *)viewmodel{
    if (_viewmodel == nil) {
        _viewmodel = [FNRMAccountManagementViewModel new];
    }
    return _viewmodel;
}
- (FNRMAccountManagementView *)managementview{
    if (_managementview == nil) {
        _managementview = [[FNRMAccountManagementView alloc]initWithViewModel:self.viewmodel];
    }
    return _managementview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(refreshWithViewModel) name:@"RefreshProfile" object:nil];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)refreshWithViewModel {
    [self.viewmodel.refreshDataCommand execute:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)jm_setupViews{
    [self.view addSubview:self.managementview];
    [self.managementview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
}
- (void)jm_bindViewModel{
    [[self.viewmodel.refreshUI takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        self.title=self.viewmodel.list[0].top_str;
    }];
    
    [[self.viewmodel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(FNRMAccountManagementModel* x) {
        NSString* title = [NSString stringWithFormat:@"您可对%@此%@进行操作",x.alipay,self.viewmodel.list[0].str];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            //
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"修改" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            FNPhoneCheckController *vc = [[FNPhoneCheckController alloc]init];
            vc.sourceType = @"bind_alipay";
            vc.title = @"验证手机号";
            vc.successCheckBlock = ^(NSString *username, UIViewController *vc) {
                JMASBindAlipayController *bindController = [[JMASBindAlipayController alloc]init];
                bindController.vcstring = @"FNRMAccountManagementView";
                [vc.navigationController pushViewController:bindController animated:YES];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }]];
        NSLog(@"%@",[NSThread currentThread]);
        [self presentViewController:alert animated:YES completion:nil];
    }];
}
@end
