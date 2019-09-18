//
//  FNStoreLocationRedpackController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/23.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreLocationRedpackController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "FNStoreLocationRedpackCateAlertView.h"
#import "FNStoreLocationRepackCateModel.h"
#import "FNStoreLocationRedpackModel.h"
#import "FNStoreLocationRedpackStoreController.h"
#import "FNStoreCouponeController.h"
#import "FNStoreLocationRedpackAlertView.h"
#import "FNStoreLocationRedpackDetailController.h"

@interface FNStoreLocationRedpackController()<MAMapViewDelegate, FNStoreLocationRedpackCateAlertViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, assign) CLLocationCoordinate2D userLocation;

@property (nonatomic, strong) UIButton *btnUser;
@property (nonatomic, strong) UIButton *btnRefresh;

@property (nonatomic, strong) UIButton *btnCate;
@property (nonatomic, strong) UIButton *btnStore;
@property (nonatomic, strong) UIButton *btnRedpack;

@property (nonatomic, strong) FNStoreLocationRedpackCateAlertView *alertView;
@property (nonatomic, strong) NSArray<FNStoreLocationRepackCateModel*> *cates;
@property (nonatomic, copy) NSString* cateId;

@property (nonatomic, strong) NSArray<FNStoreLocationRedpackModel*> *redpacks;
@property (nonatomic, strong) NSMutableArray<MAPointAnnotation*> *annotations;

@property (nonatomic, strong) FNStoreLocationRedpackAlertView *openAlert;

@end

@implementation FNStoreLocationRedpackController

- (FNStoreLocationRedpackCateAlertView*) alertView {
    if (_alertView == nil) {
        _alertView = [[FNStoreLocationRedpackCateAlertView alloc] init];
        _alertView.delegate = self;
        [self.view addSubview:_alertView];
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        
    }
    
    return _alertView;
}

- (FNStoreLocationRedpackAlertView*) openAlert {
    if (_openAlert == nil) {
        _openAlert = [[FNStoreLocationRedpackAlertView alloc] init];
//        _openAlert.delegate = self;
        [self.view addSubview:_openAlert];
        [_openAlert mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return _openAlert;
}

- (BOOL)isFullScreenShow {
    return YES;
}

- (BOOL)needLogin {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configLocationManager];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.title = @"位置红包";
    [AMapServices sharedServices].enableHTTPS = YES;
    
    _annotations = [[NSMutableArray alloc] init];
    
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_mapView];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeNone;
    _mapView.showsCompass = NO;
    _mapView.showsScale = NO;
    _mapView.zoomLevel = 16;
    _mapView.delegate = self;
    
    
    [self requestCate];
    [self configUI];
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
    _btnUser = [[UIButton alloc] init];
    _btnRefresh = [[UIButton alloc] init];
    _btnCate = [[UIButton alloc] init];
    _btnStore = [[UIButton alloc] init];
    _btnRedpack = [[UIButton alloc] init];
    
    [self.view addSubview:_btnUser];
    [self.view addSubview:_btnRefresh];
    [self.view addSubview:_btnCate];
    [self.view addSubview:_btnStore];
    [self.view addSubview:_btnRedpack];
    
    
    [_btnUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnRefresh);
        make.bottom.equalTo(self.btnRefresh.mas_top).equalTo(@-12);
        make.width.height.mas_equalTo(48);
    }];
    [_btnRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.bottom.equalTo(@-74);
        make.width.height.mas_equalTo(48);
    }];
    [_btnCate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btnStore);
        make.bottom.equalTo(self.btnStore.mas_top).offset(-12);
        make.width.height.mas_equalTo(48);
    }];
    [_btnStore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btnRedpack);
        make.bottom.equalTo(self.btnRedpack.mas_top).offset(-12);
        make.width.height.mas_equalTo(48);
    }];
    [_btnRedpack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-8);
        make.bottom.equalTo(@-74);
        make.width.height.mas_equalTo(48);
    }];
    
    [_btnUser setImage: IMAGE(@"store_location_button_location") forState: UIControlStateNormal];
    [_btnRefresh setImage: IMAGE(@"store_location_button_refresh") forState: UIControlStateNormal];
    [_btnCate setImage: IMAGE(@"store_location_button_cate") forState: UIControlStateNormal];
    [_btnStore setImage: IMAGE(@"store_location_button_store") forState: UIControlStateNormal];
    [_btnRedpack setImage: IMAGE(@"store_location_button_redpack") forState: UIControlStateNormal];
    
    [_btnUser addTarget:self action:@selector(locationBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_btnRefresh addTarget:self action:@selector(refreshBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_btnCate addTarget:self action:@selector(cateBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_btnStore addTarget:self action:@selector(storeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_btnRedpack addTarget:self action:@selector(redpackBtnAction) forControlEvents:UIControlEventTouchUpInside];
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
            
            [_mapView setCenterCoordinate:location.coordinate animated:YES];
            
            self.userLocation = location.coordinate;
            [self requestRedpack];
            
            
        }];
        
    }
}

#pragma mark - Networking

- (void)requestMain{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=position_redpacket&ctrl=index" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        

        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestCate {
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=position_redpacket&ctrl=store_cate" respondType:(ResponseTypeArray) modelType:@"FNStoreLocationRepackCateModel" success:^(id respondsObject) {
        @strongify(self)
        
        self.cates = respondsObject;
        if (self.cates.count > 0) {
            _cateId = self.cates[0].id;
        }
        [self requestLocation];
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO];
    
}

- (void)requestRedpack{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    

    NSString *latitude = [NSString stringWithFormat:@"%lf", self.userLocation.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%lf", self.userLocation.longitude];
    params[@"latitude"] = latitude;
    params[@"longitude"] = longitude;

    
    if ([_cateId kr_isNotEmpty]) {
        params[@"cid"] = _cateId;
    }
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=position_redpacket&ctrl=red_packet_list" respondType:(ResponseTypeArray) modelType:@"FNStoreLocationRedpackModel" success:^(id respondsObject) {
        @strongify(self)
        
        self.redpacks = respondsObject;
        [self refreshRedpacks];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestRedpackDetail: (NSString*)lid{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"lid": lid}];
    [SVProgressHUD show];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=position_redpacket&ctrl=open_redpacket_list" respondType:(ResponseTypeModel) modelType:@"FNStoreLocationRedpackDetailModel" success:^(id respondsObject) {
        @strongify(self)
        [SVProgressHUD dismiss];
        
        FNStoreLocationRedpackDetailModel *detail = respondsObject;
        if ([detail.is_receive isEqualToString:@"1"]) {
            
            FNStoreLocationRedpackDetailController *vc = [[FNStoreLocationRedpackDetailController alloc] init];
            vc.lid = lid;
            NSString *latitude = [NSString stringWithFormat:@"%lf", self.userLocation.latitude];
            NSString *longitude = [NSString stringWithFormat:@"%lf", self.userLocation.longitude];
            vc.latitude = latitude;
            vc.longitude = longitude;
            [self.navigationController pushViewController: vc animated: YES];
            return;
        }
        
        @weakify(self);
        [self.openAlert showModel: respondsObject block: ^() {
            @strongify(self)
            FNStoreLocationRedpackDetailModel *model = respondsObject;
            [self requestOpenRedpack: lid];
        }];
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestOpenRedpack: (NSString*)lid{
    FNStoreLocationRedpackDetailController *vc = [[FNStoreLocationRedpackDetailController alloc] init];
    vc.lid = lid;
    NSString *latitude = [NSString stringWithFormat:@"%lf", self.userLocation.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%lf", self.userLocation.longitude];
    vc.latitude = latitude;
    vc.longitude = longitude;
    
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"lid": lid}];
    [SVProgressHUD show];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=position_redpacket&ctrl=open_redpacket_doing" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        [SVProgressHUD dismiss];
        
        [FNTipsView showTips: @"领取成功"];
        
        [self.openAlert dismiss];

        [self.navigationController pushViewController: vc animated: YES];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
        
        [self.openAlert dismiss];

        [self.navigationController pushViewController: vc animated: YES];
        
    } isHideTips:NO isCache: NO];
    
}



#pragma mark - MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:reuseIndetifier];
        }
        
        NSInteger index = [_annotations indexOfObject: annotation];
        FNStoreLocationRedpackModel *model = _redpacks[index];

        [SDWebImageManager.sharedManager downloadImageWithURL:URL(model.ico) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            annotationView.image = image;
            annotationView.centerOffset = CGPointMake(0, -image.size.height / 2);
            
            @weakify(self);
            [annotationView addJXTouch:^{
                @strongify(self);
                [self requestRedpackDetail: model.id];
            }];
        }];
        return annotationView;
    }
    return nil;
}


/**
 用这个事件经常会点不中

 @param mapView
 @param view 
 */
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
//    NSInteger index = [_annotations indexOfObject: view.annotation];
//    if (index < _redpacks.count) {
//        FNStoreLocationRedpackModel *model = _redpacks[index];
//        [self requestRedpackDetail: model.id];
//    }
}


#pragma mark - Action

- (void)locationBtnAction {
    [_mapView setCenterCoordinate:_userLocation animated:YES];
}

- (void)refreshBtnAction {
    [self requestLocation];
}

- (void)redpackBtnAction {
    FNStoreCouponeController *vc = [[FNStoreCouponeController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)storeBtnAction {
    FNStoreLocationRedpackStoreController *vc = [[FNStoreLocationRedpackStoreController alloc] init];
    
    NSString *latitude = [NSString stringWithFormat:@"%lf", self.userLocation.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%lf", self.userLocation.longitude];
    vc.latitude = latitude;
    vc.longitude = longitude;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cateBtnAction {
    [self.alertView show: self.cates above: self.btnCate];
}


/**
 刷新地图上的红包显示
 */
- (void)refreshRedpacks {
    for (MAPointAnnotation *annotation in _annotations) {
        [self.mapView removeAnnotation: annotation];
    }
//    [self.mapView removeAnnotations:_annotations];
    [_annotations removeAllObjects];
    
    for (FNStoreLocationRedpackModel *model in _redpacks) {
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(model.store_lat.floatValue, model.store_lng.floatValue);
        [_annotations addObject: pointAnnotation];
        [_mapView addAnnotation:pointAnnotation];
    }
}

#pragma mark - FNStoreLocationRedpackCateAlertViewDelegate

- (void)alertView: (FNStoreLocationRedpackCateAlertView*)view didItemSelectedAt: (NSInteger) index {
    [view dismiss];
    _cateId = _cates[index].id;
    [self requestRedpack];
}

@end
