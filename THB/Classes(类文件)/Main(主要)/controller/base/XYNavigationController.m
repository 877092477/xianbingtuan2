//
//  XYNavigationController.m
//  FnuoApp
//
//  Created by zhongxueyu on 16/2/22.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "XYNavigationController.h"

@interface XYNavigationController ()

@end

@implementation XYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, kFONT17, NSFontAttributeName, nil]];
//    if (iOS7) { // 判断是否是IOS7
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//    }
    self.navigationBar.barTintColor = [UIColor whiteColor];

    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;//视图控制器，四条边不指定
        self.extendedLayoutIncludesOpaqueBars = NO;//不透明的操作栏
        self.modalPresentationCapturesStatusBarAppearance = NO;
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@""]
                                          forBarPosition:UIBarPositionTop
                                              barMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@""]
                                 forBarMetrics:UIBarMetricsDefault];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count ) {
        viewController.isNotHome = YES;
        [self.childViewControllers firstObject].isPop = @"1";
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *backToLastPage = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStyleDone target:self action:@selector(popAction)];
        viewController.navigationItem.leftBarButtonItem = backToLastPage;
    }
    [super pushViewController:viewController animated:animated];
}
#pragma mark -
- (void)popAction
{
    [self popViewControllerAnimated:YES];
}

@end
