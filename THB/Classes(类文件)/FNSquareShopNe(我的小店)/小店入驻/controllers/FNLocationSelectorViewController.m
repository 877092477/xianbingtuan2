//
//  FNLocationSelectorViewController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/21.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNLocationSelectorViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "FNLocationRetrievedNeCell.h"

@interface FNLocationSelectorViewController ()<AMapSearchDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton *lictionImgButton;
@property (nonatomic, strong) UIButton *orientationButton;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) CLLocationCoordinate2D userLocation;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, strong) NSArray<AMapPOI*> *pois;

@end

@implementation FNLocationSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configLocationManager];
    self.view.backgroundColor = UIColor.whiteColor;
    [self grabbleView];
    
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 50, FNDeviceWidth, (FNDeviceHeight-50)/2)];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_mapView];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeNone;
    _mapView.showsCompass = NO;
    _mapView.showsScale = NO;
    _mapView.zoomLevel = 16;
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    [self rushLocationSearchingTableView];
    [self requestLocation];
}

#pragma mark - 搜索
-(void)grabbleView{

    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 10, XYScreenWidth - 20, 30)];
    self.searchBar.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.searchBar.barStyle     = UIBarStyleDefault;
    self.searchBar.delegate     = self;
    self.searchBar.placeholder  = @"小区/写字楼/学校等";
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    [self.searchBar setBackgroundColor:[UIColor clearColor]];
    
    self.searchBar.backgroundImage = [UIImage createImageWithColor:[UIColor clearColor]];
    
    self.searchBar.placeholder = @"请输入关键字";
    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
    [searchField addTarget:self action:@selector(didKeywordChange:) forControlEvents:UIControlEventEditingChanged];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor clearColor]];
    }
    [self.view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(30);
    }];
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

#pragma - mark Networking

- (void) requestLocation {
    if ([FNCurrentVersion isEqualToString:Setting_checkVersion]) {
        return ;
    }
    if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        
        //定位不能用
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"需要您提供位置信息才能继续" preferredStyle:UIAlertControllerStyleAlert];
        
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
            
            NSString *latitude = [NSString stringWithFormat:@"%lf", location.coordinate.latitude];
            NSString *longitude = [NSString stringWithFormat:@"%lf", location.coordinate.longitude];
            [_mapView setCenterCoordinate:location.coordinate animated:YES];
            self.userLocation = location.coordinate;
            
            [self requestPOIs];
        }];
        
    }
}

- (void)requestPOIs {
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:_userLocation.latitude longitude:_userLocation.longitude];
    request.keywords            = _keyword;
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    [self.search AMapPOIAroundSearch:request];
}

#pragma mark - AMapSearchDelegate
/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    _pois = response.pois;
    [self.tableView reloadData];
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
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(self.mapView.mas_bottom);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _pois.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNLocationRetrievedNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"LocationRetrievedNeCellID"];
    if (cell == nil) {
        cell = [[FNLocationRetrievedNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LocationRetrievedNeCellID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FNHsearchModel *model=[[FNHsearchModel alloc]init];
    AMapPOI *poi = _pois[indexPath.row];
    model.state=indexPath.row;
    model.name=poi.name;
    model.address=poi.address;
    cell.model=model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AMapPOI *poi = _pois[indexPath.row];
    XYLog(@"搜索name:%@",poi.name);
    XYLog(@"搜索address:%@",poi.address);
    XYLog(@"搜索city:%@",poi.city);
    XYLog(@"搜索district:%@",poi.district);
    XYLog(@"搜索province:%@",poi.province);
    if ([_delegate respondsToSelector:@selector(locationController:didSelectPoi:)]) {
        [_delegate locationController:self didSelectPoi: poi];
    }
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
//    NSLog(searchField.text);
    return YES;
}

- (void)didKeywordChange: (UITextField*)textfield {
    NSLog(textfield.text);
    _keyword = textfield.text;
    [self requestPOIs];
}

@end
