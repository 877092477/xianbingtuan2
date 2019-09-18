//
//  FNDetailShopController.m
//  THB
//
//  Created by Jimmy on 2017/12/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNDetailShopController.h"
#import "FNNPDShopHeader.h"
#import "FNHomeSpecialCCell.h"
#import "FNNewProductDetailModel.h"
#import "FNHomeProductCell.h"
@interface FNDetailShopController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIWebViewDelegate>
@property (nonatomic, strong)FNNPDShopHeader* header;
@property (nonatomic, strong)NSMutableArray* products;
@end

@implementation FNDetailShopController{
    NSString *shopUrl;
}
- (NSMutableArray *)products{
    if (_products == nil) {
        _products = [NSMutableArray new];
    }
    return _products;
}
- (FNNPDShopHeader *)header{
    if (_header == nil) {
        _header = [[FNNPDShopHeader alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 0))];
        _header.searchbtn.hidden = YES;
    }
    return _header;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.model.shop_title;
    
    [SVProgressHUD show];
    /*UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectZero];
    webView.scrollView.scrollEnabled=YES;
    webView.backgroundColor = [UIColor clearColor];
    webView.delegate = self;
    [self.view addSubview:webView];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.model.shop_url]];
    [webView loadRequest:request];*/
    shopUrl=self.f_shopurl;
    self.jm_page = 1;
    [self requestMain];
    //[self jm_setupViews];
}

#pragma mark -UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    shopUrl=webView.request.URL.absoluteString;
    XYLog(@"shopUrl:%@",shopUrl);
    XYLog(@"absoluteString:%@",webView.request.URL.absoluteString);
    if ([shopUrl containsString:@"m.tmall.com"] || [shopUrl containsString:@"m.taobao.com"]) {
        self.jm_page = 1;
        [self requestMain];
        return NO;
    }
    return YES;
}

- (void)jm_setupViews{
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.headerReferenceSize = CGSizeMake(JMScreenWidth, 100);
    
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 0)) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor = FNHomeBackgroundColor;
//    self.jm_collectionview.alpha = 0;
    self.jm_collectionview.dataSource =self;
    self.jm_collectionview.delegate =self;
    self.jm_collectionview.emptyDataSetSource = self;
    self.jm_collectionview.emptyDataSetDelegate = self;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNHomeProductCell class] forCellWithReuseIdentifier:@"HomeViewGoodsCell"];
    [self.jm_collectionview registerClass:[FNHomeSpecialCCell class] forCellWithReuseIdentifier:@"FNHomeSpecialCCell"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"topheader"];
    [self.jm_collectionview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.jm_page = 1;
        [self requestMain];
    }];
}
#pragma mark - request
- (void)requestMain{
    [FNRequestTool startWithRequests:@[[self requestShop],[self requestProduct:YES]] withFinishedBlock:^(NSArray *erros) {
        [SVProgressHUD dismiss];
        self.header.model=self.model;
        @weakify(self);
        self.header.returnHeight = ^(CGFloat height) {
            @strongify(self);
            [self.jm_collectionview reloadData];
//            [UIView animateWithDuration:0.3 animations:^{
//                self.jm_collectionview.alpha = 1;
//                [self.jm_collectionview reloadData];
//            }];
                            [self.jm_collectionview reloadData];

        };
//        [UIView animateWithDuration:0.3 animations:^{
//            self.jm_collectionview.alpha = 1;
//            [self.jm_collectionview reloadData];
//        }];
                    [self.jm_collectionview reloadData];
    }];
}
- (FNRequestTool *)requestShop{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"fnuo_id":self.fnuo_id,@"url":shopUrl}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=getshopdetail&ctrl=getscore" respondType:(ResponseTypeArray) modelType:@"JM_NPD_fs" success:^(id respondsObject) {
        //
        self.model.fs = respondsObject;
    } failure:^(NSString *error) {
        //
        XYLog(@"shopError:%@",error);
        [self requestMain];
    } isHideTips:YES];
}
- (FNRequestTool *)requestProduct:(BOOL)flag{
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"p":@(self.jm_page),@"keyword":self.model.shop_title,@"fnuo_id":self.fnuo_id,@"url":shopUrl}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=getshopdetail&ctrl=index" respondType:(ResponseTypeArray) modelType:@"FNBaseProductModel" success:^(NSArray* respondsObject) {
        //
        if (self.jm_page == 1) {
            [self.products removeAllObjects];
            [self.products addObjectsFromArray:respondsObject];
            [self.jm_collectionview.mj_header endRefreshing];
            if (respondsObject.count>=_jm_pageszie) {
                self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.jm_page ++;
                    [self requestProduct:NO];
                }];
            }else{
                self.jm_collectionview.mj_footer = nil;
            }
        }else{
            [self.products addObjectsFromArray:respondsObject];
            if (respondsObject.count>=_jm_pageszie) {
                [self.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        //
        XYLog(@"shopError:%@",error);
        [self requestMain];
        [self.jm_collectionview.mj_footer endRefreshing];
        [self.jm_collectionview.mj_header endRefreshing];
    } isHideTips:YES];
}
#pragma mark - collection data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.products.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //FNHomeSpecialCCell* cell = [FNHomeSpecialCCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    //cell.model = self.products[indexPath.item];
    //return cell;
    FNHomeProductCell *cell = [FNHomeProductCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    cell.model =self.products[indexPath.item];
//    cell.backgroundColor=[UIColor whiteColor];
    [cell setIsLeft: indexPath.row % 2 == 0];
    cell.borderColor = FNGlobalTextGrayColor;
    cell.clipsToBounds = YES;
    cell.sharerightNow = ^(FNBaseProductModel *mod) {
        [self shareProductWithModel:mod];
    };
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView* reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"topheader" forIndexPath:indexPath];
    if (reusableview.subviews.count>=1) {
        [reusableview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [reusableview addSubview:self.header];
    return reusableview;
}
#pragma mark - collection flowlayout delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.header.width, self.header.height+1);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeZero;
    CGFloat width = (JMScreenWidth-15)*0.5;
    CGFloat height = width+ _hscc_btm_h + 34 +30;
    size = CGSizeMake(width, height);
    return size;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets insets =  UIEdgeInsetsMake(0, 5, 5, 5);
    return insets;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self goProductVCWithModel:self.products[indexPath.item]];
}
@end
