//
//  FNPNormalProController.m
//  THB
//
//  Created by Jimmy on 2017/12/25.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPNormalProController.h"
#import "FNPromotionalListController.h"
#import "FNCategoryModel.h"
#import "FNCustomeNavigationBar.h"
#import "FNPNormalFilterView.h"
#import "FNPopUpTool.h"
#import "JMFilterListView.h"
@interface FNPNormalProController ()
@property (nonatomic, strong)NSArray<FNCategoryModel *>* categories;
@property (nonatomic, strong)FNCustomeNavigationBar* navigationview;
@property (nonatomic, strong)UIImageView* titleImgView;
@property (nonatomic, strong)UIImage* titleimage;
@property (nonatomic, strong)FNPNormalFilterView* filterview;
@property (nonatomic, strong)JMFilterListView* complexList;
@property (nonatomic, strong)RACSubject* filtersubject;
@property (nonatomic, copy)NSString* sort;

@property (nonatomic, strong)NSLayoutConstraint* btmCons;
@end

@implementation FNPNormalProController
#pragma mark - getter
- (void)setIsNotHome:(BOOL)isNotHome{
    [super setIsNotHome:isNotHome];
    if (self.isNotHome) {
        UIButton* backbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backbtn setImage:IMAGE(@"return_w") forState:(UIControlStateNormal)];
        [backbtn sizeToFit];
        [backbtn addTarget:self action:@selector(backbtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        backbtn.size = CGSizeMake(backbtn.width+20, backbtn.height+20);
        _navigationview.leftButton = backbtn;

    }
}
- (RACSubject *)filtersubject{
    if (_filtersubject == nil) {
        _filtersubject = [RACSubject subject];
    }
    return _filtersubject;
}
- (UIImageView *)titleImgView{
    if (_titleImgView == nil) {
        _titleImgView = [UIImageView new];
        CGSize size = IMAGE(@"logo_generalize").size;
        if (self.titleimage.size.width>size.width) {
            size = CGSizeMake(size.width, size.height);
        }else{
            size = CGSizeMake(self.titleimage.size.width, size.height);
        }
        _titleImgView.size = size;
        _titleImgView.contentMode = UIViewContentModeScaleAspectFit;
        [_titleImgView setUrlImg:self.titleImg];
    }
    return _titleImgView;
}
- (FNCustomeNavigationBar *)navigationview{
    if (_navigationview == nil) {
        self.titleimage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.titleImg]]];
        if ([NSString isEmpty:self.titleImg] || self.titleimage==nil) {
            _navigationview = [FNCustomeNavigationBar customeNavigationBarWithTitle:self.title];
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
}
- (void)backbtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (JMFilterListView *)complexList{
    if (_complexList == nil) {
        _complexList = [[JMFilterListView alloc]initWithFrame:CGRectMake(0, JMNavBarHeigth+self.filterview.height+35, self.view.width, 0)];
        @weakify(self);
        _complexList.selectedAtIndexpath = ^(NSIndexPath* indexPaht,NSString* name){
            [FNPopUpTool hiddenAnimated:YES];
            @strongify(self);
            //[self.filterview changeName:name atIndex:0];
            if (indexPaht.row == 0) {
                self.sort = @"1";
            }else if (indexPaht.row == 1){
                self.sort = @"2";
            }else if (indexPaht.row == 2){
                self.sort = @"3";
            }else{
                self.sort = @"6";
            }
            [self.filtersubject sendNext:self.sort];
        };
        
        _complexList.list = @[@"综合",@"销量从高到低",@"价格从低到高",@"领券量从高到低"];
    }
    return _complexList;
}
- (FNPNormalFilterView *)filterview{
    if (_filterview == nil) {
        _filterview = [[FNPNormalFilterView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 40))];
        _filterview.backgroundColor  =FNWhiteColor;
        [_filterview selectedAtIndex:0];
        @weakify(self);
        _filterview.clickedWithType = ^(FilterType type) {
            @strongify(self);
            
            if (type == FilterTypeComplex) {
                
                [FNPopUpTool showViewWithContentView:self.complexList withDirection:(FMPopupAnimationDirectionNone) finished:^{
                    //
                }];
              
            }else{
                self.sort = [NSString stringWithFormat:@"%ld",type];
                [self.filtersubject sendNext:self.sort];
            }
        };
    }
    return _filterview;
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
        *titleHeight = 35;
        // 设置标题字体
        *titleFont = kFONT13;
        
    }];
    
    
    // 推荐方式（设置下标）
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        
        // 是否显示标签
        *isShowUnderLine = YES;
        
        // 标题填充模式
        *underLineColor = RED;
        
        // 是否需要延迟滚动,下标不会随着拖动而改变
        //        *isDelayScroll = YES;
        
    }];
    
    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
    self.isfullScreen = NO;
    self.contentView.alpha = 0;
    [self.contentView addSubview:self.filterview];
    [self.filterview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.filterview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [self.filterview autoSetDimension:(ALDimensionHeight) toSize:self.filterview.height];
    
    [SVProgressHUD show];
    [self requestCategories];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
#pragma mark - request
- (FNRequestTool *)requestCategories{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appHhr&ctrl=getCate" respondType:(ResponseTypeArray) modelType:@"FNCategoryModel" success:^(id respondsObject) {
        //
        self.categories  = respondsObject;
        if (self.categories.count>=1) {
            [UIView animateWithDuration:0.3 animations:^{
                self.contentView.alpha = 1;
            } completion:^(BOOL finished) {
                [self setupChildVC];
            }];
            
        }
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
#pragma mark - set up child view controllers
- (void)setupChildVC{
   
        [self.categories enumerateObjectsUsingBlock:^(FNCategoryModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNPromotionalListController* controller = [FNPromotionalListController new];
            controller.isNotHome = self.isNotHome;
            controller.viewmodel.identifier = self.identifier;
            controller.viewmodel.view_type = self.view_type;
            controller.viewmodel.cid  = obj.ID;
            controller.title = obj.catename?:@"";
            controller.viewmodel.sort = @"1";
            controller.filtersubject = self.filtersubject;
            [self addChildViewController:controller];
        }];
        [self refreshDisplay];
        self.contentView.frame=CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, JMScreenHeight-SafeAreaTopHeight);
        [self.view addSubview: self.contentView];
        [self.titleScrollView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
        [self.titleScrollView autoSetDimension:(ALDimensionHeight) toSize:35];
        self.titleScrollView.frame=CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, 35);
        [self.contentView addSubview:self.titleScrollView];
        [self.filterview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.titleScrollView];
        [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.filterview.mas_bottom).offset(0);
            make.left.right.bottom.equalTo(@0); 
        }];
    
    
   
}

@end
