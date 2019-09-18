//
//  CategoryViewController.m
//  FnuoApp
//
//  Created by zhongxueyu on 16/2/22.
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

#import "CategoryViewController.h"
#import "XYCategoryLable.h"
#import "SizeMacros.h"
#import "CatagoryProductCell.h"
#import "XYTitleModel.h"
#import "CategoryListModel.h"
#import "SearchViewController.h"
#import "ProductListViewController.h"
#define lBLH 70
@interface CategoryViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

/** 左边的分类ScrollView */
@property (nonatomic,strong)  UIScrollView *categoryScrollView;


/** CollectionView */
@property (nonatomic,strong)   UICollectionView *collectionView;

/** CollectionView布局 */
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;

/** 按钮侧边滑动的控件 */
@property(nonatomic, strong)UIView *line;

/** 分割线 */
@property (nonatomic, strong) UIImageView *lineView;

/** 存放分类数据的数组 */
@property (retain, nonatomic) NSMutableArray *categoryDataArray;

/** 存放分类的数组 */
@property (retain, nonatomic) NSMutableArray *categoryNameArray;

/** 产品列表数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 分类名 **/
@property(nonatomic,strong) NSString *categoryName;

@end


@implementation CategoryViewController
@synthesize categoryScrollView,lineView;
static NSString * const reuseIdentifier = @"collectionViewCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"逛逛";
    //初始化数组
    _categoryDataArray = [NSMutableArray array];
    _categoryNameArray = [NSMutableArray array];
    _categoryName = [[NSString alloc]init];
    [self loadCategoryNameMethod];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //导航栏样式设置
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = NO;
    
    if (iOS7) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    }
}
//获取数据
-(void)loadCategoryNameMethod
{
    NSMutableArray *idArray = [NSMutableArray array];
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"Type":@4,
                                                                                 @"time":[NSString GetNowTimes]                        }];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_home_getCates successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        NSString *msg = [NSString stringWithFormat:@"%@",[dict objectForKey:XYMessage]];
        
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            NSArray *tempArray = [dict objectForKey:XYData];
            [_categoryNameArray removeAllObjects];
            [_categoryDataArray removeAllObjects];
            
            if (tempArray) {
                for (int i = 0; i < tempArray.count; i ++) {
                    XYTitleModel *model = [XYTitleModel mj_objectWithKeyValues:tempArray[i]];
                    [_categoryDataArray addObject:model];
                    [_categoryNameArray addObject:model.category_name];
                    [idArray addObject:model.id];
                    _categoryName = _categoryNameArray[0];
                }
            }
            if (_categoryNameArray.count>0) {
                [SVProgressHUD dismiss];
                [self initView:_categoryNameArray];
                
                [self loadRightDateMethod:[idArray[0] intValue]];
                [self initCollectionView];
                
                
            }else{
                [FNTipsView showTips:XYMsg];
            }
            
        }
        else{
            [FNTipsView showTips:msg];
        }
        
        
        
    } failureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
        [XYNetworkAPI cancelAllRequest];
    }];
    
    
}

-(void)initView:(NSMutableArray *)array{
    CGFloat margin = 5;
    //搜索框
    UIImageView *titleView=[[UIImageView alloc]initWithFrame:CGRectMake(margin, 5, XYScreenWidth-margin*2, 28)];
    titleView.image=[UIImage imageNamed:@"goodbg"];
    titleView.userInteractionEnabled = YES;
    [self.view addSubview:titleView];
    //搜索图标
    UIImageView *search = [[UIImageView alloc]initWithFrame:CGRectMake(12, 5, 21, 21)];
    search.image = IMAGE(@"cgf_search");
    [titleView addSubview:search];
    //关键字
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(search.frame)+10, 0, CGRectGetWidth(titleView.frame)-65, CGRectGetHeight(titleView.frame))];
    lable.text = @"请输入商品关键字";
    lable.textColor = RGB(150, 150, 150);
    lable.font = kFONT15;
    [titleView addSubview:lable];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnTapTitleView:)];
    [titleView addGestureRecognizer:tap];
    
    //分割线
    lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame)+5, XYScreenWidth, 1)];
    lineView.image = IMAGE(@"member_line1");
    [self.view addSubview:lineView];
    //配置ScrollView
    categoryScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame)+10, 80, XYScreenHeight-XYTabBarHeight-CGRectGetMinY(lineView.frame)-64)];
    [self.view addSubview:categoryScrollView];
    categoryScrollView.showsHorizontalScrollIndicator = NO;
    categoryScrollView.showsVerticalScrollIndicator = NO;
    
    //初始化数据
    CGFloat labelW = 40;
    CGFloat labelH = lBLH;
    
    
    
    // 添加label
    for (NSInteger i = 0; i<array.count; i++) {
        XYCategoryLable *label = [[XYCategoryLable alloc] init];
        label.numberOfLines = 2;
        label.text = array[i];
        CGFloat labelX = 15;
        CGFloat labelY = i*labelH;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        label.tag = i;
        label.font = kFONT14;
        label.textColor = RGB(35, 44, 50);
        [categoryScrollView addSubview:label];
        if (i == 0) { // 最前面的label
            label.scale = 0.8;
        }
    }
    
    // 设置contentSize
    categoryScrollView.contentSize = CGSizeMake(0,array.count * labelH);
    
    //轨道
    UIView *verticalView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(categoryScrollView.frame)-3, 0, 3, array.count*lBLH+XYScreenHeight)];
    
    verticalView.backgroundColor = RGB(223, 223, 223);
    [categoryScrollView addSubview:verticalView];
    // 按钮下边滑动的控件
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(categoryScrollView.frame)-3, lBLH/2-9, 3, 22)];
    line.backgroundColor =RED;
    self.line = line;
    [categoryScrollView addSubview:self.line];
}
/**
 * 监听顶部label点击
 */
- (void)labelClick:(UITapGestureRecognizer *)tap
{
    [SVProgressHUD show];
    // 取出被点击label的索引
    NSInteger index = tap.view.tag;
    XYTitleModel *model = _categoryDataArray[index];
    _categoryName = _categoryNameArray[index];
    CGFloat scale = index;
    if (scale < 0 || scale > categoryScrollView.subviews.count - 1) return;
    // 获得需要操作的label
    NSInteger tapIndex = scale;
    XYCategoryLable *tapLabel = categoryScrollView.subviews[tapIndex];
    //获得左边的label
    NSInteger leftIndex = tapIndex -1;
    XYCategoryLable *leftLabel = (tapIndex == 0) ? categoryScrollView.subviews[tapIndex] : categoryScrollView.subviews[leftIndex];
    NSLog(@"count is %lu",(unsigned long)categoryScrollView.subviews.count);
    NSLog(@"tapIndex is %ld",(long)tapIndex);
    // 获得需要操作的右边label
    NSInteger rightIndex = tapIndex + 1;
    XYCategoryLable *rightLabel = (tapIndex < categoryScrollView.subviews.count-3) ? categoryScrollView.subviews[rightIndex] : nil;
    // 设置label的比例
    leftLabel.scale = 0;
    tapLabel.scale = 0.8;
    rightLabel.scale = 0;
    
    CGFloat height = categoryScrollView.frame.size.height;
    // 让对应的顶部标题居中显示
    XYCategoryLable *label = categoryScrollView.subviews[index];
    CGPoint titleOffset = categoryScrollView.contentOffset;
    titleOffset.y = label.center.y - height * 0.5;
    // 左边超出处理
    if (titleOffset.y < 0) titleOffset.y = 0;
    // 右边超出处理
    CGFloat maxTitleOffsetY = categoryScrollView.contentSize.height -height;
    if (titleOffset.y > maxTitleOffsetY) titleOffset.y = maxTitleOffsetY;
    
    [categoryScrollView setContentOffset:titleOffset animated:YES];
    
    // 让其他label回到最初的状态
    XYCategoryLable *otherLabel;
    for (otherLabel in categoryScrollView.subviews) {
        
        if ([otherLabel isKindOfClass:[UILabel class]]) {
            if (otherLabel != label)
            {
                otherLabel.scale = 0;
            }
        }
        
    }
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.line.frame = CGRectMake(CGRectGetWidth(categoryScrollView.frame)-3, CGRectGetMinY(label.frame)+lBLH/2-7, 3, 22);
    } completion:^(BOOL finished) {
        [self loadRightDateMethod:[model.id intValue]];
    }];
    
}

-(void)loadRightDateMethod:(int)Id
{
    NSNumber *catagoryId = [NSNumber numberWithInt:Id];

    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{
                                                  @"id":catagoryId,
                                                  @"time":[NSString GetNowTimes]
                                                  }];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_home_getCatesChild successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        //        NSString *msg = [NSString stringWithFormat:@"%@",[dict objectForKey:XYMessage]];
        XYLog(@"responseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            
            [self.dataArray removeAllObjects];
            
            NSArray *tempArray = [dict objectForKey:XYData];
            if (tempArray.count>0) {
                for (int i = 0; i < tempArray.count; i ++) {
                    CategoryListModel *model = [CategoryListModel mj_objectWithKeyValues:tempArray[i]];
                    [self.dataArray addObject:model];
                    if (self.dataArray.count>0) {
                        [_collectionView reloadData];
                        [SVProgressHUD dismiss];
                    }
                }
                
                
            }else{
                [FNTipsView showTips:XYMsg];
            }
            
            
            
        }else
        {
            [SVProgressHUD dismiss];
            //            [FNTipsView showTips:msg];
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        
        
    } failureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
        [XYNetworkAPI cancelAllRequest];
    }];
    
}
-(void)OnTapTitleView:(UIGestureRecognizer *)sender
{
    SearchViewController *vc = [[SearchViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.type = 2;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)closeBtnMethod{
    SearchViewController *vc = [[SearchViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.type = 2;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - CollectionView
-(void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    //    flowLayout.minimumInteritemSpacing = 5;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(categoryScrollView.frame)+10, CGRectGetMaxY(lineView.frame)+10, XYScreenWidth-CGRectGetWidth(categoryScrollView.frame)-10, XYScreenHeight-CGRectGetMaxY(lineView.frame)-XYTabBarHeight-64) collectionViewLayout:flowLayout];
    
    
    //设置代理
    //    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //注册cell和ReusableView（相当于头部）
    [self.collectionView registerClass:[CatagoryProductCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    CatagoryProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    if (self.dataArray.count>0) {
        CategoryListModel *model = self.dataArray[indexPath.row];
        [cell.imgView setUrlImg:model.img1];
        cell.goodsTitle.text = model.category_name;
    }
    
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake(CGRectGetWidth(_collectionView.frame)/3-20, CGRectGetWidth(_collectionView.frame)/3+10);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 10, 1, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.001f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.001f;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryListModel *model = self.dataArray[indexPath.row];
    ProductListViewController *vc = [ProductListViewController alloc];
    vc.hidesBottomBarWhenPushed = YES;
    vc.searchTitle = model.category_name;
    if([_categoryName rangeOfString:@"男"].location !=NSNotFound ||[_categoryName rangeOfString:@"女"].location !=NSNotFound)//_roaldSearchText
    {
        vc.categoryID = _categoryName;
    }
    else
    {
        vc.categoryID = @"";
    }
    [self.navigationController pushViewController:vc animated:YES];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -Getter
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


@end
