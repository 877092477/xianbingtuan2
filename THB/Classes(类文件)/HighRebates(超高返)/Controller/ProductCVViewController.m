//
//  ProductCVViewController.m
//  THB
//
//  Created by zhongxueyu on 16/3/21.
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

#import "ProductCVViewController.h"
#import "FNBaseProductModel.h"
#import "JMHomeProductCell.h"
#import "FNAPIHome.h"
#import "FNHomeSpecialCell.h"
#import "FNHomeProductSingleRowCell.h"

@interface ProductCVViewController ()<UITableViewDataSource,UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong)   UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;

/** 店铺列表数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 页数 */
@property (nonatomic, assign) int page;

/** 是否是筛选 */
@property (nonatomic,assign) int fromSift;

/** 判断跳到详情 */
@property (nonatomic,assign) int toDetails;

@property (nonatomic, strong)UIImageView* toTopImage;


@end
static NSString * const reuseIdentifier = @"RebatesCell";
@implementation ProductCVViewController
@synthesize toTopImage;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  
    self.searchTitle = [[NSString alloc]init];


    //注册通知
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(tongzhi:) name:@"SiftNoti" object:nil];
    
    [self CategoryTableView];
    self.page = 1;
    [SVProgressHUD show];
    [self apiRequestProduct];
    
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
    NSString* ID = [noti.userInfo objectForKey:@"cid"];
    if ([NSString checkIsSuccess:self.categoryId andElement:ID]) {
        [SVProgressHUD show];
        [self apiRequestProduct];
    }

    //    [self.collectionView setContentOffset:CGPointMake(0,0) animated:YES];
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//获取产品
- (FNAPIHome *)apiRequestProduct{
    if (self.sort.integerValue == 0) {
        self.sort = @1;
    }
    if (self.type == 0) {
        self.type =1;
    }
    NSInteger pagesize = 6;
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"sort":self.sort,
                                   @"time":[NSString GetNowTimes],
                                   @"type":self.skipUIIdentifier,
                                   @"p":[NSNumber numberWithInt:self.page],
                                   @"price1":[NSNumber numberWithInt:self.price1],
                                   @"price2":[NSNumber numberWithInt:self.price2],
                                   @"keyword":self.searchTitle,
                                   @"token":UserAccessToken,
                                   @"is_new_app":@"1",
                                   PageSize:@(pagesize)}];
    if (self.categoryId) {
        params[@"cid"] = self.categoryId;
    }
    return [FNAPIHome apiHomeForProductsWithParams:params success:^(id respondsObject) {
        
        NSArray* array = respondsObject;
        if (selfWeak.page == 1) {
            if (array.count == 0) {
                [selfWeak.jm_collectionview.mj_footer endRefreshing];
                [FNTipsView showTips:@"很抱歉，没有找到该类产品~"];
                return ;
            }
            [selfWeak.dataArray removeAllObjects];
            [selfWeak.dataArray addObjectsFromArray:respondsObject];
            if (array.count >= pagesize) {
                selfWeak.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.page ++;
                    [selfWeak apiRequestProduct];
                }];
            }else{
                selfWeak.jm_collectionview.mj_footer = nil;
            }
            
        } else {
            [selfWeak.dataArray addObjectsFromArray:respondsObject];
            if (array.count >= pagesize) {
                [selfWeak.jm_collectionview.mj_footer endRefreshing];
            }else{
                [selfWeak.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [selfWeak.jm_collectionview.mj_header endRefreshing];
        selfWeak.jm_collectionview.hidden = NO;
        
        [selfWeak.jm_collectionview reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
        selfWeak.jm_collectionview.hidden = NO;
        [selfWeak.jm_collectionview.mj_footer endRefreshing];
        [selfWeak.jm_collectionview.mj_header endRefreshing];
        [selfWeak apiRequestProduct];
    } isHidden:YES];
}
#pragma mark - initializedSubviews
//- (void)initializedSubviews
//{
//    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, self.fromHome? XYScreenHeight-XYTabBarHeight-35:XYScreenHeight-JMNavBarHeigth-35)) style:(UITableViewStylePlain)];
//    self.jm_tableview.dataSource = self;
//    self.jm_tableview.delegate = self;
//    self.jm_tableview.hidden = YES;
//    [self.jm_tableview removeEmptyCellRows];
//    [self.view addSubview:self.jm_tableview];
//
//
//    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom) ];
//    [self.jm_tableview autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
//    self.jm_tableview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//    @WeakObj(self);
//    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        selfWeak.page = 1;
//        [selfWeak apiRequestProduct];
//    }];
//
//    toTopImage = [[UIImageView alloc]initWithFrame:CGRectMake(XYScreenWidth-65, XYScreenHeight-XYTabBarHeight-60, 47, 47)];
//    toTopImage.image = IMAGE(@"hddb");
//    [toTopImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickToScrollTopMethod:)]];
//    [self.view addSubview:toTopImage];
//    toTopImage.userInteractionEnabled = YES;
//    toTopImage.hidden = YES;
//
//    [toTopImage autoSetDimensionsToSize:(CGSizeMake(47, 47))];
//    [toTopImage autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15];
//
//    [toTopImage autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.jm_tableview withOffset:-20];
//    [self.view bringSubviewToFront:toTopImage];
//}
//#pragma mark - Table view data source
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArray.count;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [JMCellTool tableView:tableView atIndexPath:indexPath superVC:self andModel:self.dataArray[indexPath.row]];
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return [UIView new];
//}
//#pragma mark - Table view delegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat height = [JMCellTool cellHeightTableview:tableView atIndexPath:indexPath andModel:self.dataArray[indexPath.row]];
//    return height;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.01;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.dataArray.count>0) {
//
//        FNBaseProductModel *model = self.dataArray[indexPath.row];
//        if (model.is_qiangguang.boolValue) {
//
//            [FNTipsView showTips:@"商品太火爆了，已被抢光，赶紧看一下其他商品吧〜"];
//        }else{
//
//            [self goProductVCWithModel:model];
//        }
//
//    }
//
//}

#pragma mark - 单元
-(void)CategoryTableView{
    
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing=2.0f;
    flowlayout.minimumInteritemSpacing=0.0f;
    flowlayout.headerReferenceSize = CGSizeMake(XYScreenWidth, 88);
    flowlayout.footerReferenceSize = CGSizeZero;
    if (@available(iOS 9.0, *)) {
        flowlayout.sectionHeadersPinToVisibleBounds = YES;
    }
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:(CGRectZero) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(246, 246, 246);
    self.jm_collectionview.showsHorizontalScrollIndicator = NO;
    self.jm_collectionview.showsVerticalScrollIndicator = NO;
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    [self.jm_collectionview registerClass:[FNHomeProductSingleRowCell class] forCellWithReuseIdentifier:@"HomeViewGoodsSingleCell"];
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    
    @WeakObj(self);
    // 下拉刷新
    self.jm_collectionview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.jm_page = 1;
        [selfWeak apiRequestProduct];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.jm_collectionview.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉加载
    self.jm_collectionview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        selfWeak.jm_page += 1;
        [selfWeak apiRequestProduct];
    }];
    
    //    _voryView=[[UIView alloc]init];
    //    _voryView.frame=CGRectMake(0, 0, FNDeviceWidth, 200);
    //    self.jm_tableview.sectionHeaderHeight=40;
    
}



#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

        FNBaseProductModel *model = self.dataArray[indexPath.row];
    
        FNHomeProductSingleRowCell *cell = [FNHomeProductSingleRowCell cellWithCollectionView:collectionView atIndexPath:indexPath];
        cell.model = model;
        cell.backgroundColor=[UIColor whiteColor];
        cell.sharerightNow = ^(FNBaseProductModel *mod) {
            [self shareProductWithModel:mod];
        };
        cell.clipsToBounds = YES;
        return cell;

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(FNDeviceWidth,  140);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2, 0, 2, 0);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count>0) {

        FNBaseProductModel *model = self.dataArray[indexPath.row];
        if (model.is_qiangguang.boolValue) {

            [FNTipsView showTips:@"商品太火爆了，已被抢光，赶紧看一下其他商品吧〜"];
        }else{

            [self goProductVCWithModel:model withData:model.data];
        }

    }
}

// 设置Footer的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(XYScreenWidth, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(XYScreenWidth, 0);
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
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
    [self.jm_tableview setContentOffset:CGPointMake(0,0) animated:YES];
}

@end
