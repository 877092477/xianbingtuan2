//
//  FNStoreLocationRedpackStoreListController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/23.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreLocationRedpackStoreListController.h"
#import "FNrushNoGoodsNeCell.h"
#import "FNshopTendStoreDoubleRowNeCell.h"
#import "FNNewStoreDetailController.h"

@interface FNStoreLocationRedpackStoreListController()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FNStoreLocationRedpackStoreListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] init];
    
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing=0;
    flowayout.minimumInteritemSpacing=0;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowayout];

    [self.jm_collectionview registerClass:[FNshopTendStoreDoubleRowNeCell class] forCellWithReuseIdentifier:@"FNshopTendStoreDoubleRowNeCell"];
    [self.jm_collectionview registerClass:[FNrushNoGoodsNeCell class] forCellWithReuseIdentifier:@"rushNoGoodsNeCellID"];
    

    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.delegate=self;
    self.jm_collectionview.dataSource=self;
    self.jm_collectionview.backgroundColor=FNWhiteColor;
    
    //    self.jm_collectionview.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview:self.jm_collectionview];

    [self.jm_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.equalTo(@0);
        make.edges.equalTo(@0);
    }];
//    self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        self.jm_page=1;
//        //[self apiRequestRebateStoreList];
//        [self apiRequestRebateStoreList ];
//    }];
    
    [self apiRequestRebateStoreList];
    
}

#pragma - mark Networking

//获取小店首页数据
- (FNRequestTool *)apiRequestRebateStoreList{
    
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"p":@(self.jm_page),@"keyword":@""}];

    if([self.latitude kr_isNotEmpty]){
        params[@"lat"]=self.latitude;
    }
    if([self.longitude kr_isNotEmpty]){
        params[@"lng"]=self.longitude;
    }
    if([_cate_id kr_isNotEmpty]){
        params[@"cid"]=_cate_id;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_store&ctrl=store_list" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"小店列表:%@",respondsObject);
        NSArray* arrM = respondsObject[DataKey];
        NSMutableArray *arrList=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dittry in arrM) {
            [arrList addObject:dittry];
        }
        if (selfWeak.jm_page == 1) {
            if (arrList.count == 0) {
                //[SVProgressHUD showInfoWithStatus:@"很抱歉，没有找到该类产品~"];
                //return ;
            }
            [selfWeak.dataArray removeAllObjects];
            [selfWeak.dataArray addObjectsFromArray:arrList];
            if (arrList.count >= _jm_pro_pagesize) {
                selfWeak.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiRequestRebateStoreList];
                }];
            }else{
                selfWeak.jm_collectionview.mj_footer = nil;
            }
        } else {
            [selfWeak.dataArray addObjectsFromArray:arrList];
            if (arrList.count >= _jm_pro_pagesize) {
                [selfWeak.jm_collectionview.mj_footer endRefreshing];
            }else{
                [selfWeak.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [selfWeak.jm_collectionview.mj_footer endRefreshing];
        [selfWeak.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}


#pragma mark UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if(self.dataArray.count>0){
        //FNrushNoGoodsNeCell
        return self.dataArray.count;
    }else{
        return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if(self.dataArray.count>0){

        FNshopTendStoreDoubleRowNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNshopTendStoreDoubleRowNeCell" forIndexPath:indexPath];
        cell.dicModel=self.dataArray[indexPath.row];
        [cell setIsLeft: indexPath.row % 2 == 0];
        return cell;
    }else{
        FNrushNoGoodsNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rushNoGoodsNeCellID" forIndexPath:indexPath];
        cell.backgroundColor=RGB(246, 246, 246);
        return cell;
    }

}
#pragma mark - collectionView delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.dataArray.count>0){
        int w = FNDeviceWidth / 2;
        if (indexPath.row % 2 == 1)
            w = FNDeviceWidth - w;
        return CGSizeMake(w, 240);
    }else{
        return CGSizeMake(FNDeviceWidth, 270);
    }
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return [[UIView alloc] init];
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{

    return CGSizeMake(0, 0);

}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count > 0) {
        FNStoreThendNeModel *model=[FNStoreThendNeModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
        //        FNstorePaveNeController *vc=[[FNstorePaveNeController alloc]init];
        FNNewStoreDetailController *vc = [[FNNewStoreDetailController alloc] init];
        vc.storeID=model.id;
        vc.storeName=model.name;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
