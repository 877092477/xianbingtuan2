//
//  JMMIneBillController.m
//  THB
//
//  Created by jimmy on 2017/3/30.
//  Copyright © 2017年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */
#import "JMMIneBillController.h"
#import "JMMineBillListController.h"
#import "FNAPIHome.h"
@interface JMMIneBillController ()

@end

@implementation JMMIneBillController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = FNHomeBackgroundColor;
        [self initializedSubviews];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.title = self.title?self.title:@"账单";
    
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
        
        // 是否需要延迟滚动,下标不会随着拖动而改变
        //        *isDelayScroll = YES;
        
    }];
    
    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
    self.isfullScreen = NO;
    
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage: [UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(0, 0, 21, 21);
    [leftbutton addTarget:self action:@selector(LeftBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    [self setupChildVc];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];

    
    UIView* noteView = [UIView new];
    UILabel* label = [UILabel new];
    label.text = @"提醒开关";
    label.textColor = FNMainTextNormalColor;
    label.font = kFONT12;
    [label sizeToFit];
    [noteView addSubview:label];
    
    NSString* flag = Userzztx;
    UIButton* noteSwitch = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [noteSwitch setImage:IMAGE(@"rp_switch_on") forState:UIControlStateSelected];
    [noteSwitch setImage:IMAGE(@"rp_switch_off") forState:UIControlStateNormal];
    [noteSwitch addTarget:self action:@selector(noteSwitchAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [noteSwitch sizeToFit];
    noteSwitch.selected = flag.boolValue;
    [noteView addSubview:noteSwitch];
    [noteSwitch autoSetDimensionsToSize:noteSwitch.size];
    [noteSwitch autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [noteSwitch autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [label autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [label autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:noteSwitch withOffset:-5];
    noteView.size = CGSizeMake(label.width+noteSwitch.width+5, noteSwitch.height);
    
    [noteView autoSetDimensionsToSize:noteView.size];//iOS 11会把noteView frame 无效化
    UIBarButtonItem* item =[[UIBarButtonItem alloc]initWithCustomView:noteView];

    self.navigationItem.rightBarButtonItem =item;
}
- (void)noteSwitchAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    [self apiRequestSetNote:btn.selected];
}
- (void)apiRequestSetNote:(BOOL)flag{
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"hbtx":@(flag),TokenKey:UserAccessToken,@"type":@2}];
    [FNAPIHome apiHomeRequestSetNoticeWithParams:params success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",flag] forKey:XYzztx];
        [FNTipsView showTips:flag?@"已打开":@"已关闭"];
    } failure:^(NSString *error) {
        
    } isHidden:NO];

}


- (void)LeftBtnMethod:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
//setupChildVc
- (void)setupChildVc
{

    NSArray *titleArray = [NSArray arrayWithObjects:@"全部",@"收入",@"支出", nil];
    NSArray *statuArray = [NSArray arrayWithObjects:@0,@1,@2, nil];
    if (titleArray.count>0) {
        
        for (int i = 0 ; i<titleArray.count; i++) {
            JMMineBillListController *VC = [[JMMineBillListController alloc] init];
            VC.title = titleArray[i];
            VC.statu = statuArray[i];
            [self addChildViewController:VC];
            
        }
    }
    
//    [self refreshDisplay];

    self.selectIndex = self.toIndex;
    
}

@end
