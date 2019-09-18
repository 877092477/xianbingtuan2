//
//  FNsortHomeListNeController.m
//  THB
//
//  Created by Jimmy on 2018/12/14.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNsortHomeListNeController.h"
//other
#import "FNCollectionViewCellIdentifier.h"
#import "FNHomeSecKillViewController.h"
#import "FNGoodsListViewController.h"
//model
#import "FNHomeModel.h"
#import "FNAPIHome.h"
//cell
#import "FNBannerViewCell.h"
#import "FNSlideBarViewCell.h"
#import "FNGridViewCell.h"
#import "FNBannerViewCell.h"
#import "FNSaleGoodsViewCell.h"
#import "FNMarqueeViewCell.h"
#import "FNADViewCell.h"
#import "FNFunctionviewCell.h"
#import "FNTopNavViewCell.h"
#import "FNHomeProductSingleRowCell.h"
#import "FNHomeProductCell.h"
#import "FNMaskBannerViewCell.h"//轮播图
#import "FNHomePromotionalView.h"

#import "FNcateSortDeCell.h"

#define _quick_menuH  147
#define _quick_pageH   20
static NSString *CellIdentifier = @"HomeViewGoodsCell";
static NSString *SingleCellId = @"HomeViewGoodsSingleCell";

@interface FNsortHomeListNeController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNcateSortDeCellDelegate,FNBuyProductHeatNViewDelegate, UIScrollViewDelegate, FNMaskBannerViewCellDelegate>
{
    CGFloat headerHeight;
    NSString *ColumnSkipUIIdentifier;
    NSInteger storeindex;//商城索引
    BOOL singleBool;//单双列
    NSInteger reloadInt;//刷新区域
}
/** 存放Cell的标识内容 **/
@property (nonatomic, strong) NSMutableArray<NSArray<FNCollectionViewCellIdentifier *> *> *tableSections;
/** 秒杀商品头部信息 */
@property (retain, nonatomic) NSDictionary *seckillDic;
/** 跑马灯数据数组 */
@property (nonatomic, strong) NSMutableArray *marqueeArray;
/** 商品数据数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 秒杀商品的数组 */
@property (retain, nonatomic) NSMutableArray *seckillArray;
/** 首页Model **/
@property (nonatomic, strong)FNHomeModel* homeModel;
// 排序
@property (nonatomic, strong)NSString* sortType;

@property (nonatomic, strong) UIButton *btnScrollToTop;

@property (nonatomic, strong)MJRefreshNormalHeader *pullHeader;

@end

@implementation FNsortHomeListNeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    reloadInt=0;
    NSString *columnSwitch=[FNBaseSettingModel settingInstance].index_goods_columnSwitch;
    NSInteger singleInt=[columnSwitch integerValue];
    if(singleInt==1){
        singleBool=NO;
    }else{
        singleBool=YES;
    }
    //初始化存放组件的数组
    self.tableSections = [NSMutableArray array];
    [self InitHeaderApiNew];
    [self apiRequestProduct];//每日推荐下的数据
    [self initializedSubviews];
    [self apiRequestPromotionalProduct];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = UIColor.clearColor;
    
    
}

- (void)stopBanner {
    for (UICollectionViewCell *cell in self.jm_collectionview.visibleCells) {
        if ([cell isKindOfClass:[FNMaskBannerViewCell class]]) {
            [((FNMaskBannerViewCell*)cell) stopPlaying];
        }
    }
}
- (void)playBanner {
    for (UICollectionViewCell *cell in self.jm_collectionview.visibleCells) {
        if ([cell isKindOfClass:[FNMaskBannerViewCell class]]) {
            [((FNMaskBannerViewCell*)cell) play];
        }
    }
}

#pragma mark -  单元
- (void)initializedSubviews
{
    @WeakObj(self);
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing=0;
    flowayout.minimumInteritemSpacing=0;
    
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowayout];
    self.jm_collectionview.backgroundColor = UIColor.clearColor;
    
    //向CollectionView注册所有样式组件
    //商品Cell
    [self.jm_collectionview registerClass:[FNHomeProductCell class] forCellWithReuseIdentifier:CellIdentifier];
    [self.jm_collectionview registerClass:[FNHomeProductSingleRowCell class] forCellWithReuseIdentifier:SingleCellId];
    //导航栏组件
    [self.jm_collectionview registerClass:[FNTopNavViewCell class] forCellWithReuseIdentifier:kIndex_Topnav_01_Component];
    
    
    //幻灯片组件
    [self.jm_collectionview registerClass:[FNBannerViewCell class] forCellWithReuseIdentifier:kIndex_Huandengpian_01_Component];
    //新遮罩幻灯片
    [self.jm_collectionview registerClass:[FNMaskBannerViewCell class] forCellWithReuseIdentifier:kIndex_Huandengpian_02_Component];
    
    //快速入口组件
    [self.jm_collectionview registerClass:[FNFunctionviewCell class] forCellWithReuseIdentifier:kIndex_Kuaisurukou_01_Component];
    [self.jm_collectionview registerClass:[FNFunctionviewCell class] forCellWithReuseIdentifier:kIndex_Kuaisurukou_02_Component];
    [self.jm_collectionview registerClass:[FNFunctionviewCell class] forCellWithReuseIdentifier:kIndex_Kuaisurukou_03_Component];
    
    //第三模块广告位组件
    [self.jm_collectionview registerClass:[FNADViewCell class] forCellWithReuseIdentifier:kIndex_Threemodel_01_Component];
    
    //跑马灯组件
    [self.jm_collectionview registerClass:[FNMarqueeViewCell class] forCellWithReuseIdentifier:kIndex_Paomadeng_01_Component];
    
    //特价商品组件
    [self.jm_collectionview registerClass:[FNSaleGoodsViewCell class] forCellWithReuseIdentifier:kIndex_Miaosha_01_Component];
    
    //图文位组件
    [self.jm_collectionview registerClass:[FNGridViewCell class] forCellWithReuseIdentifier:kIndex_Tuwenwei_01_Component];
    
    //商品分栏视图组件
    [self.jm_collectionview registerClass:[FNSlideBarViewCell class] forCellWithReuseIdentifier:kIndex_Goods_01_Component];
    
    [self.jm_collectionview registerClass:[FNcateSortDeCell class] forCellWithReuseIdentifier:kIndex_Goods_01_Component];
    
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.delegate=self;
    self.jm_collectionview.dataSource=self;
    
//    self.jm_collectionview.backgroundColor=FNWhiteColor;
    if([self.jm_collectionview respondsToSelector:@selector(setPrefetchingEnabled:)]){
        self.jm_collectionview.prefetchingEnabled = YES;
    }

    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, 0, 0, 0))];
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
      
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
//    self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        selfWeak.jm_page = 1;
//        [SVProgressHUD show];
//        [self apiRequestProduct];
//    }];
    
    self.pullHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onePageNumberData)];
    // 设置头部
    self.jm_collectionview.mj_header = self.pullHeader;
    
    _btnScrollToTop = [[UIButton alloc] init];
    [self.view addSubview:_btnScrollToTop];
    [_btnScrollToTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.bottom.equalTo(@-120);
    }];
    [_btnScrollToTop setImage:IMAGE(@"hddb") forState:UIControlStateNormal];
    [_btnScrollToTop setHidden:YES];
    [_btnScrollToTop addTarget:self action:@selector(onScrollToTopClick)];
}
-(void)onePageNumberData{
    self.jm_page = 1;
    [SVProgressHUD show];
    [self apiRequestProduct];
}
#pragma mark UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView { 
    return self.tableSections.count+1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //FNCollectionViewCellIdentifier *FunctionComponent=self.tableSections[section];
   
    if (section == self.tableSections.count) {
        return self.dataArray.count;
    }
    else{
        NSArray *itemArr=self.tableSections[section];
        FNCollectionViewCellIdentifier *FunctionComponent=itemArr[0];
        NSLog(@"cellIdentifier:%@",self.tableSections);
        if ([FunctionComponent.cellIdentifier isEqualToString:kIndex_Kuaisurukou_01_Component] ||
            [FunctionComponent.cellIdentifier isEqualToString:kIndex_Kuaisurukou_02_Component] ||
            [FunctionComponent.cellIdentifier isEqualToString:kIndex_Kuaisurukou_03_Component]){
            NSArray *listArr=FunctionComponent.data;
            if(listArr.count==0){
                return 0;
            }else{
                return 1;
            }
        }else{
            return 1;
        }
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    @WeakObj(self);
    FNCollectionViewCellIdentifier *row;
    XYLog(@"tableSections:%@",self.tableSections);
        if (indexPath.section<self.tableSections.count) {
            row = self.tableSections[indexPath.section][indexPath.row];
        }
        
        if ([row.cellIdentifier isEqualToString:kIndex_Huandengpian_01_Component]) {
            
            FNBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
            cell.bannerArray = row.data;
            cell.BannerClickedBlock = ^(NSInteger index) {
                [selfWeak loadOtherVCWithModel:selfWeak.homeModel.index_huandengpian_01List[index] andInfo:nil outBlock:nil];
            };
            cell.backgroundColor = FNWhiteColor;
            
        
            return cell;
        } else if ([row.cellIdentifier isEqualToString:kIndex_Huandengpian_02_Component]) {
            
            FNMaskBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
            cell.delegate = self;
            cell.bannerArray = row.data;
            cell.time = row.banner_speed / 1000;
            cell.BannerClickedBlock = ^(NSInteger index) {
                [selfWeak loadOtherVCWithModel:selfWeak.homeModel.index_huandengpian_02List[index] andInfo:nil outBlock:nil];
            };
        
            
            return cell;
        }
        else if ([row.cellIdentifier isEqualToString:kIndex_Kuaisurukou_01_Component] ||
                 [row.cellIdentifier isEqualToString:kIndex_Kuaisurukou_02_Component] ||
                 [row.cellIdentifier isEqualToString:kIndex_Kuaisurukou_03_Component]){
            FNFunctionviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
//            cell.index_kuaisurukou_01List = row.data;
            [cell setIndex_kuaisurukou_01List:row.data withColumn:[row.cellIdentifier isEqualToString:kIndex_Kuaisurukou_01_Component] ? 5 : 4];
            cell.cateString=self.categoryId;
            cell.QuickClickedBlock = ^(MenuModel *model) {
                if([selfWeak.categoryId isEqualToString:@"0"]){
                   [selfWeak loadOtherVCWithModel:model andInfo:nil outBlock:nil];
                }else{
                    [self withSeletedCareTwo:model];
                }
            };
            cell.backgroundColor = FNWhiteColor;
            return cell;
        }
        else if ([row.cellIdentifier isEqualToString:kIndex_Threemodel_01_Component]){
            FNADViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
            cell.index_threemodel_01List = row.data;
            cell.QuickClickedBlock = ^(MenuModel *model) {
                [selfWeak loadOtherVCWithModel:model andInfo:nil outBlock:nil];
            };
            cell.backgroundColor = FNWhiteColor;
            return cell;
        }else if ([row.cellIdentifier isEqualToString:kIndex_Paomadeng_01_Component]){
            FNMarqueeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
            cell.index_paomadeng_01List = row.data;
            cell.backgroundColor = FNWhiteColor;
            return cell;
        }else if ([row.cellIdentifier isEqualToString:kIndex_Tuwenwei_01_Component]){
            FNGridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
            cell.index_tuwenwei_01List = row.data;
            cell.QuickClickedBlock = ^(MenuModel *model) {
                [selfWeak loadOtherVCWithModel:model andInfo:nil outBlock:nil];
            };
            cell.backgroundColor = FNWhiteColor;
            return cell;
        }
        else if ([row.cellIdentifier isEqualToString:kIndex_Miaosha_01_Component]){
            FNSaleGoodsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
            cell.seckillArr=self.seckillArray;
            cell.restsDic=self.seckillDic;
            cell.heatView.delegate=self;
            cell.backgroundColor = FNWhiteColor;
            return cell;
        }
        else if ([row.cellIdentifier isEqualToString:kIndex_Goods_01_Component]){
            FNcateSortDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
            cell.sortArr=row.data;
            cell.delegate=self;
            cell.categoryId=self.categoryId;
            cell.singleType=singleBool;
            cell.backgroundColor = FNWhiteColor;
            return cell;

        }
        else if (indexPath.section == self.tableSections.count){
            FNBaseProductModel *model = self.dataArray[indexPath.row];
            
            if(singleBool==YES){
                FNHomeProductSingleRowCell *cell = [FNHomeProductSingleRowCell cellWithCollectionView:collectionView atIndexPath:indexPath];
                cell.model = model;
//                cell.backgroundColor=[UIColor whiteColor];
                cell.sharerightNow = ^(FNBaseProductModel *mod) {
                    [self shareProductWithModel:mod];
                };
                cell.clipsToBounds = YES;
                return cell;
            }else{
                FNHomeProductCell *cell = [FNHomeProductCell cellWithCollectionView:collectionView atIndexPath:indexPath];
                cell.model = model;
//                cell.backgroundColor=[UIColor whiteColor];
                [cell setIsLeft: indexPath.row % 2 == 0];
                cell.borderColor = FNGlobalTextGrayColor;
                cell.clipsToBounds = YES;
                cell.sharerightNow = ^(FNBaseProductModel *mod) {
                    [self shareProductWithModel:mod];
                };
                return cell;
            }
        }
    
    
    return nil;
}
-(void)withSeletedCareTwo:(MenuModel *)model{
    FNGoodsListViewController *VC=[FNGoodsListViewController new];
    VC.keyword=[model valueForKey:@"name"];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - FNBuyProductHeatNViewDelegate
- (void)ProductHeatClickAction:(FNBaseProductModel *)item{
    //NSLog(@"首页选择");
    [self goProductVCWithModel:item];
}
- (void)CheckProductAction{
    //NSLog(@"查看全部");
    FNHomeSecKillViewController *secKill = [FNHomeSecKillViewController new];
    [self.navigationController pushViewController:secKill animated:YES];
}
#pragma mark - collectionView delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FNCollectionViewCellIdentifier *row;
    if (indexPath.section<self.tableSections.count) {
        row = self.tableSections[indexPath.section][indexPath.row];
    }
    NSLog(@"rowHeight:%f",row.rowHeight);
    if (indexPath.section == self.tableSections.count) {
        if(singleBool==YES){
            CGFloat singlewidth=140;
            return CGSizeMake(FNDeviceWidth,  singlewidth);
        }else{
            int w = FNDeviceWidth/2;
            CGFloat h = w+110;
            if (indexPath.row % 2 == 1) //防止出现缝隙
                w = FNDeviceWidth - w;
            return CGSizeMake(w, h);
        }
    }else{
        NSArray *jiageArr=self.homeModel.jiangeArr;
        NSString *jiageString=jiageArr[indexPath.section];
        CGFloat jiageFloat=0;
        if([jiageString kr_isNotEmpty]){
            jiageFloat=[jiageString floatValue]/2;
        }
        
        return CGSizeMake(FNDeviceWidth, row.rowHeight+jiageFloat);
    }
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark--collectionView点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == self.tableSections.count) {
        if (self.dataArray.count>0) {
            FNBaseProductModel *model = self.dataArray[indexPath.row];
            [self goProductVCWithModel:model withData:model.data];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[FNMaskBannerViewCell class]]) {
        [((FNMaskBannerViewCell*)cell) play];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[FNMaskBannerViewCell class]]) {
        [((FNMaskBannerViewCell*)cell) stopPlaying];
    }
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_btnScrollToTop setHidden: scrollView.contentOffset.y < XYScreenHeight];
    
    [FNNotificationCenter postNotificationName:@"HomeRoll" object:nil];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [FNNotificationCenter postNotificationName:@"HomeEndRoll" object:nil];
}
-(void)dealloc{
    [FNNotificationCenter removeObserver:self];
}
#pragma mark - Action
- (void)onScrollToTopClick {
    [self.jm_collectionview scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

#pragma mark -  FNcateSortDeCellDelegate 排序 排版样式
// 点击排序方式
- (void)cateGoodsSortAction:(NSString*)sender{
    self.sortType=sender;
    reloadInt=1;
    [self apiRequestProduct];
    
}
//排版样式
- (void)cateGoodsComposingAction:(NSInteger)sender{
    reloadInt=1;
    if(sender==1){
       singleBool=NO;
    }else{
       singleBool=YES;
    }
    [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:_tableSections.count]];
}
#pragma mark - api request
//首页头部接口
- (void)InitHeaderApiNew{
    @WeakObj(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],@"cid":self.categoryId}];
    XYLog(@"categoryId:%@",self.categoryId);
    //
    NSString *apiString=@"mod=appapi&act=appDiyIndex02&ctrl=index";
    if([self.categoryId isEqualToString:@"0"]){
        apiString=@"mod=appapi&act=appDiyIndex&ctrl=getIndex";
    }
    [FNRequestTool requestWithParams:params api:apiString respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        XYLog(@"首页头部接口%@",respondsObject);
        FNHomeModel *Model=[[FNHomeModel alloc]init];
        NSMutableArray *jiangeArr=[[NSMutableArray alloc]init];
        NSMutableArray *TypeArr=[[NSMutableArray alloc]init];
        NSMutableDictionary *TypeDic=[[NSMutableDictionary alloc]init];
        [self.tableSections removeAllObjects];
        
        //selfWeak.cuNaivgationbar.searchBar.placeholder=@"搜索一下吧";//listArr[0][@"str"];
        //根据传过来的数据添加对应组件
        for (NSDictionary *Dict in respondsObject) {
            NSString *TypeStr=[Dict objectForKey:typeKey];//index_topnav_01
            //            NSLog(@"11抢购:%@",TypeStr);
            NSArray *listArr=[Dict objectForKey:listKey];
            
            if ([TypeStr isEqualToString:kIndex_Topnav_01_Component]) {//导航栏
                Model.index_topnav_01List=listArr;
            }
            else if ([TypeStr isEqualToString:kIndex_Huandengpian_01_Component] || [TypeStr isEqualToString:kIndex_Cate_Banner_01]) {//幻灯片
                NSString *banner_bili=[Dict objectForKey:@"banner_bili"];
                CGFloat huandengpianHeight;
                huandengpianHeight=FNDeviceWidth*[banner_bili floatValue];
                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                //[TypeDic setObject:self.headerView.bannerView forKey:TypeStr];
                Model.index_huandengpian_01List=listArr;
                FNCollectionViewCellIdentifier *BannerComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:kIndex_Huandengpian_01_Component data:listArr rowHeight:huandengpianHeight];
                [self.tableSections addObject:@[BannerComponent]];
                
            }else if ([TypeStr isEqualToString:kIndex_Huandengpian_02_Component]) {//幻灯片
                NSString *banner_bili=[Dict objectForKey:@"banner_bili"];
                CGFloat huandengpianHeight;
                huandengpianHeight=FNDeviceWidth*[banner_bili floatValue] + 4;
                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                //[TypeDic setObject:self.headerView.bannerView forKey:TypeStr];
                Model.index_huandengpian_02List=listArr;
                FNCollectionViewCellIdentifier *BannerComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:kIndex_Huandengpian_02_Component data:listArr rowHeight:huandengpianHeight];
                NSString *banner_speed=[Dict objectForKey:@"banner_speed"];
                if ([banner_speed kr_isNotEmpty]) {
                    BannerComponent.banner_speed = [banner_speed doubleValue];
                }
                
                if ([_delegate respondsToSelector:@selector(controller:didMaskBackground:foreground:percent:)]) {
                    
                    Index_huandengpian_01Model *model1;
                    Index_huandengpian_01Model *model2;
                    
                    if (listArr.count > 0) {
                        NSDictionary *dict1 = listArr[0];
                        model1=[Index_huandengpian_01Model mj_objectWithKeyValues:dict1];
                    }
                    if (listArr.count > 1) {
                        NSDictionary *dict2 = listArr[1];
                        model2=[Index_huandengpian_01Model mj_objectWithKeyValues:dict2];
                    }
                    
                    [_delegate controller:self didMaskBackground:model1 == nil ? nil : model1.banner_bj_img foreground:model2 == nil ? nil : model2.banner_bj_img percent:0];
                }
                
                [self.tableSections addObject:@[BannerComponent]];
                
            }else if ([TypeStr isEqualToString:kIndex_Kuaisurukou_01_Component] ||
                      [TypeStr isEqualToString:kIndex_Kuaisurukou_02_Component] ||
                      [TypeStr isEqualToString:kIndex_Kuaisurukou_03_Component]) {//快速入口2
                
                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                //[TypeDic setObject:self.headerView.functionview forKey:TypeStr];
                Model.index_kuaisurukou_01List=listArr;;
                FNCollectionViewCellIdentifier *FunctionComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:TypeStr data:listArr rowHeight:[self heightForComponentInSection:TypeStr data:listArr]];
                [self.tableSections addObject:@[FunctionComponent]];
                
            }
            
            else if ([TypeStr isEqualToString:kIndex_Threemodel_01_Component]||[TypeStr isEqualToString:kIndex_Threemodel_02_Component]||[TypeStr isEqualToString:kIndex_Threemodel_03_Component]){
                
                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                //[TypeDic setObject:self.headerView.adView forKey:TypeStr];
                Model.index_threemodel_01List=listArr;
                
                FNCollectionViewCellIdentifier *ADViewComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:kIndex_Threemodel_01_Component data:listArr rowHeight:[self heightForComponentInSection:kIndex_Threemodel_01_Component data:listArr]];
                
        
                // 异步更新cell高度
                NSMutableArray* images = [NSMutableArray new];
                for (NSDictionary *dict in listArr) {
                    Index_threemodel_01Model *threemodel=[Index_threemodel_01Model mj_objectWithKeyValues:dict];
                    [images addObject:threemodel.img];
                }
                XYLog(@"images0=%@",images);
                ADViewComponent.imageUrls = images;
                
                [self.tableSections addObject:@[ADViewComponent]];
                
            }else if ([TypeStr isEqualToString:kIndex_Paomadeng_01_Component]) {//跑马灯，这个数据要另外调接口
                //                isPaomadeng=YES;
                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                //[TypeDic setObject:self.headerView.FNMarqueeView forKey:TypeStr];
                FNCollectionViewCellIdentifier *MarqueeComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:kIndex_Paomadeng_01_Component data:self.marqueeArray rowHeight:[self heightForComponentInSection:kIndex_Paomadeng_01_Component data:self.marqueeArray]];
                [self.tableSections addObject:@[MarqueeComponent]];
                
                [self  apiRequstMarqueeData];
                
                
            }else if ([TypeStr isEqualToString:kIndex_Miaosha_01_Component]) {//特价商品列表，这个数据要另外调接口
                XYLog(@"秒杀Roda:%@",Dict);
                //秒杀
                self.seckillDic=Dict;
                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                //[TypeDic setObject:self.headerView.specialView forKey:TypeStr];
                // Model.index_tuwenwei_01List=listArr;
                FNCollectionViewCellIdentifier *GridComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:kIndex_Miaosha_01_Component data:listArr rowHeight:[self heightForComponentInSection:kIndex_Miaosha_01_Component data:listArr]];
                [self.tableSections addObject:@[GridComponent]];
                [self apiRequestMiaoShaGoods];
                
                
            }else if ([TypeStr isEqualToString:kIndex_Tuwenwei_01_Component]) {//图文位
                
                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                //[TypeDic setObject:self.headerView.specialView forKey:TypeStr];
                //Model.index_tuwenwei_01List=listArr;
                FNCollectionViewCellIdentifier *GridComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:kIndex_Tuwenwei_01_Component data:listArr rowHeight:[self heightForComponentInSection:kIndex_Tuwenwei_01_Component data:listArr]];
                [self.tableSections addObject:@[GridComponent]];
                
                
            }
            
            
            else if ([TypeStr isEqualToString:kIndex_Goods_01_Component] || [TypeStr isEqualToString:kIndex_Cate_Goods_01]) {//商品分栏视图
                
                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                //[TypeDic setObject:self.headerView.slideBarView forKey:TypeStr];
                Model.index_goods_01List=listArr;
                
                FNCollectionViewCellIdentifier *SlideBarComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:kIndex_Goods_01_Component data:listArr rowHeight:[self heightForComponentInSection:kIndex_Goods_01_Component data:listArr]];
                [self.tableSections addObject:@[SlideBarComponent]];
                NSMutableArray *title=[[NSMutableArray alloc]init];
                for (NSDictionary *dictry in listArr){
                    Index_goods_01Model *goodsModel=[Index_goods_01Model mj_objectWithKeyValues:dictry];
                    [title addObject:goodsModel];
                }
                //selfWeak.ComponentArray=title;
            }
        }
        
        [self requestThreeModelImages];
        
        Model.jiangeArr=jiangeArr;
        Model.TypeArr=TypeArr;
        Model.TypeDic=TypeDic;
        selfWeak.homeModel = Model;
        if(selfWeak.homeModel.index_huandengpian_02List.count>0){
           selfWeak.pullHeader.stateLabel.textColor=[UIColor whiteColor];
           selfWeak.pullHeader.lastUpdatedTimeLabel.textColor=[UIColor whiteColor];
        }else{
           selfWeak.pullHeader.stateLabel.textColor=RGB(153, 153, 153);
           selfWeak.pullHeader.lastUpdatedTimeLabel.textColor=RGB(153, 153, 153);
        }
        
        NSMutableArray* goodsIndexArr=[[NSMutableArray alloc]init];
        
        for (NSDictionary *dict in Model.index_goods_01List) {
            Index_goods_01Model *goodsIndexModel=[Index_goods_01Model mj_objectWithKeyValues:dict];
            if ([goodsIndexModel.is_check integerValue]==1) {
                ColumnSkipUIIdentifier=goodsIndexModel.SkipUIIdentifier;
            }
            [goodsIndexArr addObject:goodsIndexModel.SkipUIIdentifier];
        }
        
        if (goodsIndexArr.count>0) {
            ColumnSkipUIIdentifier=goodsIndexArr[0];
        }
        
        [SVProgressHUD dismiss];
        
        [selfWeak.jm_collectionview reloadData];
    } failure:^(NSString *error) {

    } isHideTips:YES];
    
}


/**
 请求Three_Model图片，计算高度
 */
- (void)requestThreeModelImages {
    for (NSArray *array in self.tableSections) {
        for (FNCollectionViewCellIdentifier *model in array) {
            CGFloat padding = 0;
            NSArray<NSString*> *images = model.imageUrls;
            XYLog(@"images1=%@",images);
            if ([model.cellIdentifier isEqualToString:kIndex_Threemodel_01_Component]
                && images && images.count > 0) {
                @weakify(model)
                @weakify(self)
                [SDWebImageManager.sharedManager downloadImageWithURL:URL(images[0]) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    @strongify(model)
                    @strongify(self)
                    
                    model.rowHeight=1;
                    if(error == nil && finished && image != nil){
                        CGFloat imgW = (JMScreenWidth-(padding*images.count+padding))/images.count;
                        model.rowHeight=image.size.height/image.size.width*imgW+padding*2;
                    }
                    
                    [self.jm_collectionview reloadData];
                }];
            }
        }
        
    }
}


//获取跑马灯
- (void)apiRequstMarqueeData{
    @WeakObj(self);
    NSMutableDictionary*params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    [FNRequestTool requestWithParams:params api:_api_home_marqueeApi respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        [self.marqueeArray removeAllObjects];
        for (NSDictionary *Dict in respondsObject) {
            Index_paomadeng_01Model *Model=[Index_paomadeng_01Model mj_objectWithKeyValues:Dict];
            [self.marqueeArray addObject:Model];
        }
        [selfWeak.jm_collectionview reloadData];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
    
}
- (FNRequestTool *)apiRequestMiaoShaGoods{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"is_index":@"1",@"p":@(self.jm_page),@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dgmiaosha02&ctrl=getgoods" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSLog(@"秒杀商品:%@",respondsObject);
        NSArray* arr = respondsObject[DataKey];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dictry in arr) {
            [arrM addObject:[FNBaseProductModel mj_objectWithKeyValues:dictry]];
        }
        selfWeak.seckillArray = arrM;
        //selfWeak.heatView.heatArr=arrM;
        
        [selfWeak.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}

//promotional product
- (FNAPIHome *)apiRequestPromotionalProduct{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken}];
    return [FNAPIHome apiHomeForPromotionalProductWithParams:params success:^(id respondsObject) {
        NSArray* results = respondsObject;
        if (results.count > 0) {
            [FNHomePromotionalView showWithModel:[results firstObject] clickedProBlock:^{
                //click
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [selfWeak goProductVCWithModel:[results firstObject] withData:nil];
                });
            }];
        }
        
    } failure:^(NSString *error) {
        
    } isHidden:YES];
}

//获取产品(三只松鼠)
- (FNRequestTool *)apiRequestProduct{

    @WeakObj(self);
    [selfWeak.jm_collectionview.mj_footer endRefreshing];
    [selfWeak.jm_collectionview.mj_header endRefreshing];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{PageNumber:@(self.jm_page), @"token":UserAccessToken,PageSize:@(_jm_pro_pagesize),@"time":[NSString GetNowTimes]}];
    params[@"sort"] = @"zonghe";
    NSString *apiUrlString=@"mod=appapi&act=appGoods03&ctrl=index";
    if([self.categoryId isEqualToString:@"0"]){
        params[@"is_index"] = @"1";
        apiUrlString=_api_Newhome_getGoods;
    }
    if([self.showtype kr_isNotEmpty]){
        params[@"show_type_str"]=self.showtype;
        // show_type_str 类型
    }
    if([self.keyword kr_isNotEmpty]){
        params[@"keyword"]=self.keyword;
    }
    if (self.categoryId) {
        params[@"cid"] = self.categoryId;
        //cid 商品分类
    }
    if ([self.sortType kr_isNotEmpty]) {
        params[@"sort"] = self.sortType;
        //sort排序
        //zonghe=>综合 goods_price_asc=>价格从低到高 goods_price_desc=>价格从高到低 commission_asc=>佣金从高到低 commission_asc=>佣金从低到高 goods_sales_desc=>销量从高到低 goods_sales_asc=>销量从低到高
    }
    return [FNRequestTool requestWithParams:params api:apiUrlString respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        NSArray* array = respondsObject;
        [SVProgressHUD dismiss]; 
        if (selfWeak.jm_page == 1) {
            if (array.count == 0) {
                //[FNTipsView showTips:@"很抱歉，没有找到该类产品~"];
                return ;
            }
            [selfWeak.dataArray removeAllObjects];
            for (NSDictionary *dic in respondsObject) {
                FNBaseProductModel *model = [FNBaseProductModel mj_objectWithKeyValues:dic];
                model.data = dic;
                [selfWeak.dataArray addObject:model];
            }
            if (array.count >= _jm_pro_pagesize) {
                selfWeak.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiRequestProduct];
                }];
            }else{
                selfWeak.jm_collectionview.mj_footer = nil;
            }
        } else {
//            [selfWeak.dataArray addObjectsFromArray:respondsObject];
            for (NSDictionary *dic in respondsObject) {
                FNBaseProductModel *model = [FNBaseProductModel mj_objectWithKeyValues:dic];
                model.data = dic;
                [selfWeak.dataArray addObject:model];
            }
            if (array.count >= _jm_pro_pagesize) {
                [selfWeak.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [selfWeak.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        selfWeak.jm_collectionview.hidden = NO;
        if(reloadInt==0){
            [selfWeak.jm_collectionview reloadData];
        }else{
            //只刷新商品列表
            [UIView performWithoutAnimation:^{
                [selfWeak.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:selfWeak.tableSections.count]];
            }];
        }
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

#pragma mark - //计算Cell高度
- (CGFloat)heightForComponentInSection:(NSString *)ComponentStr data:(NSArray *)data {
    
    if ([ComponentStr isEqualToString:kIndex_Huandengpian_01_Component]) {
        
        double height =FNDeviceWidth*0.52;
        headerHeight += height;
        
        return height;
    } else if ([ComponentStr isEqualToString:kIndex_Huandengpian_02_Component]) {
        
        double height =FNDeviceWidth*0.52 + 4;
        headerHeight += height;
        
        return height;
    }
    
    else if ([ComponentStr isEqualToString:kIndex_Kuaisurukou_01_Component] ||
             [ComponentStr isEqualToString:kIndex_Kuaisurukou_02_Component] ||
             [ComponentStr isEqualToString:kIndex_Kuaisurukou_03_Component]){
        
        double height ;
        
        if (data.count > 5 && data.count <=10) {
            height = _quick_menuH;
        }else if (data.count > 10){
            height = _quick_menuH + _quick_pageH;
        }
        else if (data.count == 0){
            height = 0;
        }
        else{
            height = _quick_menuH * 0.5;
            
        }
        headerHeight += height;
        return height;
    }else if ([ComponentStr isEqualToString:kIndex_Threemodel_01_Component]){
        //旧代码通过[UIImage imageWithData:[NSData dataWithContentsOfURL:URL(images[0])]]
        //计算图片大小的代码已经被移出，现通过sdwebimage异步加载更新cell高度
        return 0;
    }else if ([ComponentStr isEqualToString:kIndex_Paomadeng_01_Component]){
        double height = 45 ;
        
        headerHeight += height;
        return height;
    }else if ([ComponentStr isEqualToString:kIndex_Tuwenwei_01_Component]){
        double height = 0.53*FNDeviceWidth;
        headerHeight += height;
        
        return height;
    }else if ([ComponentStr isEqualToString:kIndex_Goods_01_Component]){
        double height = 80 ;
        if(![[FNBaseSettingModel settingInstance].index_cgfjx_ico kr_isNotEmpty]){
            height = 40;
        }
        if([self.categoryId isEqualToString:@"0"]){
            height=40;
        }
        headerHeight += height;
        return height;
    }
    else if ([ComponentStr isEqualToString:kIndex_Miaosha_01_Component]){
        double height = JMScreenWidth/3+60+50;
        headerHeight += height;
        NSLog(@"秒杀height");
        return height;
    }else{
        return 0;
    }
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)marqueeArray {
    if (!_marqueeArray) {
        _marqueeArray = [NSMutableArray array];
    }
    return _marqueeArray;
}

#pragma mark - FNMaskBannerViewCellDelegate
- (void)banner:(FNMaskBannerViewCell *)banner didScrollToIndex:(NSInteger)index percent: (CGFloat)percent{
    if ([_delegate respondsToSelector:@selector(controller:didMaskBackground:foreground:percent:)]) {
        NSDictionary *dict1 = self.homeModel.index_huandengpian_02List[index];
        Index_huandengpian_01Model *model1=[Index_huandengpian_01Model mj_objectWithKeyValues:dict1];
        NSInteger next = (percent < 0) ? (index - 1) : (index + 1);
        next = (next + self.homeModel.index_huandengpian_02List.count) % self.homeModel.index_huandengpian_02List.count;
        NSDictionary *dict2 = self.homeModel.index_huandengpian_02List[next];
        Index_huandengpian_01Model *model2=[Index_huandengpian_01Model mj_objectWithKeyValues:dict2];
        
        [_delegate controller:self didMaskBackground:model1.banner_bj_img foreground:model2.banner_bj_img percent:percent];
    }
}

 
@end
