//
//  FNNewStoreDetailController.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/19.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreDetailController.h"
#import "FNstoreInformationDaModel.h"
#import "FNStoreBottomView.h"
#import "FNNewStoreDetailCell.h"
#import "FNNewStoreCouponeCell.h"
#import "FNDetailCateCell.h"
#import "FNNewStoreGoodsCell.h"
#import "FNStoreGoodsModel.h"
#import "FNStoreCommentModel.h"
#import "FNNewStoreCommentCateCell.h"
#import "FNMaximumSpacingFlowLayout.h"
#import "FNNewStoreCommentCell.h"
#import "FNNewStorePayController.h"
#import "FNNewStoreCouponeAlertView.h"
#import "FNNewStoreGoodsController.h"
#import "FNStoreCarModel.h"
#import "FNNewStoreCarAlertView.h"
#import "FNNewStoreGoodsAttributeAlertView.h"
#import "FNRushPurchaseNeController.h"
#import "FNNewStoreCommendQuestionController.h"
#import "FNNewStoreImagesController.h"
#import "FNNewStoreGoodsCateCell.h"
#import "FNStoreHomeButtonModel.h"

#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface FNNewStoreDetailController()<UICollectionViewDataSource, UICollectionViewDelegate, SliderControlDelegate, FNNewStoreDetailCellDelegate, FNNewStoreCouponeAlertViewDelegate, FNStoreBottomViewDelegate, FNNewStoreCarAlertViewDelegate, FNNewStoreGoodsCellDelegate, FNNewStoreGoodsAttributeAlertViewDelegate, FNNewStoreCommentCellDelegate, FNNewStoreGoodsCateCellDelegate>

@property (nonatomic, strong) FNstoreInformationDaModel *model;
@property (nonatomic, strong) NSString *cateType;
@property (nonatomic, strong) FNStoreBottomView *bottomView;

@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic, strong) NSMutableArray<FNStoreGoodsModel*> *goods;
@property (nonatomic, strong) NSString *commentType;
@property (nonatomic, strong) NSArray<FNStoreCommentCateModel*> *commentCates;
@property (nonatomic, strong) NSMutableArray<FNStoreCommentModel*> *comments;
@property (nonatomic, assign) NSInteger commentCateIndex;
@property (nonatomic, assign) NSInteger commentPage;

@property (nonatomic, strong) FNNewStoreCouponeAlertView *couponeAlert;
@property (nonatomic, strong) FNNewStoreCarAlertView *carAlert;
@property (nonatomic, strong) FNNewStoreGoodsAttributeAlertView *attributeAlert;
@property (nonatomic, strong) FNStoreGoodsModel *goodsModel;

@property (nonatomic, strong) NSMutableArray<FNStoreCarModel*> *cars;
@property (nonatomic, copy) NSString *cate;
@property (nonatomic, assign) NSInteger cateIndex;

@property (nonatomic, strong) NSMutableArray<UIButton*> *buttons;
@property (nonatomic, strong) NSMutableArray<FNStoreHomeButtonModel*> *buttonModels;
@end

@implementation FNNewStoreDetailController

- (FNNewStoreCouponeAlertView *)couponeAlert {
    if (_couponeAlert == nil) {
        _couponeAlert = [[FNNewStoreCouponeAlertView alloc] init];
        _couponeAlert.delegate = self;
        [self.view addSubview:_couponeAlert];
        [_couponeAlert mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    [self.view bringSubviewToFront:_couponeAlert];
    return _couponeAlert;
}

- (FNNewStoreCarAlertView *)carAlert {
    if (_carAlert == nil) {
        _carAlert = [[FNNewStoreCarAlertView alloc] init];
        _carAlert.delegate = self;
    }
//    [self.view bringSubviewToFront:_carAlert];
    return _carAlert;
}
-(FNNewStoreGoodsAttributeAlertView*) attributeAlert {
    if (_attributeAlert == nil) {
        _attributeAlert = [[FNNewStoreGoodsAttributeAlertView alloc] init];
        _attributeAlert.delegate = self;
        [self.view addSubview:_attributeAlert];
        [_attributeAlert mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    [self.view bringSubviewToFront:_attributeAlert];
    return _attributeAlert;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    _buttons = [[NSMutableArray alloc] init];
    _buttonModels = [[NSMutableArray alloc] init];
    _goods = [[NSMutableArray alloc] init];
    _comments = [[NSMutableArray alloc] init];
    _cars = [[NSMutableArray alloc] init];
    [self configUI];
    [self configLocationManager];
//    [self requestButtons];
//    [self requestLocation];
    [self requestCar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.bottomView setCount: self.model.cart_count withPrice: self.model.cart_price canBuy:[self.model.can_buy isEqualToString:@"1"] payTitle: self.model.btn_str];
    [self requestLocation];
    [self.carAlert dismiss];
}

- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    //    [self.locationManager setDelegate:self];
    
    self.locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;

    
}

- (void)configUI {
    self.view.backgroundColor = FNWhiteColor;
    
    FNMaximumSpacingFlowLayout *flowayout=[[FNMaximumSpacingFlowLayout alloc]init];
    flowayout.minimumLineSpacing=0;
    flowayout.minimumInteritemSpacing=0;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowayout];
//    self.jm_collectionview.hidden=YES;
    [self.jm_collectionview registerClass:[FNNewStoreDetailCell class] forCellWithReuseIdentifier:@"FNNewStoreDetailCell"];
    [self.jm_collectionview registerClass:[FNNewStoreCouponeCell class] forCellWithReuseIdentifier:@"FNNewStoreCouponeCell"];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.jm_collectionview registerClass:[FNNewStoreGoodsCell class] forCellWithReuseIdentifier:@"FNNewStoreGoodsCell"];
    [self.jm_collectionview registerClass:[FNNewStoreCommentCateCell class] forCellWithReuseIdentifier:@"FNNewStoreCommentCateCell"];
    [self.jm_collectionview registerClass:[FNNewStoreCommentCell class] forCellWithReuseIdentifier:@"FNNewStoreCommentCell"];
    [self.jm_collectionview registerClass:[FNNewStoreGoodsCateCell class] forCellWithReuseIdentifier:@"FNNewStoreGoodsCateCell"];
    
    
    [self.jm_collectionview registerClass:[FNDetailCateCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNDetailCateCell"];
    
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.delegate=self;
    self.jm_collectionview.dataSource=self;
    
    @weakify(self)
    self.jm_collectionview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        if (self.model == nil)
            return;
        self.jm_page++;
        if ([_cateType isEqualToString:@"goods"]) {
            
            [self requestStoreGoods];
        } else {
            [self requestComment];
        }
    }];
    
    self.jm_collectionview.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.jm_collectionview];
    
    
    [self.view addSubview:self.carAlert];
    
    _bottomView = [[FNStoreBottomView alloc] init];
    _bottomView.delegate = self;
    [self.view addSubview: _bottomView];
    
    [self.jm_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(isIphoneX ? @-34 : @0);
    }];
    
    [self.carAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
}

#pragma - mark Networking

- (void) requestLocation {
    if ([FNCurrentVersion isEqualToString:Setting_checkVersion]) {
        [self apiRequestStoreMessage: @"" longitude: @""];
        return ;
    }
    if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        
        //定位不能用
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"需要您提供位置信息才能获取周围店铺" preferredStyle:UIAlertControllerStyleAlert];

        @weakify(self);
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
        }]];

        [alertController addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
            
        }]];
        [self presentViewController:alertController animated:true completion:nil];
        
    } else {
        
        //定位功能可用
        [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
            
            if (error)
            {
                NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
                
                if (error.code == AMapLocationErrorLocateFailed)
                {
                    return;
                }
            }
            
            NSLog(@"location:%@", location);
            NSString *latitude = [NSString stringWithFormat:@"%lf", location.coordinate.latitude];
            NSString *longitude = [NSString stringWithFormat:@"%lf", location.coordinate.longitude];
            
            [self apiRequestStoreMessage: latitude longitude: longitude];
        }];
        
    }
}

//获取店铺信息数据
- (FNRequestTool *)apiRequestStoreMessage: (NSString*)latitude longitude: (NSString*)longitude{
    //@WeakObj(self);
    @weakify(self);
    //
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    if([self.storeID kr_isNotEmpty]){
        params[@"id"]=self.storeID;
    }
    params[@"lat"]=latitude;
    params[@"lng"]=longitude;
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_store&ctrl=store_detail" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"店铺信息:%@",respondsObject);
        @strongify(self);
        NSDictionary* dataDic = respondsObject[DataKey];
        self.model=[FNstoreInformationDaModel mj_objectWithKeyValues:dataDic];
        if (self.model.cates.count > 0) {
            self.cate = self.model.cates[0].id;
            self.cateIndex = 0;
        }
        self.title = self.model.name;
        if (self.model && self.model.tab.count > 0) {
            NSString *type = self.model.tab[0][@"type"];
            _cateType = type;
            self.jm_page = 1;
            if ([type isEqualToString:@"goods"]) {
                [self requestStoreGoods];
            } else if ([type isEqualToString:@"comments"]) {
                [self requestCommentCate];
            }
        }
        [self.jm_collectionview reloadData];
        [self.bottomView setCount: self.model.cart_count withPrice: self.model.cart_price canBuy:[self.model.can_buy isEqualToString:@"1"] payTitle: self.model.btn_str];
        
        if (self.isNeedJumpGoods && [self.goods_id kr_isNotEmpty]) {
            self.isNeedJumpGoods = NO;
            FNNewStoreGoodsController *vc = [[FNNewStoreGoodsController alloc] init];
            vc.goods_id = self.goods_id;
            vc.storeID = self.storeID;
            vc.storeName = self.storeName;
            [vc setStore: self.model];
            [self.navigationController pushViewController:vc animated: YES];
        }
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache: NO];
}

- (void)requestStoreGoods{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    params[@"id"] = self.model.id;
    params[@"p"] = @(self.jm_page);
    if ([_cate kr_isNotEmpty]) {
        params[@"cate"] = _cate;
    }
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods&ctrl=index" respondType:(ResponseTypeArray) modelType:@"FNStoreGoodsModel" success:^(id respondsObject) {
        @strongify(self)
        
        if (self.jm_page == 1) {
            [self.goods removeAllObjects];
        }
        
        self.jm_page ++;
        
        [self.goods addObjectsFromArray: respondsObject];
        
        [self.jm_collectionview reloadData];
        [self.jm_collectionview.mj_footer endRefreshing];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES isCache: NO];
    
}

- (void)requestButtons {
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    if ([_storeID kr_isNotEmpty]) {
        params[@"store_id"] = _storeID;
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=position_redpacket&ctrl=entrance" respondType:(ResponseTypeDataKey) modelType:@"FNStoreHomeButtonModel" success:^(id respondsObject) {
        @strongify(self)
        
        NSArray *redpacket = [FNStoreHomeButtonModel mj_objectArrayWithKeyValuesArray:respondsObject[@"redpacket"]];
        NSArray *normal_redpacket = [FNStoreHomeButtonModel mj_objectArrayWithKeyValuesArray:respondsObject[@"normal_redpacket"]];
        NSArray *orderico = [FNStoreHomeButtonModel mj_objectArrayWithKeyValuesArray:respondsObject[@"orderico"]];
        NSArray *memberico = [FNStoreHomeButtonModel mj_objectArrayWithKeyValuesArray:respondsObject[@"memberico"]];
        
        [self.buttonModels addObjectsFromArray: redpacket];
        [self.buttonModels addObjectsFromArray: normal_redpacket];
        [self.buttonModels addObjectsFromArray: orderico];
        [self.buttonModels addObjectsFromArray: memberico];
        
        [self updateButtons];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES isCache: NO];
    
}

- (void)requestCommentCate{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    params[@"id"] = self.model.id;
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_comment&ctrl=comment_cate" respondType:(ResponseTypeArray) modelType:@"FNStoreCommentCateModel" success:^(id respondsObject) {
        @strongify(self)
        self.commentCates = respondsObject;
        
        self.commentCateIndex = 0;
        self.commentPage = 1;
        if (self.commentCates.count > 0) {
            self.commentType = self.commentCates[0].type;
            [self requestComment];
        }
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES isCache: NO];
    
}

- (void)requestComment{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    params[@"id"] = self.model.id;
    params[@"p"] = @(self.commentPage);
    if ([_commentType kr_isNotEmpty]) {
        params[@"type"] = _commentType;
    }
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_comment&ctrl=comment_list" respondType:(ResponseTypeArray) modelType:@"FNStoreCommentModel" success:^(id respondsObject) {
        @strongify(self)
        NSArray *array = respondsObject;
        if (self.commentPage == 1) {
            [self.comments removeAllObjects];
        }
        if (array.count > 0) {
            self.commentPage ++;
        }
        [self.comments addObjectsFromArray: respondsObject];
        
        [self.jm_collectionview.mj_footer endRefreshing];
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES isCache: NO];
    
}

- (void)requestCoupone: (NSString*) couponeId{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"id": couponeId}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_red_packet&ctrl=receive_yhq" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
                   
        [FNTipsView showTips:@"领取成功"];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestClearCar {
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"store_id": self.storeID}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods&ctrl=clear_cart" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        [self.cars removeAllObjects];
        [self.bottomView setCount: [NSString stringWithFormat:@"%ld", self.cars.count] withPrice: @"未选购商品" canBuy:[self.model.can_buy isEqualToString:@"1"] payTitle: self.model.btn_str];
        [self.carAlert dismiss];
        self.model.cart_count = @"0";
        self.model.cart_price = @"0";
        self.model.can_buy = @"0";
        
        for (FNStoreGoodsModel *g in self.goods) {
            g.count = @"0";
        }
        [self.jm_collectionview reloadData];
        [self requestCar];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestRemoveCar: (NSString*)goodsID gid: (NSString*)gid {
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    if ([goodsID kr_isNotEmpty]) {
        params[@"id"] = goodsID;
    }
    if ([gid kr_isNotEmpty]) {
        params[@"gid"] = gid;
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods&ctrl=del_cart_goods" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        NSString *count = respondsObject[@"count"];
        NSString *price = respondsObject[@"price"];
        NSString *can_buy = respondsObject[@"can_buy"];
        self.model.can_buy = can_buy;
        if (![count kr_isNotEmpty] || [count isEqualToString:@"0"]) {
            [self.carAlert dismiss];
        }
        [self.bottomView setCount: count withPrice: price canBuy:[self.model.can_buy isEqualToString:@"1"] payTitle: self.model.btn_str];
        self.model.cart_count = count;
        self.model.cart_price = price;
        
        for (FNStoreGoodsModel *g in self.goods) {
            if ([g.id isEqualToString:gid]) {
                int c = g.count.intValue;
                g.count = [NSString stringWithFormat:@"%d", c - 1];
                break;
            }
        }
        
        for (FNStoreCarModel *car in self.cars) {
            if ([car.id isEqualToString:goodsID]) {
                int c = car.count.intValue;
                car.count = [NSString stringWithFormat:@"%d", c - 1];
            }
        }
        [self.carAlert reloadData];
        
        [self.jm_collectionview reloadData];
        [self requestCar];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestAddCar:(NSString*)gid count: (NSString*)count specs: (NSString*)specs attribute:(NSString*) attribute {
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    if ([gid kr_isNotEmpty]) {
        params[@"gid"] = gid;
    }
    if ([_storeID kr_isNotEmpty]) {
        params[@"store_id"] = _storeID;
    }
    if ([count kr_isNotEmpty]) {
        params[@"add_count"] = count;
    } else {
        params[@"add_count"] = @"1";
    }
    if (specs) {
        params[@"specs"] = specs;
    }
    
    if (attribute) {
        params[@"attribute"] = attribute;
    }
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods&ctrl=add_shoppingcart" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        NSString *rCount = respondsObject[@"count"];
        NSString *price = respondsObject[@"price"];
        NSString *can_buy = respondsObject[@"can_buy"];
        self.model.can_buy = can_buy;
        
        [self.bottomView setCount: rCount withPrice: price  canBuy:[self.model.can_buy isEqualToString:@"1"] payTitle: self.model.btn_str];
        [self.attributeAlert dismiss];
        self.model.cart_count = rCount;
        self.model.cart_price = price;
        
        for (FNStoreGoodsModel *g in self.goods) {
            if ([g.id isEqualToString:gid]) {
                int c = g.count.intValue;
                int add = [count kr_isNotEmpty] ? count.intValue : 1;
                g.count = [NSString stringWithFormat:@"%d", c + add];
                break;
            }
        }
        
        for (FNStoreCarModel *car in self.cars) {
            if ([car.gid isEqualToString:gid] && [car.specs isEqualToString:specs] && [car.attribute isEqualToString: attribute]) {
                int c = car.count.intValue;
                int add = [count kr_isNotEmpty] ? count.intValue : 1;
                car.count = [NSString stringWithFormat:@"%d", c + add];
            }
        }
        
        [self.carAlert reloadData];
        [self.jm_collectionview reloadData];
        [self requestCar];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestCar{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    params[@"id"]=self.storeID;
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_store&ctrl=cart_list" respondType:(ResponseTypeArray) modelType:@"FNStoreCarModel" success:^(id respondsObject) {
        @strongify(self)
        
        [self.cars removeAllObjects];
        [self.cars addObjectsFromArray:respondsObject];
        
        if (self.cars.count > 0) {
            [self.carAlert setCars: self.cars];
//            [self.carAlert show];
        }
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestThumb: (FNStoreCommentModel*)comment{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    params[@"id"]=comment.id;
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_comment&ctrl=vote" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        int count = comment.vote.intValue;
        if ([comment.has_vote isEqualToString:@"1"]) {
            count --;
            comment.has_vote = @"0";
        } else {
            count ++;
            comment.has_vote = @"1";
        }
        comment.vote = [NSString stringWithFormat: @"%d", count];
        [self.jm_collectionview reloadData];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if ([_cateType isEqualToString:@"goods"]) {
        return 3;
    } else if ([_cateType isEqualToString:@"comments"]) {
        return 4;
    }
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.model == nil) {
            return 0;
        } else if (self.model.yhq_list.count == 0) {
            return 1;
        } else {
            return 2;
        }
    } else if (section == 1) {
        if ([_cateType isEqualToString:@"goods"]) {
            return self.model.cates.count > 0 ? 1 : 0;
        } else if ([_cateType isEqualToString:@"comments"]) {
            return 0;
        }
    } else if (section == 2) {
        
        if ([_cateType isEqualToString:@"goods"]) {
            return self.goods.count;
        } else if ([_cateType isEqualToString:@"comments"]) {
            return self.commentCates.count;
        }
    } else if (section == 3) {
        return self.comments.count;
    }
    return 0;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            FNNewStoreDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNNewStoreDetailCell" forIndexPath:indexPath];
            [cell setModel: self.model];
            cell.delegate = self;
            return cell;
        } else if (indexPath.row == 1) {
            FNNewStoreCouponeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNNewStoreCouponeCell" forIndexPath:indexPath];
            [cell setModel: self.model.yhq_list];
            return cell;
        }
    } else if (indexPath.section == 1) {

        FNNewStoreGoodsCateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNNewStoreGoodsCateCell" forIndexPath:indexPath];
        NSMutableArray *cates = [[NSMutableArray alloc] init];
        for (FNstoreInformationCateModel *cate in self.model.cates) {
            [cates addObject:cate.name];
        }
        cell.delegate = self;
        [cell setTitles: cates selected: _cateIndex];
        return cell;
        
    } else if (indexPath.section == 2) {
        
        if ([_cateType isEqualToString:@"goods"]) {
            FNStoreGoodsModel *model = self.goods[indexPath.row];
            FNNewStoreGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNNewStoreGoodsCell" forIndexPath:indexPath];
            cell.model = model;
            [cell setIsLeft: indexPath.row % 2 == 0];
            cell.borderColor = FNGlobalTextGrayColor;
            cell.delegate = self;
            return cell;
        } else if ([_cateType isEqualToString:@"comments"]) {
            FNNewStoreCommentCateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNNewStoreCommentCateCell" forIndexPath:indexPath];
            cell.lblTitle.text = self.commentCates[indexPath.row].str;
            [cell setIsSelected: indexPath.row == _commentCateIndex];
            return cell;
        }
        
        
    } else if (indexPath.section == 3) {
        FNNewStoreCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNNewStoreCommentCell" forIndexPath:indexPath];
        [cell setModel: self.comments[indexPath.row]];
        cell.delegate = self;
        return cell;
    }
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 && _model && _model.tab.count > 0) {
        FNDetailCateCell* cateHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FNDetailCateCell" forIndexPath:indexPath];
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        NSInteger index = 0;
        for (NSInteger i = 0; i < _model.tab.count; i++) {
            NSDictionary *dict = _model.tab[i];
            [titles addObject: dict[@"str"]];
            if ([_cateType isEqualToString:((NSString*)dict[@"type"])]) {
                index = i;
            }
        }
        [cateHeader.sliderControl setTitles:titles];
        [cateHeader.sliderControl setSelected:index animated: NO];
        cateHeader.sliderControl.delegate = self;
        return cateHeader;
    }
    
    
    return [[UIView alloc] init];
}

#pragma mark - collectionView delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 1 && _model && _model.tab.count > 0) {
        return CGSizeMake(JMScreenWidth, 47);
    }
    
    return CGSizeMake(JMScreenWidth, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (self.model.album_list.count > 0) {
                return CGSizeMake(FNDeviceWidth, 378);
            } else {
                return CGSizeMake(FNDeviceWidth, 278);
            }
        }
        else {
            return CGSizeMake(FNDeviceWidth, 65);
        }
    } if (indexPath.section == 1) {
        return CGSizeMake(FNDeviceWidth, 38);
    } if (indexPath.section == 2) {
        
        if ([_cateType isEqualToString:@"goods"]) {
            int w = FNDeviceWidth/2;
            if (indexPath.row % 2 == 1) //防止出现缝隙
                w = FNDeviceWidth - w;
            return CGSizeMake(w, 274);
        }
            
        
        NSString* string = self.commentCates[indexPath.item].str;
        CGRect rect = [string boundingRectWithSize:(CGSizeMake(JMScreenWidth-30, 36)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:kFONT13} context:nil];
        CGFloat width = rect.size.width+36;
        CGSize size = CGSizeMake(floor(width), 36);
        return size;
    } else if (indexPath.section == 3) {
//        return CGSizeMake(FNDeviceWidth, 300);
        NSString* string = self.comments[indexPath.item].content;
        CGRect rect = [string boundingRectWithSize:(CGSizeMake(JMScreenWidth-89, 1000)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:kFONT14} context:nil];
        CGFloat height = rect.size.height + (self.comments[indexPath.item].imgs.count > 0 ? 96 : 0) + 170;
        
        return CGSizeMake(FNDeviceWidth, height);
    }
    return CGSizeMake(FNDeviceWidth, 0);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        if ([_cateType isEqualToString:@"goods"]) {
            if (![UserAccessToken kr_isNotEmpty]) {
                [self warnToLogin];
                return;
            }
            
            FNNewStoreGoodsController *vc = [[FNNewStoreGoodsController alloc] init];
            FNStoreGoodsModel *goods = self.goods[indexPath.row];
            vc.goods_id = goods.id;
            vc.storeID = self.storeID;
            vc.storeName = self.storeName;
            [vc setStore: self.model];
            [self.navigationController pushViewController:vc animated: YES];
            return ;
        }
        
        _commentCateIndex = indexPath.row;
        _commentType = self.commentCates[indexPath.row].type;
        [self.jm_collectionview reloadData];
        self.commentPage = 1;
        [self requestComment];
    }
    else if (indexPath.section == 0 && indexPath.row == 1) {
        //点击优惠券
        
        if (![UserAccessToken kr_isNotEmpty]) {
            [self warnToLogin];
            return;
        }
        [self.couponeAlert setCoupones: self.model.yhq_list];
        [self.couponeAlert show];
    }
    
}

#pragma mark - SliderControlDelegate
- (void)sliderControl: (SliderControl*) slider didCellSelectedAtIndex: (NSInteger) index {
    if (self.model && index < self.model.tab.count) {
        NSString *type = self.model.tab[index][@"type"];
        self.jm_page = 1;
        _cateType = type;
        if ([type isEqualToString:@"goods"]) {
            [self requestStoreGoods];
        } else if ([type isEqualToString:@"comments"]) {
            [self requestCommentCate];
        }
    }
}

#pragma mark - FNNewStoreDetailCellDelegate

- (void)cell:(FNNewStoreDetailCell*)cell didImageClickAt: (NSInteger) index {
    FNNewStoreImagesController *vc = [[FNNewStoreImagesController alloc] init];
    vc.store_id = self.model.id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cellDidLocationClick: (FNNewStoreDetailCell*)cell {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"请选择地图" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    [alert addAction:[UIAlertAction actionWithTitle:@"用iPhone自带地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *urlString=[NSString stringWithFormat:@"http://maps.apple.com/?daddr=%@,%@",self.model.lat,self.model.lng];
        if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:urlString]]){
            if ([[UIDevice currentDevice].systemVersion integerValue] >= 10) { //iOS10以后,使用新API
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:^(BOOL success) {
                    
                }];
            } else { //iOS10以前,使用旧API
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            }
        } else {
            [FNTipsView showTips:@"无法打开地图"];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"用高德地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:@"iosamap://"]]){
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
            NSString *urlString = [[NSString stringWithFormat: @"iosamap://path?sourceApplication=%@&sid=BGVIS1&did=BGVIS2&dlat=%@&dlon=%@&dev=0&t=0", app_Name, self.model.lat, self.model.lng] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
            if ([[UIDevice currentDevice].systemVersion integerValue] >= 10) { //iOS10以后,使用新API
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:^(BOOL success) {

                }];
            } else { //iOS10以前,使用旧API
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            }
        
        } else {
            [FNTipsView showTips:@"没有安装高德地图"];
        }
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"用百度地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL * baidu_App = [NSURL URLWithString:@"baidumap://"];
        if ([[UIApplication sharedApplication] canOpenURL:baidu_App]) {
            
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=%@,%@&src=%@&coord_type=gcj02", self.model.lat, self.model.lng,self.model.address] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        } else {
            [FNTipsView showTips:@"没有安装百度地图"];
        }
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)cellDidCallClick: (FNNewStoreDetailCell*)cell {
    UIWebView * callWebview = [[UIWebView alloc]init];
    
    NSString *url = [NSString stringWithFormat:@"tel:%@", self.model.phone];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
}
- (void)cellDidPayClick: (FNNewStoreDetailCell*)cell {
    if (![UserAccessToken kr_isNotEmpty]) {
        [self warnToLogin];
        return;
    }
    
    if ([self.model.is_open isEqualToString:@"0"]) {
        [FNTipsView showTips: self.model.btn_str];
    } else {
        FNNewStorePayController *vc = [[FNNewStorePayController alloc] init];
        vc.store_id = _storeID;
        [vc setModel:self.model];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - FNNewStoreCouponeAlertViewDelegate

- (void)onCouponeClickAt: (NSInteger) index {
    if (index < self.model.yhq_list.count) {
        FNstoreCouponeModel *coupone = self.model.yhq_list[index];
        [self requestCoupone:coupone.id];
    }
}

#pragma mark - FNStoreBottomViewDelegate
- (void)didCarClick: (FNStoreBottomView*)view {
//    [self requestCar];
    if (self.cars.count > 0) {
        [self.carAlert setCars: self.cars];
        [self.carAlert show];
    }
}

- (void)didPayClick: (FNStoreBottomView*)view {
    
    FNRushPurchaseNeController *vc=[[FNRushPurchaseNeController alloc]init];
    vc.storeID=self.storeID;
    vc.storeName=self.storeName;
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - FNNewStoreCarAlertViewDelegate

- (void)didClearClick: (FNNewStoreCarAlertView*)alertView {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清空购物车" message:@"确定清空购物车？" preferredStyle:UIAlertControllerStyleAlert];
    
    @weakify(self);
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        @strongify(self);
        [self requestClearCar];
        
    }]];
    [self presentViewController:alertController animated:true completion:nil];
    
}
- (void)didSubClick: (FNNewStoreCarAlertView*)alertView atIndex: (NSInteger) index {
    FNStoreCarModel *model = _cars[index];
    [self requestRemoveCar:model.id gid: model.gid];
}
- (void)didAddClick: (FNNewStoreCarAlertView*)alertView atIndex: (NSInteger) index {
    FNStoreCarModel *model = _cars[index];
    [self requestAddCar: model.gid count: @"1" specs: model.specs attribute:model.attribute];
}

#pragma mark - FNNewStoreGoodsCellDelegate

- (void)storeGoodsCelldidSubClick: (FNNewStoreGoodsCell*) cell {
    NSIndexPath *indexPath = [self.jm_collectionview indexPathForCell:cell];
    FNStoreGoodsModel *model = self.goods[indexPath.row];
    if (model.specs) {
        [FNTipsView showTips:@"该商品含有多种属性，请到购物车删除"];
        return;
    }
    for (FNStoreCarModel *car in _cars) {
        if ([car.gid isEqualToString:model.id]) {
            [self requestRemoveCar:car.id gid: car.gid];
            return;
        }
    }
}
- (void)storeGoodsCelldidAddClick: (FNNewStoreGoodsCell*) cell {
    NSIndexPath *indexPath = [self.jm_collectionview indexPathForCell:cell];
    FNStoreGoodsModel *model = self.goods[indexPath.row];
//    [self requestAddCar:@"" gid: model.id];
    
    if (model.specs || model.attribute.count > 0) {
        [self.attributeAlert setModel: model];
        _goodsModel = model;
        [self.attributeAlert show];
    } else {
        [self requestAddCar:model.id count: @"1" specs: @"" attribute:@""];
    }
}


#pragma mark - FNNewStoreGoodsAttributeAlertViewDelegate

- (void)attributeAlertDidClick:(NSString*)count specs: (NSString*)specs withKeys: (NSArray<NSString*>*)keys {
    NSMutableString *str = nil;
    for (NSString *att in keys) {
        if (str == nil) {
            str = [NSMutableString stringWithFormat:@"%@",att];
        } else {
            [str appendFormat:@",%@",att];
        }
    }
    
    [self requestAddCar:_goodsModel.id count: count specs: specs attribute:str];
}

#pragma mark - FNNewStoreCommentCellDelegate
- (void)commentCell: (FNNewStoreCommentCell*)cell didImageClickAt: (NSInteger)index {
    NSLog(@"%ld", index);

    NSIndexPath *indexPath = [self.jm_collectionview indexPathForCell:cell];
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
    // 弹出相册时显示的第一张图片是点击的图片
    browser.currentPhotoIndex = index;
    NSMutableArray *photos = [NSMutableArray array];
    FNStoreCommentModel *comment = self.comments[indexPath.row];
    NSArray *imgs = comment.imgs;
    [imgs enumerateObjectsUsingBlock:^(id  _Nonnull sobj, NSUInteger idx, BOOL * _Nonnull stop) {
        MJPhoto *mjPhoto = [[MJPhoto alloc] init];
        
        mjPhoto.url = [NSURL URLWithString:sobj];
        
//        mjPhoto.srcImageView = imageview;
        
        [photos addObject:mjPhoto];
    }];
    
    // 设置所有的图片。photos是一个包含所有图片的数组。
    browser.photos = photos;
    [browser show];
    
}

- (void)didThumbClick: (FNNewStoreCommentCell*)cell {
    NSIndexPath *indexPath = [self.jm_collectionview indexPathForCell:cell];
    FNStoreCommentModel *comment = self.comments[indexPath.row];
    [self requestThumb: comment];
}
- (void)didQuestionClick: (FNNewStoreCommentCell*)cell {
    NSIndexPath *indexPath = [self.jm_collectionview indexPathForCell:cell];
    FNStoreCommentModel *comment = self.comments[indexPath.row];
    FNNewStoreCommendQuestionController *vc = [[FNNewStoreCommendQuestionController alloc] init];
    vc.commentId = comment.id;
    
    [vc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - FNNewStoreGoodsCateCellDelegate

- (void)cateCell: (FNNewStoreGoodsCateCell*)cell didCateClickAt: (NSInteger) index {
    _cate = self.model.cates[index].id;
    self.jm_page = 1;
    _cateIndex = index;
    [self requestStoreGoods];
}


#pragma mark - 红包按钮列表
- (void)updateButtons {
    for (UIButton* btn in _buttons) {
        [btn removeFromSuperview];
    }
    [_buttons removeAllObjects];
    
    for (NSInteger index = _buttonModels.count - 1; index >= 0; index--) {
        FNStoreHomeButtonModel* model = _buttonModels[index];
        UIButton *button = [[UIButton alloc] init];
        [self.view addSubview:button];
        [self.buttons addObject:button];
        [button addTarget:self action:@selector(onButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-14);
            make.height.mas_equalTo(50);
            
            NSInteger i = _buttonModels.count - index - 1;
            if (i == 0) {
                make.bottom.equalTo(@-200);
            } else {
                make.bottom.equalTo(self.buttons[i - 1].mas_top).offset(-14);
            }
            make.width.mas_equalTo(0);
        }];
        
        [button sd_setBackgroundImageWithURL:URL(model.img) forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                [button mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(50 * image.size.width / image.size.height);
                }];
            }
        }];
    }
}

- (void)onButtonClick: (UIButton*)sender {
    NSInteger index = [self.buttons indexOfObject: sender];
    if (index >= 0 && index < _buttonModels.count) {
        FNStoreHomeButtonModel* model = _buttonModels[_buttonModels.count - index - 1];
        [self loadOtherVCWithModel:model andInfo:nil outBlock:nil];
    }
}

@end
