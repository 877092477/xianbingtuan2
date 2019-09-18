//
//  FNBrandSaleListController.m
//  THB
//
//  Created by jimmy on 2017/5/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNBrandSaleListController.h"
#import "FNBrandDetailController.h"

#import "FNBrandShopCell.h"
#import "FNAPIHome.h"
#import "FNBrandShopModel.h"

@interface FNBrandSaleListController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray<FNBrandShopModel*>*  shops;
@property (nonatomic, strong)UIImageView* toTopImage;
@end

@implementation FNBrandSaleListController
@synthesize toTopImage;
#pragma mark - Forcasted Loading......
- (NSMutableArray<FNBrandShopModel*> *)shops
{
    if (_shops == nil) {
        _shops = [NSMutableArray new];
    }
    return _shops;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [SVProgressHUD show];
    [self apiRequestShoplist];
    [self initializedSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.hidden = YES;
    self.jm_tableview.clipsToBounds = YES;
    [self.jm_tableview removeEmptyCellRows];
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) ];
//    [self.jm_tableview autoSetDimension:(ALDimensionHeight) toSize:FNDeviceHeight-99];
    @WeakObj(self);
    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.jm_page = 1;
        [selfWeak apiRequestShoplist].CompleteBlock = ^(NSString *error) {
            [selfWeak.jm_tableview.mj_header endRefreshing];
        };
    }];
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    toTopImage = [[UIImageView alloc]initWithFrame:CGRectMake(XYScreenWidth-65, XYScreenHeight-XYTabBarHeight-60, 47, 47)];
    toTopImage.image = IMAGE(@"hddb");
    [toTopImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickToScrollTopMethod:)]];
    [self.view addSubview:toTopImage];
    toTopImage.userInteractionEnabled = YES;
    toTopImage.hidden = YES;
    
    [toTopImage autoSetDimensionsToSize:(CGSizeMake(47, 47))];
    [toTopImage autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15];
    //    [toTopImage autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:XYTabBarHeight+15 + 20];
    [toTopImage autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.jm_tableview withOffset:-20];
    [self.view bringSubviewToFront:toTopImage];
}
#pragma mark - api request
- (FNAPIHome *)apiRequestShoplist{
    @WeakObj(self);
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"sort":@1,@"goodslist":@"1",@"cid":_cateID,PageNumber:@(self.jm_page)}];
    return [FNAPIHome apiBrandForStoreListWithParams:params success:^(id respondsObject) {
        //
        [SVProgressHUD dismiss];
        NSArray* result = respondsObject;
        if (selfWeak.jm_page == 1) {
            [selfWeak.shops removeAllObjects];
            [selfWeak.shops addObjectsFromArray:result];
            if (result.count >= _jm_pageszie) {
                selfWeak.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiRequestShoplist];
                }];
            } else {
                selfWeak.jm_tableview.mj_footer = nil;
            }
        } else {
            [selfWeak.shops addObjectsFromArray:result];
            if (result.count >= _jm_pageszie) {
                [selfWeak.jm_tableview.mj_footer endRefreshing];
            } else {
                [selfWeak.jm_tableview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        selfWeak.jm_tableview.hidden = NO;
        [selfWeak.jm_tableview reloadData];
    } failure:^(NSString *error) { 
        //
        [selfWeak.jm_tableview.mj_footer endRefreshing];
        if (error) {
            [FNTipsView showTips:error];
        }
        if (selfWeak.shops.count==0) {
            [self apiRequestShoplist];
        }
        
    } isHidden:NO];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.shops.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNBrandShopCell* cell = [FNBrandShopCell cellWithTableView:tableView atIndexPath:indexPath];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = self.shops[indexPath.section].goodsH + 0.35*FNDeviceWidth;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(FNBrandShopCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.model = self.shops[indexPath.section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FNBrandDetailController* detail = [FNBrandDetailController new];
    detail.model = self.shops[indexPath.section];
    detail.dp_type = @"1";
    [self.navigationController pushViewController:detail animated:YES];
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
    [self.jm_tableview setContentOffset:CGPointMake(0,0) animated:YES];
}
@end
