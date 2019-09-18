//
//  FNtendOrderDaNeController.m
//  69橙子
//
//  Created by Jimmy on 2018/12/3.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNtendOrderDaNeController.h"
//controller
#import "FNtendOrderListNeController.h"
@interface FNtendOrderDaNeController ()

@end

@implementation FNtendOrderDaNeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的订单";
    // 设置标题字体
    /*
     方式一：
     self.titleFont = [UIFont systemFontOfSize:20];
     */
    // 推荐方式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        *titleHeight = 35;
        // 设置标题字体
        *titleFont = kFONT12;
        *selColor  =RGB(244, 47, 25);
    }];
    
    // 设置下标
    /*
     方式一
     // 是否显示标签
     self.isShowUnderLine = YES;
     
     // 标题填充模式
     self.underLineColor = [UIColor redColor];
     
     // 是否需要延迟滚动,下标不会随着拖动而改变
     self.isDelayScroll = YES;
     */
    
    // 推荐方式（设置下标）
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        
        // 是否显示标签
        *isShowUnderLine = YES;
        
        // 标题填充模式
        *underLineColor = [UIColor redColor];
        *underLineColor = [UIColor whiteColor];
        // 是否需要延迟滚动,下标不会随着拖动而改变
        //        *isDelayScroll = YES;
        
    }];
    
    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
    self.isfullScreen = NO;
    [self setupChildVc];
    [self setupNav];
      
}

//导航栏
-(void)setupNav{
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage: [UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(0, 0, 21, 21);
    [leftbutton addTarget:self action:@selector(LeftBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    
}

-(void)LeftBtnMethod:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//setupChildVc
- (void)setupChildVc
{
    NSArray *titleArray = [NSArray arrayWithObjects:@"全部订单",@"待付款",@"待使用",@"待评价", @"已使用", nil];
    NSArray *statuArray = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3", @"4", nil];
    if (titleArray.count>0) {
        
        for (int i = 0 ; i<titleArray.count; i++) {
            FNtendOrderListNeController *VC = [[FNtendOrderListNeController alloc] init];
            VC.title = titleArray[i];
            VC.type = @"";
            VC.state= statuArray[i];
            [self addChildViewController:VC]; 
        }
    }
    
    [self refreshDisplay];
    [SVProgressHUD dismiss];
}


@end
