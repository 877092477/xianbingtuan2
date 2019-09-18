//
//  FNPSecKillController.m
//  THB
//
//  Created by Jimmy on 2017/12/25.
//  Copyright © 2017年 方诺科技. All rights reserved.
// 限时秒杀

#import "FNPSecKillController.h"
#import "FNPromotionalListController.h"
#import "FNPSecKillTitleView.h"
#import "FNSeckillHomeModel.h"
#import "FNCustomeNavigationBar.h"
#define CNBMidMargin (isIphoneX? 40:20)
@interface FNPSecKillController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)NSArray<App_Miaosha_Time *>* times;
@property (nonatomic, strong)FNPSecKillTitleView* seckillview;
@property (nonatomic, strong)FNCustomeNavigationBar* navigationview;
@property (nonatomic, strong)UIImageView* titleImgView;


@property (nonatomic, strong)NSLayoutConstraint* btmCons;
@end

@implementation FNPSecKillController
- (void)setIsNotHome:(BOOL)isNotHome{
    [super setIsNotHome:isNotHome];
    if (self.isNotHome) {
        UIButton* backbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        //[backbtn setImage:IMAGE(@"return") forState:(UIControlStateNormal)];
        [backbtn setImage:IMAGE(@"return2member") forState:(UIControlStateNormal)];
        [backbtn sizeToFit];
        [backbtn addTarget:self action:@selector(backbtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        backbtn.size = CGSizeMake(backbtn.width+20, backbtn.height+20);
        _navigationview.leftButton = backbtn;
        self.btmCons.constant = 0;
    }else{
        self.btmCons.constant = XYTabBarHeight;
    }
}

- (UIImageView *)titleImgView{
    if (_titleImgView == nil) {
        _titleImgView = [UIImageView new];
        //_titleImgView.size = IMAGE(@"logo_rob").size;
        //_titleImgView.contentMode = UIViewContentModeScaleAspectFit;
        //[_titleImgView setUrlImg:self.titleImg];
        _titleImgView.size =CGSizeMake(XYScreenWidth, SafeAreaTopHeight);
        //_titleImgView.image=IMAGE(@"rob_bj1");
        [_titleImgView setUrlImg:[FNBaseSettingModel settingInstance].taoqianggou_nav_img];
       
    }
    return _titleImgView;
}
- (FNCustomeNavigationBar *)navigationview{
    if (_navigationview == nil) {
        /*UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.titleImg]]];
        if ([NSString isEmpty:self.titleImg] || image==nil) {
            _navigationview = [FNCustomeNavigationBar customeNavigationBarWithTitle:self.title];
            _navigationview.titleLabel.textColor = FNBlackColor;
        }else{
            _navigationview = [FNCustomeNavigationBar customeNavigationBarWithCustomeView:self.titleImgView];
        }
        _navigationview.backgroundColor = FNDefaultBarColor;*/
        XYLog(@"taoqianggou_nav_img:%@",[FNBaseSettingModel settingInstance].taoqianggou_nav_img);
        NSString *titleStr=self.show_name ? self.show_name : self.title;
        _navigationview = [FNCustomeNavigationBar customeNavigationBarWithBgImageViewAddLable:self.titleImgView withTitle:titleStr];
        NSString *navcolor=[FNBaseSettingModel settingInstance].tqg_nav_color;
        XYLog(@"navcolor:%@",[FNBaseSettingModel settingInstance].tqg_nav_color);
        _navigationview.ImagetitleLabel.textColor=[UIColor colorWithHexString:navcolor];
        
    }
    return _navigationview;
}
- (void)backbtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (FNPSecKillTitleView *)seckillview{
    if (_seckillview == nil) {
        _seckillview = [[FNPSecKillTitleView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 60))]; 
        @weakify(self);
        _seckillview.clickedTimeAtIndex = ^(NSInteger index) {
            @strongify(self);
            [self.contentScrollView setContentOffset:(CGPointMake(JMScreenWidth*index, 0)) animated:YES];
        };
    }
    return _seckillview;
}
- (void)setTimes:(NSArray<App_Miaosha_Time *> *)times{
    _times = times;
    _seckillview.model = _times;
    if (_times.count>=1) {
        [_times enumerateObjectsUsingBlock:^(App_Miaosha_Time * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.check.boolValue) {
                [self.seckillview selectedTimeAtIndex:idx];
            }
        }];
    }
}
- (void)setTitleImg:(NSString *)titleImg{
    _titleImg = titleImg;
    [self.view addSubview:self.navigationview];
    [self.navigationview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationview autoSetDimension:(ALDimensionHeight) toSize:self.navigationview.height];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = FNWhiteColor;
    // 设置标题字体
    /*
     方式一：
     self.titleFont = [UIFont systemFontOfSize:20];
     */
    // 推荐方式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        //设置标题高度
        *titleHeight = 60;
        // 设置标题字体
        *titleFont = kFONT13;
        
    }];
    
    
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
    
    [SVProgressHUD show];
    self.contentView.alpha = 0;
    [self.contentView addSubview:self.seckillview];
    [self.seckillview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.seckillview autoSetDimension:(ALDimensionHeight) toSize:self.seckillview.height];
    
    

    [self requestTimes];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:self.isNotHome];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:self.isNotHome];
}
#pragma mark - api request
- (FNRequestTool *)requestTimes{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    if (self.identifier) {
        params[@"type"] = self.identifier;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=goods_cate&ctrl=dd_time" respondType:(ResponseTypeArray) modelType:@"App_Miaosha_Time" success:^(id respondsObject) {
       
        selfWeak.times = respondsObject;
        if (selfWeak.times.count>=1) {
            [UIView animateWithDuration:0.3 animations:^{
                self.contentView.alpha = 1;
            }];
            [selfWeak setupChildVC];
        }
    } failure:^(NSString *error) {
        if(self.times.count==0){
            [self requestTimes];
        }
    } isHideTips:NO];
}
#pragma mark - set up child view controllers
- (void)setupChildVC{
    [self.times enumerateObjectsUsingBlock:^(App_Miaosha_Time * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FNPromotionalListController* controller = [FNPromotionalListController new];
        controller.isNotHome = self.isNotHome;
        controller.viewmodel.identifier = self.identifier;
        controller.viewmodel.view_type = self.view_type;
        controller.viewmodel.time  = obj.time;
        controller.viewmodel.status = obj.status;
        controller.title = obj.time;
        NSLog(@"status%@",obj.status);
        [self addChildViewController:controller];
        
    }];
    [self refreshDisplay];
    self.titleScrollView.hidden = YES;
    [self.titleScrollView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.titleScrollView autoSetDimension:(ALDimensionHeight) toSize:self.seckillview.height];
    
    self.contentScrollView.delegate = self;
    [self.contentScrollView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [self.contentScrollView
     autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.seckillview];
    
    [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    //self.btmCons = [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:self.isNotHome ?0:XYTabBarHeight];
    [self.contentView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.navigationview];
    self.btmCons = [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
    [self.times enumerateObjectsUsingBlock:^(App_Miaosha_Time * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.check.boolValue) {
            self.selectIndex = idx;
            [self.seckillview selectedTimeAtIndex:idx];
            
        }
    }];
    [self.view layoutIfNeeded];
   
    
}

#pragma mark - scroll view delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/JMScreenWidth;
    [self.seckillview selectedTimeAtIndex:index];
}

@end
