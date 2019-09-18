//
//  FNWelfareController.m
//  THB
//
//  Created by Jimmy on 2018/1/15.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNWelfareController.h"
#import "FNWelfareView.h"
#import "FNWelfareViewModel.h"

@interface FNWelfareController ()
@property (nonatomic, strong)FNWelfareView* welfareview;
@property (nonatomic, strong)FNWelfareViewModel* viewmodel;
@end

@implementation FNWelfareController
- (FNWelfareViewModel *)viewmodel{
    if(_viewmodel == nil){
        _viewmodel = [FNWelfareViewModel new];
    }
    return _viewmodel;
}
- (FNWelfareView *)welfareview{
    if (_welfareview == nil) {
        _welfareview = [[FNWelfareView alloc]initWithViewModel:self.viewmodel];
    }
    return  _welfareview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)jm_setupViews{
    [self.view addSubview:self.welfareview];
    [self.welfareview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
}

- (void)jm_bindViewModel{
    [[self.viewmodel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        [self loadOtherVCWithModel:x andInfo:nil outBlock:nil];
    }];
}


@end
