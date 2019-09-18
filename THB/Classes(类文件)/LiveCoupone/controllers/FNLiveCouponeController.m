//
//  FNLiveCouponeController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/24.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveCouponeController.h"
#import "FNLiveCouponeSearchController.h"

#import "FNCollectionViewCellIdentifier.h"
#import "FNHomeModel.h"
#import "FNLiveCouponeModel.h"

#import "FNLiveCouponeBannerCell.h"
#import "FNFunctionviewCell.h"
#import "FNADViewCell.h"
#import "FNMarqueeViewCell.h"
#import "FNSaleGoodsViewCell.h"
#import "FNSlideBarViewCell.h"
#import "FNcateSortDeCell.h"
#import "FNLiveCouponeStoreCell.h"
#import "FNLiveCouponeCatCell.h"
#import "FNLiveCouponeCell.h"
#import "FNLiveCouponeGridCell.h"

#define _quick_menuH  147
#define _quick_pageH   20

#define life_banner_01          @"life_banner_01"
#define life_ico_01             @"life_ico_01"
#define life_tuwen_01           @"life_tuwen_01"
#define life_store_01           @"life_store_01"
#define life_list_01            @"life_list_01"

@interface FNLiveCouponeController ()<UICollectionViewDelegate, UICollectionViewDataSource, FNLiveCouponeCatCellDelegate>{
    CGFloat headerHeight;
}

/** 存放Cell的标识内容 **/
@property (nonatomic, strong) NSMutableArray<NSArray<FNCollectionViewCellIdentifier *> *> *tableSections;

@property (nonatomic, strong) FNHomeModel *homeModel;

@property (nonatomic, strong) NSMutableArray<FNLiveCouponeModel*> *coupones;
@property (nonatomic, assign) NSInteger cateIndex;
@property (nonatomic, copy) NSNumber* cateId;
@property (nonatomic, copy) NSString* cateType;

@end

@implementation FNLiveCouponeController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    
    _coupones = [[NSMutableArray alloc] init];
    //初始化存放组件的数组
    self.tableSections = [NSMutableArray array];
    [self requestMain];
    [self initializedSubviews];
}

-(void)setupNav{
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [rightbutton setTitle:@"搜索" forState:UIControlStateNormal];
    [rightbutton setImage:IMAGE(@"live_coupone_nav_button_search") forState:(UIControlStateNormal)];
    rightbutton.titleLabel.font = kFONT12;
    [rightbutton setTitleColor:RGB(60, 60, 60) forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
 
}

- (void)rightBtnAction {
    FNLiveCouponeSearchController *vc = [[FNLiveCouponeSearchController alloc] init];
//    [self presentViewController:vc animated:NO completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Networking

//首页头部接口
- (void)requestMain{
    @WeakObj(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=life_coupon&ctrl=index" respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        FNHomeModel *Model=[[FNHomeModel alloc]init];
        NSMutableArray *jiangeArr=[[NSMutableArray alloc]init];
        NSMutableArray *TypeArr=[[NSMutableArray alloc]init];
        NSMutableDictionary *TypeDic=[[NSMutableDictionary alloc]init];
        [self.tableSections removeAllObjects];
        
        //selfWeak.cuNaivgationbar.searchBar.placeholder=@"搜索一下吧";//listArr[0][@"str"];
        //根据传过来的数据添加对应组件
        for (NSDictionary *Dict in respondsObject) {
            NSString *TypeStr=[Dict objectForKey:typeKey];
            //            NSLog(@"11抢购:%@",TypeStr);
            NSArray *listArr=[Dict objectForKey:listKey];
            
            if ([TypeStr isEqualToString:kIndex_Topnav_01_Component]) {//导航栏
                Model.index_topnav_01List=listArr;
            }
            else if ([TypeStr isEqualToString:life_banner_01]) {//幻灯片
                NSString *banner_bili=[Dict objectForKey:@"banner_bili"];
                NSString *banner_speed=[Dict objectForKey:@"banner_speed"];
                CGFloat huandengpianHeight;
                huandengpianHeight=FNDeviceWidth*[banner_bili floatValue];
                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                //[TypeDic setObject:self.headerView.bannerView forKey:TypeStr];
                Model.index_huandengpian_01List=listArr;
                if (listArr.count > 0) {
                    [listArr[0] setValue:banner_bili forKey:@"banner_bili"];
                    [listArr[0] setValue:banner_speed forKey:@"banner_speed"];
                }
                FNCollectionViewCellIdentifier *BannerComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:TypeStr data:listArr rowHeight:huandengpianHeight];
                [self.tableSections addObject:@[BannerComponent]];
                
            }else if ([TypeStr isEqualToString:life_ico_01]) {//快速入口2
                
                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                //[TypeDic setObject:self.headerView.functionview forKey:TypeStr];
                Model.index_kuaisurukou_01List=listArr;;
                FNCollectionViewCellIdentifier *FunctionComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:TypeStr data:listArr rowHeight:[self heightForComponentInSection:TypeStr data:listArr]];
                [self.tableSections addObject:@[FunctionComponent]];
                
            }
            else if ([TypeStr isEqualToString:life_tuwen_01]) {//图文位
                
                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                //[TypeDic setObject:self.headerView.specialView forKey:TypeStr];
                //Model.index_tuwenwei_01List=listArr;
                FNCollectionViewCellIdentifier *GridComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:life_tuwen_01 data:listArr rowHeight:[self heightForComponentInSection:life_tuwen_01 data:listArr]];
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
            } else if ([TypeStr isEqualToString: life_store_01]) {
                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                //[TypeDic setObject:self.headerView.functionview forKey:TypeStr];
                Model.index_kuaisurukou_01List=listArr;;
                FNCollectionViewCellIdentifier *FunctionComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:TypeStr data:listArr rowHeight:[self heightForComponentInSection:TypeStr data:listArr]];
                [self.tableSections addObject:@[FunctionComponent]];
            }else if ([TypeStr isEqualToString: life_list_01]) {
                [jiangeArr addObject:[Dict objectForKey:jiangeKey]];
                [TypeArr addObject:TypeStr];
                //[TypeDic setObject:self.headerView.functionview forKey:TypeStr];
                Model.index_kuaisurukou_01List=listArr;;
                
                if (listArr.count > 0) {
                    NSDictionary *dict = listArr[0];
                    self.cateId = dict[@"id"];
                    self.cateType = dict[@"type"];
                    [self requestCoupon];
                }
                
                FNCollectionViewCellIdentifier *FunctionComponent = [[FNCollectionViewCellIdentifier alloc] initWithCellIdentifier:TypeStr data:listArr rowHeight:[self heightForComponentInSection:TypeStr data:listArr]];
                [self.tableSections addObject:@[FunctionComponent]];
            }
        }
        
//        [self requestThreeModelImages];
        
        Model.jiangeArr=jiangeArr;
        Model.TypeArr=TypeArr;
        Model.TypeDic=TypeDic;
        selfWeak.homeModel = Model;
        
        
//        NSMutableArray* goodsIndexArr=[[NSMutableArray alloc]init];
//
//        for (NSDictionary *dict in Model.index_goods_01List) {
//            Index_goods_01Model *goodsIndexModel=[Index_goods_01Model mj_objectWithKeyValues:dict];
//            if ([goodsIndexModel.is_check integerValue]==1) {
//                ColumnSkipUIIdentifier=goodsIndexModel.SkipUIIdentifier;
//            }
//            [goodsIndexArr addObject:goodsIndexModel.SkipUIIdentifier];
//        }
//
//        if (goodsIndexArr.count>0) {
//            ColumnSkipUIIdentifier=goodsIndexArr[0];
//        }
        
        [SVProgressHUD dismiss];
        
        [selfWeak.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
    
}

- (void)requestCoupon{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"p": @(self.jm_page)}];
    params[@"cid"] = self.cateId;
    if ([self.cateType kr_isNotEmpty]) {
        params[@"type"] = self.cateType;
    }
//    [SVProgressHUD show];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=life_coupon&ctrl=coupon_list" respondType:(ResponseTypeArray) modelType:@"FNLiveCouponeModel" success:^(NSArray* respondsObject) {
        [SVProgressHUD dismiss];
        @strongify(self)
        
        if (self.jm_page == 1) {
            [self.coupones removeAllObjects];
        }
        
        self.jm_page ++;
        
        if (respondsObject.count <= 0) {
            self.jm_collectionview.mj_footer = nil;
        } else {
            @weakify(self)
            self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                @strongify(self)
                [self requestCoupon];
            }];
        }
        
        [self.coupones addObjectsFromArray:respondsObject];
        [self.jm_collectionview reloadData];
        [self.jm_collectionview.mj_footer endRefreshing];
       
        
    } failure:^(NSString *error) {

            [XYNetworkAPI cancelAllRequest];
            [SVProgressHUD dismiss];
            [self.jm_collectionview.mj_footer endRefreshing];
        
    } isHideTips:YES];
    
}


#pragma mark -  单元
- (void)initializedSubviews
{
    self.view.backgroundColor = FNWhiteColor;
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing=0;
    flowayout.minimumInteritemSpacing=0;
    
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowayout];
    
    //向CollectionView注册所有样式组件
    //商品Cell
//    [self.jm_collectionview registerClass:[FNHomeProductCell class] forCellWithReuseIdentifier:CellIdentifier];
//    [self.jm_collectionview registerClass:[FNHomeProductSingleRowCell class] forCellWithReuseIdentifier:SingleCellId];
    //导航栏组件
//    [self.jm_collectionview registerClass:[FNTopNavViewCell class] forCellWithReuseIdentifier:kIndex_Topnav_01_Component];
    
    //幻灯片组件
    [self.jm_collectionview registerClass:[FNLiveCouponeBannerCell class] forCellWithReuseIdentifier:life_banner_01];
    
    //快速入口组件
    [self.jm_collectionview registerClass:[FNFunctionviewCell class] forCellWithReuseIdentifier:life_ico_01];
    
    //图文位组件
    [self.jm_collectionview registerClass:[FNLiveCouponeGridCell class] forCellWithReuseIdentifier:life_tuwen_01];
    
    [self.jm_collectionview registerClass:[FNLiveCouponeStoreCell class] forCellWithReuseIdentifier:life_store_01];
    
    //商品分栏视图组件
    [self.jm_collectionview registerClass:[FNSlideBarViewCell class] forCellWithReuseIdentifier:kIndex_Goods_01_Component];
    
    [self.jm_collectionview registerClass:[FNcateSortDeCell class] forCellWithReuseIdentifier:kIndex_Goods_01_Component];
    
    [self.jm_collectionview registerClass:[FNLiveCouponeCatCell class] forCellWithReuseIdentifier:life_list_01];
    [self.jm_collectionview registerClass:[FNLiveCouponeCell class] forCellWithReuseIdentifier:@"FNLiveCouponeCell"];
    
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.delegate=self;
    self.jm_collectionview.dataSource=self;
    
    self.jm_collectionview.backgroundColor=FNHomeBackgroundColor;
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
    
    @weakify(self)
    
    self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self requestCoupon];
    }];
    
}
#pragma mark UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.tableSections.count+1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //FNCollectionViewCellIdentifier *FunctionComponent=self.tableSections[section];
    
    if (section == self.tableSections.count) {
//        return self.dataArray.count;
        return self.coupones.count;
    }
    else{
        NSArray *itemArr=self.tableSections[section];
        FNCollectionViewCellIdentifier *FunctionComponent=itemArr[0];
        NSLog(@"cellIdentifier:%@",self.tableSections);
        if ([FunctionComponent.cellIdentifier isEqualToString:life_ico_01]){
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
    
    if ([row.cellIdentifier isEqualToString:life_banner_01]) {
        
        FNLiveCouponeBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
//        cell.bannerView.contentMode = UIViewContentModeScaleAspectFit;
//        cell.bannerArray = row.data;
        [cell setBannerArray:row.data withHeight:row.rowHeight speed:4000];
        cell.bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
//        cell.bannerView.autoScrollTimeInterval =
        cell.BannerClickedBlock = ^(NSInteger index) {
            [selfWeak loadOtherVCWithModel:selfWeak.homeModel.index_huandengpian_01List[index] andInfo:nil outBlock:nil];
        };
        return cell;
    }
    else if ([row.cellIdentifier isEqualToString:life_ico_01]){
        FNFunctionviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
        //            cell.index_kuaisurukou_01List = row.data;
        [cell setIndex_kuaisurukou_01List:row.data withColumn:[row.cellIdentifier isEqualToString:life_ico_01] ? 5 : 4];
//        cell.cateString=self.categoryId;
        cell.functionbgimgview.hidden = YES;
        cell.QuickClickedBlock = ^(MenuModel *model) {
//            if([selfWeak.categoryId isEqualToString:@"0"]){
                [selfWeak loadOtherVCWithModel:model andInfo:nil outBlock:nil];
//            }else{
//                [self withSeletedCareTwo:model];
//            }
        };
        return cell;
    }else if ([row.cellIdentifier isEqualToString:life_tuwen_01]){
        FNLiveCouponeGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
        cell.index_tuwenwei_01List = row.data;
        cell.QuickClickedBlock = ^(MenuModel *model) {
            [selfWeak loadOtherVCWithModel:model andInfo:nil outBlock:nil];
        };
        
        return cell;
    }
    else if ([row.cellIdentifier isEqualToString:life_store_01]){
        FNLiveCouponeStoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObjectsFromArray:row.data];
        [array addObjectsFromArray:row.data];
        [cell setIndex_store_01List:row.data withColumn:4];
        cell.QuickClickedBlock = ^(MenuModel *model) {
            [selfWeak loadOtherVCWithModel:model andInfo:nil outBlock:nil];
        };
        return cell;
    }
    else if ([row.cellIdentifier isEqualToString:life_list_01]) {
        FNLiveCouponeCatCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in row.data) {
            [array addObject:dict[@"name"]];
        }
        cell.delegate = self;
        [cell.slider setTitles:array];
        [cell.slider setSelected:_cateIndex animated:NO];
        
        return cell;
    }
    else if ([row.cellIdentifier isEqualToString:kIndex_Goods_01_Component]){
        FNcateSortDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
        cell.sortArr=row.data;
//        cell.delegate=self;
//        cell.categoryId=self.categoryId;
//        cell.singleType=singleBool;
        return cell;
        
    }
    else if (indexPath.section == self.tableSections.count){
        FNLiveCouponeCell *cell = [self.jm_collectionview dequeueReusableCellWithReuseIdentifier:@"FNLiveCouponeCell" forIndexPath:indexPath];
        
        FNLiveCouponeModel *model = self.coupones[indexPath.row];
        [cell.imgHeader sd_setImageWithURL:URL(model.img)];
        cell.lblTitle.text = model.name;
        cell.lblDesc.text = model.str;
        cell.lblCount.text = model.count_str;
//        [cell.btnAccept sd_setBackgroundImageWithURL:URL(model.btn_img) forState:(UIControlStateNormal)];
        [cell.btnAccept sd_setImageWithURL:URL(model.btn_img)];
    
        return cell;
//        FNBaseProductModel *model = self.dataArray[indexPath.row];
//
//        if(singleBool==YES){
//            FNHomeProductSingleRowCell *cell = [FNHomeProductSingleRowCell cellWithCollectionView:collectionView atIndexPath:indexPath];
//            cell.model = model;
//            cell.backgroundColor=[UIColor whiteColor];
//            cell.sharerightNow = ^(FNBaseProductModel *mod) {
//                [self shareProductWithModel:mod];
//            };
//            cell.clipsToBounds = YES;
//            return cell;
//        }else{
//            FNHomeProductCell *cell = [FNHomeProductCell cellWithCollectionView:collectionView atIndexPath:indexPath];
//            cell.model = model;
//            cell.backgroundColor=[UIColor whiteColor];
//            cell.borderColor = FNGlobalTextGrayColor;
//            cell.clipsToBounds = YES;
//            cell.sharerightNow = ^(FNBaseProductModel *mod) {
//                [self shareProductWithModel:mod];
//            };
//            return cell;
//        }
    }
    
    
    return nil;
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
//        if(singleBool==YES){
            CGFloat singlewidth=86;
            return CGSizeMake(FNDeviceWidth,  singlewidth);
//        }else{
//            double w = FNDeviceWidth/2;
//            return CGSizeMake(w, w+110);
//        }
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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == self.tableSections.count) {
        if (self.coupones.count>0) {
            FNLiveCouponeModel *model = self.coupones[indexPath.row];
            [self goWebWithUrl:model.url];
        }
    }
}

#pragma mark - //计算Cell高度
- (CGFloat)heightForComponentInSection:(NSString *)ComponentStr data:(NSArray *)data {
    
    if ([ComponentStr isEqualToString:life_banner_01]) {
        
        double height =0;
        headerHeight += height;
        
        return height;
    }
    
    else if ([ComponentStr isEqualToString:life_ico_01]){
        
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
    }else if ([ComponentStr isEqualToString:life_tuwen_01]){
        double height = 0.53*FNDeviceWidth;
        headerHeight += height;
        
        return height;
    }else if ([ComponentStr isEqualToString:kIndex_Goods_01_Component]){
        double height = 80 ;
        if(![[FNBaseSettingModel settingInstance].index_cgfjx_ico kr_isNotEmpty]){
            height = 40;
        }
        headerHeight += height;
//        if([self.categoryId isEqualToString:@"0"]){
//            height=40;
//        }
        return height;
    }else if ([ComponentStr isEqualToString:life_store_01]){
        
        double height ;
        
        if (data.count > 4 && data.count <=8) {
            height = 144;
        }else if (data.count > 8){
            height = 144 + _quick_pageH;
        }
        else if (data.count == 0){
            height = 0;
        }
        else{
            height = 90;
            
        }
        headerHeight += height;
        return height;
    }else if ([ComponentStr isEqualToString:life_list_01]) {
        double height = 40;
        headerHeight += height;
        return height;
    }else{
        return 0;
    }
}

#pragma mark - FNLiveCouponeStoreCellDelegate

- (void)cell:(FNLiveCouponeStoreCell *)cell didItemSelectedAt:(NSInteger)index {
    NSIndexPath *indexPath = [self.jm_collectionview indexPathForCell:cell];
    NSDictionary *dict = self.tableSections[indexPath.section][0].data[index];
    
    self.jm_page = 1;
    self.cateId = dict[@"id"];
    self.cateType = dict[@"type"];
    [self requestCoupon];
    _cateIndex = index;
}

@end
