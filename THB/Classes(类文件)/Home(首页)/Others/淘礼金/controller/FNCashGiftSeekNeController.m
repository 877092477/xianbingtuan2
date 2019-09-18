//
//  FNCashGiftSeekNeController.m
//  THB
//
//  Created by 李显 on 2018/10/15.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNCashGiftSeekNeController.h"

//view
#import "FNCashGiftCarouselNeCell.h"
#import "FNHomeProductSingleRowCell.h"
#import "FNCashGiftHeaderNeView.h"
#import "FNHomeProductCell.h"
#import "FNCashGiftNeLayout.h"
//model
#import "FNBaseProductModel.h"
#import "FNGiftSeekHeNeModel.h"

@interface FNCashGiftSeekNeController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,FNCashGiftCarouselNeCellDelegate,FNCashGiftHeaderNeViewDelegate>
/** 幻灯片data **/
@property(nonatomic,strong)NSMutableArray *slideArr;
/** 排序data **/
@property(nonatomic,strong)NSMutableArray *sortArr;
/** 分类data **/
@property(nonatomic,strong)NSMutableArray *classifyArr;
@property(nonatomic,strong)NSMutableArray *classifyNameArr;
/** 商品data **/
@property(nonatomic,strong)NSMutableArray *dataArray;
/** 商品分类ID **/
@property(nonatomic,strong)NSString *cidString;
/** 分类位置 **/
@property(nonatomic,assign)NSInteger cidInt;
/** 排序ID **/
@property(nonatomic,strong)NSString *sortString;
/** 排序位置 **/
@property(nonatomic,assign)NSInteger siteInt;
/** 样式 **/
@property(nonatomic,assign)NSInteger singleInt;
/** 样式 **/
@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation FNCashGiftSeekNeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"淘礼金";
    self.cidInt=0;
    self.siteInt=0;
    NSString *columnSwitch=[FNBaseSettingModel settingInstance].index_goods_columnSwitch;
    NSInteger singleInt=[columnSwitch integerValue];
    self.singleInt=singleInt;
    [SVProgressHUD show];
    //[self apiRequestSlideShow];
    //[self apiRequestClassification];
    [self apiMainReqeuest];
    [self CashGiftSeekView];
    
    
}
#pragma mark - 单元
-(void)CashGiftSeekView{
   
    FNCashGiftNeLayout *layout = [FNCashGiftNeLayout new];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    //设置头部视图的尺寸
    layout.naviHeight = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
     
    CGFloat SeekHeight=JMScreenHeight; 
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing=0;
    flowlayout.minimumInteritemSpacing=0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    
    
    
    //self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 1, JMScreenWidth, SeekHeight-1) collectionViewLayout:flowlayout];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, JMScreenWidth, SeekHeight-64) collectionViewLayout: layout];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //self.jm_collectionview.bounces = YES;
    self.collectionView.showsVerticalScrollIndicator=NO;
    self.collectionView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"rightClassifycellId"];
    [self.collectionView registerClass:[FNCashGiftCarouselNeCell class] forCellWithReuseIdentifier:@"CashGiftCarouselCellId"];
    [self.collectionView registerClass:[FNHomeProductSingleRowCell class] forCellWithReuseIdentifier:@"HomeViewGoodsSingleCell"];
    [self.collectionView registerClass:[FNHomeProductCell class] forCellWithReuseIdentifier:@"HomeViewGoodsCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    [self.collectionView registerClass:[FNCashGiftHeaderNeView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GiftHeaderNeView"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView"];
    
    @WeakObj(self);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.jm_page = 1;
        [self apiRequestProduct];
    }]; 
    self.collectionView.hidden=YES;
    
    self.collectionView.alwaysBounceVertical = NO;
    self.collectionView.alwaysBounceHorizontal = NO;
    self.collectionView.pagingEnabled = NO;
    
}


#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    if(section==0){
//        return 1;
//    }
//    else if(section==1){
//        return 1;
//    }else{
//        return self.dataArray.count;
//    }
    if(section==0){
        return 1;
    }
    else{
        return self.dataArray.count;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        FNCashGiftCarouselNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CashGiftCarouselCellId" forIndexPath:indexPath];
        cell.bannerArray=self.slideArr;
        cell.delegate=self;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
//    else if(indexPath.section==1){
//        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rightClassifycellId" forIndexPath:indexPath];
//        //FNRightclassifyModel *model=self.rightDataArr[indexPath.row];
//        //cell.model=model;
//        cell.backgroundColor = [UIColor whiteColor];
//        return cell;
//    }
    else{
        if(self.singleInt==1){
            FNHomeProductCell *cell = [FNHomeProductCell cellWithCollectionView:collectionView atIndexPath:indexPath];
            FNBaseProductModel *model=self.dataArray[indexPath.row];
            cell.model = model;
//            cell.backgroundColor=[UIColor whiteColor];
            
            [cell setIsLeft: indexPath.row % 2 == 0];
            cell.borderColor = FNGlobalTextGrayColor;
            cell.clipsToBounds = YES;
            cell.sharerightNow = ^(FNBaseProductModel *mod) {
                [self shareProductWithModel:mod];
            };
            return cell;
        }else{
            FNHomeProductSingleRowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeViewGoodsSingleCell" forIndexPath:indexPath];
            FNBaseProductModel *model=self.dataArray[indexPath.row];
            cell.model=model;
            cell.backgroundColor = [UIColor whiteColor];
            return cell;
        }
    }
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
//        if(indexPath.section==1){
//            FNCashGiftHeaderNeView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GiftHeaderNeView" forIndexPath:indexPath];
//            headerView.classifyArr=self.classifyNameArr;
//            headerView.sortArr=self.sortArr;
//            headerView.delegate=self;
//            return headerView;
//        }else{
//            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
//            return headerView;
//        }
        FNCashGiftHeaderNeView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GiftHeaderNeView" forIndexPath:indexPath];
        headerView.backgroundColor=[UIColor whiteColor];
        headerView.classifyArr=self.classifyNameArr;
        headerView.sortArr=self.sortArr;
        headerView.delegate=self; 
        headerView.seletedInt=self.cidInt;
        headerView.sortInt=self.siteInt;
        headerView.switchInt=self.singleInt;
        if(indexPath.section==1){
          headerView.hidden=NO;
        }else{
          headerView.hidden=YES;
        }
        return headerView;
        
    }else{
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"footView" forIndexPath:indexPath];
        return footView;
    }
}
#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=JMScreenWidth;
    if(indexPath.section==0){
        CGSize size = CGSizeMake(with, 200);
        return size;
    }
//    else if(indexPath.section==1){
//        CGSize size = CGSizeMake(0, 0);
//        return size;
//    }
    else{
        if(self.singleInt==1){
            double w = FNDeviceWidth/2;
            return CGSizeMake(w, w+110);
        }else{
            CGSize size = CGSizeMake(with, 140);
            return size;
        }
    }
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=JMScreenWidth;
    if(section==0){
        CGSize size = CGSizeMake(0, 0);
        return size;
    }
//    else if(section==1){
//        CGSize size = CGSizeMake(with, 80);
//        return size;
//    }else{
//        CGSize size = CGSizeMake(0, 0);
//        return size;
//    }
    CGSize size = CGSizeMake(with, 80);
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        FNBaseProductModel *model=self.dataArray[indexPath.row];
        [self goProductVCWithModel:model];
    }
}


#pragma mark - FNCashGiftCarouselNeCellDelegate  点击轮播图片
- (void)CashGiftCarouselClickAction:(NSInteger)sender{
    FNGiftSeekHeNeModel *model=self.slideArr[sender];
    [self loadOtherVCWithModel:model andInfo:nil outBlock:nil];
}
#pragma mark - FNCashGiftHeaderNeViewDelegate 
/** 点击分类 **/
- (void)CashGiftCarouselClassifyAction:(NSInteger)sender withIndexPath:(NSIndexPath*)indexPath{
    
   
    self.cidInt=sender;
    NSDictionary *dictry=self.classifyArr[sender];
    self.cidString=dictry[@"id"];
    self.jm_page = 1;
    [self apiRequestProduct];
    NSString *siteString=[NSString stringWithFormat:@"%ld",(long)sender];
    NSNotification * notice = [NSNotification notificationWithName:@"CashGiftSite" object:nil userInfo:@{@"state":siteString}];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    
}
/** 点击排序 **/
- (void)CashGiftCarouselSortAction:(NSString *)type withSite:(NSUInteger)site{
    self.siteInt=site;
    self.sortString=type;
    self.jm_page = 1;
    [self apiRequestProduct];
}
/** 更换样式 **/
- (void)CashGiftCarouselChangeAction:(NSInteger)sender{
    self.singleInt=sender;
    [UIView performWithoutAnimation:^{
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [self.collectionView reloadSections:indexSet];
    }];
}
#pragma mark - api request
- (void)apiMainReqeuest{
    @WeakObj(self);
    NSLog(@"minerequest");
    [FNRequestTool startWithRequests:@[[self apiRequestSlideShow],[self apiRequestClassification],[self apiRequestSort]] withFinishedBlock:^(NSArray *erros) {
        
        [selfWeak.collectionView reloadData];
        
        [selfWeak apiRequestProduct];
    }];
    
}
//获取幻灯片
- (FNRequestTool *)apiRequestSlideShow{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    if ([self.show_type_str kr_isNotEmpty]) {
        params[@"show_type_str"]=self.show_type_str;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=taolj_goods&ctrl=slide" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSMutableArray* zoonarray = [[NSMutableArray alloc]init];
        NSArray* array = respondsObject[DataKey];
        if (array.count>0) {
          for (NSDictionary *dic in array) {
              //[zoonarray addObject:[FNGiftSeekHeNeModel mj_objectWithKeyValues:dic]];
              [zoonarray addObject:dic];
          }
          selfWeak.slideArr=zoonarray;
          [selfWeak.collectionView reloadData];
        }
    } failure:^(NSString *error) {
        [self apiRequestSlideShow];
    } isHideTips:YES];
}

//获取分类
- (FNRequestTool *)apiRequestClassification{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken,@"time":[NSString GetNowTimes]}];
    if ([self.show_type_str kr_isNotEmpty]) {
        params[@"show_type_str"]=self.show_type_str;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=taolj_goods&ctrl=cate" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSMutableArray* dataArray = [[NSMutableArray alloc]init];
        NSMutableArray* nameArray = [[NSMutableArray alloc]init];
        NSArray* array = respondsObject[DataKey];
        if (array.count>0) {
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [dataArray addObject:obj];
                [nameArray addObject:[obj objectForKey:@"category_name"]];
            }];
            selfWeak.cidString=array[0][@"id"];
        }
        selfWeak.classifyNameArr=nameArray;
        selfWeak.classifyArr=dataArray;
        [selfWeak.collectionView reloadData];
        [self apiRequestSort];
    } failure:^(NSString *error) {
        [self apiRequestClassification];
    } isHideTips:YES];
}
//获取搜排序文字
- (FNRequestTool *)apiRequestSort{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{}];
    if ([self.SkipUIIdentifierString kr_isNotEmpty]) {
        params[@"SkipUIIdentifier"]=self.SkipUIIdentifierString;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=taolj_goods&ctrl=getsort" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSMutableArray* zoonarray = [[NSMutableArray alloc]init];
        NSArray* array = respondsObject[DataKey];
        if (array.count>0) {
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [zoonarray addObject:obj];
            }];
            selfWeak.sortString=array[0][@"type"];
        }
        selfWeak.sortArr=zoonarray;
        [selfWeak.collectionView reloadData];
        //[self apiRequestProduct];
    } failure:^(NSString *error) {
        [self apiRequestSort];
    } isHideTips:YES];
}
//获取产品
- (FNRequestTool *)apiRequestProduct{
    [self.collectionView.mj_footer endRefreshing];
    [self.collectionView.mj_header endRefreshing];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{PageNumber:@(self.jm_page), @"token":UserAccessToken,PageSize:@(_jm_pro_pagesize)}];
    if ([self.SkipUIIdentifierString kr_isNotEmpty]) {
        params[@"SkipUIIdentifier"]=self.SkipUIIdentifierString;
    }
    if ([self.show_type_str kr_isNotEmpty]) {
        params[@"show_type_str"]=self.show_type_str;
    }
    if ([self.sortString kr_isNotEmpty]) {
        params[@"sort"]=self.sortString;
    }
    if ([self.cidString kr_isNotEmpty]) {
        params[@"cid"]=self.cidString;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=taolj_goods&ctrl=getgoods" respondType:(ResponseTypeArray) modelType:@"FNBaseProductModel" success:^(id respondsObject) {
        NSArray* array = respondsObject;
        NSMutableArray *itemArr=[NSMutableArray array];
        if (selfWeak.jm_page == 1) {
            if (array.count == 0) {
                [FNTipsView showTips:@"很抱歉，没有找到该类产品~"];
                return ;
            }
            [selfWeak.dataArray removeAllObjects];
            [selfWeak.dataArray addObjectsFromArray:respondsObject];
            
            if (array.count >= _jm_pro_pagesize) {
                selfWeak.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiRequestProduct];
                }];
            }else{
            }
            for(NSInteger i=0;i<selfWeak.dataArray.count;i++){
                NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:1];
                [itemArr addObject:index];
            }
        } else {
            [selfWeak.dataArray addObjectsFromArray:respondsObject];
            for(NSInteger i=0;i<selfWeak.dataArray.count;i++){
                NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:1];
                [itemArr addObject:index];
            }
            if (array.count >= _jm_pro_pagesize) {
                [selfWeak.collectionView.mj_footer endRefreshing];
                
            }else{
                [selfWeak.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
        
        //if(itemArr.count>0){
        //  [selfWeak.collectionView reloadItemsAtIndexPaths:itemArr];
        //}
        [UIView performWithoutAnimation:^{
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
            [selfWeak.collectionView reloadSections:indexSet];
        }];
        selfWeak.collectionView.hidden=NO;
        [SVProgressHUD dismiss];
        
        
    } failure:^(NSString *error) {
        if (self.dataArray.count==0) {
            [self apiRequestProduct];
        }
        [selfWeak.collectionView.mj_footer endRefreshing];
    } isHideTips:NO];
}

- (NSMutableArray *)slideArr {
    if (!_slideArr) {
        _slideArr = [NSMutableArray array];
    }
    return _slideArr;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)classifyNameArr {
    if (!_classifyNameArr) {
        _classifyNameArr = [NSMutableArray array];
    }
    return _classifyNameArr;
}
- (NSMutableArray *)classifyArr {
    if (!_classifyArr) {
        _classifyArr = [NSMutableArray array];
    }
    return _classifyArr;
}
- (NSMutableArray *)sortArr {
    if (!_sortArr) {
        _sortArr = [NSMutableArray array];
    }
    return _sortArr;
}


@end
