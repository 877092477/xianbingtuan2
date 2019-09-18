//
//  ShopRebatesViewController.m
//  THB
//
//  Created by zhongxueyu on 16/3/24.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "ShopRebatesViewController.h"
#import "ProductCVViewController.h"
#import "ShopRebatesCateController.h"
#import "JMTutorialController.h"

#import "XYTitleLabel.h"
#import "ShopRebatesModel.h"
#import "SDCycleScrollView.h"
#import "FNAPIHome.h"
#import "MenuModel.h"
#import "FNMNineTitleView.h"
#import "FNPopUpTool.h"
#import "FDSlideBar.h"
#define TitleH 30

@interface ShopRebatesViewController ()

@property (nonatomic, strong) FDSlideBar *titleview;

@property (nonatomic, strong)NSArray<ShopRebatesStoreModel*> *allStores;
@property (nonatomic, strong)NSArray<ShopRebatesCateModel*> *allCategories;

@property (nonatomic, copy) NSString *currentStore;
@property (nonatomic, copy) NSString *currentCate;

@property (nonatomic, copy) NSString *shopType;
@property (nonatomic, copy) NSString* show_type_str;

@end

@implementation ShopRebatesViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (instancetype)initWithShopType:(NSString*)shopType withStr: (NSString*)show_type_str {
    _shopType = shopType;
    _show_type_str = show_type_str;
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)setIsNotHome:(BOOL)isNotHome{
    [super setIsNotHome:isNotHome];
    if (self.isNotHome) {
        //        self.btmcons.constant = 0;
        UIBarButtonItem * back = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"return") style:(UIBarButtonItemStyleDone) target:self action:@selector(backAction)];
        self.navigationItem.leftBarButtonItem = back;
    }else{
        //        self.btmcons.constant = XYTabBarHeight;
    }
    [self.view layoutIfNeeded];
}

//- (JMTitleScrollView *)titleview{
//    if (_titleview == nil) {
//        _titleview = [[JMTitleScrollView alloc]initWithFrame:(CGRectMake(40, 40, JMScreenWidth-80, 40)) titleArray:@[] fontSize:14 _textLength:3 andButtonSpacing:10 type:StableType];
//        _titleview.backgroundColor = [UIColor clearColor];
//        _titleview.tDelegate = self;
//        _titleview.contentSize = CGSizeMake((14*3+10)*3, 44);
//        _titleview.alwaysBounceVertical = NO;
//        [_titleview setBottomViewAtIndex:0];
//    }
//    return _titleview;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商城";
    [self setupNav];
    
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
        *titleFont = kFONT12;
        
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
    
    if ([self.shopType kr_isNotEmpty]) {
        self.currentStore = self.shopType;
        [self apiRequestCates];
    } else {
        
        [self apiRequestStores];
    }
    
    
}

//导航栏
-(void)setupNav{
    
    self.titleview = [[FDSlideBar alloc] initWithFrame:CGRectMake(40, 0, FNDeviceWidth-80, 40)];
    //    self.titleview.is_middle=YES;
    //    self.titleview.itemColor = FNGlobalTextGrayColor;
    //    self.titleview.itemSelectedColor = RED;
    //    self.titleview.sliderColor = RED;
    //    self.titleview.fontSize=14;
    //    self.titleview.SelectedfontSize=14;
    
    self.navigationItem.titleView = self.titleview;
    
}
#pragma mark - action
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)LeftBtnMethod:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (FNRequestTool*)apiRequestStores{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    if ([_show_type_str kr_isNotEmpty]) {
        params[@"show_type_str"] = _show_type_str;
    }
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_rebate_store&ctrl=topcate" respondType:ResponseTypeArray modelType:@"ShopRebatesStoreModel" success:^(id respondsObject) {
        @strongify(self);
        self.allStores = respondsObject;
        
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        for (ShopRebatesStoreModel *story in self.allStores) {
            [titles addObject:story.name];
        }
        
        self.titleview.is_middle=YES;
        self.titleview.itemsTitle =titles;
        self.titleview.itemColor = FNGlobalTextGrayColor;
        self.titleview.itemSelectedColor = RED;
        self.titleview.sliderColor = RED;
        self.titleview.fontSize=14;
        self.titleview.SelectedfontSize=14;
        if (self.allStores.count > 0) {
            [self.titleview selectSlideBarItemAtIndex:0];
            self.currentStore = self.allStores[0].type;
            [self apiRequestCates];
        }
        [self.titleview slideBarItemSelectedCallback:^(NSUInteger index) {
            self.jm_page = 1;
            self.currentStore = self.allStores[index].type;
            [self apiRequestCates];
        }];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
    
}
- (FNRequestTool*)apiRequestCates{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, typeKey: self.currentStore}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_rebate_store&ctrl=cate" respondType:ResponseTypeArray modelType:@"ShopRebatesCateModel" success:^(id respondsObject) {
        @strongify(self);
        self.allCategories = respondsObject;
        if (self.allCategories.count > 0) {
            self.currentCate = self.allCategories[0].ID;
            
            [self setupChildViewController];
        }
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
    
}

//setupChildVc
- (void)setupChildViewController
{
    for (UIViewController *controller in self.childViewControllers) {
        [controller removeFromParentViewController];
    }
    
    for (NSInteger index = 0; index < self.allCategories.count; index ++) {
        ShopRebatesCateController *vc = [[ShopRebatesCateController alloc] init];
        vc.cateId = self.allCategories[index].ID;
        vc.title = self.allCategories[index].category_name;
        vc.storeType = self.currentStore;
        
        [self addChildViewController:vc];
    }
    
    self.selectIndex = 0;
    
    [self refreshDisplay];
    self.btmcons = [self.contentView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
    [self.titleScrollView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.titleScrollView autoSetDimension:(ALDimensionHeight) toSize:35];
    
    [self.contentScrollView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeTop)];
    [self.contentScrollView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.titleScrollView];
    
}


@end
