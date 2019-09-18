//
//  FNFamilyController.m
//  SuperMode
//
//  Created by jimmy on 2017/11/4.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNFamilyController.h"
#import "FNFamilyView.h"
#import "FNFamilyViewModel.h"
@interface FNFamilyController ()
@property (nonatomic, strong)FNFamilyView* familyview;
@property (nonatomic, strong)FNFamilyViewModel* viewmodel;
@end

@implementation FNFamilyController
- (FNFamilyView *)familyview{
    if (_familyview == nil) {
        _familyview = [[FNFamilyView alloc]initWithViewModel:self.viewmodel];
    }
    return _familyview;
}
- (FNFamilyViewModel *)viewmodel{
    if (_viewmodel == nil) {
        _viewmodel = [FNFamilyViewModel new];
    }
    return _viewmodel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"家族成员";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    [self.view addSubview:self.familyview];
    [self.familyview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
}

- (void)jm_layoutNavigation{
    UIButton * btn = [UIButton buttonWithTitle:@"家族说明" titleColor:FNGlobalTextGrayColor font:kFONT14 target:self action:@selector(desbtnAction)];
    [btn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}
- (void)desbtnAction{
    
    [self goWebDetailWithWebType:@"0" URL:self.viewmodel.model.family];
}
@end
