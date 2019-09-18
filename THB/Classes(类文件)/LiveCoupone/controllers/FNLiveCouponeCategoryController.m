//
//  FNLiveCouponeCategoryController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveCouponeCategoryController.h"
#import "FNLiveCouponeCateModel.h"
#import "FNSeckillHomeModel.h"
#import "FNCustomeNavigationBar.h"
#import "FNLiveCouponeListController.h"
#import "FNImageSliderView.h"

@interface FNLiveCouponeCategoryController ()<UICollectionViewDelegateFlowLayout, FNImageSliderViewDelegate>
@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, copy) NSString *show_type_str;

@property (nonatomic, strong)FNImageSliderView* sliderView;
@property (nonatomic, strong)UIImageView* titleImgView;


@property (nonatomic, strong)NSLayoutConstraint* btmCons;

@property (nonatomic, strong) NSArray<FNLiveCouponeCateModel*> *categories;

@end

@implementation FNLiveCouponeCategoryController

- (instancetype)initWithType:(NSString*)type
{
    _show_type_str = type;
    self = [super init];
    if (self) {
    }
    return self;
}

//- (void)setIsNotHome:(BOOL)isNotHome{
//    [super setIsNotHome:isNotHome];
//    if (self.isNotHome) {
//        UIButton* backbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        //[backbtn setImage:IMAGE(@"return") forState:(UIControlStateNormal)];
//        [backbtn setImage:IMAGE(@"return2member") forState:(UIControlStateNormal)];
//        [backbtn sizeToFit];
//        [backbtn addTarget:self action:@selector(backbtnAction) forControlEvents:(UIControlEventTouchUpInside)];
//        backbtn.size = CGSizeMake(backbtn.width+20, backbtn.height+20);
//        self.btmCons.constant = 0;
//    }else{
//        self.btmCons.constant = XYTabBarHeight;
//    }
//}

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

- (FNImageSliderView *)sliderView{
    if (_sliderView == nil) {
        _sliderView = [[FNImageSliderView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 100))];
        _sliderView.delegate = self;
        _sliderView.textColor = RGB(51, 51, 51);
        _sliderView.font = kFONT12;
        _sliderView.hightlightFont = kFONT12;
        _sliderView.textHighlightColor = RGB(51, 51, 51);
        _sliderView.highlightColor = RGB(250, 76, 79);
    }
    return _sliderView;
}

- (void)viewDidLoad {
//    [super viewDidLoad];
    
    _lblTitle = [[UILabel alloc] init];
    [self.view addSubview:_lblTitle];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@13);
        make.top.equalTo(@10);
        make.right.lessThanOrEqualTo(@-13);
        make.height.mas_equalTo(16);
    }];
    
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
        *titleHeight = 140;
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
//    self.contentView.alpha = 0;
    [self.contentView addSubview:self.sliderView];
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
//        make.top.equalTo(self.lblTitle.mas_bottom).offset(10);
        make.top.equalTo(@40);
        make.height.mas_equalTo(100);
    }];
    
    [self requestCateggory];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - set up child view controllers
- (void)setupChildVC{
    @weakify(self)
    
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    NSMutableArray *imgUrls = [[NSMutableArray alloc] init];
    
    [self.categories enumerateObjectsUsingBlock:^(FNLiveCouponeCateModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)
        FNLiveCouponeListController *controller = [[FNLiveCouponeListController alloc] init];
        controller.title = obj.name;
        
        controller.cid = obj.ID;
        controller.type = obj.type;
        controller.show_type_str = self.show_type_str;
        
        [titles addObject:obj.name];
        [imgUrls addObject:obj.img];
        
        [self addChildViewController:controller];
        
    }];
    [self refreshDisplay];
    self.titleScrollView.hidden = YES;
    [self.titleScrollView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.titleScrollView autoSetDimension:(ALDimensionHeight) toSize:self.sliderView.height];
    
    self.contentScrollView.delegate = self;
    [self.contentScrollView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [self.contentScrollView
     autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.sliderView];
    
    [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
    self.btmCons = [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
    [self.sliderView setTitles:titles imageUrls:imgUrls];
    [self.view layoutIfNeeded];
    
    
}

#pragma mark - scroll view delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/JMScreenWidth;
//    [self.seckillview selectedTimeAtIndex:index];
    [self.sliderView setSelected:index animated:YES];
}


#pragma mark - Networking

- (void)requestCateggory{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,}];
    if ([self.show_type_str kr_isNotEmpty]) {
        params[@"show_type_str"] = self.show_type_str;
    }
    [SVProgressHUD show];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=life_coupon&ctrl=cate" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        @strongify(self)
        NSString *title = respondsObject[@"str"];
        NSArray *cate = respondsObject[@"cate"];
        
        self.categories = [FNLiveCouponeCateModel mj_objectArrayWithKeyValuesArray:cate];
        self.lblTitle.text = title;
        
        if (self.categories.count > 0) {
            [self setupChildVC];
        } else {
            FNLiveCouponeListController *vc = [[FNLiveCouponeListController alloc] init];
            vc.show_type_str = self.show_type_str;
            [self.view addSubview:vc.view];
            [self addChildViewController:vc];
            [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(@0);
            }];
//            [vc didMoveToParentViewController:self];
        }
        
    } failure:^(NSString *error) {
            [XYNetworkAPI cancelAllRequest];
            [SVProgressHUD dismiss];
            [self.jm_collectionview.mj_footer endRefreshing];
    } isHideTips:YES];
    
}

#pragma mark - FNImageSliderViewDelegate
- (void)sliderControl:(FNImageSliderView *)slider didCellSelectedAtIndex:(NSInteger)index {
    [self.contentScrollView setContentOffset:(CGPointMake(JMScreenWidth*index, 0)) animated:YES];
}

@end
