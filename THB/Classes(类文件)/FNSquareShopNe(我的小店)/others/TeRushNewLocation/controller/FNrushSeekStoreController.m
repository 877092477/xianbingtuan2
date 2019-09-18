//
//  FNrushSeekStoreController.m
//  每选
//
//  Created by Jimmy on 2018/12/11.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNrushSeekStoreController.h"
//view
#import "FNshopTendStoreRowNeCell.h"
#import "FNCustomeNavigationBar.h"
//controller
#import "FNstorePaveNeController.h"
#import "FNNewStoreDetailController.h"
@interface FNrushSeekStoreController ()<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate>
/** 店铺数据数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong)FNCustomeNavigationBar* cuNaivgationbar;
@end

@implementation FNrushSeekStoreController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpCustomizedNaviBar];
    [self shopListView];
}
#pragma mark - initializedNavBar 导航栏
- (void)setUpCustomizedNaviBar{
    
    _cuNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithSearchBarFrame:(CGRectMake(80, 27, FNDeviceWidth-80*2, 30)) andPlaceholder:@"搜索附近的商家"];
    _cuNaivgationbar.searchBar.cornerRadius = 5;
    _cuNaivgationbar.searchBar.backgroundImage = [UIImage createImageWithColor:RGB(240, 240, 240)];
    _cuNaivgationbar.searchBar.delegate  =self;
    UITextField *searchField = [_cuNaivgationbar.searchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor clearColor]];
    }
    
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSFontAttributeName: kFONT14}];
    
    
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backBtn setImage:[UIImage imageNamed:@"details_cion_back"] forState:UIControlStateNormal];
    
    [backBtn sizeToFit];
    backBtn.size = CGSizeMake(backBtn.width+10, backBtn.height+10);
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *seekBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //[seekBtn setImage:[UIImage imageNamed:@"home_new"] forState:UIControlStateNormal];
    [seekBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [seekBtn setTitleColor:RGB(47, 140, 255) forState:UIControlStateNormal];
    seekBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [seekBtn sizeToFit];
    seekBtn.size = CGSizeMake(seekBtn.width+10, seekBtn.height+10);
    [seekBtn addTarget:self action:@selector(seekBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _cuNaivgationbar.leftButton = backBtn;
    _cuNaivgationbar.rightButton = seekBtn;
    _cuNaivgationbar.backgroundColor =[UIColor whiteColor];
  
    [self.view addSubview:_cuNaivgationbar];
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)seekBtnAction{
    XYLog(@"搜索:%@",_cuNaivgationbar.searchBar.text);
    [self apiRequestRebateStoreList];
}
#pragma mark - UISearchBarDelegate
//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//
//    return NO;
//}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [_cuNaivgationbar.searchBar resignFirstResponder];
    
    if(_cuNaivgationbar.searchBar.text.length == 0) {
        return;
    }
    [self apiRequestRebateStoreList];
    
}
-(void)shopListView{
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing=0;
    flowayout.minimumInteritemSpacing=0;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowayout];
    self.jm_collectionview.hidden=YES;
    [self.jm_collectionview registerClass:[FNshopTendStoreRowNeCell class] forCellWithReuseIdentifier:@"shopTendStoreRowNeCellID"];
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.delegate=self;
    self.jm_collectionview.dataSource=self;
    self.jm_collectionview.backgroundColor=FNWhiteColor;
    [self.view addSubview:self.jm_collectionview];
    self.jm_collectionview.sd_layout
    .topSpaceToView(self.cuNaivgationbar, 1).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
    self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.jm_page=1;
        [self apiRequestRebateStoreList];
    }];
    self.view.backgroundColor=RGB(240, 240, 240);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FNshopTendStoreRowNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopTendStoreRowNeCellID" forIndexPath:indexPath];
    cell.dicModel=self.dataArray[indexPath.row];
    return cell;
    
}
#pragma mark - collectionView delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(FNDeviceWidth, 110);
    
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
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"p":@(self.jm_page),@"cid":@""}];
    if([self.city_id kr_isNotEmpty]){
        params[@"city_id"]=self.city_id;
    }
    if([self.latitude kr_isNotEmpty]){
        params[@"lat"]=self.latitude;
    }
    if([self.longitude kr_isNotEmpty]){
        params[@"lng"]=self.longitude;
    }
    if([_cuNaivgationbar.searchBar.text kr_isNotEmpty]){
        params[@"keyword"]=_cuNaivgationbar.searchBar.text;
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
