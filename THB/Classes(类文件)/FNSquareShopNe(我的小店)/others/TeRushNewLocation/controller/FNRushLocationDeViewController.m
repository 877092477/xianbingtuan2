//
//  FNRushLocationDeViewController.m
//  69橙子
//
//  Created by 李显 on 2018/12/9.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNRushLocationDeViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#import "POIAnnotation.h"

#import "FNLocationRetrievedNeCell.h"
#import "FNHContactModel.h"
#import "CustomAnnotationView.h"
#import "FNCustomAnnotationsView.h"

#define DefaultLocationTimeout  6
#define DefaultReGeocodeTimeout 3
@interface FNRushLocationDeViewController ()<MAMapViewDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,AMapLocationManagerDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;
@property (nonatomic, strong) CLLocation *curenPlace;
@property (nonatomic, strong) MAAllResultsSearch *search;
@property (nonatomic, strong) UIButton *lictionImgButton;
@property (nonatomic, strong) UIButton *orientationButton;
@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSString *currentCity;
@property (nonatomic, strong) NSString *subLocality;
@property (nonatomic, strong) NSMutableArray *retrievedArr;

@property (nonatomic, assign) CGFloat  latitude;
@property (nonatomic, assign) CGFloat  longitude;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;

@property (nonatomic, assign)NSInteger  onceInt;

@end

@implementation FNRushLocationDeViewController

- (NSMutableArray *)retrievedArr {
    if (!_retrievedArr) {
        _retrievedArr = [NSMutableArray array];
    }
    return _retrievedArr;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self backButtonAction];
}
-(void)backButtonAction{
    if ([self.delegate respondsToSelector:@selector(inSelectLocationAction:)]) {
        [self.delegate inSelectLocationAction:self.locationModel];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"确认收货地址";
    self.onceInt=0;
    [self grabbleView];
    [self lictionDrawView];
    [self rushLocationSearchingTableView];
}

#pragma mark - 搜索
-(void)grabbleView{
 
    
//    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [backBtn setTitleColor:FNBlackColor forState:UIControlStateNormal];
//    //[backBtn setTitle:[NSString stringWithFormat:@"  %@",nameString] forState:UIControlStateNormal];
//    [backBtn setImage:IMAGE(@"details_cion_back") forState:UIControlStateNormal];
//    //backBtn.titleLabel.font = kFONT14;
//    [backBtn sizeToFit];
//    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    
    UIView *searcView=[[UIView alloc]init];
    searcView.backgroundColor=[UIColor whiteColor];
    searcView.frame=CGRectMake(0, 0, FNDeviceWidth, 50);
    [self.view addSubview:searcView];
   
    UIView *lightView=[[UIView alloc]init];
    lightView.backgroundColor=RGB(239, 239, 239);
    lightView.frame=CGRectMake(10, 7, FNDeviceWidth-20, 35);
    lightView.cornerRadius=35/2;
    [searcView addSubview:lightView];
    
    self.orientationButton= [UIButton buttonWithType:UIButtonTypeCustom];
    self.orientationButton.frame=CGRectMake(30, 10, 50, 30);
    self.orientationButton.titleLabel.font=kFONT14;
    [self.orientationButton addTarget:self action:@selector(orientationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orientationButton setTitle:@"定位" forState:UIControlStateNormal];
    [self.orientationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lightView addSubview:self.orientationButton];
    
    self.lictionImgButton= [UIButton buttonWithType:UIButtonTypeCustom];
    self.lictionImgButton.frame=CGRectMake(10, 35/2, 15, 15);
    [self.lictionImgButton setImage:IMAGE(@"FN_ic_pull") forState:UIControlStateNormal];
    [self.lictionImgButton addTarget:self action:@selector(orientationAction) forControlEvents:UIControlEventTouchUpInside];
    [lightView addSubview:self.lictionImgButton];
    
    UIView *lineView=[[UIView alloc]init];
    lineView.backgroundColor=RGB(221, 221, 221);
    [lightView addSubview:lineView];
    
    
    self.orientationButton.sd_layout
    .leftSpaceToView(lightView, 5).centerYEqualToView(lightView).widthIs(50).heightIs(25);
    
    self.lictionImgButton.sd_layout
    .leftSpaceToView(self.orientationButton, 5).centerYEqualToView(lightView).widthIs(10).heightIs(6);
    
    lineView.sd_layout
    .leftSpaceToView(self.lictionImgButton, 10).centerYEqualToView(lightView).widthIs(1).heightIs(17);
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    self.searchBar.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.searchBar.barStyle     = UIBarStyleDefault;
    self.searchBar.delegate     = self;
    self.searchBar.placeholder  = @"小区/写字楼/学校等";
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    //self.searchBar.backgroundColor=RGB(221, 221, 221);
     [self.searchBar setBackgroundColor:[UIColor clearColor]];
    
    self.searchBar.backgroundImage = [UIImage createImageWithColor:[UIColor clearColor]];
   
    self.searchBar.placeholder = @"请输入关键字";
    //self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor clearColor]];
    }
    //self.navigationItem.titleView = self.searchBar;
    [lightView addSubview:self.searchBar];
    
    [self.searchBar sizeToFit];
    self.searchBar.sd_layout
    .leftSpaceToView(lineView, 10).centerYEqualToView(lightView).heightIs(30).rightSpaceToView(lightView, 10);
    
}


#pragma mark - 地图
-(void)lictionDrawView{
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 50, FNDeviceWidth, (FNDeviceHeight-50)/2)];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    self.mapView.showsScale= NO;
    self.mapView.showsCompass= NO; //指南针
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    //self.mapView.userLocation.title = @"您的位置在这里";
    [self.mapView setZoomLevel:15.1 animated:YES];
    self.mapView.desiredAccuracy = kCLLocationAccuracyBest;
    
    
//    MAUserLocationRepresentation *represent = [[MAUserLocationRepresentation alloc] init];
//    represent.showsAccuracyRing = YES;
//    represent.showsHeadingIndicator = YES;
//    represent.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
//    represent.strokeColor = [UIColor lightGrayColor];;
//    represent.lineWidth = 2.f;
//    represent.image = [UIImage imageNamed:@"userPosition"];//
//    [self.mapView updateUserLocationRepresentation:represent];
    
    
    self.search = [[MAAllResultsSearch alloc] init];
    CGFloat tableHeight=(FNDeviceHeight-50)/2;
    UIButton *locationButton= [UIButton buttonWithType:UIButtonTypeCustom];
    locationButton.frame=CGRectMake(FNDeviceWidth-65, tableHeight-75, 45, 45);
    [locationButton addTarget:self action:@selector(orientationAction) forControlEvents:UIControlEventTouchUpInside];
    [locationButton setImage:IMAGE(@"fn_ orientationNe") forState:UIControlStateNormal];
    [locationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:locationButton];
    
    
    [self configLocationManager];
    [self initCompleteBlock];
    //[self manualOperation];
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
-(void)manualOperation{
    [self reGeocodeAction];
}
- (void)cleanUpAction
{
    //停止定位
    [self.locationManager stopUpdatingLocation];
    
    [self.locationManager setDelegate:nil];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
}

- (void)reGeocodeAction
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    //进行单次带逆地理定位请求
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
}
- (void)locAction
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    //进行单次定位请求
    [self.locationManager requestLocationWithReGeocode:NO completionBlock:self.completionBlock];
}
#pragma mark - Initialization

- (void)initCompleteBlock
{
    __weak FNRushLocationDeViewController *weakSelf = self;
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
            //[annotation setSubtitle:[NSString stringWithFormat:@"%@-%@-%.2fm", regeocode.citycode, regeocode.adcode, location.horizontalAccuracy]];
        }
        else
        {
            [annotation setTitle:[NSString stringWithFormat:@"lat:%f;lon:%f;", location.coordinate.latitude, location.coordinate.longitude]];
            //[annotation setSubtitle:[NSString stringWithFormat:@"accuracy:%.2fm", location.horizontalAccuracy]];
        }
        
         FNRushLocationDeViewController *strongSelf = weakSelf;
        
//        NSString *cityName=regeocode.city;
//        strongSelf.currentCity= cityName;
//        strongSelf.locationModel.address=[NSString stringWithFormat:@"%@",regeocode.formattedAddress];
//        strongSelf.locationModel.latitude=location.coordinate.latitude;
//        strongSelf.locationModel.longitude=location.coordinate.longitude;
//
//        if([cityName kr_isNotEmpty]){
//            [strongSelf.orientationButton setTitle:cityName forState:UIControlStateNormal];
//
//        }
//        [strongSelf searchPoiByKeyword:@""];
        
       
        [strongSelf addAnnotationToMapView:annotation];
    };
}
#pragma mark - 手动定位
-(void)orientationAction{
    [self manualOperation];
    
}
#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchBar setShowsCancelButton:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.searchBar setShowsCancelButton:NO];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    
    if(self.searchBar.text.length == 0) {
        return;
    }
    
    [self searchPoiByKeyword:self.searchBar.text];
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
//        annotationView.pinColor         = MAPinAnnotationColorPurple;
//        annotationView.image=[UIImage imageNamed:@"Fn_locationBlue"];
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
    
    
   
    __weak FNRushLocationDeViewController *weakSelf = self;
    // 初始化编码器
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        //获取当前城市位置信息，其中CLPlacemark包括name、thoroughfare、subThoroughfare、locality、subLocality等详细信息
        CLPlacemark *mark = [placemarks lastObject];
        NSString *cityName = mark.locality;//
     
        XYLog(@"城市 - :%@", cityName);
        XYLog(@"城市subLocality - :%@", mark.subLocality);
        XYLog(@"城市subThoroughfare - :%@", mark.subThoroughfare);
        XYLog(@"城市thoroughfare - :%@", mark.thoroughfare);
        self.subLocality=mark.subLocality;
        XYLog(@"城市name - :%@", mark.name);
        
        self.currentCity= cityName;
        self.locationModel.address=[NSString stringWithFormat:@"%@%@%@",mark.name,mark.subLocality,mark.thoroughfare];
        self.locationModel.latitude=userLocation.location.coordinate.latitude;
        self.locationModel.longitude=userLocation.location.coordinate.longitude;
        
        if([cityName kr_isNotEmpty]){
           [self.orientationButton setTitle:cityName forState:UIControlStateNormal];
            
        }
        //[self searchPoiByKeyword:@""];
        if(self.onceInt<1){
            [self searchPoiByKeyword:@""];
        }
        self.onceInt++;
        
        //[self manualOperation];
    }];
    
}
- (void)addAnnotationToMapView:(id<MAAnnotation>)annotation
{
    [self.mapView addAnnotation:annotation];
    
    [self.mapView selectAnnotation:annotation animated:YES];
    [self.mapView setZoomLevel:15.1 animated:NO];
    [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
}
#pragma mark - 单元检索周围地址view
-(void)rushLocationSearchingTableView{
    CGFloat tableHeight=(FNDeviceHeight-50)/2;//FNDeviceHeight/2;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, tableHeight, FNDeviceWidth, tableHeight) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight=70;
    if (@available(iOS 11.0, *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight= 0;
        self.tableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor=FNColor(240,240,240);
    self.tableView.backgroundColor=[UIColor whiteColor];
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
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FNHsearchModel *model=_retrievedArr[indexPath.row];
    self.locationModel=_retrievedArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(inSelectLocationAction:)]) {
        [self.delegate inSelectLocationAction:model];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)onPoiSearchDone:(AMapPOISearchResponse_AllResults *)allResult {
    //[self.mapView removeAnnotations:self.mapView.annotations];
    
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
    //self.retrievedArr=arrM;
    //[self.tableView reloadData];
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
        [self.tableView reloadData];
    }
    [self.tableView reloadData];
    
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

#pragma mark - Utility
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
@end


#pragma mark - 其他

@implementation AMapPOISearchResponse_OnePage
@end
@implementation AMapPOISearchResponse_AllResults
@end


@interface MAAllResultsSearch ()<AMapSearchDelegate>
@property (nonatomic, copy) MAKeyWordsPOISearchCallback resultCallback;
@property (nonatomic, strong) AMapPOIKeywordsSearchRequest *firstReq;
@property (nonatomic, strong) AMapPOISearchResponse_AllResults *allAroundPoiResults;

@end

@implementation MAAllResultsSearch

- (id)init {
    self = [super init];
    if(self) {
        self.searchAPI = [[AMapSearchAPI alloc] init];
        self.searchAPI.delegate = self;
    }
    
    return self;
}

- (void)searchAllPOIsWith:(AMapPOIKeywordsSearchRequest *)req resultCallback:(MAKeyWordsPOISearchCallback)resultCallback {
    self.firstReq = req;
    self.resultCallback = resultCallback;
    [self.searchAPI AMapPOIKeywordsSearch:req];
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    BOOL allFinished = YES;
    
    if(self.firstReq == request) {
        self.allAroundPoiResults = [[AMapPOISearchResponse_AllResults alloc] init];
        self.allAroundPoiResults.offset = request.offset;
        self.allAroundPoiResults.totalCount = response.count;
        self.allAroundPoiResults.allPages = [NSMutableArray array];
        
        AMapPOISearchResponse_OnePage *page = [[AMapPOISearchResponse_OnePage alloc] init];
        page.pageNum = 1;
        page.pois = response.pois;
        page.status = 0;
        page.offset = request.offset;
        [self.allAroundPoiResults.allPages addObject:page];
        
        NSInteger pageCount = response.count / request.offset;
        if(response.count % request.offset > 0) {
            pageCount += 1;
        }
        
        if(pageCount > 1) {
            allFinished = NO;
        }
        
        for(int i = 2; i <= pageCount; ++i) {
            AMapPOISearchResponse_OnePage *page = [[AMapPOISearchResponse_OnePage alloc] init];
            page.pageNum = i;
            page.status = -1;
            page.offset = request.offset;
            [self.allAroundPoiResults.allPages addObject:page];
            
            AMapPOIKeywordsSearchRequest *remainReq = [[AMapPOIKeywordsSearchRequest alloc] init];
            remainReq.keywords = self.firstReq.keywords;
            remainReq.location = self.firstReq.location;
            remainReq.city = self.firstReq.city;
            remainReq.cityLimit = self.firstReq.cityLimit;
            
            remainReq.types = self.firstReq.types;
            remainReq.sortrule = self.firstReq.sortrule;
            remainReq.building = self.firstReq.building;
            remainReq.page = i;
            remainReq.offset = self.firstReq.offset;
            remainReq.requireSubPOIs = self.firstReq.requireSubPOIs;
            remainReq.requireExtension = self.firstReq.requireExtension;
            
            [self.searchAPI AMapPOIKeywordsSearch:remainReq];
        }
        
    } else {
        NSInteger pageNum = request.page;
        AMapPOISearchResponse_OnePage *page = [self.allAroundPoiResults.allPages objectAtIndex:pageNum - 1];
        page.status = 0;
        page.pois = response.pois;
        
        for(AMapPOISearchResponse_OnePage *page in self.allAroundPoiResults.allPages) {
            if(page.status == -1) {
                allFinished = NO;
                break;
            }
        }
        
    }
    
    if(allFinished) {
        if(self.resultCallback) {
            self.resultCallback(self.allAroundPoiResults);
        }
    }
    
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    //NSLog(@"Error: %@ - %@", error, [ErrorInfoUtility errorDescriptionWithCode:error.code]);
    
    AMapPOISearchBaseRequest *req = (AMapPOISearchBaseRequest *)request;
    NSInteger pageNum = req.page;
    AMapPOISearchResponse_OnePage *page = [self.allAroundPoiResults.allPages objectAtIndex:pageNum - 1];
    page.status = 1;
}

@end
