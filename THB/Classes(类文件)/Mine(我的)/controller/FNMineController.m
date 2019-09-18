//
//  FNMineController.m
//  THB
//
//  Created by Jimmy on 2018/1/16.
//  Copyright © 2018年 方诺科技. All rights reserved.
//  个人中心

#import "FNMineController.h"
#import "MsgCenterViewController.h"
#import "FXDrawViewController.h"
#import "FNWithdrawController.h"
#import "FNPhoneCheckController.h"
#import "JMASBindAlipayController.h"
#import "OrderBaseViewController.h"
#import "SettingViewController.h"
#import "ProfileViewController.h"
#import "FNMineSignUpController.h"

#import "FNCustomeNavigationBar.h"
#import "FNMineHeaderView.h"
#import "FNSectionHeaderView.h"
#import "FNMineAddtionalCell.h"
#import "FNMineOrderCell.h"
#import "FNMineWalletCell.h"

#import "FNMinePageModel.h"
#import "FNMineFunctionModel.h"

#import "COFListController.h"
#import "FNMineAccountCell.h"
#import "FNMineImageCell.h"
#import "FNMineIconsCell.h"
#import "FXOrderNavBarViewController.h"
#import "OrderViewController.h"
#import "FNMineHeaderModel.h"
#import "FNMineModel.h"
#import "FNMembershipUpgradeViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "FNNetCouponeExchangeController.h"
#import "FNNewUpgradeGoodsNController.h"

#define TExtttt _jmsize_10
@interface FNMineController ()<UITableViewDataSource,UITableViewDelegate, FNMineAccountCellDelegate, FNMineImageCellDelegate, FNMineHeaderViewDelegate>
@property (nonatomic, strong)UIImageView* imgHeader;
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton* settingBtn;
@property (nonatomic, strong)UIButton* msgBtn;
@property (nonatomic, strong)FNMineHeaderView* header;

@property (nonatomic, strong)FNMineHeaderModel* headerModel;
@property (nonatomic, strong)ProfileModel* model;
@property (nonatomic, strong)FNMinePageModel *pagemodel;

@property (nonatomic, assign)BOOL isShowLogin;

@property (nonatomic, strong) NSArray<UIImage*>* testImages;
@property (nonatomic, strong) NSArray<FNMineModel*> *mineModels;

@property (nonatomic, assign) BOOL isCache;

@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic, assign) CGFloat HeaderHeight;

@end

@implementation FNMineController

//#define HeaderHeight 200
//#define HeaderOffset 60

- (void)setModel:(ProfileModel *)model{
    _model = model;
}

- (void)setHeaderModel:(FNMineHeaderModel *)headerModel{
    _headerModel = headerModel;
    
    if (_headerModel) {
        [self.imgHeader sd_setImageWithURL:URL(_headerModel.bj_img) placeholderImage:IMAGE(@"APP底图")];
        [self.header.btnHeader sd_setBackgroundImageWithURL:URL(_headerModel.head_img) forState:UIControlStateNormal];
        self.header.lblTitle.text = _headerModel.nickname;
        self.header.lblLevel.text = _headerModel.vip_name;
        [self.header.imgLevel sd_setImageWithURL:URL(_headerModel.vip_logo)];
        self.header.lblCode.text = _headerModel.tgid;
        self.header.lblUpgrade.text = _headerModel.vip_btn_str;
        self.header.lblUpgrade.textColor = [UIColor colorWithHexString:_headerModel.vip_btn_fontcolor];
        self.header.btnUpgrade.backgroundColor = [UIColor colorWithHexString:_headerModel.vip_btn_color];
        
        self.header.vSum.hidden = ![_headerModel.sum_onoff isEqualToString:@"1"] || [FNCurrentVersion isEqualToString:Setting_checkVersion] || ![_headerModel.sum_str kr_isNotEmpty];
        self.header.frame = CGRectMake(0, 0, JMScreenWidth, self.header.vSum.hidden ? 200 : 270);
        
        [self.header.imgSumBg sd_setImageWithURL:URL(_headerModel.sum_bjimg)];
        [self.header.imgSumIcon sd_setImageWithURL:URL(_headerModel.sum_ico)];
        
        if (!self.header.vSum.hidden && [_headerModel.sum_str kr_isNotEmpty]) {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc]
                                                 initWithString:_headerModel.sum_str
                                                 attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:12],
                                                              NSForegroundColorAttributeName: [UIColor colorWithHexString:_headerModel.sum_str_color]}];
            
            NSRange range = [_headerModel.sum_str rangeOfString: _headerModel.all_sum];
            if (range.location != NSNotFound) {
                [string addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18], NSForegroundColorAttributeName: [UIColor colorWithHexString:_headerModel.sum_val_color]} range:range];
            }
            self.header.lblSum.attributedText = string;
        }
//        self.header.lblSum.textColor = [UIColor colorWithHexString:_headerModel.sum_str_color];
        [self.header.btnSum setTitle: _headerModel.sum_btn_str forState: UIControlStateNormal];
        [self.header.btnSum setTitleColor: [UIColor colorWithHexString:_headerModel.sum_btn_color] forState: UIControlStateNormal];
    
        
        UIColor *textColor = [UIColor colorWithHexString:_headerModel.color];
        [self.header setTextColor:textColor];
        
        [self.settingBtn setTitleColor:textColor forState:UIControlStateNormal];
        [self.msgBtn setTitleColor:textColor forState:UIControlStateNormal];
        if([_headerModel.is_vip_btn_show integerValue]==0){
            self.header.lblUpgrade.hidden=YES;
            self.header.btnUpgrade.hidden=YES;
        }else{
            self.header.lblUpgrade.hidden=NO;
            self.header.btnUpgrade.hidden=NO;
        }
        
        _header.vCoupone.hidden = YES;
        if ([self.headerModel.coupon_show isEqualToString:@"1"]) {
            _header.vCoupone.hidden = NO;
            _header.lblCoupone.text = self.headerModel.coupon_money;
            _header.lblCoupone.textColor = [UIColor colorWithHexString:self.headerModel.coupon_info_color];
            _header.lblCouponeDesc.text = self.headerModel.coupon_info;
            _header.lblCouponeDesc.textColor = [UIColor colorWithHexString:self.headerModel.coupon_info_color];
            
            
            @weakify(self)
            [_header.vCoupone addJXTouch:^{
                @strongify(self);
                FNNetCouponeExchangeController *vc = [FNNetCouponeExchangeController new];
                [self.navigationController pushViewController:vc animated: YES];
            }];
            
            [_header.imgCoupone sd_setImageWithURL: URL(self.headerModel.couponlimit_bjimg) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                @strongify(self)
                if (image) {
                    int height = (XYScreenWidth - 20) * image.size.height / image.size.width;
                    [self.header.imgCoupone mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(height);
                    }];
                    
                    self.header.frame = CGRectMake(0, 0, self.header.frame.size.width, self.header.frame.size.height + height);
                    self.jm_tableview.tableHeaderView = self.header;
                }
            }];
        }
        
        _header.vJifen.hidden = YES;
        if (self.headerModel.jf_data && [self.headerModel.jf_data.jfdh_onoff isEqualToString:@"1"]) {
            _header.vJifen.hidden = NO;
            FNNMineGradeModel *grade = self.headerModel.jf_data;
            [_header.imgJifen sd_setImageWithURL:URL(grade.mem_jf_bjimg)];
            [_header.imgIcon sd_setImageWithURL:URL(grade.mem_jf_ico)];
            _header.lblJifenTitle.text = grade.str;
            _header.lblJifenTitle.textColor = [UIColor colorWithHexString:grade.str_color];
            [_header.imgMore sd_setImageWithURL:URL(grade.mem_jf_ico1)];
            _header.lblMore.text = grade.str1;
            _header.lblMore.textColor = [UIColor colorWithHexString: grade.str_color1];
            _header.lblJifen.text = grade.integral;
            _header.lblJifen.textColor = [UIColor colorWithHexString: grade.val_color];
            _header.lblJifenUnit.text = grade.str2;
            _header.lblJifenUnit.textColor = [UIColor colorWithHexString:grade.str_color2];
            if (grade.list && grade.list.count > 0) {
                [_header.imgJifenExchange sd_setImageWithURL:URL(grade.list[0].img)];
                
                @weakify(self);
                [_header.vJifen addJXTouch:^{
                    @strongify(self);
                    [self loadOtherVCWithModel:grade.list[0] andInfo:nil outBlock:nil];
                }];
            }
            @weakify(self);
            [_header.btnMore addJXTouch:^{
                @strongify(self);
                [self goWebWithUrl:grade.url];
            }];
            
        }
        
        if (!_header.vJifen.hidden) {
            self.header.frame = CGRectMake(0, 0, self.header.frame.size.width, self.header.frame.size.height + 100);
            [_header.vJifen mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(100);
            }];
        } else {
            [_header.vJifen mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
        }
    }
}

- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
        
        UIView* rightView = [UIView new];
        self.settingBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.settingBtn setTitle:@"设置" forState:UIControlStateNormal];
        [self.settingBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        self.settingBtn.titleLabel.font = kFONT13;
        [self.settingBtn sizeToFit];
        [self.settingBtn addTarget:self action:@selector(settingBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.settingBtn.size = CGSizeMake(self.settingBtn.width+_jmsize_10, self.settingBtn.height+10);
        [rightView addSubview:self.settingBtn];
        
        self.msgBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.msgBtn setTitle:@"消息" forState:UIControlStateNormal];
        [self.msgBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        self.msgBtn.titleLabel.font = kFONT13;
        [self.msgBtn sizeToFit];
        [self.msgBtn addTarget:self action:@selector(messageBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.msgBtn.size = CGSizeMake(self.msgBtn.width+_jmsize_10, self.msgBtn.height+10);
        [rightView addSubview:self.msgBtn];
        
        rightView.frame = CGRectMake(0, 0, self.settingBtn.width+self.msgBtn.width+15, self.settingBtn.height);
        
        [self.msgBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.msgBtn autoSetDimensionsToSize:self.msgBtn.size];
        [self.msgBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        
        [self.settingBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.settingBtn autoSetDimensionsToSize:self.settingBtn.size];
        [self.settingBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        
        _navigationView.rightButton = rightView;
        
    }
    return _navigationView;
}

#pragma mark - system
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [SVProgressHUD show];
    [FNNotificationCenter addObserver:self selector:@selector(requestMain:) name:@"RefreshProfile" object:nil];
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(tongzhi) name:@"EditProfile" object:nil];
    self.isCache = YES;
}
- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)tongzhi {
    self.isCache = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:self.isPop.boolValue];
    self.isPop = @"0";
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    [self requestMain: self.isCache];
    self.isCache = YES;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!self.isShowLogin) {
        
        self.isShowLogin = YES;
        [self gologin];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
//    [SVProgressHUD dismiss];
}
#pragma mark - set up views
- (void)jm_setupViews{
    if (![NSString isEmpty:UserAccessToken]) {
        self.isShowLogin = YES;
    }
    self.view.backgroundColor = FNHomeBackgroundColor;
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    self.jm_tableview.emptyDataSetSource = nil;
    self.jm_tableview.emptyDataSetDelegate = nil;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.alpha = 1;
    self.jm_tableview.backgroundColor = [UIColor clearColor];
    self.jm_tableview.estimatedRowHeight = 200;
    self.jm_tableview.rowHeight = UITableViewAutomaticDimension;
    
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(0, 0, XYTabBarHeight, 0));
    }];
    
    [self.jm_tableview registerClass:[FNMineAccountCell class] forCellReuseIdentifier:@"FNMineAccountCell"];
    [self.jm_tableview registerClass:[FNMineIconsCell class] forCellReuseIdentifier:@"FNMineIconsCell"];
    [self.jm_tableview registerClass:[FNMineImageCell class] forCellReuseIdentifier:@"FNMineImageCell"];
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _HeaderHeight = 0;
    _header = [[FNMineHeaderView alloc]initWithFrame:CGRectMake(0, 0, JMScreenWidth, 200)];
    _header.delegate = self;
    self.jm_tableview.tableHeaderView = self.header;
    
    [self configHeader];
    if (![FNCurrentVersion isEqualToString:Setting_checkVersion]){
       [self configLocationManager];
    }
    [self requestMain: YES];
}

- (void)configHeader {
    _imgHeader = [[UIImageView alloc] init];
    [self.view insertSubview:_imgHeader atIndex:0];
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(_HeaderHeight);
    }];
    _imgHeader.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
//    [self.locationManager setDelegate:self];
    
//    self.locationManager.locationTimeout =2;
//    //   逆地理请求超时时间，最低2s，此处设置为2s
//    self.locationManager.reGeocodeTimeout = 2;
    
    
}

#pragma mark - request
- (void)requestMain: (BOOL)isCache{
    
    @weakify(self);
    [FNRequestTool startWithRequests:@[[self requestMine: isCache],[self requestPage: isCache],[self requestHeader: isCache],[self requestDatas: isCache]] withFinishedBlock:^(NSArray *erros) {
        @strongify(self);
        [SVProgressHUD dismiss];
        
        [self.jm_tableview reloadData];
    }];
}

- (FNRequestTool*) requestHeader: (BOOL)isCache {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appMemberList&ctrl=top_list" respondType:(ResponseTypeModel) modelType:@"FNMineHeaderModel" success:^(id respondsObject) {
        @strongify(self);
        self.headerModel = respondsObject;
        
        self.HeaderHeight = self.headerModel.user_top_img_bili.floatValue * XYScreenWidth;
        [self.imgHeader mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(_HeaderHeight);
        }];
//        self.header.frame = CGRectMake(0, 0, JMScreenWidth, _HeaderHeight);
        [self.jm_tableview reloadData];
        if (![FNCurrentVersion isEqualToString:Setting_checkVersion]){
            [self requestLocation];
        }
        
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:isCache];
}

- (void) requestLocation {
    if ([FNCurrentVersion isEqualToString:Setting_checkVersion] || [UserAccessToken isEqualToString:@""])
        return ;
    
    if ([self.headerModel.is_need_location isEqualToString:@"1"]) {
        if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {

            //定位不能用
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:self.headerModel.location_title message:self.headerModel.location_tip preferredStyle:UIAlertControllerStyleAlert];
            if ([self.headerModel.is_need_location isEqualToString:@"1"]) {
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
            }
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
                
                if (regeocode && location != nil)
                {
                    NSString *latitude = [NSString stringWithFormat:@"%lf", location.coordinate.latitude];
                    NSString *longitude = [NSString stringWithFormat:@"%lf", location.coordinate.longitude];
                    NSLog(@"reGeocode:%@", regeocode);
                    [self bindLocation: regeocode.province city: regeocode.city district: regeocode.district lat: latitude lng: longitude address: regeocode.formattedAddress];
                }
            }];
            
        }
    }
}

- (FNRequestTool *)bindLocation: (NSString*)province city: (NSString*)city district: (NSString*)district lat: (NSString*)lat lng: (NSString*)lng address: (NSString*)address {
    
    //    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                  TokenKey:UserAccessToken
                                                                                  }];
    if ([province kr_isNotEmpty]) {
        params[@"province"] = province;
    }
    if ([city kr_isNotEmpty]) {
        params[@"city"] = city;
    }
    if ([district kr_isNotEmpty]) {
        params[@"district"] = district;
    }
    if ([lat kr_isNotEmpty]) {
        params[@"lat"] = lat;
    }
    if ([lng kr_isNotEmpty]) {
        params[@"lng"] = lng;
    }
    if ([address kr_isNotEmpty]) {
        params[@"address"] = address;
    }
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=location&ctrl=bind" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache: NO];
    
}
/**会员中心样式接口***/ //收益数据--佣金收益规则-我的应用-我的工具
- (FNRequestTool *)requestDatas: (BOOL)isCache{
    
    //    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appMemberList&ctrl=getIndex" respondType:(ResponseTypeArray) modelType:@"FNMineModel" success:^(id respondsObject) {
        @strongify(self);
        self.mineModels = respondsObject;
       
        for (FNMineModel *model in self.mineModels) {
            if ([model.type isEqualToString:@"member_one_banner_01"] ||
                [model.type isEqualToString:@"member_two_banner_01"]) {
                NSMutableArray *imageUrls = [[NSMutableArray alloc] init];
                for (FNMineDataModel *data in model.list) {
                    [imageUrls addObject:data.img];
                }
                
                @weakify(self);
                [XYNetworkAPI downloadImages:imageUrls withFinishedBlock:^(NSArray<UIImage *> *images) {
                    @strongify(self);
                    model.images = images;
                    [self.jm_tableview reloadData];
                }];
            }
        }
        [self.jm_tableview reloadData];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:isCache ];
    
}

- (FNRequestTool*) requestBind: (NSString*)tgid {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"tgid": tgid}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appMemberList&ctrl=bind_tgid" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        [self requestMain: NO];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}

-(FNRequestTool *)requestMine: (BOOL)isCache{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:_api_mine_getUserInfo respondType:(ResponseTypeModel) modelType:@"ProfileModel" success:^(id respondsObject) {
        //
        [ProfileModel saveProfile:respondsObject];
        self.model = respondsObject;
        
        //将用户信息保存在本地
        [[NSUserDefaults standardUserDefaults] setValue:self.model.nickname forKey:XYUserNick];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.head_img forKey:XYhead_img];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.checkTime forKey:XYcheckTime];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.vip forKey:XYvip];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.phone forKey:XYUserPhone];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.sex forKey:XYsex];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.realname forKey:XYrealname];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.taobao_au forKey:XYtaobao_au];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.money forKey:XYmoney];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.loginname forKey:XYloginname];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.checkNum forKey:XYcheckNum];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.zfb_au forKey:XYzfb_au];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.growth forKey:XYgrowth];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.integral forKey:XYintegral];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.qq forKey:XYqq];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.email forKey:XYemail];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.qq_au forKey:XYqq_au];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.sina_au forKey:XYsina_au];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.returnmoney forKey:XYReturnMoney];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.commission forKey:XYFcommission];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.tid forKey:XYTid];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.three_nickname forKey:XYthree_nickname];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.like_count forKey:XYlike_count];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.address forKey:XYAddress];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.zztx forKey:XYzztx];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.gywm forKey:XYgywm];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.lhbtx forKey:XYlhbtx];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.hbtx forKey:XYhbtx];
        [[NSUserDefaults standardUserDefaults] setValue:self.model.extend_id forKey:XYextend_id];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } failure:^(NSString *error) {
        //
        ProfileModel* model = [ProfileModel new];
        [ProfileModel saveProfile:model];
    } isHideTips:YES isCache: isCache];
}
- (FNRequestTool *)requestPage: (BOOL)isCache{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_fls&ctrl=mem_index" respondType:(ResponseTypeModel) modelType:@"FNMinePageModel" success:^(id respondsObject) {
        //
        self.pagemodel = respondsObject;
        [[NSUserDefaults standardUserDefaults] setObject:self.pagemodel.wallet.is_tx forKey:@"JM_MPM_wallet_is_tx"];
        [[NSUserDefaults standardUserDefaults] setObject:self.pagemodel.wallet.img forKey:@"JM_MPM_wallet_img"];
        [[NSUserDefaults standardUserDefaults] setObject:self.pagemodel.wallet.title1 forKey:@"JM_MPM_wallet_title1"];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:isCache];
}

#pragma mark - action
- (void)settingBtnAction{
//    if (![NSString isEmpty:UserAccessToken]) {
        SettingViewController *vc = [[SettingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
//    }else{
//        [self gologin];
//    }
    
}
- (void)messageBtnAction{
    if (![NSString isEmpty:UserAccessToken]) {
        MsgCenterViewController *vc = [[MsgCenterViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self gologin];
    }
    
}
- (void)signUpBtnAction{
    if ([NSString isEmpty:UserAccessToken]) {
        //
        [self gologin];
        return;
    }
    FNMineSignUpController* signup = [FNMineSignUpController new];
    [self.navigationController pushViewController:signup animated:YES];
}
- (void)orderBtnAction{
    //订单
    if (![NSString isEmpty:UserAccessToken]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"OrderStoryboard" bundle:nil];
        OrderBaseViewController *vc = [sb instantiateViewControllerWithIdentifier:@"OrderBaseVC"];
        vc.status = @0;
        vc.hidesBottomBarWhenPushed = YES;
        vc.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self gologin];
    }
}

- (void)showBindAlert: (NSString*)title {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    @weakify(self);
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         @strongify(self);
                                                         if (alert.textFields.count > 0) {
                                                             NSString *code = alert.textFields.firstObject.text;
                                                             [self requestBind:code];
                                                         }
                                                     }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"填写邀请码";
    }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.mineModels)
        return self.mineModels.count;
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNMineModel *model = self.mineModels[indexPath.row];
    if ([model.type isEqualToString:@"member_income_01"]) {
        FNMineAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNMineAccountCell"];
        if (model.list.count > 0) {
            FNMineDataModel *data = model.list[0];
            cell.lblCommissionTitle.text = data.str;
            UIColor *textColor = [UIColor colorWithHexString:data.color];
            cell.lblCommissionTitle.textColor = textColor;
            
            cell.lblCommission.text = [FNCurrentVersion isEqualToString:Setting_checkVersion] ? @"个人中心" : data.tx_money;
            cell.lblCommission.textColor = [UIColor colorWithHexString:data.tx_moneycolor];
            
            cell.lblCommissionDesc.text = data.str1;
            cell.lblCommissionDesc.textColor = textColor;
            cell.lblCommissionDesc.hidden = [FNCurrentVersion isEqualToString:Setting_checkVersion];
            
            [cell.btnCommission setTitle:data.tx_str forState:UIControlStateNormal];
            [cell.btnCommission setTitleColor:[UIColor colorWithHexString:data.tx_color] forState:UIControlStateNormal];
            cell.vCommission.hidden = [FNCurrentVersion isEqualToString:Setting_checkVersion];
            cell.vCommission.backgroundColor = [UIColor colorWithHexString:data.tx_bjcolor];
            
            NSMutableArray<NSString*> *titles = [[NSMutableArray alloc] init];
            NSMutableArray<NSString*> *descs = [[NSMutableArray alloc] init];
            NSMutableArray<UIColor*> *colors = [[NSMutableArray alloc] init];
            for (FNMineIncomeModel *income in model.list[0].income_list) {
                [titles addObject:income.num];
                [descs addObject:income.str];
                [colors addObject:[UIColor colorWithHexString:income.color]];
            }
            if (titles.count == 0) {
                [titles addObject:data.yg_num];
                [descs addObject:data.yg_str];
                [colors addObject:[UIColor colorWithHexString:data.yg_color]];
                [titles addObject:data.agent_num];
                [descs addObject:data.agent_str];
                [colors addObject:[UIColor colorWithHexString:data.agent_color]];
            }
            [cell setCenterWithTitles:titles descs:descs colors:colors];
//            cell.lblShouyiTitle.text = data.yg_str;
//            cell.lblShouyiTitle.textColor = textColor;
//
//            cell.lblShouyi.text = [NSString stringWithFormat:@"¥%@", data.yg_num];
//            cell.lblShouyi.textColor = [UIColor colorWithHexString:data.yg_color];
//
//            cell.lblJintieTitle.text = data.agent_str;
//            cell.lblJintieTitle.textColor = textColor;
//
//            cell.lblJintie.text = [NSString stringWithFormat:@"¥%@", data.agent_num];
//            cell.lblJintie.textColor = [UIColor colorWithHexString:data.agent_color];
            
            cell.lblBottomLeftTitle.text = data.fan_str;
            cell.lblBottomLeftTitle.textColor = textColor;
            
            cell.lblBottomLeft.text = data.fan_num;
            cell.lblBottomLeft.textColor = [UIColor colorWithHexString:data.fan_color];
            
            cell.lblBottomRightTitle.text = data.extend_str;
            cell.lblBottomRightTitle.textColor = textColor;
            
            cell.vBottomRight.hidden = [FNCurrentVersion isEqualToString:Setting_checkVersion];
            if ([data.extend_num isEqualToString:@""] && data.is_can_bind.integerValue == 1) {
                cell.lblBottomRight.text = data.tip_content;
            } else {
                cell.lblBottomRight.text = data.extend_num;
            }
            cell.lblBottomRight.textColor = [UIColor colorWithHexString:data.extend_color];
            
            [cell.imgBackground sd_setImageWithURL:URL(data.bj_img)];
            [cell setPadding:model.jiange.floatValue];
            cell.delegate = self;
            if([data.yg_num kr_isNotEmpty]){
               [[NSUserDefaults standardUserDefaults] setValue:data.tx_money forKey:@"yg_num"];
               [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
        return cell;
    } else if ([model.type isEqualToString:@"member_mem_ico_01"]) {
        FNMineIconsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNMineIconsCell"];
        NSMutableArray *images = [[NSMutableArray alloc] init];
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        for (FNMineDataModel *data in model.list) {
            [images addObject:data.img];
            [titles addObject:data.name];
            [colors addObject:[UIColor colorWithHexString:data.font_color]];
        }
        [cell showTitle:model.name isShow:YES];
        [cell setPadding:model.jiange.floatValue];
        [cell setBackgroundImage:model.img];
        @weakify(self);
        [cell showWithImages:images andTitles:titles andColors:colors clickBlock:^(NSInteger index) {
            @strongify(self);
            if ([NSString isEmpty:UserAccessToken]) {
                [self gologin];
                return;
            }
            [self loadOtherVCWithModel:model.list[index] andInfo:nil outBlock:nil];
            
        }];
        
        return cell;
    } else if ([model.type isEqualToString:@"member_one_banner_01"]) {
        FNMineImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNMineImageCell"];
        [cell setPadding:model.jiange.floatValue];
        if (model.images) {
            [cell setImages:model.images column:1];
        }
        cell.delegate = self;
        return cell;
    } else if ([model.type isEqualToString:@"member_two_banner_01"]) {
        FNMineImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNMineImageCell"];
        [cell setPadding:model.jiange.floatValue];
        if (model.images) {
            [cell setImages:model.images column:2];
        }
        cell.delegate = self;
        return cell;
    }
    return [[UITableViewCell alloc] init];
}

#pragma mark - Table view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    
    if (conY<0) {
        [_imgHeader mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
            make.height.mas_equalTo(_HeaderHeight - conY);
        }];
    }else{
        [_imgHeader mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(-conY);
            make.height.mas_equalTo(_HeaderHeight);
        }];
    }
    
    NSArray *rgb = [UIColor getRGBWithHexString:_headerModel.color];
    int r = [((NSNumber*)rgb[0]) intValue];
    int g = [((NSNumber*)rgb[1]) intValue];
    int b = [((NSNumber*)rgb[2]) intValue];
    if (conY>0 && conY<=JMNavBarHeigth) {
        //滚动中
        float percent = conY/JMNavBarHeigth;
        self.navigationView.backgroundColor = [FNMainGobalControlsColor colorWithAlphaComponent:conY/JMNavBarHeigth];
        [self.msgBtn setTitleColor:RGB(r + (255 - r)*percent, g + (255 - g)*percent, b + (255 - b)*percent) forState:UIControlStateNormal];
        [self.settingBtn setTitleColor:RGB(r + (255 - r)*percent, g + (255 - g)*percent, b + (255 - b)*percent) forState:UIControlStateNormal];
    }else if (conY > JMNavBarHeigth){
        //
        self.navigationView.backgroundColor = FNMainGobalControlsColor;
        [self.msgBtn setTitleColor:FNWhiteColor forState:UIControlStateNormal];
        [self.settingBtn setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    }else{
        self.navigationView.backgroundColor = [UIColor clearColor];
        [self.msgBtn setTitleColor:[UIColor colorWithHexString:_headerModel.color] forState:UIControlStateNormal];
        [self.settingBtn setTitleColor:[UIColor colorWithHexString:_headerModel.color] forState:UIControlStateNormal];
    }
}

#pragma mark - FNMineAccountCellDelegate
- (void)didWithdrawClick: (FNMineAccountCell*)cell {
    if ([NSString isEmpty:UserAccessToken]) {
        [self gologin];
        return;
    }
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    FNMineModel *model = self.mineModels[indexPath.row];
    FNMineDataModel *data = model.list[0];
    if (data.is_tx.integerValue == 1) {

        if ([[ProfileModel profileInstance].zfb_au kr_isNotEmpty]) {
            FNWithdrawController* vc = [[FNWithdrawController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            JMASBindAlipayController* alipay = [JMASBindAlipayController new];
            [self.navigationController pushViewController:alipay animated:YES];
        }
    }
}

- (void)didInviterClick:(FNMineAccountCell *)cell {
   
    if ([NSString isEmpty:UserAccessToken]) {
        [self gologin];
        return;
    }
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    FNMineModel *model = self.mineModels[indexPath.row];
    if (model.list.count > 0) {
        FNMineDataModel *data = model.list[0];
        if ([data.is_can_bind isEqualToString:@"1"]) {
            [self showBindAlert:data.tip_str];
        }
    }
}

#pragma mark - FNMineImageCell
- (void) imageCell: (FNMineImageCell*)cell didClickAt: (NSInteger)index {
    if ([NSString isEmpty:UserAccessToken]) {
        [self gologin];
        return;
    }
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    FNMineModel *model = self.mineModels[indexPath.row];
    FNMineDataModel *data = model.list[index];
    [self loadOtherVCWithModel:data andInfo:nil outBlock:nil];
}

#pragma mark - FNMineHeaderViewDelegate

- (void)didCopyClick:(FNMineHeaderView*)headerView {
    if ([NSString isEmpty:UserAccessToken]) {
        [self gologin];
        return;
    }
    [FNTipsView showTips:@"复制成功"];
    [[UIPasteboard generalPasteboard] setString:self.model.tid];
}
- (void)didUpgradeClick: (FNMineHeaderView*)headerView {
    if ([NSString isEmpty:UserAccessToken]) {
        [self gologin];
        return;
    }
    if (self.headerModel.is_vip_max.boolValue)
        return;
    
    [self loadMembershipUpgradeViewController];

}
- (void)didHeaderClick: (FNMineHeaderView*)headerView {
    if ([NSString isEmpty:UserAccessToken]) {
        [self gologin];
        return;
    }
    ProfileViewController *vc = [[ProfileViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSumClick: (FNMineHeaderView*)headerView {
    if (![_headerModel.sum_onoff isEqualToString:@"1"]) {
        return;
    }
    
    [self loadOtherVCWithModel:self.headerModel andInfo:nil outBlock:nil];
}

@end
