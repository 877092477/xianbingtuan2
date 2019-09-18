//
//  FNstorePaveNeController.m
//  69橙子
//
//  Created by Jimmy on 2018/11/22.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//店铺
#import "FNstorePaveNeController.h"
//view
#import "FNstorePaveSlideNeCell.h"
#import "FNstoreInformationDaNeCell.h"
#import "FNstoreCommodityDaNeCell.h"
#import "FNStoreHeaderNeReusableView.h"
#import "FNrushNoGoodsNeCell.h"
//controller
#import "FNTeOddpayDaNeController.h"
#import "FNRushPurchaseNeController.h"
@interface FNstorePaveNeController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNstorePaveSlideNeCellDelegate,FNstoreCommodityDaNeCellDelegate,FNstoreInformationDaNeCellDelegate>
/** 轮播数据数组 */
@property (nonatomic, strong) NSArray *carouselArray;
/** 分类数据数组 */
@property (nonatomic, strong) NSDictionary *informationDic;
/** 店铺商品数据数组 */
@property (nonatomic, strong) NSMutableArray *commodityDataArray;
/** 数量 */
@property (nonatomic, strong) UIButton *quantityBtn;
/** 付款 */
@property (nonatomic, strong) UIButton *depositBtn;
/** 立即购买 */
@property (nonatomic, strong) UIButton *immediatelyBtn;
/** 底部view */
@property (nonatomic, strong) UIView *baseView;
/** 添加商品数量 */
@property (nonatomic, assign) NSInteger addDataInt;
/** 添加商品ID */
@property (nonatomic, assign) NSString *commodity;
/** 添加商品数量 */
@property (nonatomic, assign) NSString *commodityCount;

@property (nonatomic, assign) FNstoreInformationDaModel *storeModel;

@end

@implementation FNstorePaveNeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"店铺";
    if([self.storeName kr_isNotEmpty]){
        self.title=self.storeName;
    }
    
    [self initStructureSubviews];
    [self baseStructureSubViews];
    
    [self apiStoreMainStoreReqeuest];
}

#pragma mark -  构建视图
- (void)initStructureSubviews
{
    self.view.backgroundColor = FNWhiteColor;
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing=0;
    flowayout.minimumInteritemSpacing=0;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowayout];
    self.jm_collectionview.hidden=YES;
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"storeCell"];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellID"];
    [self.jm_collectionview registerClass:[FNstorePaveSlideNeCell class] forCellWithReuseIdentifier:@"storePaveSlideNeCellID"];
    [self.jm_collectionview registerClass:[FNstoreInformationDaNeCell class] forCellWithReuseIdentifier:@"storeInformationDaNeCellID"];
    [self.jm_collectionview registerClass:[FNstoreCommodityDaNeCell class] forCellWithReuseIdentifier:@"storeCommodityDaNeCellID"];
    
    //[self.jm_collectionview registerClass:[FNrushNoGoodsNeCell class] forCellWithReuseIdentifier:@"FNrushNoGoodsNeCellID"];
    
//    [self.jm_collectionview registerClass:[FNshopTendSlideNeCell class] forCellWithReuseIdentifier:@"shopTendSlideNeCellID"];
//    [self.jm_collectionview registerClass:[FNshopTendOptionsNeCell class] forCellWithReuseIdentifier:@"shopTendOptionsNeCellID"];

//    [self.jm_collectionview registerClass:[FNshopTendStoreRowNeCell class] forCellWithReuseIdentifier:@"shopTendStoreRowNeCellID"];
//
    [self.jm_collectionview registerClass:[FNStoreHeaderNeReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"StoreHeaderNeID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderNeReusableViewID"];
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.delegate=self;
    self.jm_collectionview.dataSource=self;
    self.jm_collectionview.backgroundColor=FNWhiteColor;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, 0, 50, 0))]; 
    self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.jm_page=1;
        //[self apiRequestStoreCommodity];
        [self apiStoreMainStoreReqeuest ];
    }];
    
}

#pragma mark UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section==2){
            return self.commodityDataArray.count;
    }else{
        return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0){
        FNstorePaveSlideNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"storePaveSlideNeCellID" forIndexPath:indexPath];
        cell.delegate=self;
        cell.bannerArray=self.carouselArray;
        return cell;
    }
    else if(indexPath.section==1){
        FNstoreInformationDaNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"storeInformationDaNeCellID" forIndexPath:indexPath];
        cell.delegate=self;
        cell.dicModel=self.informationDic;
        return cell;
    }else{
        
             FNstoreCommodityDaNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"storeCommodityDaNeCellID" forIndexPath:indexPath];
             //cell.dicModel=self.commodityDataArray[indexPath.row];
             cell.delegate=self;
             cell.indexPath=indexPath;
             cell.model=self.commodityDataArray[indexPath.row];
             return cell;
         
    }
}
#pragma mark - collectionView delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        return CGSizeMake(FNDeviceWidth, 200);
    }
    else if(indexPath.section==1){
        return CGSizeMake(FNDeviceWidth, 155);
    }else{
        return CGSizeMake(FNDeviceWidth, 110);
    }
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==2){
        FNStoreHeaderNeReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"StoreHeaderNeID" forIndexPath:indexPath];
        headerView.TypeLB.text=@"商品介绍";
        return headerView;
    }else{
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderNeReusableViewID" forIndexPath:indexPath];
        return headerView;
    }
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section==2){
        return CGSizeMake(FNDeviceWidth, 56);
    }else{
        return CGSizeMake(0, 0);
    }
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==2){
       
    }
}
#pragma mark -  FNstoreCommodityDaNeCellDelegate 修改购买数量
// 添加数量
- (void)storeCommodityAttachAmountAction:(NSIndexPath*)indexPath{
    if ([NSString isEmpty:UserAccessToken]) {
        [self goToLogin];
    }else{
        FNstorePaveItemModel *model=self.commodityDataArray[indexPath.row];
        model.count+=1;
        [self.jm_collectionview reloadData];
        [self calculateCount];
        self.commodity=model.id;
        self.commodityCount=[NSString stringWithFormat:@"%ld",(long)model.count];
        [self apiRequestAdditionMerchandise];
    }
}
// 减数量
- (void)storeCommodityDecrementAction:(NSIndexPath*)indexPath{
    if ([NSString isEmpty:UserAccessToken]) {
        [self goToLogin];
    }else{
        FNstorePaveItemModel *model=self.commodityDataArray[indexPath.row];
        model.count-=1;
        [self.jm_collectionview reloadData];
        [self calculateCount];
        self.commodity=model.id;
        self.commodityCount=[NSString stringWithFormat:@"%ld",(long)model.count];
        [self apiRequestAdditionMerchandise];
    }
}
-(void)calculateCount{
    NSInteger count=0;
    for (FNstorePaveItemModel *itemmodel in self.commodityDataArray){
        if(itemmodel.count>0){
            count+=itemmodel.count;
        }
    }
    self.addDataInt=count;
    if(count>0){
        self.quantityBtn.hidden=NO;
    }else{
        self.quantityBtn.hidden=YES;
    }
    [self.quantityBtn setTitle:[NSString stringWithFormat:@"%ld",(long)self.addDataInt] forState:UIControlStateNormal];
    
}
#pragma mark -  FNstoreInformationDaNeCellDelegate 拨打电话
// 拨打电话
- (void)ringUpStoreCommodityAction{
    NSString *phoneString=self.informationDic[@"phone"];
    NSLog(@"电话:%@",phoneString);
    if([phoneString kr_isNotEmpty]){
        NSString *str = [NSString stringWithFormat:@"tel:%@",phoneString];
        
        UIWebView *callWebView = [[UIWebView alloc]init];
        
        [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebView];
    }
    
}
#pragma mark -  底部view
-(void)baseStructureSubViews{
    self.baseView=[[UIView alloc]initWithFrame:CGRectMake(0,FNDeviceHeight-55 , FNDeviceWidth, 55)];
    //baseView.backgroundColor=[UIColor clearColor];
    self.baseView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.baseView];
    self.baseView.sd_layout.bottomSpaceToView(self.view, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(55);
    
    self.depositBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.depositBtn.titleLabel.font=kFONT14;
    self.depositBtn.backgroundColor=RGB(246, 51, 40);
    [self.depositBtn addTarget:self action:@selector(depositBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.baseView addSubview:self.depositBtn];
    self.depositBtn.sd_layout.leftSpaceToView(self.baseView, 110).widthIs(JMScreenWidth/4+20).heightIs(55).bottomSpaceToView(self.baseView, 0);
    
    
    self.immediatelyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.immediatelyBtn.titleLabel.font=kFONT14;
    self.immediatelyBtn.backgroundColor=RGB(255 , 155, 64);
    [self.immediatelyBtn addTarget:self action:@selector(immediatelyBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.baseView addSubview:self.immediatelyBtn];
    self.immediatelyBtn.sd_layout.leftSpaceToView(self.depositBtn, 0).heightIs(55).bottomSpaceToView(self.baseView, 0).rightSpaceToView(self.baseView, 0);
    
    
    
    
    UIButton *shoppingBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    shoppingBtn.backgroundColor=[UIColor whiteColor];
    shoppingBtn.borderWidth=0.5;
    shoppingBtn.borderColor = FNGlobalTextGrayColor;
    shoppingBtn.cornerRadius=60/2;
    [shoppingBtn addTarget:self action:@selector(shoppingBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [shoppingBtn setImage:[UIImage imageNamed:@"details_cion_shopping"] forState:UIControlStateNormal];
    [self.view addSubview:shoppingBtn];
    shoppingBtn.sd_layout.leftSpaceToView(self.view, 20).widthIs(60).heightIs(60).bottomSpaceToView(self.view, 10);
    
    self.quantityBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.quantityBtn.backgroundColor=RGB(246, 51, 40);
    self.quantityBtn.cornerRadius=20/2;
    self.quantityBtn.hidden=YES;
    [self.quantityBtn addTarget:self action:@selector(shoppingBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.quantityBtn setTitle:@"" forState:UIControlStateNormal];
    self.quantityBtn.titleLabel.font=kFONT13;
    [self.view addSubview:self.quantityBtn];
    self.quantityBtn.sd_layout.leftSpaceToView(self.view, 60).widthIs(20).heightIs(20).bottomSpaceToView(self.view, 50);
    
    
    
}
-(void)shoppingBtnAction{
    
}
//付款
-(void)depositBtnAction{
    
    if([NSString isEmpty:UserAccessToken]){
        [self goToLogin];
    }else{
        FNTeOddpayDaNeController *vc=[[FNTeOddpayDaNeController alloc]init];
        vc.storeID=self.storeID;
        vc.moneyRatio=self.informationDic[@"commission"];
        vc.storeDictry=self.informationDic;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
//立即购买
-(void)immediatelyBtnAction{
    if(self.addDataInt==0){
        [FNTipsView showTips:@"请选择商品!"];
    }else if([NSString isEmpty:UserAccessToken]){
        [self goToLogin];
    }else{
        FNRushPurchaseNeController *vc=[[FNRushPurchaseNeController alloc]init];
        vc.storeID=self.storeID;
        vc.storeName=self.storeName;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - Request
- (void)apiStoreMainStoreReqeuest{
    @WeakObj(self);
    [SVProgressHUD show];
    [FNRequestTool startWithRequests:@[[self apiRequestStoreMessage],[self apiRequestStoreCommodity]] withFinishedBlock:^(NSArray *erros) {
        [selfWeak.jm_collectionview reloadData];
        [SVProgressHUD dismiss];
        self.jm_collectionview.hidden=NO;
    }];
}
//获取店铺信息数据
- (FNRequestTool *)apiRequestStoreMessage{
    //@WeakObj(self);
     @weakify(self);
    //
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    if([self.storeID kr_isNotEmpty]){
        params[@"id"]=self.storeID;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_store&ctrl=store_detail" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"店铺信息:%@",respondsObject);
        @strongify(self);
        NSDictionary* dataDic = respondsObject[DataKey];
        self.storeModel=[FNstoreInformationDaModel mj_objectWithKeyValues:dataDic];
        self.carouselArray=dataDic[@"banner"];
        self.informationDic=dataDic;

        NSInteger cart_count=[dataDic[@"cart_count"] integerValue];
        [self.quantityBtn setTitle:[NSString stringWithFormat:@"%ld",(long)cart_count] forState:UIControlStateNormal];
        if (![FNCurrentVersion isEqualToString:Setting_checkVersion]) {
            [self.immediatelyBtn setTitle:dataDic[@"buy_str"] forState:UIControlStateNormal];
            [self.depositBtn setTitle:dataDic[@"pay_str"] forState:UIControlStateNormal];

        }else{
            [self.immediatelyBtn setTitle:@"付款" forState:UIControlStateNormal];
            [self.depositBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        }
        self.addDataInt=cart_count;
        if(cart_count>0){
           self.quantityBtn.hidden=NO;
        }else{
           self.quantityBtn.hidden=YES;
        }
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
//获取店铺商品
- (FNRequestTool *)apiRequestStoreCommodity{
    [self.jm_collectionview.mj_footer endRefreshing];
    [self.jm_collectionview.mj_header endRefreshing];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"p":@(self.jm_page)}];
    if([self.storeID kr_isNotEmpty]){
        params[@"id"]=self.storeID;
    }
    @WeakObj(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"店铺商品:%@",respondsObject);
        
        NSArray* arrM = respondsObject[DataKey];
        NSMutableArray *arrList=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary* dittry in arrM) {
            FNstorePaveItemModel *model=[FNstorePaveItemModel mj_objectWithKeyValues:dittry];
            model.daCount=0;
            [arrList addObject:model];
        }
        if (selfWeak.jm_page == 1) {
            if (arrList.count == 0) {
                [SVProgressHUD showInfoWithStatus:@"很抱歉，没有找到该类产品~"];
                return ;
            }
            [selfWeak.commodityDataArray removeAllObjects];
            [selfWeak.commodityDataArray addObjectsFromArray:arrList];
            if (arrList.count >= _jm_pro_pagesize) {
                selfWeak.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiRequestStoreCommodity];
                }];
            }else{
                selfWeak.jm_collectionview.mj_footer = nil;
            }
        } else {
            [selfWeak.commodityDataArray addObjectsFromArray:arrList];
            if (arrList.count >= _jm_pro_pagesize) {
                [selfWeak.jm_collectionview.mj_footer endRefreshing];
            }else{
                [selfWeak.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
//添加商品到购物车
- (FNRequestTool *)apiRequestAdditionMerchandise{
    @WeakObj(self); 
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"gid":self.commodity,@"count":self.commodityCount}];
    if([self.storeID kr_isNotEmpty]){
        params[@"store_id"]=self.storeID;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods&ctrl=add_shoppingcart" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        
        XYLog(@"添加商品结果:%@",respondsObject);
        NSDictionary* dictry = respondsObject[DataKey];
        NSInteger cart_count=[dictry[@"count"] integerValue];
        selfWeak.addDataInt=cart_count;
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

- (NSMutableArray *)commodityDataArray {
    if (!_commodityDataArray) {
        _commodityDataArray = [NSMutableArray array];
    }
    return _commodityDataArray;
}
-(void)goToLogin{
    if ([NSString isEmpty:UserAccessToken]) {
        [self warnToLogin];
        return;
    }
}
-(void)setStoreModel:(FNstoreInformationDaModel *)storeModel{
    _storeModel=storeModel;
    if(storeModel){
        NSArray *btnArr=storeModel.btn;
        FNstoreBtnItemModel *payModel=[[FNstoreBtnItemModel alloc]init];
        FNstoreBtnItemModel *buyModel=[[FNstoreBtnItemModel alloc]init];
        if(btnArr.count>0){
            FNstoreBtnItemModel *model=[FNstoreBtnItemModel mj_objectWithKeyValues:btnArr[0]];
            if([model.type isEqualToString:@"pay"]){
              payModel=model;
              [self.depositBtn setTitle:model.str forState:UIControlStateNormal];
              [self.depositBtn setTitleColor:[UIColor colorWithHexString:model.font_color] forState:UIControlStateNormal];
              self.depositBtn.backgroundColor=[UIColor colorWithHexString:model.bg_color];
              
            }else if ([model.type isEqualToString:@"buy"]){
              buyModel=model;
              [self.immediatelyBtn setTitle:model.str forState:UIControlStateNormal];
              [self.immediatelyBtn setTitle:model.str forState:UIControlStateNormal];
              [self.immediatelyBtn setTitleColor:[UIColor colorWithHexString:model.font_color] forState:UIControlStateNormal];
              self.immediatelyBtn.backgroundColor=[UIColor colorWithHexString:model.bg_color];
            }
        }
        if(btnArr.count>1){
            FNstoreBtnItemModel *model=[FNstoreBtnItemModel mj_objectWithKeyValues:btnArr[1]];
            if([model.type isEqualToString:@"pay"]){
                payModel=model;
                [self.depositBtn setTitle:model.str forState:UIControlStateNormal];
                [self.depositBtn setTitle:model.str forState:UIControlStateNormal];
                [self.depositBtn setTitleColor:[UIColor colorWithHexString:model.font_color] forState:UIControlStateNormal];
                self.depositBtn.backgroundColor=[UIColor colorWithHexString:model.bg_color];
            }else if ([model.type isEqualToString:@"buy"]){
                buyModel=model;
                [self.immediatelyBtn setTitle:model.str forState:UIControlStateNormal];
                [self.immediatelyBtn setTitleColor:[UIColor colorWithHexString:model.font_color] forState:UIControlStateNormal];
                self.immediatelyBtn.backgroundColor=[UIColor colorWithHexString:model.bg_color];
            }
            
        }
        [self didBottomButtonShow:payModel.is_show withShow:buyModel.is_show];
        if ([FNCurrentVersion isEqualToString:Setting_checkVersion]) {
            [self.immediatelyBtn setTitle:@"付款" forState:UIControlStateNormal];
            [self.depositBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        }
    }
}
-(void)didBottomButtonShow:(NSInteger)payshow withShow:(NSInteger)buyShow{
    if(payshow==1&&buyShow==1){
       self.depositBtn.hidden=NO;
       self.immediatelyBtn.hidden=NO;
       self.depositBtn.sd_layout.leftSpaceToView(self.baseView, 110).widthIs(JMScreenWidth/4+20).heightIs(55).bottomSpaceToView(self.baseView, 0);
       self.immediatelyBtn.sd_layout.leftSpaceToView(self.depositBtn, 0).heightIs(55).bottomSpaceToView(self.baseView, 0).rightSpaceToView(self.baseView, 0);
      
    }else if(payshow==0&&buyShow==1){
       self.depositBtn.hidden=YES;
       self.immediatelyBtn.hidden=NO;
       self.depositBtn.sd_layout.leftSpaceToView(self.baseView, 110).widthIs(0).heightIs(55).bottomSpaceToView(self.baseView, 0);
       self.immediatelyBtn.sd_layout.leftSpaceToView(self.depositBtn, 0).heightIs(55).bottomSpaceToView(self.baseView, 0).rightSpaceToView(self.baseView, 0);
    }
    else if(payshow==1&&buyShow==0){
       self.depositBtn.hidden=NO;
       self.immediatelyBtn.hidden=YES;
       self.depositBtn.sd_layout.rightSpaceToView(self.baseView, 0).heightIs(55).bottomSpaceToView(self.baseView, 0).widthIs(JMScreenWidth/4+20);
       self.immediatelyBtn.sd_layout.leftSpaceToView(self.depositBtn, 0).heightIs(55).bottomSpaceToView(self.baseView, 0).widthIs(0);
    }
    else if(payshow==0&&buyShow==0){
       self.depositBtn.hidden=YES;
       self.immediatelyBtn.hidden=YES;
    }
}
@end
