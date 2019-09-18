//
//  FNDefiniteStoreNeController.m
//  THB
//
//  Created by Jimmy on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNDefiniteStoreNeController.h"
//controller
#import "FNdefineRecommendNeController.h"
#import "FNdefinConvertNeController.h"
#import "FNdefinHuntNeController.h"
#import "FNIntegralMallDetailController.h"
#import "FNShareViewController.h"
//model
#import "FNDefiniteStoreNeModel.h"
#import "Index_paomadeng_01Model.h"
//view
#import "FNdefinMsgDeCell.h"
#import "FNdefinBannerDeCell.h"
#import "FNAfficheDeCell.h"
#import "FNdefineRecommendCell.h"
#import "FNdefineBannerTwoCell.h"
#import "FNSortAnScreenDeCell.h"
#import "FNdefineCommodityCell.h"

@interface FNDefiniteStoreNeController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNdefinBannerDeCellDelegate,FNBannerTwoCellDelegate,FNSortAnScreenDeCellDelegate, FNdefineCommodityCellDelegate>
@property(nonatomic,strong) UIButton *backBtn;
@property(nonatomic,strong) UIButton * searchBtn;

@property(nonatomic,strong) NSMutableArray *productArr;
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) NSMutableArray *marqueeArray;
@property(nonatomic,strong) NSMutableArray *screenArray;
@property(nonatomic,strong) NSString       *cid;
@property(nonatomic,strong) NSString       *sort;
@property(nonatomic,assign) NSInteger       classifyInt;
@property(nonatomic,assign) NSInteger       sortPalce;
@end

@implementation FNDefiniteStoreNeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sort=@"zonghe";
    self.classifyInt=0;
    [self definiteStoreCollectionview];
    [self apiRequestDefiniteHome];
    [self apiRequstMarqueeData];
    [self apiRequstScreen];
    [self apiRequestProduct];
    [self DefiniteStoreNavView];
}
-(void)DefiniteStoreNavView{
    _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_backBtn setTitleColor:FNBlackColor forState:UIControlStateNormal];
    [_backBtn setTitle:@"积分商城" forState:UIControlStateNormal];
    _backBtn.titleLabel.font = kFONT14;
    [_backBtn sizeToFit];
    [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_backBtn];
    if(self.understand==YES){
        [_backBtn setImage:IMAGE(@"") forState:UIControlStateNormal];
    }else{
        [_backBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    }
    [_backBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5.0f];
    
    _searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.adjustsImageWhenHighlighted = NO;
    _searchBtn.backgroundColor=RGB(246, 245, 245);
    [_searchBtn sizeToFit];
    _searchBtn.titleLabel.font = kFONT12;
    [_searchBtn setImage:IMAGE(@"FJ_slices_img") forState:UIControlStateNormal];
    [_searchBtn setTitleColor:FNGlobalTextGrayColor forState:UIControlStateNormal];
    [_searchBtn setTitle:@"搜索您想要的商品" forState:UIControlStateNormal];
    [_searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView =_searchBtn;
     _searchBtn.cornerRadius=30/2;
    _searchBtn.sd_layout
    .heightIs(30).leftSpaceToView(_backBtn, 15).widthIs(JMScreenWidth-_backBtn.size.width-40);
    [_searchBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:8.0f];
    
}
-(void)backBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)searchBtnAction{
    FNdefinHuntNeController *vc=[[FNdefinHuntNeController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 主视图
-(void)definiteStoreCollectionview{
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight;
    if(self.understand==YES){
        tableHeight=FNDeviceHeight-SafeAreaTopHeight-XYTabBarHeight;
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 10;
    flowlayout.minimumInteritemSpacing = 10;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, tableHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.hidden=YES;
    [self.view addSubview:self.jm_collectionview];
   
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"DefiniteStore"];
    [self.jm_collectionview registerClass:[FNdefinMsgDeCell class] forCellWithReuseIdentifier:@"integral_top_01"];
    [self.jm_collectionview registerClass:[FNdefinBannerDeCell class] forCellWithReuseIdentifier:@"integral_banner_01"];
    [self.jm_collectionview registerClass:[FNAfficheDeCell class] forCellWithReuseIdentifier:@"integral_report_01"];
    [self.jm_collectionview registerClass:[FNdefineRecommendCell class] forCellWithReuseIdentifier:@"integral_ico_01"];
    [self.jm_collectionview registerClass:[FNdefineBannerTwoCell class] forCellWithReuseIdentifier:@"integral_guanggao_01"];
    [self.jm_collectionview registerClass:[FNSortAnScreenDeCell class] forCellWithReuseIdentifier:@"integral_goods_01"];
    [self.jm_collectionview registerClass:[FNdefineCommodityCell class] forCellWithReuseIdentifier:@"integral_commodity"];
    
    //self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //}];
    self.view.backgroundColor=RGB(240, 240, 240);
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FNDefiniteStoreNeModel *model=self.dataArray[section];
    NSString *type=model.type;
    if([type isEqualToString:@"integral_ico_01"]){
        return model.list.count;
    }else if([type isEqualToString:@"integral_commodity"]){
        return self.productArr.count;
    }
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNDefiniteStoreNeModel *model=self.dataArray[indexPath.section];
    NSString *type=model.type;
    if([type isEqualToString:@"integral_top_01"]){
        FNdefinMsgDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"integral_top_01" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.modelArr=model.list;
        cell.rightBtn.hidden=YES;
        [cell.rightBtn addTarget:self action:@selector(integralDetailAction)];
        return cell;
    }
    else if([type isEqualToString:@"integral_banner_01"]){
        FNdefinBannerDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"integral_banner_01" forIndexPath:indexPath];
        cell.delegate=self;
        cell.bannerArray=model.list;
        return cell;
    }
    else if([type isEqualToString:@"integral_report_01"]){
        FNAfficheDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"integral_report_01" forIndexPath:indexPath];
        cell.model=model;
        cell.marqueeArray=self.marqueeArray;
        return cell;
    }
    else if([type isEqualToString:@"integral_ico_01"]){
        FNdefineRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"integral_ico_01" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        NSArray *rapidArr=model.list;
        FNDefiniteListItemModel *model=[FNDefiniteListItemModel mj_objectWithKeyValues:rapidArr[indexPath.row]];
        cell.model=model;
        return cell;
    }
    else if([type isEqualToString:@"integral_guanggao_01"]){
        FNdefineBannerTwoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"integral_guanggao_01" forIndexPath:indexPath];
        cell.delegate=self;
        cell.backgroundColor=RGB(246, 245, 245);
        cell.bannerArray=model.list;
        return cell;
    }
    else if([type isEqualToString:@"integral_goods_01"]){
        FNSortAnScreenDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"integral_goods_01" forIndexPath:indexPath];
        cell.delegate=self;
        cell.sortArray=model.list;
        cell.screeningArray=self.screenArray;
        //cell.catePlace=self.classifyInt;
        cell.sortPalce=self.sortPalce;
        return cell;
    }
    else if([type isEqualToString:@"integral_commodity"]){
        FNdefineCommodityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"integral_commodity" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=[FNDefiniteProductModel mj_objectWithKeyValues:self.productArr[indexPath.row]];
        cell.delegate = self;
        return cell;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DefiniteStore" forIndexPath:indexPath];
  
    return cell;
    
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0; 
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=FNDeviceWidth;
    CGFloat high=0;
    FNDefiniteStoreNeModel *model=self.dataArray[indexPath.section];
    
    NSString *type=model.type;
    if([type isEqualToString:@"integral_top_01"]){
        with=FNDeviceWidth;
        high=35;
    }
    else if([type isEqualToString:@"integral_banner_01"]){
        if(model.list.count>0){
            FNDefiniteListItemModel *itemModel=[FNDefiniteListItemModel mj_objectWithKeyValues:model.list[0]];
            NSString *bannerBili=itemModel.banner_bili;
            CGFloat bannerOneHight;
            if([bannerBili kr_isNotEmpty]){
                bannerOneHight=[bannerBili floatValue] *FNDeviceWidth;
            }else{
                bannerOneHight=165;
            }
            
            high=bannerOneHight;
        }else{
            high=0.01;
        }
        with=FNDeviceWidth;
    }
    else if([type isEqualToString:@"integral_report_01"]){
        with=FNDeviceWidth;
        high=45;
    }
    else if([type isEqualToString:@"integral_ico_01"]){
        with=FNDeviceWidth/4;
        high=130;
    }
    else if([type isEqualToString:@"integral_guanggao_01"]){
        if(model.list.count>0){
           FNDefiniteListItemModel *itemModel=[FNDefiniteListItemModel mj_objectWithKeyValues:model.list[0]];
           NSString *bannerBili=itemModel.banner_bili;
           CGFloat bannerTwoHight;
           if([bannerBili kr_isNotEmpty]){
               bannerTwoHight=[bannerBili floatValue] *FNDeviceWidth +20;
           }else{
               bannerTwoHight=145;
           }
           high=bannerTwoHight;
        }else{
            high=0.01;
        }
        with=FNDeviceWidth; 
    }
    else if([type isEqualToString:@"integral_goods_01"]){
        with=FNDeviceWidth;
        high=70;
    }
    else if([type isEqualToString:@"integral_commodity"]){
        with=FNDeviceWidth;
        high=130;
    }
    CGSize size = CGSizeMake(with, high);
    return size;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNDefiniteStoreNeModel *model=self.dataArray[indexPath.section];
    NSString *type=model.type;
    if([type isEqualToString:@"integral_ico_01"]){
        NSArray *rapidArr=model.list;
        FNDefiniteListItemModel *itemModel=[FNDefiniteListItemModel mj_objectWithKeyValues:rapidArr[indexPath.row]];
        [self loadOtherVCWithModel:itemModel andInfo:nil outBlock:nil];
    }
    else if([type isEqualToString:@"integral_commodity"]){
        FNDefiniteProductModel *itemModel=[FNDefiniteProductModel mj_objectWithKeyValues:self.productArr[indexPath.row]];
        FNIntegralMallDetailController *vc = [FNIntegralMallDetailController new];
        vc.goodsId =itemModel.id;
        [self.navigationController pushViewController:vc animated:YES];
        //[self loadOtherVCWithModel:itemModel andInfo:nil outBlock:nil];
    }
}
#pragma mark -  // 积分明细
-(void)integralDetailAction{
    //XYLog(@"积分明细");
}
#pragma mark - //FNdefinBannerDeCellDegate // 点击轮播1
- (void)oddWelfBannerClick:(FNDefiniteListItemModel*)model{
    [self loadOtherVCWithModel:model andInfo:nil outBlock:nil];
}
#pragma mark - //FNBannerTwoCellDelegate // 点击轮播2
- (void)seletedBannerTwoClick:(FNDefiniteListItemModel*)model{
    [self loadOtherVCWithModel:model andInfo:nil outBlock:nil];
}
#pragma mark - //FNSortAnScreenDeCellDelegate // 点击分类
- (void)choiceClassifyIntegralClick:(NSString*)send withPlace:(NSInteger)place{
    self.classifyInt=place;
    self.cid=send;
    self.jm_page=1;
    [self apiRequestProduct];
}
// 点击排序
- (void)choiceRankIntegralClickWithPlace:(NSInteger)place WithState:(NSInteger)state{
    XYLog(@"位置:%ld 状态: %ld",(long)place,(long)state);
    self.sortPalce=place;
    FNDefiniteScreenModel *model=[FNDefiniteScreenModel mj_objectWithKeyValues:self.screenArray[place]];
    if(place>0){
       if(state==0){
          self.sort=model.up_sort;
       }else{
          self.sort=model.down_sort;
       }
    }else{
          self.sort=model.up_sort;
    }
    self.jm_page=1;
    [self apiRequestProduct];
}
#pragma mark - //积分商城首页
- (FNRequestTool *)apiRequestDefiniteHome{
    [SVProgressHUD show];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_integral&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSArray* arr = respondsObject[DataKey];
        //XYLog(@"积分商城首页:%@",arr);
        NSMutableArray *typeArr=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dictry in arr) {
            FNDefiniteStoreNeModel *model=[FNDefiniteStoreNeModel mj_objectWithKeyValues:dictry];
            [typeArr addObject:model];
            NSString *type=model.type;
            if([type isEqualToString:@"integral_top_01"]){
                id top = model.list.firstObject;
                if (top) {
                    [selfWeak.backBtn setTitle:top[@"str"] forState:UIControlStateNormal];
                    [selfWeak.searchBtn setTitle:top[@"str1"] forState:UIControlStateNormal];
                }
            }
        }
        selfWeak.dataArray=typeArr;
        FNDefiniteStoreNeModel *model=[[FNDefiniteStoreNeModel alloc]init];
        model.type=@"integral_commodity";
        [selfWeak.dataArray addObject:model]; 
        [SVProgressHUD dismiss];
        selfWeak.jm_collectionview.hidden=NO;
        [selfWeak.jm_collectionview reloadData];
        
        
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
//获取跑马灯
- (void)apiRequstMarqueeData{
    @WeakObj(self);
    NSMutableDictionary*params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_integral&ctrl=super_msg" respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        [self.marqueeArray removeAllObjects];
        for (NSDictionary *Dict in respondsObject) {
            Index_paomadeng_01Model *Model=[Index_paomadeng_01Model mj_objectWithKeyValues:Dict];
            [self.marqueeArray addObject:Model];
        }
        [selfWeak.jm_collectionview reloadData];
    } failure:^(NSString *error) {
    } isHideTips:YES];
}
//排序文字
- (void)apiRequstScreen{
    @WeakObj(self);
    NSMutableDictionary*params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_goods&ctrl=getsort" respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        for (NSDictionary *Dict in respondsObject) {
             [self.screenArray addObject:Dict];
        }
        [selfWeak.jm_collectionview reloadData];
    } failure:^(NSString *error) {
    } isHideTips:YES];

}
//获取产品
- (FNRequestTool *)apiRequestProduct{
    //[SVProgressHUD show];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{ @"token":UserAccessToken,PageNumber:@(self.jm_page),PageSize:@(_jm_pro_pagesize),@"SkipUIIdentifier":@"",@"keyword":@"",@"is_index":@"1"}];
    if([self.cid kr_isNotEmpty]){
        params[@"cid"]=self.cid;
    }
    if([self.sort kr_isNotEmpty]){
        params[@"sort"]=self.sort;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_goods&ctrl=goods" respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        NSArray* array = respondsObject;
        [SVProgressHUD dismiss];
        [selfWeak.jm_collectionview.mj_footer endRefreshing];
        [selfWeak.jm_collectionview.mj_header endRefreshing];
        
        if (selfWeak.jm_page == 1) {
            if (array.count == 0) {
                [FNTipsView showTips:@"很抱歉，没有找到该类产品~"];
                //return ;
            }
            [selfWeak.productArr removeAllObjects];
            
        }
        
        [selfWeak.productArr addObjectsFromArray:respondsObject];
        
        self.jm_page++;
        if (array.count > 0) {
            selfWeak.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [selfWeak apiRequestProduct];
            }];
        }else{
            selfWeak.jm_collectionview.mj_footer = nil;
        }

        selfWeak.jm_collectionview.hidden = NO;
        //只刷新商品列表
        [UIView performWithoutAnimation:^{
            if(selfWeak.dataArray.count>0){
              [selfWeak.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:selfWeak.dataArray.count-1]];
            }
        }];
        
     } failure:^(NSString *error) {
         
     } isHideTips:YES];
}

-(NSMutableArray *)productArr{
    if (!_productArr) {
        _productArr = [NSMutableArray array];
    }
    return _productArr;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)marqueeArray{
    if (!_marqueeArray) {
        _marqueeArray = [NSMutableArray array];
    }
    return _marqueeArray;
}
-(NSMutableArray *)screenArray{
    if (!_screenArray) {
        _screenArray = [NSMutableArray array];
    }
    return _screenArray;
}


#pragma mark - FNdefineCommodityCellDelegate
- (void)onShareClick: (FNdefineCommodityCell*)cell {
    NSIndexPath *indexPath = [self.jm_collectionview indexPathForCell:cell];
//    FNDefiniteStoreNeModel *model=self.dataArray[indexPath.section];
    FNDefiniteProductModel *model=[FNDefiniteProductModel mj_objectWithKeyValues:self.productArr[indexPath.row]];
    FNShareViewController *share = [[FNShareViewController alloc] init];
    share.SkipUIIdentifier = model.SkipUIIdentifier;
    share.fnuo_id = model.id;
    [self.navigationController pushViewController:share animated:YES];
}

@end
