//
//  FNStoreGoodsAttriSpecManagerController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/15.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsAttriSpecManagerController.h"
#import "FNCustomeNavigationBar.h"
#import "FNStoreGoodsAttriListManagerController.h"
#import "FNStoreGoodsSpecManagerController.h"
#import "FNStoreGoodsAttriEditManagerController.h"

@interface FNStoreGoodsAttriSpecManagerController()

@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)FNStoreGoodsAttriListManagerController *specController;
@property (nonatomic, strong)FNStoreGoodsAttriListManagerController *attriController;

@property (nonatomic, assign) NSInteger page;

@end

@implementation FNStoreGoodsAttriSpecManagerController

- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
        _navigationView.backgroundColor = RGB(255, 102, 102);
        
        UIButton* leftView = [UIButton new];
        UIImageView *imgBack = [[UIImageView alloc] init];
        imgBack.size = CGSizeMake(9, 15);
        imgBack.image = IMAGE(@"connection_button_back");
        [leftView addSubview:imgBack];
        leftView.frame = CGRectMake(10, 0, 20, 20);
        [leftView addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        UIButton* rightView = [UIButton new];
        UIImageView *imgAdd = [[UIImageView alloc] init];
        imgAdd.size = CGSizeMake(18, 18);
        imgAdd.image = IMAGE(@"store_manager_button_add");
        [rightView addSubview:imgAdd];
        rightView.frame = CGRectMake(10, 0, 20, 20);
        [rightView addTarget:self action:@selector(addBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        _navigationView.leftButton = leftView;
        _navigationView.rightButton = rightView;
        
        self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
        self.navigationView.titleLabel.sd_layout
        .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
        [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
        _navigationView.titleLabel.text=@"规格属性";
        
        if(self.understand==YES){
            _navigationView.leftButton.hidden=YES;
        }
        
        
    }
    return _navigationView;
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addBtnAction {
    
    if (_page == 0) {
        [_specController create];
    } else {
        [_attriController create];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    _page = (x + scrollViewW/2)/scrollViewW;
    
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
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    
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
    
    self.titleScrollView.backgroundColor=RGB(250, 250, 250);

    self.contentView.frame = CGRectMake(0, self.navigationView.bounds.size.height, XYScreenWidth, XYScreenHeight - self.navigationView.bounds.size.height);
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(@0);
//        make.top.equalTo(self.navigationView.mas_bottom);
//    }];
    
    _specController = [[FNStoreGoodsAttriListManagerController alloc] init];
    _specController.title = @"商品规格";
    _specController.type = @"1";
    [self addChildViewController:_specController];
    
    _attriController = [[FNStoreGoodsAttriListManagerController alloc] init];
    _attriController.title = @"商品属性";
    _attriController.type = @"2";
    [self addChildViewController:_attriController];
    
    [self refreshDisplay];
}

@end
