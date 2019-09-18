//
//  FNshopTendListNeController.m
//  69橙子
//
//  Created by Jimmy on 2018/12/7.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNshopTendListNeController.h"

//view
#import "FNshopTendStoreRowNeCell.h"
#import "FNrushNoGoodsNeCell.h"

//controller
#import "FNstorePaveNeController.h"
#import "FNNewStoreDetailController.h"

@interface FNshopTendListNeController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/** 店铺数据数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation FNshopTendListNeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.title=@"店铺";
    if([self.catename kr_isNotEmpty]){
        self.title=self.catename;
    }
    [self apiRequestRebateStoreList];
    //[self shopListView];
}

- (void)jm_setupViews{
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing=0;
    flowayout.minimumInteritemSpacing=0;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowayout];
    //self.jm_collectionview.hidden=YES;
    [self.jm_collectionview registerClass:[FNshopTendStoreRowNeCell class] forCellWithReuseIdentifier:@"shopTendStoreRowNeCellID"];
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.delegate=self;
    self.jm_collectionview.dataSource=self;
    self.jm_collectionview.backgroundColor=FNWhiteColor;
    //self.jm_collectionview.emptyDataSetDelegate = self;
    //self.jm_collectionview.emptyDataSetSource = self;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNrushNoGoodsNeCell class] forCellWithReuseIdentifier:@"rushNoGoodsNeCellID"];
    
    [self.jm_collectionview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, 0, 0, 0))];
    self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.jm_page=1;
        
        [self apiRequestRebateStoreList];
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(self.dataArray.count>0){
       return self.dataArray.count;
    }else{
       return 1;
    }
    
   
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(self.dataArray.count>0){
        FNshopTendStoreRowNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopTendStoreRowNeCellID" forIndexPath:indexPath];
        cell.dicModel=self.dataArray[indexPath.row];
        return cell;
    }
    else{
        FNrushNoGoodsNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rushNoGoodsNeCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        return cell;
    }
   
}
#pragma mark - collectionView delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   if(self.dataArray.count>0){
    return CGSizeMake(FNDeviceWidth, 110);
   }
   else{
    return CGSizeMake(FNDeviceWidth, 300);
   }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    FNStoreThendNeModel *model=[FNStoreThendNeModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    FNNewStoreDetailController *vc=[[FNNewStoreDetailController alloc]init];
    vc.storeID=model.id;
    vc.storeName=model.name;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//获取小店首页数据
- (FNRequestTool *)apiRequestRebateStoreList{
    [self.jm_collectionview.mj_footer endRefreshing];
    [self.jm_collectionview.mj_header endRefreshing];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"p":@(self.jm_page),@"city_id":@"",@"keyword":@"",@"lat":@"",@"lng":@""}];
    if([self.shopType kr_isNotEmpty]){
        params[@"cid"]=self.shopType;
    }
    if([self.city_id kr_isNotEmpty]){
        params[@"city_id"]=self.city_id;
    }
    if([self.latitude kr_isNotEmpty]){
        params[@"lat"]=self.latitude;
    }
    if([self.longitude kr_isNotEmpty]){
        params[@"lng"]=self.longitude;
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
                return ;
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
        self.jm_collectionview.hidden=NO;
        [selfWeak.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
