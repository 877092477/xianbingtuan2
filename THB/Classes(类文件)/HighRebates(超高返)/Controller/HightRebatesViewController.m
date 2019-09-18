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

#import "HightRebatesViewController.h"
#import "XMGSocialViewController.h"
#import "XYConst.h"
#import "ProductCVViewController.h"
#import "XYTitleModel.h"
#import "FNSiftViewController.h"
#define TitleH 30
@interface HightRebatesViewController ()
@property (nonatomic, strong)UIImageView* titleImgView;

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

@implementation HightRebatesViewController
- (void)setIsNotHome:(BOOL)isNotHome{
    [super setIsNotHome:isNotHome];
    if (self.isNotHome) {
        self.btmcons.constant = 0;
        
        UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        [leftbutton setImage: [UIImage imageNamed:@"return"] forState:UIControlStateNormal];
        leftbutton.frame=CGRectMake(0, 0, 21, 21);
        [leftbutton addTarget:self action:@selector(LeftBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
        

    }else{
        self.btmcons.constant = XYTabBarHeight;
    }
}
- (void)setSkipUIIdentifier:(NSString *)SkipUIIdentifier{
    _SkipUIIdentifier = SkipUIIdentifier;
    [self loadCategoryNameMethod];
}
- (UIImageView *)titleImgView{
    if (_titleImgView == nil) {
        _titleImgView = [UIImageView new];
        _titleImgView.image = IMAGE(@"nine_logo");
        [_titleImgView sizeToFit];
        
    }
    return _titleImgView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.fromHome = !self.isNotHome;
    //加载数据
    [self loadCategoryNameMethod];
    
    //添加导航栏
    [self setupNav];
    
    //注册通知
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(pushTongzhi:) name:@"PushNoti" object:nil];

    
    [notiCenter addObserver:self selector:@selector(tongzhi:) name:@"SiftNoti" object:nil];
}
/**
 *  接收搜索结果
 *
 *  @param noti <#noti description#>
 */
- (void)tongzhi:(NSNotification *)noti{
    XYLog(@"－－－－－这里接收到通知------");
    self.fromSift = 1;
    NSLog(@"%@",noti.userInfo);
    self.searchTitle = [noti.userInfo objectForKey:@"keyword"];
    self.price1 = [[noti.userInfo objectForKey:@"minPrice"] intValue];
    self.price2 = [[noti.userInfo objectForKey:@"maxPrice"]intValue];
    self.sort = [noti.userInfo objectForKey:@"sort"];
    NSNumber* num =  [noti.userInfo objectForKey:@"index"];
    self.selectIndex = num.integerValue;
    //    [self.collectionView setContentOffset:CGPointMake(0,0) animated:YES];
}
//获取数据
-(void)loadCategoryNameMethod
{
    _categoryIdArray = [NSMutableArray array];
    _categoryNameArray = [NSMutableArray array];
    if ([NSString isEmpty:self.SkipUIIdentifier]) {
        return;
    }
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{
                                                        @"type":self.SkipUIIdentifier,
                                                        @"time":[NSString GetNowTimes],
                                                        @"is_new_app":@"1"
                                                                                    }];
    params[SignKey] = [NSString getSignStringWithDictionary:params];

    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_home_getCates successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            NSArray *tempArray = [dict objectForKey:XYData];
            [_categoryNameArray removeAllObjects];
            [_categoryIdArray removeAllObjects];

            if (tempArray.count>0) {
                for (int i = 0; i < tempArray.count; i ++) {
                    XYTitleModel *model = [XYTitleModel mj_objectWithKeyValues:tempArray[i]];
                    [_categoryIdArray addObject:model.id];
                    [_categoryNameArray addObject:model.category_name];
                    
                }
            }else{
                [FNTipsView showTips:@"很抱歉，未获取到商品分类名~"];
            }
            if (_categoryNameArray.count>0) {
                [self setupChildVc:_categoryNameArray _idArray:_categoryIdArray];
                
                
                
                
            }else{
                [FNTipsView showTips:XYMsg];
            }
            
        }
        else{

        }
        
        
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
    }];
    
    
}
//导航栏
-(void)setupNav{

    UIButton *rightbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setImage: [UIImage imageNamed:@"screening"] forState:UIControlStateNormal];
    [rightbutton setTitle:@"  筛选" forState:UIControlStateNormal];
    [rightbutton setTitleColor:FNBlackColor forState:UIControlStateNormal];
    [rightbutton sizeToFit];
    rightbutton.titleLabel.font = kFONT14;
    [rightbutton addTarget:self action:@selector(RightBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
}
-(void)LeftBtnMethod:(UIButton *)sender
{
    if(self.fromNoti == 1){
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}
-(void)RightBtnMethod:(UIButton *)sender
{

    FNSiftViewController *vc = [[FNSiftViewController alloc]init];
    vc.Sifttype=@"pub_baicaiguan";
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//setupChildVc
- (void)setupChildVc:(NSMutableArray *)_array _idArray:(NSMutableArray *)_idArray 
{
    if (_array.count>0) {
        NSArray *array = _array;
        for (int i = 0 ; i<array.count; i++) {

            ProductCVViewController *VC = [[ProductCVViewController alloc] init];
            VC.categoryId =_idArray[i];
            VC.skipUIIdentifier = self.SkipUIIdentifier;

            if (self.fromHome == 1) {
                VC.fromHome =1;
            }
            [self addChildViewController:VC];
            VC.title = array[i];
            VC.searchTitle = self.searchTitle;
            VC.sort = self.sort;
            VC.price1 = self.price1;
            VC.price2 = self.price2;

        }
    }
    
    [self refreshDisplay];
    self.selectIndex = self.toIndex;
    [self.titleScrollView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.titleScrollView autoSetDimension:(ALDimensionHeight) toSize:35];
    
    [self.contentScrollView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.titleScrollView];
    [self.contentScrollView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    
    [self.contentView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:self.isNotHome?0:XYTabBarHeight];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
