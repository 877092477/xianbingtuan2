//
//  FNCommodityFieldDeController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCommodityFieldDeController.h"
#import "FNCommColumnItController.h"
#import "FNCustomeNavigationBar.h"
#import "FNCommodityRecommendCell.h"
#import "FNCommodityActivityItemACell.h"
#import "FNCommodityGoodsItemMCell.h"

#import "FNBannerViewCell.h"
#import "FNADViewCell.h"


#import "FNCommSortHFView.h"
#import "FNCommRecommendPView.h"
#import "FNBaseProductModel.h"
#import "Index_threemodel_01Model.h"

@interface FNCommodityFieldDeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNCommodityRecommendCellDelegate,FNCommodityActivityItemACellDelegate,FNCommSortHFViewDelegate>

@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIImageView *imgTopHeader;
@property (nonatomic, strong)UIImageView *imgHeader;
@property (nonatomic, strong)FNCommSortHFView *headerSort;
@property (nonatomic, strong)DSHPopupContainer *container;

@property (nonatomic, assign)UICollectionReusableView *headView;

@property (nonatomic, strong)FNCommodityFieldTopModel *topModel;

@property (nonatomic, strong)NSMutableArray *styleArr;

@property (nonatomic, strong)NSMutableArray *dataGoodsArr;

@property (nonatomic, strong)NSMutableArray *cateArr;

@property (nonatomic, strong)NSString *cid;

@property (nonatomic, strong)NSArray *bannerArr;

@property (nonatomic, strong)MJRefreshNormalHeader *pullHeader;
@end

@implementation FNCommodityFieldDeController
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
}

#pragma mark - set top views
- (void)setTopViews{
    
    CGFloat imgH=258;
    self.imgHeader = [[UIImageView alloc] init];
    //self.imgHeader.backgroundColor=[UIColor whiteColor];
    [self.view insertSubview:_imgHeader atIndex:0];
    self.imgHeader.contentMode=UIViewContentModeScaleToFill;
    self.imgHeader.clipsToBounds=YES;
    [self.imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
        //make.height.mas_equalTo(imgH);
    }];
    self.imgHeader.image=IMAGE(@"FN_SP_topBImg");
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.view addSubview:self.navigationView];
    [self.view bringSubviewToFront:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 18);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:200];
    self.navigationView.titleLabel.text=self.keyWord?self.keyWord:@"商品专场";//;
    [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor clearColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.leftBtn.imageView.sd_layout
    .centerYEqualToView(self.leftBtn).widthIs(8).heightIs(16).leftSpaceToView(self.leftBtn, 10);
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
    //[self addCateViewS];
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - set up views
- (void)jm_setupViews{
    
    self.view.backgroundColor =RGB(250, 250, 250);
    CGFloat baseGap=0;
    if(self.understand==YES){
        baseGap=XYTabBarHeight;
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    //flowlayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    if (@available(iOS 9.0, *)) {
        flowlayout.sectionHeadersPinToVisibleBounds = YES;
    }
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, FNDeviceHeight-baseGap-SafeAreaTopHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.alpha = 1;
    self.jm_collectionview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.jm_collectionview];
    
    [self.jm_collectionview registerClass:[FNBannerViewCell class] forCellWithReuseIdentifier:@"goodsspecial_huandengpian_01"];
    [self.jm_collectionview registerClass:[FNADViewCell class] forCellWithReuseIdentifier:@"goodsspecial_one_banner_01"];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"goodsspecial_goods_01"];
    
    [self.jm_collectionview registerClass:[FNCommodityRecommendCell class] forCellWithReuseIdentifier:@"FNCommodityRecommendCellID"];
    [self.jm_collectionview registerClass:[FNCommodityActivityItemACell class] forCellWithReuseIdentifier:@"FNCommodityActivityItemACellID"];
    [self.jm_collectionview registerClass:[FNCommodityGoodsItemMCell class] forCellWithReuseIdentifier:@"FNCommodityGoodsItemMCellID"];

    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView1"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewNU"];
    [self setTopViews];
    
    [self requestSpecialTop];
    [self requestSpecialStyle];
    [self requestSpecialGoodsShow];
    //[self requestMain:YES];
    //[self requestSpecialGoodsShow];
    
//    self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        self.jm_page=1;
//        [self requestSpecialGoods];
//    }];
    
    self.pullHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onePageNumberData)];
    // 设置头部
    self.jm_collectionview.mj_header = self.pullHeader;
    
    self.headerSort=[[FNCommSortHFView alloc]init];
    self.headerSort.frame=CGRectMake(0, 0, FNDeviceWidth, 105);
    self.headerSort.delegate=self;
    self.headerSort.backgroundColor=[UIColor whiteColor];
}
-(void)onePageNumberData{
    self.jm_page=1;
    [self requestSpecialGoods];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.styleArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FNCommodityFieldModel *model=self.styleArr[section];
    if([model.type isEqualToString:@"goodsspecial_goods_01"]){
        return self.dataGoodsArr.count;
    }
    else{
        return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        @WeakObj(self);
        FNCommodityFieldModel *model=self.styleArr[indexPath.section];
        if([model.type isEqualToString:@"goodsspecial_huandengpian_01"]){
            //幻灯片
            FNBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"goodsspecial_huandengpian_01" forIndexPath:indexPath];
            cell.bannerView.cornerRadius=10;
            cell.bannerArray = model.list;
            cell.backgroundColor=[UIColor clearColor];
            cell.BannerClickedBlock = ^(NSInteger index) {
                [selfWeak loadOtherVCWithModel:selfWeak.bannerArr[index] andInfo:nil outBlock:nil];
            };
            return cell;
        }
        else if([model.type isEqualToString:@"goodsspecial_one_banner_01"]){
            //一个广告 ||二个广告 || 三个广告
            FNADViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"goodsspecial_one_banner_01" forIndexPath:indexPath];
            cell.adView.backgroundColor=[UIColor clearColor];
            cell.index_threemodel_01List = model.list;
            cell.QuickClickedBlock = ^(MenuModel *model) {
                //[selfWeak loadOtherVCWithModel:model andInfo:nil outBlock:nil];
                [selfWeak didSeletedAdvertisingPushVC:model];
            };
            return cell;
        }
        else if([model.type isEqualToString:@"goodsspecial_changegoods_01"]){
            //幻灯片商品
            FNCommodityRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNCommodityRecommendCellID" forIndexPath:indexPath];
            cell.backgroundColor=[UIColor clearColor];
            if([self.topModel.info kr_isNotEmpty]){
               cell.titleLB.textColor=[UIColor colorWithHexString:self.topModel.top_fontcolor];
               cell.titleLB.text=self.topModel.info;
            }
            cell.dataArr=model.list;
            cell.delegate=self;
            return cell;
        }else if([model.type isEqualToString:@"goodsspecial_rowgoods_01"]){
            //横滑商品
            FNCommodityActivityItemACell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNCommodityActivityItemACellID" forIndexPath:indexPath];
            cell.backgroundColor=[UIColor clearColor];
            cell.delegate=self;
            cell.indexS=indexPath;
            cell.dataArr=model.list;
            return cell;
        }
        else{
            //商品
            FNBaseProductModel *model=[FNBaseProductModel mj_objectWithKeyValues:self.dataGoodsArr[indexPath.row]];
            FNCommodityGoodsItemMCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNCommodityGoodsItemMCellID" forIndexPath:indexPath];
            cell.backgroundColor=[UIColor clearColor];
            cell.model=model;
            cell.sharerightNow = ^(FNBaseProductModel *mod) {
                [self shareProductWithModel:mod]; 
            };
            return cell;
        }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNCommodityFieldModel *model=self.styleArr[indexPath.section];
    CGFloat height=0;
    CGFloat with= FNDeviceWidth;
    height=model.rowHeight;
    if([model.type isEqualToString:@"goodsspecial_goods_01"]){
        //商品
        height=300;
        with=(FNDeviceWidth-10)/2;
    }else if([model.type isEqualToString:@"goodsspecial_one_banner_01"]){
        //广告
       with=FNDeviceWidth-15;
    }
    else if([model.type isEqualToString:@"goodsspecial_huandengpian_01"]){
       //幻灯片
       with=FNDeviceWidth-30;
    }
    CGSize  size= CGSizeMake(with, height);
    return  size;
  
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
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FNCommodityFieldModel *model=self.styleArr[indexPath.section];
    if([model.type isEqualToString:@"goodsspecial_goods_01"]){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView1" forIndexPath:indexPath];
        self.headView= headerView;
        if(self.headerSort.superview == nil) {
            [headerView addSubview:self.headerSort];
        }
        return headerView;
    }
    else{
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewNU" forIndexPath:indexPath];
        return headerView;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    FNCommodityFieldModel *model=self.styleArr[section];
    CGFloat with=FNDeviceWidth;
    CGFloat hight=45;
    if([model.type isEqualToString:@"goodsspecial_goods_01"]){
        hight=105;
    }
    else{
        hight=0;
    }
    return CGSizeMake(with,hight);
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    FNCommodityFieldModel *model=self.styleArr[section];
    
    CGFloat topGap=0;
    CGFloat leftGap=0;
    CGFloat bottomGap=0;
    CGFloat rightGap=0;
    if([model.jiange kr_isNotEmpty]){
        bottomGap=[model.jiange floatValue];
    }
    if([model.type isEqualToString:@"goodsspecial_goods_01"]){
        topGap=0;
        //bottomGap=0;
        leftGap=5;
        rightGap=5;
    }
    else if([model.type isEqualToString:@"goodsspecial_one_banner_01"]){
        topGap=0;
        //bottomGap=0;
        leftGap=15;
        rightGap=0;
    }
    else if([model.type isEqualToString:@"goodsspecial_huandengpian_01"]){
        topGap=10;
        //bottomGap=10;
        leftGap=15;
        rightGap=15;
    }
    else if([model.type isEqualToString:@"goodsspecial_changegoods_01"]){
        topGap=0;
        leftGap=0;
        rightGap=0; 
    }
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.styleArr.count>0){
       FNCommodityFieldModel *model=self.styleArr[indexPath.section];
        if([model.type isEqualToString:@"goodsspecial_goods_01"]){
            FNBaseProductModel *model=[FNBaseProductModel mj_objectWithKeyValues:self.dataGoodsArr[indexPath.row]];
            [self goProductVCWithModel:model withData:model.data];
        }
    }
}
#pragma mark - FNCommodityRecommendCellDelegate  // 点击切换的商品
- (void)didCommodityRecommendItemAction:(FNBaseProductModel*)model{
    [self goProductVCWithModel:model withData:model.data];
}
//分享
- (void)didCommodityRecommendShareGoodsAction:(FNBaseProductModel*)model{
    [self shareProductWithModel:model];
}
#pragma mark - FNCommodityActivityItemACellDelegate // 点击更多
- (void)didCommodityActivityItemMoreAction:(NSIndexPath*)indexS{
    //FNCommColumnItController *vc=[[FNCommColumnItController alloc]init];
    //vc.understand=NO;
    //vc.keyWord=@"美好家居";
    //[self.navigationController pushViewController:vc animated:YES];
}
- (void)didCommodityActivityItemGoodsAction:(FNBaseProductModel*)model{
    [self goProductVCWithModel:model withData:model.data];
}
#pragma mark - FNCommSortHFViewDelegate // 点击分类
- (void)didCommSortHFViewDelegateItemAction:(NSInteger)index{
    if(self.cateArr.count>0){
      FNCommoditySortItemModel *model=self.cateArr[index];
      self.cid=model.id;
      self.jm_page =1;
      [self requestSpecialGoods];
    }
}

#pragma mark -  点击广告
-(void)didSeletedAdvertisingPushVC:(id)model{
//    MenuModel *itemModel=[MenuModel mj_objectWithKeyValues:model];
//    NSString *SkipUIIdentifier=itemModel.SkipUIIdentifier;
//    if([SkipUIIdentifier isEqualToString:@"pub_goods_special_performance_detail"]){
//        FNCommColumnItController *vc=[[FNCommColumnItController alloc]init];
//        vc.understand=NO;
//        vc.keyWord=itemModel.name;
//        vc.SkipUIIdentifier=itemModel.SkipUIIdentifier;
//        vc.show_type_str=itemModel.show_type_str;
//        vc.headModel=itemModel;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else{
        [self loadOtherVCWithModel:model andInfo:nil outBlock:nil];
//    } 
}
#pragma mark - 弹出商品
-(void)disSpecialGoodsShow:(NSDictionary*)send{
    FNBaseProductModel *goodModel=[FNBaseProductModel mj_objectWithKeyValues:send];
    FNCommRecommendPView *customView = [[FNCommRecommendPView alloc] init];
    customView.goodModel=goodModel;
    [customView.cancelBtn addTarget:self action:@selector(cancelBtnAction)];
    self.container = [[DSHPopupContainer alloc] initWithCustomPopupView:customView];
    self.container.autoDismissWhenClickedBackground=NO;
    self.container.maskColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    [self.container show];
    @weakify(self);
    customView.showCheckGoods = ^(FNBaseProductModel * _Nonnull model) {
        @strongify(self);
        [self.container dismiss];
        [self goProductVCWithModel:model withData:model.data];
    };
}
-(void)cancelBtnAction{
    [self.container dismiss];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}
#pragma mark - request
- (void)requestMain: (BOOL)isCache{
    @weakify(self);
    [FNRequestTool startWithRequests:@[[self requestSpecialTop],[self requestSpecialStyle],[self requestSpecialGoodsCate]] withFinishedBlock:^(NSArray *erros) {
        @strongify(self);
        //[SVProgressHUD dismiss];
        //[self requestSpecialGoods];
        //[self requestSpecialGoodsShow];
        [self.jm_collectionview reloadData];
    }];
}

#pragma mark - //专场头部
-(FNRequestTool*)requestSpecialTop{
    [SVProgressHUD show];
    //@WeakObj(self);
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=goods_special_performance&ctrl=top_list" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dictry = respondsObject[DataKey];
        self.topModel=[FNCommodityFieldTopModel mj_objectWithKeyValues:dictry];
        @strongify(self);
        //self.navigationView.titleLabel.text=self.topModel.info;
        self.navigationView.titleLabel.textColor=[UIColor colorWithHexString:self.topModel.top_fontcolor];
        [self.leftBtn sd_setImageWithURL:URL(self.topModel.return_img) forState:UIControlStateNormal];
        [self.imgHeader setUrlImg:self.topModel.bj_img];
        
        if([self.topModel.bj_img kr_isNotEmpty]){
            self.pullHeader.stateLabel.textColor=[UIColor whiteColor];
            self.pullHeader.lastUpdatedTimeLabel.textColor=[UIColor whiteColor];
        }else{
            self.pullHeader.stateLabel.textColor=RGB(153, 153, 153);
            self.pullHeader.lastUpdatedTimeLabel.textColor=RGB(153, 153, 153);
        }
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - //专场样式
-(FNRequestTool*)requestSpecialStyle{
    [SVProgressHUD show];
    //@WeakObj(self);
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=goods_special_performance&ctrl=getIndex" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        NSArray *arrM = respondsObject[DataKey];
        @strongify(self);
        if(arrM.count>0){
            NSMutableArray *typeArray=[NSMutableArray arrayWithCapacity:0];
            [arrM enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNCommodityFieldModel *model=[FNCommodityFieldModel mj_objectWithKeyValues:obj];
                if ([model.type isEqualToString:@"goodsspecial_huandengpian_01"]) {
                    self.bannerArr=model.list;
                    model.rowHeight=FNDeviceWidth*0.52;
                }else if ([model.type isEqualToString:@"goodsspecial_one_banner_01"] ||
                          [model.type isEqualToString:@"goodsspecial_two_banner_01"] ||
                          [model.type isEqualToString:@"goodsspecial_three_banner_01"] ){
//                    if (model.list.count > 5 && model.list.count <=10) {
//                        model.rowHeight=  147;
//                    }else if (model.list.count > 10){
//                        model.rowHeight=  147 + 20;
//                    }else{
//                        model.rowHeight=  147 * 0.5;
//                    }
                    NSMutableArray* images = [NSMutableArray new];
                    for (NSDictionary *dict in model.list) {
                        Index_threemodel_01Model *threemodel=[Index_threemodel_01Model mj_objectWithKeyValues:dict];
                        [images addObject:threemodel.img];
                    }
                    model.type=@"goodsspecial_one_banner_01";
                    model.imageUrls = images;
                }else if ([model.type isEqualToString:@"goodsspecial_changegoods_01"]){
                    model.rowHeight=222;
                }
                else if ([model.type isEqualToString:@"goodsspecial_rowgoods_01"]){
                    model.rowHeight=240;//350
                }
                else if ([model.type isEqualToString:@"goodsspecial_goods_01"]){
                    self.show_type_str=model.show_type_str;
                    model.rowHeight=1;
                }
                [typeArray addObject:model];
            }];
            self.styleArr=typeArray;
            [self requestThreeModelImages];
            [self requestSpecialGoodsCate];
            [UIView performWithoutAnimation:^{
                [self.jm_collectionview reloadData];
            }]; 
        }
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
- (void)requestThreeModelImages {
    for (FNCommodityFieldModel *model in self.styleArr) {
        CGFloat padding = 0;//[model.jiange floatValue];
        NSArray<NSString*> *images = model.imageUrls;
        if ([model.type isEqualToString:@"goodsspecial_one_banner_01"]
            && images && images.count > 0){ 
                @weakify(model)
                @weakify(self)
                [SDWebImageManager.sharedManager downloadImageWithURL:URL(images[0]) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    @strongify(model)
                    @strongify(self)
                    if(error){
                        model.rowHeight=0;
                        [UIView performWithoutAnimation:^{
                            [self.jm_collectionview reloadData];
                        }];
                    }else{
                        if (finished) {
                            CGFloat imgW = (FNDeviceWidth-(padding*images.count+padding))/images.count;
                            model.rowHeight=image.size.height/image.size.width*imgW+padding*2;
                            
                            [UIView performWithoutAnimation:^{
                                [self.jm_collectionview reloadData];
                            }];
                        }
                    }
                }];
            }
    } 
}
#pragma mark - //专场商品
-(FNRequestTool*)requestSpecialGoods{
    [self.jm_collectionview.mj_footer endRefreshing];
    [self.jm_collectionview.mj_header endRefreshing];
    //[SVProgressHUD show];
    //@WeakObj(self);
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    if([self.cid kr_isNotEmpty]){
        params[@"cid"]=self.cid;
    }
    if([self.show_type_str kr_isNotEmpty]){
        params[@"show_type_str"]=self.show_type_str;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=goods_special_performance&ctrl=getgoods" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //[SVProgressHUD dismiss]; 
        @strongify(self);
        NSArray *array=respondsObject[DataKey];
        XYLog(@"专场商品=%@",array);
        if (self.jm_page == 1) {
            if (array.count == 0) {
                return ;
            }
            [self.dataGoodsArr removeAllObjects];
            [self.dataGoodsArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
//                self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//                    self.jm_page ++;
//                    [self requestSpecialGoods];
//                }];
                MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
                // 设置尾部
                self.jm_collectionview.mj_footer = footer;
                if([self.topModel.bj_img kr_isNotEmpty]){
                   footer.stateLabel.textColor=[UIColor whiteColor];
                }else{
                    footer.stateLabel.textColor=RGB(153, 153, 153);
                }
            }else{
            }
        } else {
            [self.dataGoodsArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                [self.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
                //self.jm_collectionview.mj_footer.mj
            }
        }
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadData];
        }];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
-(void)loadMoreData{
    self.jm_page ++;
    [self requestSpecialGoods];
}
#pragma mark - //商品分类
-(FNRequestTool*)requestSpecialGoodsCate{
    //@WeakObj(self);
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.show_type_str kr_isNotEmpty]){
        params[@"show_type_str"]=self.show_type_str;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=goods_special_performance&ctrl=cate" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSArray *arrM=respondsObject[DataKey];
        if(arrM.count>0){
            NSMutableArray *tyArray=[NSMutableArray arrayWithCapacity:0];
            [arrM enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNCommoditySortItemModel *model=[FNCommoditySortItemModel mj_objectWithKeyValues:obj];
                model.sortid=idx;
                if(idx==0){
                    self.cid=model.id;
                    model.state=1;
                }else{
                    model.state=0;
                }
                [tyArray addObject:model];
            }];
            self.cateArr=tyArray;
            self.headerSort.dataArr=self.cateArr;
            [self requestSpecialGoods];
            [UIView performWithoutAnimation:^{
                [self.jm_collectionview reloadData];
            }];
        }
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - //专场弹窗商品
-(FNRequestTool*)requestSpecialGoodsShow{
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=goods_special_performance&ctrl=goods_show" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        NSArray *arrM = respondsObject[DataKey];
        XYLog(@"推荐:%@",arrM);
        @strongify(self);
        if(arrM.count>0){
           NSDictionary * dictry=arrM[0];
           [self disSpecialGoodsShow:dictry];
        }
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:NO];
}
- (NSMutableArray *)styleArr{
    if (!_styleArr) {
        _styleArr = [NSMutableArray array];
    }
    return _styleArr;
}

- (NSMutableArray *)dataGoodsArr{
    if (!_dataGoodsArr) {
        _dataGoodsArr = [NSMutableArray array];
    }
    return _dataGoodsArr;
}
- (NSMutableArray *)cateArr{
    if (!_cateArr) {
        _cateArr = [NSMutableArray array];
    }
    return _cateArr;
}

@end
