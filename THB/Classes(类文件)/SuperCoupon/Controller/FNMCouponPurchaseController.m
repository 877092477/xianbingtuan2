//
//  FNMCouponPurchaseController.m
//  LikeKaGou
//
//  Created by jimmy on 16/10/8.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "FNMCouponPurchaseController.h"

#import "FNSiftViewController.h"

#import "JMHomeProductCell.h"
#import "SDCycleScrollView.h"
#import "JMTitleScrollView.h"

#import "FNMCouponGoodsView.h"
#import "FNMCSubCategoryView.h"

#import "FNAPIProductsTool.h"
#import "FNBuyProductModel.h"
#import "FNCouponListModel.h"
#import "FNAPIHome.h"
#import "MenuModel.h"
#import "XYTitleModel.h"
#import "FNMCTopGoodsModel.h"
#import "FNHomeSpecialCell.h"
#import "FNBuyProductHeatNView.h"
#import "FNPartnerGoodsNewCell.h"
@interface FNMCouponPurchaseController ()<UITableViewDelegate,UITableViewDataSource,JMTitleScrollViewDelegate,SDCycleScrollViewDelegate>
@property (nonatomic, strong)UIView* headerView;
@property (nonatomic, strong)SDCycleScrollView* bannerView;
@property (nonatomic, strong)NSLayoutConstraint* bannerConsH;
@property (nonatomic, strong)JMTitleScrollView* titleView;
@property (nonatomic, strong)UIImageView* titleImgView;
@property (nonatomic, strong)UIImageView* toTopImage;
@property (nonatomic, strong)FNMCouponGoodsView* goodsview;
@property (nonatomic, strong)NSLayoutConstraint* goodsviewConsH;
@property (nonatomic, strong)UIImageView* adImgview;
@property (nonatomic, strong)NSLayoutConstraint* adConsH;
@property (nonatomic, strong)FNMCSubCategoryView* categoryview;

@property (nonatomic, strong)NSLayoutConstraint* heatViewConsH;



@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, strong) NSMutableArray<MenuModel *>* banners;
@property (nonatomic, strong) NSMutableArray<XYTitleModel *>* categories;
@property (nonatomic, strong) NSArray<XYTitleModel *>* subcategories;
@property (nonatomic, strong) NSMutableArray* categoryTitles;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray<FNMCTopGoodsModel *>* topgoods;

@property (nonatomic, strong) NSMutableArray *heatgoods;
@property (nonatomic, strong) MenuModel* adModel;

@property (nonatomic, copy)NSString* bannerType;
@property (nonatomic, copy)NSString* cateType;
@property (nonatomic, copy)NSString* goodsType;
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, assign)NSInteger subindex;


/**搜索的内容 */
@property (nonatomic,strong) NSString *searchTitle;

/**排序条件（1.最新,2.最热) */
@property (nonatomic,assign) NSNumber *sort;

/**最低价格 */
@property (nonatomic,assign) int price1;

/**最高价格*/
@property (nonatomic,assign) int price2;

/**过去一小时商品*/
@property (nonatomic,strong) FNBuyProductHeatNView *heatView;
@end

@implementation FNMCouponPurchaseController
@synthesize toTopImage;
- (NSMutableArray<MenuModel *> *)banners
{
    if (_banners == nil) {
        _banners = [NSMutableArray new];
    }
    return _banners;
}
- (NSMutableArray<XYTitleModel *>*)categories
{
    if (_categories == nil) {
        _categories = [NSMutableArray new];
    }
    return _categories;
}
- (NSMutableArray *)categoryTitles
{
    if (_categoryTitles == nil) {
        _categoryTitles = [NSMutableArray new];
    }
    return _categoryTitles;
}
- (NSMutableArray *)products
{
    if (_products == nil) {
        _products = [NSMutableArray new];
    }
    return _products;
}
- (UIImageView *)titleImgView{
    if (_titleImgView == nil) {
        _titleImgView = [UIImageView new];
        _titleImgView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _titleImgView;
}
- (FNMCouponGoodsView *)goodsview{
    if (_goodsview == nil) {
        _goodsview = [[FNMCouponGoodsView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, FNDeviceWidth*0.53+10))];
        @WeakObj(self);
        _goodsview.viewclicked = ^(FNMCTopGoodsModel *mdoel) {
            [selfWeak loadOtherVCWithModel:mdoel andInfo:nil outBlock:nil];
        };
    }
    return _goodsview;
}
- (SDCycleScrollView *)bannerView{
    if (_bannerView == nil) {
        _bannerView = [[SDCycleScrollView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0.4*FNDeviceWidth))];
        _bannerView.delegate = self;
    }
    return _bannerView;
}
- (JMTitleScrollView *)titleView{
    if (_titleView == nil) {
        _titleView = [[JMTitleScrollView alloc]initWithFrame:(CGRectMake(0, 0.93*FNDeviceWidth, FNDeviceWidth, 40)) titleArray:@[] fontSize:14 _textLength:4 andButtonSpacing:0 type:(VariableType)];
        _titleView.borderColor = FNHomeBackgroundColor;
        _titleView.borderWidth= 1.0;
        _titleView.tDelegate  =self;
    }
    return _titleView;
}
- (FNMCSubCategoryView *)categoryview{
    if (_categoryview == nil) {
        _categoryview = [[FNMCSubCategoryView alloc]initWithFrame:(CGRectMake(0, self.bannerConsH.constant + self.goodsviewConsH.constant+self.adConsH.constant+  self.heatViewConsH.constant, FNDeviceWidth, 0))];
        //_headerView.backgroundColor=[UIColor blueColor];
        _categoryview.cateDelegate = self;
        @WeakObj(self);
        _categoryview.filterbtnClicked = ^(SCFilterType index) {
            selfWeak.sort = @(index);
            selfWeak.jm_page = 1;
            [SVProgressHUD show];
            [selfWeak apiRequestProducts];
        };
        
    }
    return _categoryview;
}
- (FNBuyProductHeatNView *)heatView{
    if (_heatView == nil) {
        _heatView=[FNBuyProductHeatNView new]; 
        _heatView.recordInt=2;
        CGFloat Height=JMScreenWidth/3+60+50;
        _heatView.frame=CGRectMake(0, 0, FNDeviceWidth, Height);
        @WeakObj(self);
        _heatView.selectHeatCommodityNow = ^(FNBaseProductModel *model) {
            [selfWeak goProductVCWithModel:model withData:model.data];
        }; 
    }
    return _heatView;
}
- (UIView *)headerView{
    if (_headerView == nil) {
        _headerView = [UIView new];
        
        
        [_headerView addSubview:self.bannerView];
        [self.bannerView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
        _bannerConsH =  [_bannerView autoSetDimension:(ALDimensionHeight) toSize:0.4*FNDeviceWidth];
        
        [_headerView addSubview:self.goodsview];
        [self.goodsview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [self.goodsview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [self.goodsview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.bannerView withOffset:0];
        self.goodsviewConsH = [self.goodsview autoSetDimension:(ALDimensionHeight) toSize:self.goodsview.height];
        
      
        [_headerView addSubview:self.heatView];
        [self.heatView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.self.goodsview];
        [self.heatView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [self.heatView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        self.heatViewConsH= [self.heatView autoSetDimension:(ALDimensionHeight) toSize:self.heatView.height];
        
        [_headerView addSubview:self.adImgview];
        [self.adImgview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.heatView];
        [self.adImgview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [self.adImgview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        self.adConsH = [self.adImgview autoSetDimension:(ALDimensionHeight) toSize:0];
        
        
        [_headerView addSubview:self.categoryview];
        _headerView.width = FNDeviceWidth;
        [self changeHeaderHeight];
        
    }
    return _headerView;
}
- (UIImageView *)adImgview{
    if (_adImgview == nil) {
        _adImgview = [UIImageView new];
        @WeakObj(self);
        [_adImgview addJXTouch:^{
            [selfWeak loadOtherVCWithModel:selfWeak.adModel andInfo:nil outBlock:nil];
            
        }];
    }
    return _adImgview;
}

- (void)setTopgoods:(NSArray<FNMCTopGoodsModel *> *)topgoods{
    _topgoods = topgoods;
    if (_topgoods.count>=1) {
        self.goodsview.datas = _topgoods;
        self.goodsviewConsH.constant = FNDeviceWidth*0.53+10;
    }else{
        self.goodsviewConsH.constant = 0;
    }
    [self changeHeaderHeight];
    
}
- (void)setAdModel:(MenuModel *)adModel{
    _adModel = adModel;
//    self.adConsH.constant = FNDeviceWidth*0.4;
//    [self.adImgview setUrlImg:self.adModel.image];
    [self.adImgview sd_setImageWithURL:URL(self.adModel.image) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && [image isKindOfClass:[UIImage class]]) {
            CGFloat rate = image.size.height/image.size.width;
            self.adConsH.constant = JMScreenWidth*rate;
        }else{
            self.adConsH.constant = 0;
        }
        [self changeHeaderHeight];
    }];
//    [self changeHeaderHeight];
}

-(void)setHeatgoods:(NSMutableArray *)heatgoods{
    _heatgoods=heatgoods;
    CGFloat Height=JMScreenWidth/3+60+50;
    if (_heatgoods.count>=1) { 
        self.heatViewConsH.constant = Height;
    }else{
       self.heatViewConsH.constant = 0;
    }
    [self changeHeaderHeight];
    
}
- (void)setSubcategories:(NSArray<XYTitleModel *> *)subcategories{
    _subcategories = subcategories;
    self.categoryview.subcates = _subcategories;
}
-(void)dealloc{
    [FNNotificationCenter removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册通知

    NSString* img = @"high_logo";
    
    self.sort = @1;
    switch (self.type) {
        case VCTypeHighRebate:
        {
            self.bannerType = @"107";
            self.cateType = @"cgf";

            self.goodsType = @"1";
            img = @"high_logo";
            img = [FNBaseSettingModel settingInstance].index_cgfdb_ico;
            break;
        }
        case VCTypeCoupon:{
            self.bannerType =  @"103";
            self.cateType = @"yhq";

            self.goodsType = @"11";
            img = @"coupon_logo";
            img = [FNBaseSettingModel settingInstance].index_cjqjx_ico;
            break;
        }
        case VCTypeNine:{
            
        }
        default:
            break;
    }
    self.titleImgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:URL(img)]];

    
    UIView* bgview = [UIView new];
    [bgview addSubview:self.titleImgView];
    [self.titleImgView autoSetDimensionsToSize:IMAGE(@"high_logo").size];
    [self.titleImgView autoCenterInSuperview];
    
    self.navigationItem.titleView = bgview;
    

    [self initializedSubviews];
    [SVProgressHUD show];
    [self apiMainReqeuest];
    
    //[self apiRequestHeatGoods];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - api request
- (void)apiMainReqeuest{
    @WeakObj(self);
    NSLog(@"begin request");
    [FNRequestTool startWithRequests:@[[self apiBanner],[self apiRequsetCate],[self apiRequestGoods],[self apiRequestAdvertisement],[self apiRequestHeatGoods],[self apiRequestHeatGoodsImage]] withFinishedBlock:^(NSArray *erros) {
        [self apiRequestSubCates].CompleteBlock = ^(NSString *error) {
            if (error.length >= 1 ) {
                [FNTipsView showTips:error];
                NSLog(@"ready to refresh");
                [UIView animateWithDuration:0.3 animations:^{
                    self.jm_tableview.alpha = 1;
                }];
            }else{
                [self apiRequestProducts].CompleteBlock = ^(NSString *error) {
                    NSLog(@"ready to refresh");
                    [UIView animateWithDuration:0.3 animations:^{
                        self.jm_tableview.alpha = 1;
                    }];
                };
            }
            [self changeHeaderHeight];
            self.jm_tableview.tableHeaderView = self.headerView;
            [selfWeak.jm_tableview reloadData];
        };
        [selfWeak.jm_tableview reloadData];
    }];

}
- (FNAPIHome *)apiBanner{
  
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"place":self.bannerType}];
    return [FNAPIHome apiHomeForBannerWithParams:params success:^(id respondsObject) {
        [selfWeak.banners removeAllObjects];
        [selfWeak.banners addObjectsFromArray:respondsObject];
        NSMutableArray* images = [NSMutableArray new];
        if (selfWeak.banners.count>0) {
            [selfWeak.banners enumerateObjectsUsingBlock:^(MenuModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [images addObject:obj.img];
            }];
            selfWeak.bannerConsH.constant = 0.4*FNDeviceWidth;
            selfWeak.bannerView.hidden = NO;
        }else{
            selfWeak.bannerView.hidden = YES;
            selfWeak.bannerConsH.constant = 0;
        }
        
        selfWeak.titleView.y = CGRectGetMaxY(self.goodsview.frame);
        [selfWeak changeHeaderHeight];
        selfWeak.bannerView.autoScroll = selfWeak.banners.count > 1;
        selfWeak.bannerView.imageURLStringsGroup = images;
    } failure:^(NSString *error) {
        
    } isHidden:YES];
}
- (FNRequestTool *)apiRequestGoods{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@(self.type)}];
    return [FNRequestTool requestWithParams:params api:_api_others_rebatetuwen respondType:(ResponseTypeArray) modelType:@"FNMCTopGoodsModel" success:^(id respondsObject) {
        //
        selfWeak.topgoods  = respondsObject;
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}



- (FNRequestTool *)apiRequestAdvertisement{
    
    return [FNRequestTool requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{@"type":@(self.type)}] api:_api_others_rebateggw respondType:(ResponseTypeArray) modelType:@"MenuModel" success:^(NSArray* respondsObject) {
        //success
        if (respondsObject.count>=1) {
            self.adModel = [respondsObject firstObject];
        }
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}
- (FNAPIHome* )apiRequsetCate{
 
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":self.cateType}];
    return [FNAPIHome apiHomeForNavCategoriesWithParams:params success:^(id respondsObject) {
        
        [selfWeak.categoryTitles removeAllObjects];
        [selfWeak.categories removeAllObjects];
        [selfWeak.categories addObjectsFromArray:respondsObject];
        if (selfWeak.categories.count > 0) {
            [selfWeak.categories enumerateObjectsUsingBlock:^(XYTitleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [selfWeak.categoryTitles addObject:obj.category_name];
            }];
            selfWeak.categoryId = @(selfWeak.categories[0].id.integerValue);
            selfWeak.categoryview.cates = selfWeak.categoryTitles;
        }else{
            selfWeak.jm_tableview.hidden = NO;
            [FNTipsView showTips:@"没有相关的商品分类"];
        }
    } failure:^(NSString *error) {
        if (selfWeak.categories.count==0) {
            [self apiRequsetCate];
        }
        //
        selfWeak.jm_tableview.hidden = NO;
    } isHidden:YES];
    
}
- (FNRequestTool *)apiRequestSubCates{
    if (self.categories.count>0) {
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"cid":self.categories[self.index].id,@"type":self.cateType}];
        
        return [FNRequestTool requestWithParams:params api:_api_others_rebatesubcate respondType:(ResponseTypeArray) modelType:@"XYTitleModel" success:^(id respondsObject) {
            //
            self.subcategories = respondsObject;
        } failure:^(NSString *error) {
            if (self.subcategories.count == 0) {
                [self apiRequestSubCates];
            }
        } isHideTips:YES];

    }
    return nil;
}
- (FNRequestTool *)apiRequestProducts{

    if (self.subcategories.count>=1) {
        [self.subcategories enumerateObjectsUsingBlock:^(XYTitleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isSelected) {
                self.categoryId = @(obj.id.integerValue);
            }
        }];
    }
    @WeakObj(self);
    NSMutableDictionary* params= [NSMutableDictionary dictionaryWithDictionary:@{@"type":self.goodsType,PageNumber:@(self.page),@"cid":self.categoryId?:@"",@"sort":self.sort,PageSize:@(_jm_pro_pagesize)}];
    if (self.searchTitle) {
        params[@"keyword"] = self.searchTitle;
    }
    if (self.price1 >0) {
        params[@"price1"] = @(self.price1 );
    }
    if (self.price2 >0) {
        params[@"price2"] = @(self.price2 );
    }
    if (UserAccessToken) {
        params[TokenKey] = UserAccessToken;
    }
    return [FNAPIHome apiHomeForProductsWithParams:params success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        NSArray* results = respondsObject;
        [results enumerateObjectsUsingBlock:^(FNBaseProductModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.VCName=@"优选";
        }];
        if (selfWeak.page == 1) {
            [selfWeak.products removeAllObjects];
            [selfWeak.products addObjectsFromArray:results];
            if (results.count>=_jm_pro_pagesize) {
                selfWeak.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.page ++;
                    [selfWeak apiRequestProducts];
                }];
            } else {
                selfWeak.jm_tableview.mj_footer = nil;
            }
        }else{
            [selfWeak.products addObjectsFromArray:results];
            if (results.count>=_jm_pro_pagesize) {
                [selfWeak.jm_tableview.mj_footer endRefreshing];
            } else {
                [selfWeak.jm_tableview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
        [selfWeak.jm_tableview reloadData];
        [selfWeak.jm_tableview.mj_header endRefreshing];
    } failure:^(NSString *error) {
        [selfWeak.jm_tableview.mj_footer endRefreshing];
        [selfWeak.jm_tableview.mj_header endRefreshing];
    } isHidden:NO];

}

- (FNRequestTool *)apiRequestHeatGoods{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@"cgf",@"token":UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appHigh&ctrl=goods" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSLog(@"热销商品%@",respondsObject);
        NSArray* arr = respondsObject[DataKey];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dictry in arr) {
            FNBaseProductModel *model = [FNBaseProductModel mj_objectWithKeyValues:dictry];
            model.data = dictry;
            [arrM addObject:model];
        }
        selfWeak.heatgoods = arrM;
        selfWeak.heatView.heatArr=arrM;
        
        [selfWeak.jm_tableview reloadData];
    } failure:^(NSString *error) {
        //
        if(selfWeak.heatgoods.count==0){
            [selfWeak apiRequestHeatGoods];
        }
    } isHideTips:YES];
}

- (FNRequestTool *)apiRequestHeatGoodsImage{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@"cgf",@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appHigh&ctrl=set" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSLog(@"热销商品Image%@",respondsObject);
         NSDictionary* dic = respondsObject[DataKey];
         selfWeak.heatView.imageDic=dic;
        self.jm_tableview.tableHeaderView = _headerView;
        [selfWeak.jm_tableview reloadData];
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    @WeakObj(self);
    
    self.page = 1;
    self.notHome = self.isNotHome;
    //tableView
    self.jm_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-(self.notHome ?0:XYTabBarHeight)) style:UITableViewStylePlain];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;

    self.jm_tableview.tableHeaderView = self.headerView;
    
    [self.jm_tableview removeEmptyCellRows];
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, 0, (self.notHome ?0:XYTabBarHeight), 0))];
    [self.jm_tableview registerClass:[FNPartnerGoodsNewCell class] forCellReuseIdentifier:@"JMHomeProductCell"];
    
    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.page = 1;
        [selfWeak apiMainReqeuest];
        [selfWeak apiRequestHeatGoods];
    }];
    
    UIButton *rightbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setImage: [UIImage imageNamed:@"screening"] forState:UIControlStateNormal];
    [rightbutton setTitle:@"  筛选" forState:UIControlStateNormal];
    [rightbutton setTitleColor:FNBlackColor forState:UIControlStateNormal];
    [rightbutton sizeToFit];
    rightbutton.titleLabel.font = kFONT14;
    [rightbutton addTarget:self action:@selector(RightBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    
    CGFloat tabH = !self.isNotHome ? XYTabBarHeight:0;
    toTopImage = [[UIImageView alloc]initWithFrame:CGRectMake(XYScreenWidth-65, XYScreenHeight-tabH-60, 47, 47)];
    toTopImage.image = IMAGE(@"hddb");
    [toTopImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickToScrollTopMethod:)]];
    [self.view addSubview:toTopImage];
    toTopImage.userInteractionEnabled = YES;
    toTopImage.hidden = YES;
    
    [toTopImage autoSetDimensionsToSize:(CGSizeMake(47, 47))];
    [toTopImage autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15];
    [toTopImage autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:XYTabBarHeight+15];
    [self.view bringSubviewToFront:toTopImage];
}

-(void)RightBtnMethod:(UIButton *)sender
{
    
    @WeakObj(self);
    FNSiftViewController *vc = [[FNSiftViewController alloc]init];
    vc.Sifttype=@"yhq";
    vc.completeSiftBlock = ^(NSDictionary *params) {
        
        NSLog(@"%@",params);
        selfWeak.searchTitle = [params objectForKey:@"keyword"];
        selfWeak.price1 = [[params objectForKey:@"minPrice"] intValue];
        selfWeak.price2 = [[params objectForKey:@"maxPrice"]intValue];
        selfWeak.sort = [params objectForKey:@"sort"];
        selfWeak.categoryId = [params objectForKey:@"cid"];
        NSNumber* num =[params objectForKey:@"index"];
        NSInteger index =num.integerValue;
        [selfWeak.titleView setBottomViewAtIndex:index];
        [SVProgressHUD show];
        selfWeak.page = 1;
        [self apiRequestProducts];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.products.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [JMCellTool tableView:tableView atIndexPath:indexPath superVC:self andModel:self.products[indexPath.row]];
    FNPartnerGoodsNewCell* cell = [FNPartnerGoodsNewCell cellWithTableView:tableView atIndexPath:indexPath];
//    cell.OnlyChangeStyle=self.isPL;
    cell.model = self.products[indexPath.row];
    cell.sharerightNow = ^(FNBaseProductModel *model) {
//        [self.viewmodel.cellClickSubject sendNext:model];
    };
    return cell;
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [JMCellTool cellHeightTableview:tableView atIndexPath:indexPath andModel:self.products[indexPath.row]];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FNBaseProductModel *model = self.products[indexPath.row];
    if (model.is_qiangguang.boolValue) {
        [FNTipsView showTips:@"商品太火爆了，已被抢光，赶紧看一下其他商品吧〜"];
    }else{
        [self goProductVCWithModel:model withData:model.data];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    [self loadOtherVCWithModel:self.banners[index] andInfo:nil outBlock:nil];
}
#pragma mark - JMTitleScrollViewDelegate
- (void)clickedTitleView:(JMTitleScrollView *)titleView atIndex:(NSInteger)index{
    [SVProgressHUD show];
    self.page = 1;
    if (titleView) {
        
        self.index = index;
        self.categoryId = @(self.categories[self.index].id.integerValue);
        [self apiRequestSubCates].CompleteBlock = ^(NSString *error) {
            if (error.length > 0 ) {
                [FNTipsView showTips:error];
            }else{
                [self apiRequestProducts];
            }
        };
        
    }else{
        self.subindex = index;
        self.categoryId = @(self.subcategories[self.subindex].id.integerValue);
        [self apiRequestProducts];
    }

    [self.jm_tableview setContentOffset:(CGPointMake(0, CGRectGetMaxY(self.adImgview.frame))) animated:YES];
   
}

/**
 *  接收搜索结果
 *
 *  @param noti <#noti description#>
 */
- (void)tongzhi:(NSNotification *)noti{
    XYLog(@"－－－－－这里接收到通知------");
    
    NSLog(@"%@",noti.userInfo);
    self.searchTitle = [noti.userInfo objectForKey:@"keyword"];
    self.price1 = [[noti.userInfo objectForKey:@"minPrice"] intValue];
    self.price2 = [[noti.userInfo objectForKey:@"maxPrice"]intValue];
    self.sort = [noti.userInfo objectForKey:@"sort"];
    self.categoryId = [noti.userInfo objectForKey:@"cid"];
    [SVProgressHUD show];
    self.page = 1;
    [self apiRequestProducts];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    if (self.subcategories.count>=1) {
        if (conY>= CGRectGetMaxY(self.adImgview.frame)) {
            [self.categoryview.titleView removeFromSuperview];
            self.categoryview.titleView.y = 0;
            [self.view addSubview:self.categoryview.titleView];
            [self.view bringSubviewToFront:self.categoryview.titleView];
            
        }else{
            if (![self.categoryview.subviews containsObject:self.categoryview.titleView]) {
                
                [self.categoryview addSubview:self.categoryview.titleView];
            }
        }
        if (conY>= CGRectGetMaxY(self.adImgview.frame)+CGRectGetMaxY(self.categoryview.collectionview.frame)-self.categoryview.titleView.height) {
            [self.categoryview.filterview removeFromSuperview];
            self.categoryview.filterview.y = self.categoryview.titleView.height;
            [self.view addSubview:self.categoryview.filterview];
            [self.view bringSubviewToFront:self.categoryview.filterview];
            
        }else{
            if (![self.categoryview.subviews containsObject:self.categoryview.filterview]) {
                self.categoryview.filterview.y = CGRectGetMaxY(self.categoryview.collectionview.frame)+2;
                [self.categoryview addSubview:self.categoryview.filterview];
            }
        }
    }else{
        CGFloat y = self.bannerConsH.constant + self.goodsviewConsH.constant+self.adConsH.constant;
        if (conY>= y) {
            [self.categoryview removeFromSuperview];
            self.categoryview.y = 0;
            [self.view addSubview:self.categoryview];
            [self.view bringSubviewToFront:self.categoryview];
            
        }else{
            if (![self.headerView.subviews containsObject:self.categoryview]) {
                [self.categoryview removeFromSuperview];
                self.categoryview.y = self.bannerConsH.constant + self.goodsviewConsH.constant+self.adConsH.constant;
                [self.headerView addSubview:self.categoryview];
            }
        }
    }
   
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

#pragma mark -  other methods
- (void)changeHeaderHeight{
    self.categoryview.y =self.bannerConsH.constant + self.goodsviewConsH.constant+self.heatViewConsH.constant+self.adConsH.constant;
    _headerView.height = self.bannerConsH.constant+self.goodsviewConsH.constant+self.heatViewConsH.constant+self.adConsH.constant+self.categoryview.height;
    self.jm_tableview.tableHeaderView = _headerView;
}
@end
