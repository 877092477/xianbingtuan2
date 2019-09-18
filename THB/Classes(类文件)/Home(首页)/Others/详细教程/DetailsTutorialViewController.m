//
//  DetailsTutorialViewController.m
//  THB
//
//  Created by zhongxueyu on 16/4/14.
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

#import "DetailsTutorialViewController.h"

@interface DetailsTutorialViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIImageView *image;

@end

@implementation DetailsTutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGFloat imgH ;
//    if (XYScreenHeight<568) {
//        imgH = 1248;
//    }else if (XYScreenHeight == 568){
//        imgH = 2496;
//    }else if (XYScreenHeight>568){
//        imgH = 3744;
//    }
    // Do any additional setup after loading the view.
    _scrollView = [[UIScrollView alloc]initWithFrame: XYScreenBounds];
//    _image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, imgH)];
    
    _image = [[UIImageView alloc]init];
    _image.image = IMAGE(@"course");
    [_image setAutoresizesSubviews:YES];
    [_image sizeToFit];
    [_scrollView addSubview:_image];
    _scrollView.contentSize =CGSizeMake(XYScreenWidth,_image.frame.size.height);
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
