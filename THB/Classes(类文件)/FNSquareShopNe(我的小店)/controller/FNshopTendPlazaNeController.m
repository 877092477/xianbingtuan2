//
//  FNshopTendPlazaNeController.m
//  69橙子
//
//  Created by Jimmy on 2018/11/21.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNshopTendPlazaNeController.h"
#define DefaultLocationTimeout  6
#define DefaultReGeocodeTimeout 3
//view
#import "FNCustomeNavigationBar.h"
#import "FNshopTendSlideNeCell.h"
#import "FNshopTendOptionsNeCell.h"
#import "FNshopTendStoreRowNeCell.h"
#import "FNStoreHeaderNeReusableView.h"
#import "FNrushNoGoodsNeCell.h"
//model
#import "FNStoreThendNeModel.h"
#import "FNCityDeNeModel.h"
#import "FNStoreHomeButtonModel.h"
//controller
#import "FNstorePaveNeController.h"
#import "FNtendOrderDaNeController.h"
#import "FNshopTendListNeController.h"
#import "FNtendOrientationNeController.h"
#import "FNrushSeekStoreController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "FNshopTendStoreDoubleRowNeCell.h"
#import "FNNewStoreDetailController.h"

@interface FNshopTendPlazaNeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate,FNshopTendSlideNeCellDelegate,FNshopTendOptionsNeCellDelegate,FNtendOrientationNeControllerDelegate,AMapLocationManagerDelegate, FNStoreHeaderNeReusableViewDelegate>
@property(nonatomic,strong)FNCustomeNavigationBar *storeNaivgationbar;
/** 数据 */
@property (nonatomic, strong) NSDictionary *dataDictry;
/** 幻灯片数据数组 */
@property (nonatomic, strong) NSArray *slideArray;
/** 分类数据数组 */
@property (nonatomic, strong) NSArray *categoryArray;
/** 店铺数据数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 地名 */
@property (nonatomic, strong) UIButton *nameBtn;
@property (nonatomic, strong) NSString *city_id;
@property (nonatomic, strong) NSString  *latitude;
@property (nonatomic, strong) NSString  *longitude;

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;

@property (nonatomic, assign) BOOL isSingle;

@property (nonatomic, strong) NSMutableArray<UIButton*> *buttons;
@property (nonatomic, strong) NSMutableArray<FNStoreHomeButtonModel*> *buttonModels;

@end

@implementation FNshopTendPlazaNeController
#pragma mark - 一些系统的方法
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
    _isSingle = NO;
    _buttons = [[NSMutableArray alloc] init];
    _buttonModels = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    //[self apiRequestSquare];
    //[self apiRequestRebateStoreList];
    [self apiStoreMainReqeuest];
    //定位
    [self configLocationManager];
    [self requestButtons];
    
    //self.title=@"小店";
    [self setUpCustomizedNaviBar];
    [self initStructureSubviews];
}
#pragma mark - initializedNavBar 导航栏
- (void)setUpCustomizedNaviBar{
    _storeNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithSearchBarFrame:(CGRectMake(80, 27, FNDeviceWidth-80*2, 30)) andPlaceholder:@"搜索附近商家"];
    _storeNaivgationbar.searchBar.cornerRadius = 5;
    //_storeNaivgationbar.searchBar.backgroundColor=FNColor(244, 244, 244);
    _storeNaivgationbar.searchBar.backgroundImage = [UIImage createImageWithColor:FNColor(244, 244, 244)];
    //[_storeNaivgationbar.searchBar setSearchFieldBackgroundImage:[UIImage createImageWithColor:FNColor(244, 244, 244)] forState:UIControlStateNormal];
    UIView *searchTextField = nil;
    searchTextField = [[[_storeNaivgationbar.searchBar.subviews firstObject] subviews] lastObject];
    searchTextField.backgroundColor=FNColor(244, 244, 244);
    _storeNaivgationbar.frame=CGRectMake(0, 0, FNDeviceWidth, _storeNaivgationbar.height);
    _storeNaivgationbar.backgroundColor=[UIColor whiteColor];
    _storeNaivgationbar.searchBar.delegate  =self;
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSFontAttributeName: kFONT14}];
    
    UIButton *nameBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [nameBtn setImage:[UIImage imageNamed:@"FN_ic_pull"] forState:UIControlStateNormal];
    //[nameBtn sizeToFit];
    nameBtn.titleLabel.font = kFONT13;
    nameBtn.size = CGSizeMake(nameBtn.width+10, nameBtn.height+10);
    nameBtn.frame=CGRectMake(10, _storeNaivgationbar.height/2-15, 80, 30);
    [nameBtn addTarget:self action:@selector(toponymyAction) forControlEvents:(UIControlEventTouchUpInside)];
    [nameBtn setTitle:@"选择城市" forState:UIControlStateNormal];
    [nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nameBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    nameBtn.titleLabel.sd_layout.centerYEqualToView(nameBtn).leftSpaceToView(nameBtn,5).widthIs(59).heightIs(30);
    nameBtn.imageView.sd_layout.centerYEqualToView(nameBtn).leftSpaceToView(nameBtn.titleLabel,5).widthIs(11).heightIs(6);
    //[nameBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10.0f];
    self.nameBtn=nameBtn;
    
//    UIButton *packetBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [packetBtn setImage:[UIImage imageNamed:@"FN_ic_coupon"] forState:UIControlStateNormal];
//    [packetBtn sizeToFit];
//    packetBtn.size = CGSizeMake(packetBtn.width+10, packetBtn.height+10);
//    packetBtn.size = CGSizeMake(20, 20);
//    [packetBtn addTarget:self action:@selector(packetBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _storeNaivgationbar.leftButton = nameBtn;
//    _storeNaivgationbar.rightButton = packetBtn;
    
    [self.view addSubview:_storeNaivgationbar];
}
#pragma mark -  选择地方
-(void)toponymyAction{
    FNCityDeNeModel *model=[[FNCityDeNeModel alloc]init];
    FNtendOrientationNeController *vc=[[FNtendOrientationNeController alloc]init];
    //vc.arrayHistoricalCity=[NSMutableArray arrayWithObjects:@"珠海",@"广州",@"武汉",@"长沙", nil];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    vc.arrayHistoricalCity =[defaults objectForKey:@"arrayHistoricalCity"];
    NSArray *arr=[defaults objectForKey:@"arrayHistoricalCity"];
    XYLog(@"arr:%@",arr);
    vc.delegate=self;
    vc.model=model;
    vc.topStyle=0;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -  FNtendOrientationNeControllerDelegate 选择地方

- (void)didClickedWithCityName:(NSString*)cityName{
    XYLog(@"cityName:%@",cityName);
    
   
}
- (void)didCityWithLongitude:(NSString*)longitude withLatitude:(NSString*)latitude{
    XYLog(@"longitude:%@ latitude:%@",longitude,latitude);
    
    //[self apiStoreMainReqeuest];
}
- (void)didCityWithLongitude:(NSString*)longitude withLatitude:(NSString*)latitude withModel:(FNCityDeNeModel*)model{
    XYLog(@"longitude:%@ latitude:%@",longitude,latitude);
    XYLog(@"地名:%@",model.CityName);
    self.latitude=latitude;
    self.longitude=longitude;
    if([model.CityName kr_isNotEmpty]){
        [self.nameBtn setTitle:model.CityName forState:UIControlStateNormal];
    }
    //if([model.CityID kr_isNotEmpty]){
        self.city_id=model.CityID;
    //}
    [self apiStoreMainReqeuest];
}
#pragma mark -  选择右边
-(void)packetBtnAction{
    if(![NSString isEmpty:UserAccessToken]){
      FNtendOrderDaNeController *vc=[[FNtendOrderDaNeController alloc]init];
      [self.navigationController pushViewController:vc animated:YES];
    }
    else{
      [self gologin];
    }
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
    [self.jm_collectionview registerClass:[FNshopTendSlideNeCell class] forCellWithReuseIdentifier:@"shopTendSlideNeCellID"];
    [self.jm_collectionview registerClass:[FNshopTendOptionsNeCell class] forCellWithReuseIdentifier:@"shopTendOptionsNeCellID"];
    
    [self.jm_collectionview registerClass:[FNshopTendStoreRowNeCell class] forCellWithReuseIdentifier:@"shopTendStoreRowNeCellID"];
    [self.jm_collectionview registerClass:[FNshopTendStoreDoubleRowNeCell class] forCellWithReuseIdentifier:@"FNshopTendStoreDoubleRowNeCell"];
    
    
    [self.jm_collectionview registerClass:[FNrushNoGoodsNeCell class] forCellWithReuseIdentifier:@"rushNoGoodsNeCellID"];
    
    
    [self.jm_collectionview registerClass:[FNStoreHeaderNeReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"StoreHeaderNeReusableViewID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderNeReusableViewID"];
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.delegate=self;
    self.jm_collectionview.dataSource=self; 
    self.jm_collectionview.backgroundColor=FNWhiteColor;
    
//    self.jm_collectionview.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview:self.jm_collectionview];
    CGFloat bottomInterval=0;
    if(self.isMain==YES){
        bottomInterval=XYTabBarHeight;
    }
    [self.jm_collectionview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(_storeNaivgationbar.height, 0, bottomInterval, 0))];
    self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.jm_page=1;
        //[self apiRequestRebateStoreList];
        [self apiStoreMainReqeuest ];
    }];
    //@WeakObj(self);
    //@strongify(self);
    
}

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

#pragma mark UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section==2){
        if(self.dataArray.count>0){
            //FNrushNoGoodsNeCell
            return self.dataArray.count;
        }else{
            return 1;
        }
        
    }else{
        return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0){
        FNshopTendSlideNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopTendSlideNeCellID" forIndexPath:indexPath];
        cell.delegate=self;
        cell.bannerArray=self.slideArray;
        return cell;
    }
    else if(indexPath.section==1){
        FNshopTendOptionsNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopTendOptionsNeCellID" forIndexPath:indexPath];
        cell.delegate=self;
        cell.kuaisurukouList=self.categoryArray; 
        return cell;
    }else{
        if(self.dataArray.count>0){
//            if (_isSingle) {
//                FNshopTendStoreRowNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopTendStoreRowNeCellID" forIndexPath:indexPath];
//                cell.dicModel=self.dataArray[indexPath.row];
//                return cell;
//            } else {
                FNshopTendStoreDoubleRowNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNshopTendStoreDoubleRowNeCell" forIndexPath:indexPath];
                cell.dicModel=self.dataArray[indexPath.row];
                [cell setIsLeft: indexPath.row % 2 == 0];
                return cell;
//            }
        }else{
            FNrushNoGoodsNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rushNoGoodsNeCellID" forIndexPath:indexPath];
            cell.backgroundColor=RGB(246, 246, 246);
            return cell;
        }
        
    } 
}
#pragma mark - collectionView delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
       return CGSizeMake(FNDeviceWidth, 157);
    }
    else if(indexPath.section==1){
        return CGSizeMake(FNDeviceWidth, 167);
    }else{
        if(self.dataArray.count>0){
//            if (_isSingle) {
//                return CGSizeMake(FNDeviceWidth, 110);
//            } else {
                int w = FNDeviceWidth / 2;
                if (indexPath.row % 2 == 1)
                    w = FNDeviceWidth - w;
                return CGSizeMake(w, 240);
//            }
        }else{
            return CGSizeMake(FNDeviceWidth, 270);
        }
    }
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==2){
        FNStoreHeaderNeReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"StoreHeaderNeReusableViewID" forIndexPath:indexPath];
        headerView.delegate = self;
        headerView.TypeLB.text=self.dataDictry[@"str2"];//@"附近的店";
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
    
    if(indexPath.section==2 && self.dataArray.count > 0){
        FNStoreThendNeModel *model=[FNStoreThendNeModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
//        FNstorePaveNeController *vc=[[FNstorePaveNeController alloc]init];
        FNNewStoreDetailController *vc = [[FNNewStoreDetailController alloc] init];
        vc.storeID=model.id;
        vc.storeName=model.name;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    FNrushSeekStoreController *vc=[[FNrushSeekStoreController alloc]init];
    vc.city_id=self.city_id;
    vc.latitude=self.latitude;
    vc.longitude=self.longitude;
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
}
#pragma mark - FNshopTendSlideNeCellDelegate   点击轮播图
- (void)tendSlideClickAction:(NSInteger)sender{
    XYLog(@"sender:%ld",(long)sender);
    NSDictionary* dataDic = self.slideArray[sender];
}
#pragma mark - FNshopTendOptionsNeCellDelegate  点击分类
- (void)tendOptionsAction:(NSInteger)sender{
    XYLog(@"cate:%ld",(long)sender);
    NSDictionary* dataDic = self.categoryArray[sender];
    FNStoreThendTypeNeModel *model=[ FNStoreThendTypeNeModel mj_objectWithKeyValues:dataDic];
    FNshopTendListNeController *vc=[[FNshopTendListNeController alloc]init];
    vc.shopType=model.id;
    vc.catename=model.catename;
    vc.city_id=self.city_id;
    vc.latitude=self.latitude;
    vc.longitude=self.longitude;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Request
- (void)apiStoreMainReqeuest{
    @WeakObj(self);
    [SVProgressHUD show];
    [FNRequestTool startWithRequests:@[[self apiRequestSquare],[self apiRequestRebateStoreList]] withFinishedBlock:^(NSArray *erros) {
        [selfWeak.jm_collectionview reloadData];
        [SVProgressHUD dismiss];
        self.jm_collectionview.hidden=NO;
    }];
}
//获取小店首页数据
- (FNRequestTool *)apiRequestSquare{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_store&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"小店:%@",respondsObject);
        NSDictionary* dataDic = respondsObject[DataKey];
        selfWeak.dataDictry=dataDic;
        NSArray *slisdearr=dataDic[@"banner"];
        NSArray *catearr=dataDic[@"cate"];
        selfWeak.slideArray=slisdearr;
        selfWeak.categoryArray=catearr;
        [selfWeak.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
//获取小店首页数据
- (FNRequestTool *)apiRequestRebateStoreList{
    [self.jm_collectionview.mj_footer endRefreshing];
    [self.jm_collectionview.mj_header endRefreshing];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"p":@(self.jm_page),@"cid":@"",@"keyword":@""}];
    if([self.city_id kr_isNotEmpty]){
        params[@"city_id"]=self.city_id;
    }
    if([self.latitude kr_isNotEmpty]){
        params[@"lat"]=self.latitude;
    }
    if([self.longitude kr_isNotEmpty]){
        params[@"lng"]=self.longitude;
    }
    XYLog(@"params:%@",params);
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
        [selfWeak.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache: NO];
}

- (void)requestButtons {
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
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

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
#pragma mark - 定位
- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:NO];
    
    //设置定位超时时间
    [self.locationManager setLocationTimeout:DefaultLocationTimeout];
    
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
    
    //设置开启虚拟定位风险监测，可以根据需要开启
    [self.locationManager setDetectRiskOfFakeLocation:NO];
    
    [self initCompleteBlock];
    
    [self reGeocodeAction];
    
    
    
}
//进行单次带逆地理定位请求
- (void)reGeocodeAction
{
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
}
#pragma mark - Initialization

- (void)initCompleteBlock
{
    __weak FNshopTendPlazaNeController *weakSelf = self;
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        if (error != nil && error.code == AMapLocationErrorLocateFailed)
        {
            //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.userInfo);
            return;
        }
        else if (error != nil
                 && (error.code == AMapLocationErrorReGeocodeFailed
                     || error.code == AMapLocationErrorTimeOut
                     || error.code == AMapLocationErrorCannotFindHost
                     || error.code == AMapLocationErrorBadURL
                     || error.code == AMapLocationErrorNotConnectedToInternet
                     || error.code == AMapLocationErrorCannotConnectToHost))
        {
            //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
            NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.userInfo);
        }
        else if (error != nil && error.code == AMapLocationErrorRiskOfFakeLocation)
        {
            //存在虚拟定位的风险：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.userInfo);
            
            //存在虚拟定位的风险的定位结果
            __unused CLLocation *riskyLocateResult = [error.userInfo objectForKey:@"AMapLocationRiskyLocateResult"];
            //存在外接的辅助定位设备
            __unused NSDictionary *externalAccressory = [error.userInfo objectForKey:@"AMapLocationAccessoryInfo"];
            
            return;
        }
        else
        {
            //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
        }
        //location.coordinate.latitude, location.coordinate.longitude
        
     
        
        //有无逆地理信息，annotationView的标题显示的字段不一样
        if (regeocode)
        {
            XYLog(@"city:%@",regeocode.city);
             [weakSelf.nameBtn setTitle:regeocode.city forState:UIControlStateNormal];
            weakSelf.latitude=[NSString stringWithFormat:@"%f",location.coordinate.latitude];
            weakSelf.longitude=[NSString stringWithFormat:@"%f",location.coordinate.longitude];
            [weakSelf apiRequestRebateStoreList];
            //[annotation setTitle:[NSString stringWithFormat:@"%@", regeocode.formattedAddress]];
            //[annotation setSubtitle:[NSString stringWithFormat:@"%@-%@-%.2fm", regeocode.citycode, regeocode.adcode, location.horizontalAccuracy]];
        }
        else
        {
             //annotation setTitle:[NSString stringWithFormat:@"lat:%f;lon:%f;", ]];
            //[annotation setSubtitle:[NSString stringWithFormat:@"accuracy:%.2fm", location.horizontalAccuracy]];
        }
        
       
        
     
        
        
        
    };
}

#pragma mark - FNStoreHeaderNeReusableView
- (void)view: (FNStoreHeaderNeReusableView*)view didLayoutSelected: (BOOL)isSelected {
    
//    _isSingle = !isSelected;
    [self.jm_collectionview reloadData];
    
}

@end
