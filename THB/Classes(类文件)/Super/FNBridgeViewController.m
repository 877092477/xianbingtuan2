//
//  FNBridgeViewController.m
//  THB
//
//  Created by zhongxueyu on 2018/11/23.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNBridgeViewController.h"

@interface FNBridgeViewController ()

@end

@implementation FNBridgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadOtherVCWithModel:_model andInfo:nil outBlock:nil];
    self.isPopUp = YES;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (self.isPopUp) {
        [self.navigationController popViewControllerAnimated:NO];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
