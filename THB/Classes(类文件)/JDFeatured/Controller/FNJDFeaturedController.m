//
//  FNJDFeaturedController.m
//  THB
//
//  Created by jimmy on 2017/5/24.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNJDFeaturedController.h"
#import "FNSiftViewController.h"
#import "FNAPIHome.h"
#import "XYTitleModel.h"
@interface FNJDFeaturedController ()
@property (nonatomic, strong) NSMutableArray<XYTitleModel *>*  categories;
/**搜索的内容 */
@property (nonatomic,strong) NSString *searchTitle;

/**排序条件（1.最新,2.最热) */
@property (nonatomic,assign) NSNumber *sort;

/**最低价格 */
@property (nonatomic,assign) float price1;

/**最高价格*/
@property (nonatomic,assign) float price2;
@end

@implementation FNJDFeaturedController
#pragma mark - setter && getter

- (NSMutableArray<XYTitleModel *> *)categories
{
    if (_categories == nil) {
        _categories = [NSMutableArray new];
    }
    return _categories;
}
#pragma mark - system
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = FNWhiteColor;
    // 推荐方式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        //设置标题高度
        *titleHeight = 35;
        // 设置标题字体
        *titleFont = kFONT14;
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
    if (self.title) {
        self.title = self.title;
    }else{
        self.title = @"超高返利";
    }
    

    
    //注册通知
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(pushTongzhi:) name:@"PushNoti" object:nil];
    
    [notiCenter addObserver:self selector:@selector(tongzhi:) name:@"SiftNoti" object:nil];
    [self apiRequestCategories];
    [self setupNav];
}
/**
 *  接收搜索结果
 *
 *  @param noti <#noti description#>
 */
- (void)tongzhi:(NSNotification *)noti{
    XYLog(@"－－－－－这里接收到通知------");

    NSLog(@"%@",noti.userInfo);
    self.searchTitle = [noti.userInfo objectForKey:@"keyword"];
    self.price1 = [[noti.userInfo objectForKey:@"minPrice"] intValue];
    self.price2 = [[noti.userInfo objectForKey:@"maxPrice"]intValue];
    self.sort = [noti.userInfo objectForKey:@"sort"];
    NSNumber* num =  [noti.userInfo objectForKey:@"index"];
    self.selectIndex = num.integerValue;
    //    [self.collectionView setContentOffset:CGPointMake(0,0) animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupNav{
    UIButton *rightbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setImage: [UIImage imageNamed:@"screening"] forState:UIControlStateNormal];
    [rightbutton setTitle:@"  筛选" forState:UIControlStateNormal];
    [rightbutton setTitleColor:FNBlackColor forState:UIControlStateNormal];
    [rightbutton sizeToFit];
    rightbutton.titleLabel.font = kFONT14;
    [rightbutton addTarget:self action:@selector(RightBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
}
- (void)RightBtnMethod:(UIButton *)btn{
    FNSiftViewController *vc = [[FNSiftViewController alloc]init];
    vc.Sifttype=@"cgf";
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - api request
- (void)apiRequestCategories{
    NSArray* types = @[@"3",@"1",@"3"];
    @WeakObj(self);
    [SVProgressHUD show];
    [FNAPIHome apiHomeForNavCategoriesWithParams:[NSMutableDictionary dictionaryWithDictionary:@{@"type":types[self.type]}] success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        [selfWeak.categories addObjectsFromArray:respondsObject];
        if (selfWeak.categories.count == 0) {
            [FNTipsView showTips:FNEmptyData];
        }else{
            NSMutableArray* titles = [NSMutableArray new];
            [selfWeak.categories enumerateObjectsUsingBlock:^(XYTitleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [titles addObject:obj.category_name];
            }];
            [selfWeak setUpChildViewControllerWithTitles:titles];
        }
    } failure:^(NSString *error) {
        
    } isHidden:NO];
}

#pragma mark - set up child view controller
- (void)setUpChildViewControllerWithTitles:(NSArray *)titles{
    @WeakObj(self);
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FNJDFeaturedListController* list = [FNJDFeaturedListController new];
        list.cateID = selfWeak.categories[idx].id;
        list.type = selfWeak.type;
        list.title = obj;
        list.searchTitle = self.searchTitle;
        list.sort = self.sort;
        list.price1 = [NSString stringWithFormat:@"%.2f",self.price1];
        list.price2 = [NSString stringWithFormat:@"%.2f",self.price2];
        [selfWeak addChildViewController:list];
    }];
    [self refreshDisplay];
    selfWeak.selectIndex = 0;
}
@end
