//
//  FNmerSiteMapController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerSiteMapController.h"
#import "FNtendOrientationNeController.h"
#import "FNCustomeNavigationBar.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "POIAnnotation.h"
#import "FNRushLocationDeViewController.h"
#import "FNLocationRetrievedNeCell.h"
#import "FNCustomAnnotationsView.h"


#define DefaultLocationTimeout  6
#define DefaultReGeocodeTimeout 3
@interface FNmerSiteMapController ()<MAMapViewDelegate,AMapLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,FNtendOrientationNeControllerDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar *navigationView;
@property (nonatomic, strong)UIButton     *leftBtn;
@property (nonatomic, strong)UIButton     *rightBtn;
@property (nonatomic, strong)MAMapView           *mapView;
@property (nonatomic, strong)MAAllResultsSearch  *search;
@property (nonatomic, strong)AMapLocationManager *locationManager;
@property (nonatomic, strong)FNHsearchModel      *locationModel;
@property (nonatomic, strong)CLLocation          *curenPlace;

@property (nonatomic, copy)AMapLocatingCompletionBlock completionBlock;

@property (nonatomic, strong)UITableView *tableViews;
@property (nonatomic, strong)NSMutableArray *retrievedArr;
@property (nonatomic, strong)NSString *currentCity;//城市
@property (nonatomic, strong)NSString *subLocality;
@property (nonatomic, assign)CGFloat  latitude;
@property (nonatomic, assign)CGFloat  longitude;
@property (nonatomic, assign)NSInteger  onceInt;
@property (nonatomic, strong)FNCustomAnnotationsView *userLocationAnnotationView;

@property (nonatomic, strong)NSString *provinceName;//省份
@property (nonatomic, strong)NSString *streetName;//街道
@end

@implementation FNmerSiteMapController
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
#pragma mark - set up views
- (void)jm_setupViews{
    self.locationModel=[[FNHsearchModel alloc]init];
    self.onceInt=0;
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.leftBtn.size = CGSizeMake(40, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.size = CGSizeMake(48, 48);
    self.navigationView.rightButton = self.rightBtn;
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightBtn setImage:IMAGE(@"search_search") forState:UIControlStateNormal];
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 5).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.rightBtn.imageView.sd_layout
    .rightSpaceToView(self.rightBtn, 5).centerYEqualToView(self.rightBtn).widthIs(18).heightIs(18);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:16];
    self.navigationView.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.navigationView.titleLabel.text=@"选择地址";
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=RGB(250, 250, 250);
    
    [self lictionDrawView];
    [self inLocationSearchingTableView];
}

#pragma mark - 地图
-(void)lictionDrawView{
    
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, (FNDeviceHeight-SafeAreaTopHeight)/2)];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    self.mapView.showsScale= NO;
    self.mapView.showsCompass= NO; //指南针
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
   
    self.mapView.userLocation.title = @"当前位置";
    [self.mapView setZoomLevel:15.1 animated:YES];
    self.mapView.desiredAccuracy = kCLLocationAccuracyBest;
    
//    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
//    r.fillColor = [UIColor clearColor];
//    r.strokeColor = [UIColor clearColor];
//    r.image = [UIImage imageNamed:@""];
//    [self.mapView updateUserLocationRepresentation:r];
    
    self.search = [[MAAllResultsSearch alloc] init];
    CGFloat tableHeight=(FNDeviceHeight-50)/2;
    UIButton *locationButton= [UIButton buttonWithType:UIButtonTypeCustom];
    locationButton.frame=CGRectMake(FNDeviceWidth-65, tableHeight-75, 45, 45);
    [locationButton addTarget:self action:@selector(orientationAction) forControlEvents:UIControlEventTouchUpInside];
    [locationButton setImage:IMAGE(@"FN_merRedDW") forState:UIControlStateNormal];
    [locationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:locationButton];
    
    CGFloat topGap=(FNDeviceHeight-SafeAreaTopHeight)/2-70;
    locationButton.sd_layout
    .rightSpaceToView(self.view, 2).widthIs(51).heightIs(51).topSpaceToView(self.view, topGap);
    
    [self configLocationManager];
    
    [self initCompleteBlock];
    
}
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
    
    
}
#pragma mark - Initialization

- (void)initCompleteBlock
{
    __weak FNmerSiteMapController *weakSelf = self;
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
        
        //根据定位信息，添加annotation
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        [annotation setCoordinate:location.coordinate];
        
        //有无逆地理信息，annotationView的标题显示的字段不一样
        if (regeocode)
        {
            XYLog(@"city:%@",regeocode.city);
            [annotation setTitle:[NSString stringWithFormat:@"%@", regeocode.formattedAddress]];
         
        }
        else
        {
            [annotation setTitle:[NSString stringWithFormat:@"lat:%f;lon:%f;", location.coordinate.latitude, location.coordinate.longitude]];
            //[annotation setSubtitle:[NSString stringWithFormat:@"accuracy:%.2fm", location.horizontalAccuracy]];
        }
        
        FNmerSiteMapController *strongSelf = weakSelf;
        
        [strongSelf addAnnotationToMapView:annotation];
    };
}
- (void)addAnnotationToMapView:(id<MAAnnotation>)annotation
{
    [self.mapView addAnnotation:annotation];
    [self.mapView selectAnnotation:annotation animated:YES];
    [self.mapView setZoomLevel:15.1 animated:NO];
    [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
}
#pragma mark -MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
//        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
//        }
//
//        annotationView.canShowCallout   = YES;
//        annotationView.animatesDrop     = YES;
//        annotationView.draggable        = NO;
//        //annotationView.pinColor         = MAPinAnnotationColorPurple;
//
//        if(self.latitude == annotation.coordinate.latitude&& self.longitude==annotation.coordinate.longitude){
//            annotationView.image=[UIImage imageNamed:@"Fn_locationBlue"];
//        }
        FNCustomAnnotationsView *annotationView = (FNCustomAnnotationsView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[FNCustomAnnotationsView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
                annotationView.canShowCallout   = YES;
                annotationView.draggable        = NO;
        if(self.latitude == annotation.coordinate.latitude&& self.longitude==annotation.coordinate.longitude){
            annotationView.tzImgView.image=[UIImage imageNamed:@"Fn_locationBlue"];
        }
        
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mapView selectAnnotation:annotation animated:NO];
        });
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
   
    //userLocation 就是用户当前的位置信息，通过userLocation 可以获取当前的经纬度信息及详细的地理位置信息，方法如下：//创建一个经纬度点：
    MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
    //设置点的经纬度
    point.coordinate = userLocation.location.coordinate;
    CLLocation *currentLocation = [[CLLocation alloc]initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    self.curenPlace=currentLocation;
    self.latitude=userLocation.location.coordinate.latitude;
    self.longitude=userLocation.location.coordinate.longitude;
    
    __weak FNmerSiteMapController *weakSelf = self;
    // 初始化编码器
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        //获取当前城市位置信息，其中CLPlacemark包括name、thoroughfare、subThoroughfare、locality、subLocality等详细信息
        CLPlacemark *mark = [placemarks lastObject];
        NSDictionary *dicty=mark.addressDictionary;
        NSString *cityName= mark.locality;
        XYLog(@"省份 - :%@", dicty[@"State"]);
        XYLog(@"城市 - :%@", mark.locality);
        XYLog(@"城市subLocality - :%@", mark.subLocality);
        XYLog(@"城市subThoroughfare - :%@", mark.subThoroughfare);
        XYLog(@"城市thoroughfare - :%@", mark.thoroughfare);
        //self.subLocality=mark.subLocality;
        XYLog(@"城市name - :%@", mark.name);
        self.provinceName=dicty[@"State"];
        self.currentCity= cityName;
        self.streetName=[NSString stringWithFormat:@"%@%@",mark.subLocality,mark.name];
        
        self.locationModel.address=[NSString stringWithFormat:@"%@%@%@",self.provinceName,self.currentCity,self.streetName];
        self.locationModel.latitude=userLocation.location.coordinate.latitude;
        self.locationModel.longitude=userLocation.location.coordinate.longitude;
        self.locationModel.province=dicty[@"State"];
        self.locationModel.city=mark.locality;
        self.locationModel.district=mark.subLocality;
        if([cityName kr_isNotEmpty]){
        }
        if(self.onceInt<1){
           [self searchPoiByKeyword:@""];
        }
        self.onceInt++;
        //[self manualOperation];
    }];
    
}
- (void)reGeocodeAction
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    //进行单次带逆地理定位请求
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
}
#pragma mark - 单元检索周围地址view
-(void)inLocationSearchingTableView{
    CGFloat tableHeight=(FNDeviceHeight-SafeAreaTopHeight)/2;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableViews = [[UITableView alloc]initWithFrame:CGRectMake(0, tableHeight+SafeAreaTopHeight, FNDeviceWidth, tableHeight) style:UITableViewStylePlain];
    self.tableViews.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableViews.dataSource = self;
    self.tableViews.delegate = self;
    self.tableViews.rowHeight=70;
    
    [self.view addSubview:self.tableViews];
    self.tableViews.backgroundColor=FNColor(240,240,240);
    self.tableViews.backgroundColor=[UIColor whiteColor];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _retrievedArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNLocationRetrievedNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"LocationRetrievedNeCellID"];
    if (cell == nil) {
        cell = [[FNLocationRetrievedNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LocationRetrievedNeCellID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model=_retrievedArr[indexPath.row];
    FNHsearchModel *model=_retrievedArr[indexPath.row];
    if(model.state==0){
       cell.stateImage.image=IMAGE(@"FN_merRedTB");
    }else{
       cell.stateImage.image=IMAGE(@"");
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FNHsearchModel *model=_retrievedArr[indexPath.row];
    self.locationModel.address=[NSString stringWithFormat:@"%@%@%@",self.provinceName,self.currentCity,model.name];
    self.locationModel.latitude=model.latitude;
    self.locationModel.longitude=model.longitude;
    if ([self.delegate respondsToSelector:@selector(didMerSiteMapBackAction:)]) {
        [self.delegate didMerSiteMapBackAction:self.locationModel];
    } 
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 添加位置列表信息
- (void)onPoiSearchDone:(AMapPOISearchResponse_AllResults *)allResult {
    //[self.mapView removeAnnotations:self.mapView.annotations];
    XYLog(@"连续性...");
    NSMutableArray *poiAnnotations = [NSMutableArray array];
    NSMutableArray *arrM = [NSMutableArray array];
    for(AMapPOISearchResponse_OnePage *page in allResult.allPages) {
        [page.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
            XYLog(@"搜索name:%@",obj.name);
            XYLog(@"搜索address:%@",obj.address);
            FNHsearchModel *model=[[FNHsearchModel alloc]init];
            model.state=idx;
            model.name=obj.name;
            model.address=obj.address;
            model.latitude=obj.location.latitude;
            model.longitude=obj.location.longitude;
            [arrM addObject:model];
            [poiAnnotations addObject:[[POIAnnotation alloc] initWithPOI:obj]];
        }];
    }
    if(self.onceInt==0){
       self.retrievedArr=arrM;
    }else{
      [self.retrievedArr addObjectsFromArray:arrM];
    }
    if(self.retrievedArr.count>0){
        [self.retrievedArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNHsearchModel *model=obj;
            model.state=idx;
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableViews reloadData];
        });
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableViews reloadData];
    });
    
    /* 将结果以annotation的形式加载到地图上. */
    //[self.mapView addAnnotations:poiAnnotations];
    
    
    /* 如果只有一个结果，设置其为中心点. */
    if (poiAnnotations.count == 1)
    {
        //[self.mapView setCenterCoordinate:[poiAnnotations[0] coordinate]];
    }
    /* 如果有多个结果, 设置地图使所有的annotation都可见. */
    else
    {
        
        
        //[self.mapView showAnnotations:poiAnnotations animated:NO];
    }
}

/* 根据关键字来搜索POI. */
- (void)searchPoiByKeyword:(NSString *)keyword
{
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords = keyword;
    if([self.currentCity kr_isNotEmpty]){
        request.city = self.currentCity;
    }
    
    request.location            = [AMapGeoPoint locationWithLatitude:self.latitude longitude:self.longitude];
    request.requireSubPOIs      = YES;
    request.requireExtension = YES;
    request.offset = 10;
    
    __weak typeof(self) weakSelf = self;
    [self.search searchAllPOIsWith:request resultCallback:^(AMapPOISearchResponse_AllResults *result) {
        XYLog(@"搜索result:%@",result);
        [weakSelf onPoiSearchDone:result];
    }];
}

#pragma mark - 点击
//返回
-(void)leftBtnAction{
//    if ([self.delegate respondsToSelector:@selector(didMerSiteMapBackAction:)]) {
//        [self.delegate didMerSiteMapBackAction:self.locationModel];
//    }
    [self.navigationController popViewControllerAnimated:YES];
}
//搜索
-(void)rightBtnAction{
    self.locationModel.address=[NSString stringWithFormat:@"%@%@%@",self.provinceName,self.currentCity,self.streetName];
    
    FNCityDeNeModel *model=[[FNCityDeNeModel alloc]init];
    FNtendOrientationNeController *vc=[[FNtendOrientationNeController alloc]init];
    //vc.arrayHistoricalCity=[NSMutableArray arrayWithObjects:@"珠海",@"广州",@"武汉",@"长沙", nil];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    vc.arrayHistoricalCity =[defaults objectForKey:@"arrayHistoricalCity"];
    //NSArray *arr=[defaults objectForKey:@"arrayHistoricalCity"];
    vc.delegate=self;
    vc.model=model;
    vc.topStyle=1;
    [self.navigationController pushViewController:vc animated:YES];
}
//手动定位
-(void)orientationAction{
    [self reGeocodeAction];
}
- (NSMutableArray *)retrievedArr {
    if (!_retrievedArr) {
        _retrievedArr = [NSMutableArray array];
    }
    return _retrievedArr;
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
    self.locationModel.latitude=[latitude floatValue];
    self.locationModel.longitude=[longitude floatValue];
    if([model.CityName kr_isNotEmpty]){
        if([self.locationModel.address containsString:model.CityName]) {
            self.locationModel.address=[NSString stringWithFormat:@"%@%@%@",self.provinceName,model.CityName,self.streetName];
        }else{
            self.locationModel.address=model.CityName;
            self.locationModel.province=@"";
            self.locationModel.district=@"";
        }
        self.locationModel.city=model.CityName;
        XYLog(@"address结果:%@",self.locationModel.address);
    }
    //if([model.CityID kr_isNotEmpty]){
    //self.city_id=model.CityID;
    //}
    
}
@end
