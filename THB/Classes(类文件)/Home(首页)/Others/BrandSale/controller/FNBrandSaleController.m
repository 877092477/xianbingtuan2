//
//  HightRebatesViewController.m
//  THB
//
//  Created by zhongxueyu on 16/3/15.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "FNBrandSaleController.h"
#import "XMGSocialViewController.h"
#import "XYConst.h"
#import "ProductCVViewController.h"
#import "XYTitleModel.h"
#import "FNBrandSaleListController.h"

#import "FNAPIHome.h"
#define TitleH 30
@interface FNBrandSaleController ()

/** 存放分类数据的数组 */
@property (retain, nonatomic) NSMutableArray *categoryIdArray;

/** 存放分类的数组 */
@property (retain, nonatomic) NSMutableArray *categoryNameArray;

/**搜索的内容 */
@property (nonatomic,strong) NSString *searchTitle;

/**排序条件（1.最新,2.最热) */
@property (nonatomic,assign) NSNumber *sort;

/**最低价格 */
@property (nonatomic,assign) int price1;

/**最高价格*/
@property (nonatomic,assign) int price2;
@property (nonatomic, strong)NSLayoutConstraint* btmcons;
@end

@implementation FNBrandSaleController
- (void)setIsNotHome:(BOOL)isNotHome{
    [super setIsNotHome:isNotHome];
    if (self.isNotHome) {
        self.btmcons.constant = 0;
    }else{
        self.btmcons.constant = XYTabBarHeight;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= FNWhiteColor;
    
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
        *titleFont = kFONT14;
        
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
    if (self.title) {
        self.title = self.title;
    }else{
        self.title = @"品牌特卖";
    }
    
    //加载数据
    [self loadCategoryNameMethod];
    

}

//获取数据
-(void)loadCategoryNameMethod
{
    _categoryIdArray = [NSMutableArray array];
    _categoryNameArray = [NSMutableArray array];

    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@2}];
    @WeakObj(self);
    [SVProgressHUD show];
    [FNAPIHome apiBrandForStoreCategoriesWithParams:params success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        NSArray<XYTitleModel *>* result = respondsObject;
        [selfWeak.categoryNameArray removeAllObjects];
        [selfWeak.categoryIdArray removeAllObjects];
        if (result.count > 0) {
            [result enumerateObjectsUsingBlock:^(XYTitleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [selfWeak.categoryIdArray addObject:obj.id];
                [selfWeak.categoryNameArray addObject:obj.category_name];
            }];
            [selfWeak setupChildVc:selfWeak.categoryNameArray  _idArray:selfWeak.categoryIdArray type:2];
        }else{
            [FNTipsView showTips:@"很抱歉，未获取到商品分类名~"];
        }
        
    } failure:^(NSString *error) {
        if (error) {
            [FNTipsView showTips:error];
        }
    } isHidden:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//setupChildVc
- (void)setupChildVc:(NSMutableArray *)_array _idArray:(NSMutableArray *)_idArray type:(int )type
{
    if (_array.count>0) {
        NSArray *array = _array;
        for (int i = 0 ; i<array.count; i++) {
            FNBrandSaleListController* list = [FNBrandSaleListController new];
            list.cateID = _idArray[i];
            list.title = array[i];
            [self addChildViewController:list];
        }
    }
    
    [self refreshDisplay];
    self.selectIndex = self.toIndex;
   self.btmcons = [self.contentView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:self.isNotHome?0:XYTabBarHeight];
    [self.titleScrollView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.titleScrollView autoSetDimension:(ALDimensionHeight) toSize:35];

    [self.contentScrollView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeTop)];
    [self.contentScrollView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.titleScrollView];
    
}


@end
