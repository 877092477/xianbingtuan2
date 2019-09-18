//
//  FNmerDiscountsCateController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/29.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNmerDiscountsCateController.h"
#import "FNmerDiscountsSController.h"
#import "FNCustomeNavigationBar.h"

@interface FNmerDiscountsCateController()

@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;

@end

@implementation FNmerDiscountsCateController

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:self.isPop.boolValue];
    
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 推荐方式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        *titleHeight = 35;
        // 设置标题字体
        *titleFont = kFONT15;
        *selColor  =RGB(51, 51, 51);
        *norColor  =RGB(102, 102, 102);
    }];
    
    // 推荐方式（设置下标）
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        
        // 是否显示标签
        *isShowUnderLine = YES;
        
        // 标题填充模式
        *underLineColor = RGB(255, 102, 102);
        
        // 是否需要延迟滚动,下标不会随着拖动而改变
        *isDelayScroll = YES;
        
    }];
    
    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
    self.isfullScreen = NO;
    
    self.view.backgroundColor=RGB(250, 250, 250);
    
    self.titleScrollView.backgroundColor=UIColor.whiteColor;
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 10).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.titleLabel.text=@"红包信息";
    
    self.contentView.frame = CGRectMake(0, self.navigationView.bounds.size.height, XYScreenWidth, XYScreenHeight - self.navigationView.bounds.size.height);
    //    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.bottom.equalTo(@0);
    //        make.top.equalTo(self.navigationView.mas_bottom);
    //    }];
    
//    FNmerDiscountsSController *vc1 = [[FNmerDiscountsSController alloc] init];
//    vc1.title = @"普通红包";
//    vc1.typeStr = @"hongbao";
//    [self addChildViewController:vc1];
//
//    FNmerDiscountsSController *vc2 = [[FNmerDiscountsSController alloc] init];
//    vc2.title = @"位置红包";
//    vc2.typeStr = @"position_hongbao";
//    [self addChildViewController:vc2];
//
//    [self refreshDisplay];
    [self requestCates];
}

-(void)requestCates{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=red_packet_cate" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSArray *array = respondsObject;
        for (NSDictionary *dic in array) {
            
            FNmerDiscountsSController *vc = [[FNmerDiscountsSController alloc] init];
            vc.title = dic[@"name"];
            vc.typeStr = dic[@"type"];
            vc.isNavHidden = YES;
            [self addChildViewController:vc];
        }
        [self refreshDisplay];
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}


@end
