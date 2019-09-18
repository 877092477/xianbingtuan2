//
//  JMViewController.m
//  SuperMode
//
//  Created by jimmy on 2017/6/8.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMViewController.h"

@interface JMViewController ()
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, assign) BOOL changeStatusBarAnimated;
@end

@implementation JMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = FNWhiteColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    JMViewController* viewcontroller = [super allocWithZone:zone];
    @weakify(viewcontroller);
    [[viewcontroller rac_signalForSelector:@selector(viewDidLoad) ] subscribeNext:^(id x) {
        @strongify(viewcontroller);
        [viewcontroller jm_setupViews];
        [viewcontroller jm_bindViewModel];
    }];
    
    [[viewcontroller rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        @strongify(viewcontroller);
        [viewcontroller jm_layoutNavigation];
        [viewcontroller jm_getNewData];
    }];
    
    return viewcontroller;
}

- (instancetype)initWithViewModel:(id<JMViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)setIsExtendLayout:(BOOL)isExtendLayout {
    
    if (!isExtendLayout) {
        [self initializeSelfVCSetting];
    }
}

- (void)initializeSelfVCSetting {
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}
- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
             statusBarHidden:(BOOL)statusBarHidden
     changeStatusBarAnimated:(BOOL)animated {
    
    self.statusBarStyle=statusBarStyle;
    self.statusBarHidden=statusBarHidden;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
    else{
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

#pragma mark - RAC
/**
 *  添加控件
 */
- (void)jm_setupViews {}

/**
 *  绑定
 */
- (void)jm_bindViewModel {}

/**
 *  设置navation
 */
- (void)jm_layoutNavigation {}

/**
 *  初次获取数据
 */
- (void)jm_getNewData {}

@end
