//
//  FNHomeSecKillViewController.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/8/4.
//  Copyright © 2016年 jimmy. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "FNHomeSecKillViewController.h"

#import "FNSeckillCell.h"

#import "FNHSecKillScheduleToolView.h"
#import "FNSecKillTitleView.h"

#import "FNHSecKillBeginCell.h"
#import "FNHSecKillTBDCell.h"


#import "FNHSecKillProudctModel.h"

#import "FNSeckillDataRequestTool.h"
#import "FNSeckillHomeModel.h"

@interface FNHomeSecKillViewCell :UICollectionViewCell<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, weak)UITableView* tableView;
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, strong)NSMutableArray* products;
@property (nonatomic, strong)UIImageView* toTopImage;

@property (nonatomic, copy)void (^GoToDetailBlock)(FNHSecKillProudctModel *model);

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end
@implementation FNHomeSecKillViewCell
@synthesize toTopImage;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.emptyDataSetSource = self;
    tableView.emptyDataSetDelegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView removeEmptyCellRows];
    [tableView reloadData];

    [self.contentView addSubview:tableView];
    
    _tableView =tableView;
    
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
    toTopImage = [[UIImageView alloc]initWithFrame:CGRectMake(XYScreenWidth-65, XYScreenHeight-XYTabBarHeight-60, 47, 47)];
    toTopImage.image = IMAGE(@"hddb");
    [toTopImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickToScrollTopMethod:)]];
    [self.contentView addSubview:toTopImage];
    toTopImage.userInteractionEnabled = YES;
    toTopImage.hidden = YES;
    
    [toTopImage autoSetDimensionsToSize:(CGSizeMake(47, 47))];
    [toTopImage autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15];
    //    [toTopImage autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:XYTabBarHeight+15 + 20];
    [toTopImage autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.tableView withOffset:-20];
    [self.contentView bringSubviewToFront:toTopImage];

}
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNHomeSecKillViewCell";
    FNHomeSecKillViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    return cell;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FNHSecKillProudctModel *model = self.products[indexPath.row];

    
    FNSeckillCell *cell = [FNSeckillCell cellWithTableView:tableView atIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    @WeakObj(self);
    cell.rodClicked = ^(FNHSecKillProudctModel *model) {
        if (selfWeak.GoToDetailBlock) {
            selfWeak.GoToDetailBlock(model);
        }
    };
    return cell;
    
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FNHSecKillProudctModel *model = self.products[indexPath.row];
    //跳详情
    
    if (self.GoToDetailBlock) {
        self.GoToDetailBlock(model);
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _seckill_img_h + 20;


}
- (void)setProducts:(NSMutableArray *)products{
    _products = products;
     [_tableView reloadData];
    [_tableView.mj_header endRefreshing];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"---%f",offsetY);
    if (offsetY > FNDeviceHeight) {
        
        toTopImage.hidden = NO;
    }else{
        
        toTopImage.hidden = YES;
    }
    
    if (offsetY == 0) {
        toTopImage.hidden = YES;
    }
    
}

-(void)ClickToScrollTopMethod:(UIGestureRecognizer *)sender{
    [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
}

@end
@interface FNHomeSecKillViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak)UIView *secKillMainView;
@property (nonatomic, weak) FNHSecKillScheduleToolView *scheduleToolView;
@property (nonatomic, strong)FNSecKillTitleView* sTitleView;
@property (nonatomic, weak)UICollectionView *mainCollectionView;
@property (nonatomic, strong)NSMutableArray *seckillProducts;
@property (nonatomic, strong)NSMutableDictionary* mainDatas;
@property (nonatomic, assign)NSInteger lastCount;
@property (nonatomic, assign)NSInteger currentCount;

@property (nonatomic, strong)FNSeckillHomeModel* model;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign) NSInteger remindPage;
@property (nonatomic, assign)NSInteger titleIndex;


@end

@implementation FNHomeSecKillViewController

CGPoint  _currentContentOffSet ;

#pragma mark - forcasted loading
- (NSMutableDictionary *)mainDatas{
    if (_mainDatas == nil) {
        _mainDatas = [NSMutableDictionary new];
    }
    return _mainDatas;
}
- (NSMutableArray *)seckillProducts
{
    if (_seckillProducts == nil) {
        _seckillProducts = [NSMutableArray new];
        
    }
    return _seckillProducts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self initializedSubviews];
    [self apiRequestHome];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - apiRequeset
- (void)apiRequestHome{
    [SVProgressHUD show];
    @WeakObj(self);
    [FNSeckillDataRequestTool secKillRequestForHomeWithParams:[NSMutableDictionary new] success:^(id respondsObject) {
        
            selfWeak.model = respondsObject;

            
            if (selfWeak.model.app_miaosha_time.count > 0) {
                [selfWeak.model.app_miaosha_time enumerateObjectsUsingBlock:^(App_Miaosha_Time * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj.str isEqualToString:@"疯抢中"]) {
                        selfWeak.titleIndex = idx;
                    }
                    [selfWeak.mainDatas setObject:[NSMutableArray new] forKey:@(idx)];
                }];
            }
            [selfWeak initializedSubviews];
            selfWeak.page = 1;

            [selfWeak apiRequestSeckillProduct];
        

    } failure:^(NSString *error) {

    } isHiddenTips:NO];
}
- (void)apiRequestSeckillProduct{
    @WeakObj(self);
    
    [FNSeckillDataRequestTool secKillRequestForProductsWithParams:[NSMutableDictionary dictionaryWithDictionary:@{@"time_":self.model.app_miaosha_time[_titleIndex].time,PageNumber:@(self.page),@"num":@20}] success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        
            NSMutableArray *array = selfWeak.mainDatas[@(selfWeak.titleIndex)];
            
            if (selfWeak.page == 1) {
                [array removeAllObjects];
            }
            
            [array addObjectsFromArray:respondsObject];
            [selfWeak.mainDatas setObject:array forKey:@(selfWeak.titleIndex)];
            
            [selfWeak.mainCollectionView reloadData];
        
        
    } failure:^(NSString *error) {
    
    } isHiddenTips:NO];
}

#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.automaticallyAdjustsScrollViewInsets = false;
    self.title  = @"今日必抢";
    //seckill view
    [self setUpSecKillMainView];

    
}
- (void)setUpSecKillMainView
{
    UIView *seckillView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, self.view.height)];
    [self.view addSubview:seckillView];
    _secKillMainView = seckillView;
    
    //schedule tool
    FNHSecKillScheduleToolView *scheduleToolView = [[FNHSecKillScheduleToolView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 44)];
    
    scheduleToolView.model = self.model;
    __weak typeof (self) selfWeak = self;
    scheduleToolView.clickedTimeAtIndex = ^(NSInteger index){
        selfWeak.titleIndex = index;
        selfWeak.page = 1;
//        [selfWeak.sTitleView setTitle:[NSString stringWithFormat:@"%@\t%@",selfWeak.model.app_miaosha_title,selfWeak.model.app_miaosha_title2] subTitle:selfWeak.model.app_miaosha_time[_titleIndex].str starTime:selfWeak.model.app_miaosha_time[_titleIndex].start_time andEndTime:selfWeak.model.app_miaosha_time[_titleIndex].end_time];
        [selfWeak.mainCollectionView setContentOffset:CGPointMake(index*FNDeviceWidth, 0) animated:YES];
        [SVProgressHUD show];
        [selfWeak apiRequestSeckillProduct];

    };
    [scheduleToolView selectedTimeAtIndex:_titleIndex];
    [self.secKillMainView addSubview:scheduleToolView];
    _scheduleToolView = scheduleToolView;
//    
//    _sTitleView = [[FNSecKillTitleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_scheduleToolView.frame), FNDeviceWidth, 44)];
//    [self.sTitleView setTitle:self.model.app_miaosha_title2 subTitle:self.model.app_miaosha_time[_titleIndex].str starTime:self.model.app_miaosha_time[_titleIndex].start_time andEndTime:self.model.app_miaosha_time[_titleIndex].end_time];
//    [self.secKillMainView addSubview:_sTitleView];

    
    //main collectionview
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_scheduleToolView.frame), FNDeviceWidth, self.secKillMainView.height-CGRectGetMaxY(_scheduleToolView.frame)) collectionViewLayout:flowLayout];
    mainCollectionView.bounces = NO;
    mainCollectionView.pagingEnabled = YES;
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    mainCollectionView.backgroundColor = [UIColor whiteColor];
    [mainCollectionView registerClass:[FNHomeSecKillViewCell class] forCellWithReuseIdentifier:@"FNHomeSecKillViewCell"];
    [self.secKillMainView addSubview:mainCollectionView];
    _mainCollectionView = mainCollectionView;
    
    [_mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_titleIndex inSection:0] atScrollPosition:(UICollectionViewScrollPositionNone) animated:YES];
   
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.app_miaosha_time.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = [NSMutableArray new];
    array = self.mainDatas[@(indexPath.item)];
    
    FNHomeSecKillViewCell *cell = [FNHomeSecKillViewCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    
    self.currentCount = array.count;
    if (self.lastCount == 0 || self.page==1 ) {
        self.lastCount = array.count;
        
        @WeakObj(self);
        if (self.lastCount >= _jm_pageszie) {
            cell.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                selfWeak.page ++;
                [SVProgressHUD show];
                [selfWeak apiRequestSeckillProduct];
            }];
        }else{
            cell.tableView.mj_footer = nil;
        }
    }else{
        if (self.currentCount-self.lastCount >= _jm_pageszie) {
            [cell.tableView.mj_footer endRefreshing];
        }else{
            [cell.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }

    cell.products = array;
    @WeakObj(self);
    cell.GoToDetailBlock = ^(FNHSecKillProudctModel *model){
        
        
        if (model.is_qiangguang.boolValue) {
            
            [FNTipsView showTips:@"商品太火爆了，已被抢光，赶紧看一下其他商品吧〜"];
        }else if (!model.is_start.boolValue){
            [FNTipsView showTips:@"商品还未开抢，请稍后再来~"];
        }
        else{
            selfWeak.navigationController.navigationBar.hidden = NO;
            //[selfWeak goToProductDetailsWithModel:model ToDetail:NO];
            [self goProductVCWithModel:model];
        }
        
    };
    cell.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.page = 1;
        [selfWeak apiRequestSeckillProduct];
    }];

    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(FNDeviceWidth, collectionView.height);
}
#pragma mark - Scroll view delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger contentOffsetX = _mainCollectionView.contentOffset.x;
    NSInteger currentIndex = contentOffsetX/FNDeviceWidth;
    if (_titleIndex == currentIndex) {
        return;
    }
    _titleIndex = currentIndex;
     [_scheduleToolView selectedTimeAtIndex:currentIndex];
    [self.sTitleView setTitle:self.model.app_miaosha_title2 subTitle:self.model.app_miaosha_time[_titleIndex].str starTime:self.model.app_miaosha_time[_titleIndex].start_time andEndTime:self.model.app_miaosha_time[_titleIndex].end_time];
    self.page = 1;
    [SVProgressHUD show];
    [self apiRequestSeckillProduct];
}

@end
