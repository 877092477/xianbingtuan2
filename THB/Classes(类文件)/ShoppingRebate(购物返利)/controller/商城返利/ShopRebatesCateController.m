//
//  ShopRebatesCateController.m
//  THB
//
//  Created by Weller Zhao on 2018/12/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "ShopRebatesCateController.h"
#import "ShopRebatesCell.h"
#import "ShopRebatesModel.h"
#import "StoreWebViewController.h"

@interface ShopRebatesCateController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray<ShopRebatesModel*> *stores;

@end

@implementation ShopRebatesCateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stores = [[NSMutableArray alloc] init];
    
    [self configUI];
    self.jm_page = 1;
    [self apiRequestDatas];
}

- (void)configUI {
    UICollectionViewFlowLayout* flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.itemSize = CGSizeMake(XYScreenWidth / 4, XYScreenWidth / 4 + 30);
    
    self.jm_collectionview = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.dataSource = self;
    [self.jm_collectionview registerClass:[ShopRebatesCell class] forCellWithReuseIdentifier:@"ShopRebatesCell"];
    self.jm_collectionview.backgroundColor = FNHomeBackgroundColor;
    @weakify(self);
    self.jm_collectionview.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self apiRequestDatas];
    }];
}

#pragma mark - Network

- (FNRequestTool*)apiRequestDatas{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, typeKey: self.storeType, @"cid": self.cateId, @"p": @(self.jm_page)}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_rebate_store&ctrl=index" respondType:ResponseTypeArray modelType:@"ShopRebatesModel" success:^(id respondsObject) {
        @strongify(self);
        NSArray *array = respondsObject;
        if (self.jm_page == 1)
            [self.stores removeAllObjects];
        if (array.count > 0)
            self.jm_page ++;
        [self.stores addObjectsFromArray:array];
        [self.jm_collectionview reloadData];
        [self.jm_collectionview.mj_footer endRefreshing];
        [self.jm_collectionview.mj_header endRefreshing];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
    
}
#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.stores.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShopRebatesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopRebatesCell" forIndexPath:indexPath];
    ShopRebatesModel *model = self.stores[indexPath.row];
    [cell.imgHeader sd_setImageWithURL:URL(model.logo)];
    cell.lblTitle.text = model.name;
    cell.lblDesc.text = model.str;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ShopRebatesModel *model = self.stores[indexPath.row];
//    [self goProductVCWithModel:model];
//    [self goWebDetailWithWebType:@"0" URL:model.url];
    StoreWebViewController *web = [StoreWebViewController new];
    web.url = model.url;
    [self.navigationController pushViewController:web animated:YES];
}
@end
