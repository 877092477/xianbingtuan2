//
//  FNNewStoreGoodsController.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/26.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreGoodsController.h"
#import "FNNewStoreGoodsHeaderCell.h"
#import "FNCustomeNavigationBar.h"
#import "FNNewStoreGoodsHeaderCell.h"
#import "FNStoreGoodsDetailModel.h"
#import "FNNewStoreCouponeCell.h"
#import "FNNewStoreGoodsRuleCell.h"
#import "FNNewStoreGoodsDescCell.h"
#import "FNStoreBottomView.h"
#import "FNNewStoreCarAlertView.h"
#import "FNNewStoreCouponeAlertView.h"
#import "FNNewStoreGoodsAttributeAlertView.h"
#import "FNStoreCarModel.h"
#import "FNRushPurchaseNeController.h"
#import "FNNewStoreGoodsCell.h"
#import "FNNewStoreRecommendHeaderView.h"
#import "FNShareViewController.h"

@interface FNNewStoreGoodsController()<UICollectionViewDataSource, UICollectionViewDelegate, FNStoreBottomViewDelegate, FNNewStoreCarAlertViewDelegate, FNNewStoreGoodsHeaderCellDelegate, FNNewStoreCouponeAlertViewDelegate, FNNewStoreGoodsCellDelegate, FNNewStoreGoodsAttributeAlertViewDelegate>

@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)FNStoreBottomView *bottomView;
@property (nonatomic, strong) FNNewStoreCouponeAlertView *couponeAlert;
@property (nonatomic, strong) FNNewStoreCarAlertView *carAlert;

@property (nonatomic, strong) FNNewStoreGoodsAttributeAlertView *attributeAlert;

@property (nonatomic, strong)FNStoreGoodsDetailModel *model;

@property (nonatomic, strong) NSMutableArray<FNStoreCarModel*> *cars;
@property (nonatomic, strong) FNstoreInformationDaModel *storeModel;

@property (nonatomic, strong) NSArray<FNStoreGoodsModel*> *recommends;
@property (nonatomic, strong) FNStoreGoodsModel *goodsModel;

@end

@implementation FNNewStoreGoodsController

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

- (FNStoreBottomView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[FNStoreBottomView alloc] init];
        _bottomView.delegate = self;
    }
    
    return _bottomView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self.bottomView setCount: _storeModel.cart_count withPrice: _storeModel.cart_price canBuy:[_storeModel.can_buy isEqualToString:@"1"] payTitle: _storeModel.btn_str];
    [self requestGoods];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    _cars = [[NSMutableArray alloc] init];

    [self configUI];
//    [self requestGoods];
    [self requestCar];
}


- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
        
        UIButton* backbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backbtn setImage:IMAGE(@"store_goods_detail_close_button") forState:(UIControlStateNormal)];
        [backbtn addTarget:self action:@selector(backbtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [backbtn sizeToFit];
        _navigationView.leftButton = backbtn;
        
        UIButton* sharebtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [sharebtn setImage:IMAGE(@"store_goods_detail_share_button") forState:(UIControlStateNormal)];
        [sharebtn addTarget:self action:@selector(sharebtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [sharebtn sizeToFit];
        _navigationView.rightButton = sharebtn;
        
        
    }
    return _navigationView;
}


- (void)configUI{
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:JMNavBarHeigth];
    
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 0)) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor = FNHomeBackgroundColor;
    //    self.jm_collectionview.alpha = 0;
    self.jm_collectionview.dataSource =self;
    self.jm_collectionview.delegate =self;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNNewStoreGoodsHeaderCell class] forCellWithReuseIdentifier:@"FNNewStoreGoodsHeaderCell"];
    [self.jm_collectionview registerClass:[FNNewStoreGoodsRuleCell class] forCellWithReuseIdentifier:@"FNNewStoreGoodsRuleCell"];
    [self.jm_collectionview registerClass:[FNNewStoreCouponeCell class] forCellWithReuseIdentifier:@"FNNewStoreCouponeCell"];
    [self.jm_collectionview registerClass:[FNNewStoreGoodsDescCell class] forCellWithReuseIdentifier:@"FNNewStoreGoodsDescCell"];
    [self.jm_collectionview registerClass:[FNNewStoreGoodsCell class] forCellWithReuseIdentifier:@"FNNewStoreGoodsCell"];
    [self.jm_collectionview registerClass:[FNNewStoreRecommendHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNNewStoreRecommendHeaderView"];
    
    [self.view addSubview: self.carAlert];
    
    
    [self.view addSubview: self.bottomView];
    
//    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"topheader"];
    
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
    
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view bringSubviewToFront:self.navigationView];
    
}

-(void) setStore: (FNstoreInformationDaModel *) model {
    _storeModel = model;
    [self.bottomView setCount: model.cart_count withPrice: model.cart_price canBuy:[model.can_buy isEqualToString:@"1"] payTitle: model.btn_str];
}

#pragma mark - Networking

- (void)requestGoods{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"id": _goods_id}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods&ctrl=goods_detail" respondType:(ResponseTypeModel) modelType:@"FNStoreGoodsDetailModel" success:^(id respondsObject) {
        @strongify(self)
        self.model = respondsObject;
        [self.jm_collectionview reloadData];
        
        [self requestRecommend];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES isCache: NO];
    
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

- (void)requestClearCar {
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"store_id": self.storeID}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods&ctrl=clear_cart" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        [self.cars removeAllObjects];
        self.storeModel.cart_count = @"0";
        self.storeModel.cart_price = @"0";
        self.storeModel.can_buy = @"0";
        [self.bottomView setCount: [NSString stringWithFormat:@"%ld", self.cars.count] withPrice: @"未选购商品" canBuy:[self.storeModel.can_buy isEqualToString:@"1"] payTitle: self.storeModel.btn_str];
        [self.carAlert dismiss];
        
//        for (FNStoreGoodsModel *g in self.goods) {
//            g.count = @"0";
//        }
        self.model.count = @"";
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
        self.storeModel.can_buy = can_buy;
        if (![count kr_isNotEmpty] || [count isEqualToString:@"0"]) {
            [self.carAlert dismiss];
        }
        [self.bottomView setCount: count withPrice: price canBuy:[self.storeModel.can_buy isEqualToString:@"1"] payTitle: self.storeModel.btn_str];
        self.storeModel.cart_count = count;
        self.storeModel.cart_price = price;
        

        if ([self.model.id isEqualToString:gid]) {
            int c = self.model.count.intValue;
            self.model.count = [NSString stringWithFormat:@"%d", c - 1];

        }

        
        for (FNStoreCarModel *car in self.cars) {
            if ([car.id isEqualToString:goodsID]) {
                int c = car.count.intValue;
                car.count = [NSString stringWithFormat:@"%d", c - 1];
                if (c - 1 == 0) {
                    
                }
            }
        }
        for (NSInteger index = self.cars.count - 1; index >= 0; index--) {
            FNStoreCarModel *car = self.cars[index];
            if ([car.id isEqualToString:goodsID]) {
                int c = car.count.intValue;
                car.count = [NSString stringWithFormat:@"%d", c - 1];
                if (c - 1 == 0) {
                    [self.cars removeObjectAtIndex: index];
                }
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
        self.storeModel.can_buy = can_buy;
        
        [self.bottomView setCount: rCount withPrice: price canBuy:[self.storeModel.can_buy isEqualToString:@"1"] payTitle: self.storeModel.btn_str];
        [self.attributeAlert dismiss];
        self.storeModel.cart_count = rCount;
        self.storeModel.cart_price = price;
        

        if ([self.model.id isEqualToString:gid]) {
            int c = self.model.count.intValue;
            int add = [count kr_isNotEmpty] ? count.intValue : 1;
            self.model.count = [NSString stringWithFormat:@"%d", c + add];

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

- (void)requestCoupone: (NSString*) couponeId{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"id": couponeId}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_red_packet&ctrl=receive_yhq" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        [FNTipsView showTips:@"领取成功"];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}
- (void)requestRecommend{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    if ([_storeID kr_isNotEmpty]) {
        params[@"store_id"] = _storeID;
    }
    if ([_goods_id kr_isNotEmpty]) {
        params[@"id"] = _goods_id;
    }
    if ([_model.cate_id kr_isNotEmpty]) {
        params[@"cate_id"] = _model.cate_id;
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods&ctrl=recommend_goods" respondType:(ResponseTypeArray) modelType:@"FNStoreGoodsModel" success:^(id respondsObject) {
        @strongify(self)
        
        self.recommends = respondsObject;
        
        [self.jm_collectionview reloadData];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES isCache: NO];
    
}


#pragma mark - action
- (void)backbtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sharebtnAction{
    FNShareViewController *share = [[FNShareViewController alloc] init];
    share.SkipUIIdentifier = @"buy_rebate_store";
    share.fnuo_id = _model.id;
    [self.navigationController pushViewController:share animated:YES];
}


#pragma mark - collection data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    NSInteger sec = section;
    if (sec == 0) {
        return 1;
    }
    if (self.model.yhq_list.count > 0 || [self.model.discount kr_isNotEmpty] || [self.model.discount_time kr_isNotEmpty]) {
        sec --;
        int count = 0;
        if (sec == 0) {
            if ([self.model.discount kr_isNotEmpty])
                count++;
            if (self.model.yhq_list.count > 0)
                count++;
            if ([self.model.discount_time kr_isNotEmpty])
                count++;
            return count;
        }
    }
    if ([self.model.describe kr_isNotEmpty]) {
        sec --;
        if (sec == 0) {
            return 1;
        }
    }
    
    if (self.recommends && self.recommends.count > 0) {
        sec --;
        if (sec == 0) {
            return self.recommends.count;
        }
    }
    
    return 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    int section = 1;
    if (self.model.yhq_list.count > 0 || [self.model.discount kr_isNotEmpty] || [self.model.discount_time kr_isNotEmpty]) {
        section ++;
    }
    if ([self.model.describe kr_isNotEmpty]) {
        section ++;
    }
    if (self.recommends && self.recommends.count > 0) {
        section ++;
    }
    return section;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    if (section == 0) {
        FNNewStoreGoodsHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNNewStoreGoodsHeaderCell" forIndexPath:indexPath];
        cell.delegate = self;
        [cell setModel: self.model];
        return cell;
    }
    if (self.model.yhq_list.count > 0 || [self.model.discount kr_isNotEmpty] || [self.model.discount_time kr_isNotEmpty]) {
        section --;
        NSInteger count = indexPath.row;
        if (section == 0) {
            if ([self.model.discount kr_isNotEmpty]) {
                if (count == 0) {
                    FNNewStoreGoodsRuleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNNewStoreGoodsRuleCell" forIndexPath:indexPath];
                    cell.lblTitle.text = @"优惠";
                    cell.lblDesc.text = self.model.discount;
                    return cell;
                }
                count --;
            }
            if (self.model.yhq_list.count > 0) {
                if (count == 0) {
                    FNNewStoreCouponeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNNewStoreCouponeCell" forIndexPath:indexPath];
                    [cell setModel:_storeModel.yhq_list];
                    return cell;
                }
                count --;
            }
            if ([self.model.discount_time kr_isNotEmpty]) {
                if (count == 0) {
                    FNNewStoreGoodsRuleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNNewStoreGoodsRuleCell" forIndexPath:indexPath];
                    cell.lblTitle.text = @"规则";
                    cell.lblDesc.text = self.model.discount_time;
                    return cell;
                }
                count --;
            }
        }
    }
    if ([self.model.describe kr_isNotEmpty]) {
        section --;
        if (section == 0) {
//            return 1;
            FNNewStoreGoodsDescCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNNewStoreGoodsDescCell" forIndexPath:indexPath];
            cell.lblTitle.text = @"商品描述";
            cell.lblDesc.text = self.model.describe;
            return cell;
        }
    }
    if (self.recommends && self.recommends.count > 0) {
        section --;
        if (section == 0) {
            FNStoreGoodsModel *model = self.recommends[indexPath.row];
            FNNewStoreGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNNewStoreGoodsCell" forIndexPath:indexPath];
            cell.model = model;
            //                cell.backgroundColor=[UIColor whiteColor];
            [cell setIsLeft: indexPath.row % 2 == 0];
            cell.borderColor = FNGlobalTextGrayColor;
            cell.delegate = self;
            return cell;
        }
    }
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    if (section == 0) {
    }
    if (self.model.yhq_list.count > 0 || [self.model.discount kr_isNotEmpty] || [self.model.discount_time kr_isNotEmpty]) {
        section --;
        if (section == 0) {
            
        }
    }
    if ([self.model.describe kr_isNotEmpty]) {
        section --;
        if (section == 0) {

        }
    }
    if (self.recommends && self.recommends.count > 0) {
        section --;
        if (section == 0) {
            FNNewStoreRecommendHeaderView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FNNewStoreRecommendHeaderView" forIndexPath:indexPath];
            reusableview.lblTitle.text = @"猜你喜欢";
            
            return reusableview;
        }
    }
    
    return [[UIView alloc] init];
}
#pragma mark - collection flowlayout delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    NSInteger sec = section;
    if (sec == 0) {
    }
    if (self.model.yhq_list.count > 0 || [self.model.discount kr_isNotEmpty] || [self.model.discount_time kr_isNotEmpty]) {
        sec --;
        if (sec == 0) {
            
        }
    }
    if ([self.model.describe kr_isNotEmpty]) {
        sec --;
        if (sec == 0) {
            
        }
    }
    if (self.recommends && self.recommends.count > 0) {
        sec --;
        if (sec == 0) {
            return CGSizeMake(JMScreenWidth, 44);
        }
    }
    return CGSizeMake(JMScreenWidth, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSInteger section = indexPath.section;
    if (section == 0) {
        return CGSizeMake(JMScreenWidth, JMScreenWidth + 120);
    }
    if (self.model.yhq_list.count > 0 || [self.model.discount kr_isNotEmpty] || [self.model.discount_time kr_isNotEmpty]) {
        section --;
        if (section == 0)
            return CGSizeMake(FNDeviceWidth, 44);
    }
    if ([self.model.describe kr_isNotEmpty]) {
        section --;
        if (section == 0) {
            
            NSString* string = self.model.describe;
            CGRect rect = [string boundingRectWithSize:(CGSizeMake(JMScreenWidth-32, 1000)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:kFONT12} context:nil];

            return CGSizeMake(FNDeviceWidth, rect.size.height + 62);
        }
    }
    
    if (self.recommends && self.recommends.count > 0) {
        section --;
        if (section == 0) {
            int w = FNDeviceWidth/2;
            if (indexPath.row % 2 == 1) //防止出现缝隙
                w = FNDeviceWidth - w;
            return CGSizeMake(w, 274);
        }
    }
    
    return CGSizeMake(FNDeviceWidth, 0);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets insets = UIEdgeInsetsZero;

    return insets = UIEdgeInsetsMake(0, 0, 10, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    if (section == 0) {
        
    }
    if (self.model.yhq_list.count > 0 || [self.model.discount kr_isNotEmpty] || [self.model.discount_time kr_isNotEmpty]) {
        section --;
        if (section == 0) {
            //优惠券
            if (![UserAccessToken kr_isNotEmpty]) {
                [self warnToLogin];
                return;
            }
            [self.couponeAlert setCoupones: self.model.yhq_list];
            [self.couponeAlert show];
        }
    }
    if ([self.model.describe kr_isNotEmpty]) {
        section --;
        if (section == 0) {
            
        }
    }
    
    if (self.recommends && self.recommends.count > 0) {
        section --;
        if (section == 0) {
            if (![UserAccessToken kr_isNotEmpty]) {
                [self warnToLogin];
                return;
            }
            FNNewStoreGoodsController *vc = [[FNNewStoreGoodsController alloc] init];
            FNStoreGoodsModel *goods = self.recommends[indexPath.row];
            vc.goods_id = goods.id;
            vc.storeID = self.storeID;
            vc.storeName = self.storeName;
            [vc setStore: self.storeModel];
            [self.navigationController pushViewController:vc animated: YES];
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    if (conY>=self.navigationView.height && conY<= 2*self.navigationView.height) {
        CGFloat alpha = (conY-self.navigationView.height)/self.navigationView.height;
        self.navigationView.backgroundColor = [FNWhiteColor colorWithAlphaComponent:alpha];
    }else if (conY >= self.navigationView.height*2){
        self.navigationView.backgroundColor = [FNWhiteColor colorWithAlphaComponent:1];
    }else{
        self.navigationView.backgroundColor = [FNWhiteColor colorWithAlphaComponent:0];
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

#pragma mark - FNNewStoreGoodsHeaderCellDelegate

- (void) goodsCellDidSubClick: (FNNewStoreGoodsHeaderCell*)cell {
    if (_model.specs || _model.attribute.count > 0) {
        [FNTipsView showTips:@"该商品含有多种属性，请到购物车删除"];
        return;
    } else {
        for (FNStoreCarModel *car in _cars) {
            if ([car.gid isEqualToString:self.model.id]) {
                [self requestRemoveCar:car.id gid: car.gid];
                return;
            }
        }
    }
}

- (void) goodsCellDidAddClick: (FNNewStoreGoodsHeaderCell*)cell {
    _goodsModel = nil;
    
    if (_model.specs || _model.attribute.count > 0) {
        [self.attributeAlert setModel: _model];
        [self.attributeAlert show];
    } else {
        [self requestAddCar:_model.id count: @"1" specs: @"" attribute:@""];
    }
}
- (void) goodsCellDidBuyClick: (FNNewStoreGoodsHeaderCell*)cell {
    [self goodsCellDidAddClick: cell];
}
- (void) goodsCellDidShareClick: (FNNewStoreGoodsHeaderCell*)cell {
    [self sharebtnAction];
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
    if (_goodsModel) {
        [self requestAddCar:_goodsModel.id count: count specs: specs attribute:str];
    } else {
        [self requestAddCar:_model.id count: count specs: specs attribute:str];
    }
}

#pragma mark - FNNewStoreCouponeAlertViewDelegate

- (void)onCouponeClickAt: (NSInteger) index {
    if (index < self.model.yhq_list.count) {
        FNstoreCouponeModel *coupone = self.model.yhq_list[index];
        [self requestCoupone:coupone.id];
    }
}

#pragma mark - FNNewStoreGoodsCellDelegate

- (void)storeGoodsCelldidSubClick: (FNNewStoreGoodsCell*) cell {
    
}
- (void)storeGoodsCelldidAddClick: (FNNewStoreGoodsCell*) cell {
    NSIndexPath *indexPath = [self.jm_collectionview indexPathForCell:cell];
    FNStoreGoodsModel *model = self.recommends[indexPath.row];
    //    [self requestAddCar:@"" gid: model.id];
    [self.attributeAlert setModel: model];
    _goodsModel = model;
    [self.attributeAlert show];
}

@end
