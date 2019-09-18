//
//  FNJDFeaturedListController.m
//  THB
//
//  Created by jimmy on 2017/5/24.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNJDFeaturedListController.h"
#import "FNJDFeaturedListCell.h"
#import "FNAPIHome.h"

@interface FNJDFeaturedListController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong)NSMutableArray<FNBaseProductModel *>* product;

@end

@implementation FNJDFeaturedListController
- (NSMutableArray<FNBaseProductModel *> *)product
{
    if (_product == nil) {
        _product = [NSMutableArray new];
    }
    return _product;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializedSubviews];
    [SVProgressHUD show];
    [self apiReqeustProduct];
    
    //注册通知
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(tongzhi:) name:@"SiftNoti" object:nil];
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
    self.price1 = [noti.userInfo objectForKey:@"minPrice"] ;
    self.price2 = [noti.userInfo objectForKey:@"maxPrice"];
    self.sort = [noti.userInfo objectForKey:@"sort"];
    NSString* ID = [noti.userInfo objectForKey:@"cid"];
    if ([self.cateID isEqualToString:ID]) {
        [SVProgressHUD show];
        [self apiReqeustProduct];
    }
    
    //    [self.collectionView setContentOffset:CGPointMake(0,0) animated:YES];
}
- (void)dealloc{
    [FNNotificationCenter removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - api request
- (void)apiReqeustProduct{
    NSArray* types = @[@"1",@"2",@"29"];
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":types[self.type],PageNumber:@(self.jm_page),PageSize:@(_jm_pro_pagesize)}];
    if (UserAccessToken) {
        params[TokenKey] = UserAccessToken;
    }
    if (self.cateID) {
        params[@"cid"] = self.cateID;
    }
    if (self.price1 && self.price2 && (!(self.price1.floatValue == 0 && self.price2.floatValue == 0))) {
        params[@"price1"] = self.price1;
        params[@"price2"] = self.price2;
    }
    if (self.searchTitle) {
        params[@"keyword"] = self.searchTitle;
    }
    if (self.sort) {
        params[@"sort"] = self.sort;
    }
    @WeakObj(self);
    [FNAPIHome apiHomeForProductsWithParams:params success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        NSArray* results = respondsObject;
        if (selfWeak.jm_page == 1) {
            if (results.count == 0) {
                [FNTipsView showTips:FNEmptyData];
            }
            [selfWeak.product removeAllObjects];
            [selfWeak.product addObjectsFromArray:results];
            if (results.count >= _jm_pro_pagesize) {
                selfWeak.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiReqeustProduct];
                }];
            } else {
                selfWeak.jm_collectionview.mj_footer = nil;
            }
        } else {
            [selfWeak.product addObjectsFromArray:results];
            if (results.count >= _jm_pro_pagesize) {
                [selfWeak.jm_collectionview.mj_footer endRefreshing];
            } else {
                [selfWeak.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        selfWeak.jm_collectionview.hidden = NO;
        [selfWeak.jm_collectionview reloadData];
        [selfWeak.jm_collectionview.mj_header endRefreshing];
    } failure:^(NSString *error) {
        selfWeak.jm_collectionview.hidden = NO;
        [selfWeak.jm_collectionview.mj_footer endRefreshing];
        [selfWeak.jm_collectionview.mj_header endRefreshing];
    } isHidden:NO];
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 5;
    flowlayout.minimumInteritemSpacing = 5;
    flowlayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.hidden = YES;
    self.jm_collectionview.backgroundColor = FNWhiteColor;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNJDFeaturedListCell class] forCellWithReuseIdentifier:@"FNJDFeaturedListCell"];
    [self.jm_collectionview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.jm_collectionview autoSetDimension:(ALDimensionHeight) toSize:FNDeviceHeight-64-35];
    self.jm_collectionview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    @WeakObj(self);
    self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.jm_page = 1;
        [selfWeak apiReqeustProduct];
    }];
}
#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.product.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNJDFeaturedListCell* cell = [FNJDFeaturedListCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    cell.model = self.product[indexPath.item];
    return cell;
}

#pragma mark - Collection view delegate && flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger width = floorf((FNDeviceWidth-_jm_leftMargin)*0.5);
    CGSize size = CGSizeMake(width, width + _jm_margin10*2.5 + 15*2);
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.product[indexPath.item].fnuo_url = self.product[indexPath.item].jd_url;
    [self goToProductDetailsWithModel:self.product[indexPath.item]];
}

@end
