//
//  FNPromotionalListController.m
//  THB
//
//  Created by Jimmy on 2017/12/22.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPromotionalListController.h"
#import "FNPromotionalListIView.h"
#import "FNCustomeNavigationBar.h"



@interface FNPromotionalListController ()
@property (nonatomic, strong)FNPromotionalListIView* listview;
@property (nonatomic, strong)FNCustomeNavigationBar* navigationview;
@property (nonatomic, strong)UIImageView* titleImgView;
@property (nonatomic, strong)NSLayoutConstraint* listTopCons;
@property (nonatomic, strong)NSLayoutConstraint* listBottomCons;

 

@end

@implementation FNPromotionalListController

#pragma mark - getter
- (FNPromotionalListViewModel *)viewmodel{
    if (_viewmodel == nil) {
        _viewmodel = [FNPromotionalListViewModel new];
    }
    return _viewmodel;
}
- (FNPromotionalListIView *)listview{
    if (_listview == nil) {
        _listview = [[FNPromotionalListIView alloc]initWithViewModel:self.viewmodel];
    }
    return _listview;
}
- (UIImageView *)titleImgView{
    if (_titleImgView == nil) {
        _titleImgView = [UIImageView new];
        _titleImgView.size = IMAGE(@"logo_allday").size;
        _titleImgView.contentMode = UIViewContentModeScaleAspectFit;
        [_titleImgView setUrlImg:self.titleImg];
    }
    return _titleImgView;
}
- (FNCustomeNavigationBar *)navigationview{
    if (_navigationview == nil) {
        UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.titleImg]]];
        if ([NSString isEmpty:self.titleImg] || image==nil) {
            NSString *showName=self.show_name ? self.show_name : self.title;
            _navigationview = [FNCustomeNavigationBar customeNavigationBarWithTitle:showName];
            _navigationview.titleLabel.textColor = FNWhiteColor;
        }else{
            _navigationview = [FNCustomeNavigationBar customeNavigationBarWithCustomeView:self.titleImgView];
        }
        _navigationview.backgroundColor = RED;
       
        
        
    }
    return _navigationview;
}
- (void)setTitleImg:(NSString *)titleImg{
    _titleImg = titleImg;
    [self.view addSubview:self.navigationview];
    [self.navigationview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationview autoSetDimension:(ALDimensionHeight) toSize:self.navigationview.height];
    self.listTopCons.constant = self.navigationview.height;
    [self.view layoutIfNeeded];
}
- (void)setIsNotHome:(BOOL)isNotHome{
    [super setIsNotHome:isNotHome];
    if (self.isNotHome) {
        UIButton* backbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backbtn setImage:IMAGE(@"return_w") forState:(UIControlStateNormal)];
        [backbtn sizeToFit];
        [backbtn addTarget:self action:@selector(backbtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        backbtn.size = CGSizeMake(backbtn.width+20, backbtn.height+20);
        self.navigationview.leftButton = backbtn;
        self.listBottomCons.constant = 0;
    }else{
        self.listBottomCons.constant = XYTabBarHeight;
    }
    
}
- (void)backbtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = FNWhiteColor;
    // Do any additional setup after loading the view.
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([NSString checkIsSuccess:self.viewmodel.view_type andElement:@"1"]) {
        [self.navigationController setNavigationBarHidden:YES animated:self.isNotHome];
        [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([NSString checkIsSuccess:self.viewmodel.view_type andElement:@"1"]) {
        [self.navigationController setNavigationBarHidden:NO animated:self.isNotHome];
        [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
    }
}
- (UIStatusBarStyle )preferredStatusBarStyle{
    if ([NSString checkIsSuccess:self.viewmodel.view_type andElement:@"1"]) {
        return UIStatusBarStyleLightContent;
    }else{
        return UIStatusBarStyleDefault;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)jm_setupViews{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.listview];
    [self.listview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.listview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    //self.listBottomCons = [self.listview autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:self.isNotHome ? 0:XYTabBarHeight];
    
    self.listTopCons = [self.listview autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
    if(self.isNotHome==YES){
        self.listBottomCons = [self.listview autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset: 0];
    }else{
        self.listBottomCons = [self.listview autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset: XYTabBarHeight];
    }
    
}

- (void)jm_bindViewModel{
    [[self.viewmodel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        [self goProductVCWithModel:x];
    }];
    
    [[self.filtersubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        self.viewmodel.sort = x;
        self.viewmodel.jm_page = 1;
        [SVProgressHUD show];
        [self.viewmodel.refreshDataCommand execute:nil];
    }];
}

@end
