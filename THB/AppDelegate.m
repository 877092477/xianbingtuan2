//
//  AppDelegate.m
//  FnuoApp
//
//  Created by zhongxueyu on 16/2/20.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "AppDelegate.h"
#import "XYTabBarViewController.h"
#import "XYTitleModel.h"
#import "CoreLaunchLite.h"
#import "XQNewFeatureVC.h"

#import <UMSocialCore/UMSocialCore.h>
#import "IQKeyboardManager.h"
#import "MenuModel.h"

#import "BQLAuthEngine.h"
#import "SuperViewController.h"
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#import "FNProductDetailController.h"
#import "FNErrorViewController.h"
#import "ALBBDetailsViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "FNAdvertismentManager.h"
#import <Reachability/Reachability.h>
//打印屏幕帧数
#if defined(DEBUG) || defined(_DEBUG)
#import "FHHFPSIndicator.h"
#endif

#import "UIImage+GIF.h"
#import "FNJZImageTool.h"
#import "UMCommon/UMCommon.h"
#import <UMCommonLog/UMCommonLogHeaders.h>
//#import "CrashException.h"
#import "ExceptionCrash.h"
#import "FNIntelligentSearchNeView.h"
#import "FNParseTbWordModel.h"
#import "FNNewProDetailController.h"
#import "FNGoodsListViewController.h"
#import "FNNewProductDetailModel.h"
#import "EBBannerView/EBBannerView.h"
#import "FNChatModel.h"
#import "FNConnectionsChatController.h"
#import "FNWindow.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
//#import <MAMapKit/MAMapKit.h>
//#import <AMapSearchKit/AMapSearchKit.h>
#import "WXApi.h"
#import "FNTabManager.h"
#import "FNBaseProductModel.h"
#import "FNControllerManager.h"
#import "FNPasteSearchAlertView.h"
#import "FNPasteSearchUpdateAlertView.h"
#import "FNIntegralMallDetailController.h"
#import "FNUpGoodsDetailsNController.h"
#import "QJCheckVersionUpdate.h"
#import "FNNewStoreDetailController.h"

@interface AppDelegate ()<UIWebViewDelegate, WXApiDelegate>

@property (nonatomic,strong)XYTabBarViewController *TabBarController;

//@property (nonatomic,strong)FNErrorViewController *ErrorController;

/** 存放快速入口Model的数组 */
@property (nonatomic,strong) NSMutableArray *menuModelArray;

/** 存放分类的数组 */
@property (retain, nonatomic) NSMutableArray *categoryDataArray;

@property (nonatomic,strong) UIWebView *webView;



@property (strong, nonatomic) NSString *pushValue;

@property (strong, nonatomic) NSString *pushKey;

@property (strong, nonatomic) NSArray *keyArray;

/**
 判断是否请求完基本设置
 */
@property (nonatomic, assign) BOOL gotSetting;

/**
 判断是否已读广告
 */
@property (nonatomic, assign) BOOL readAD;

@property (nonatomic, assign) BOOL isLaunched;

@property (nonatomic, assign) NetworkStatus networkStatus;

@end

@implementation AppDelegate

-(XYTabBarViewController *)TabBarController{
    if (_TabBarController==nil) {
        _TabBarController=[[XYTabBarViewController alloc]init];
    }
    return _TabBarController;
}

//-(FNErrorViewController *)ErrorController{
//    if (_ErrorController==nil) {
//        _ErrorController=[[FNErrorViewController alloc]init];
//    }
//    return _ErrorController;
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    [CrashException.shareInstance setup];
    [ExceptionCrash.shareInstance config];//bug收集管理
    // Override point for customization after application launch.
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
//    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
//        NSLog(@"百川初始化成功");
//    } failure:^(NSError *error) {
//        NSLog(@"百川初始化失败%@",error.localizedDescription);
//    }];
    
    NSString *cachesDir = [paths1 objectAtIndex:0];
    
    NSLog(@"cachesDir%@",cachesDir);
    
    if (![FNCurrentVersion isEqualToString:Setting_checkVersion]) {
        //添加缓存
        NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
        [NSURLCache setSharedURLCache:urlCache];
        //开启网络监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChange:) name:kReachabilityChangedNotification object:nil];
        Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
        reach = [Reachability reachabilityForInternetConnection];
        [reach startNotifier];
        
        /** 写入缓存 **/
        [self loadDateMethod];
        
    }
    
    [FNNotificationCenter addObserver:self selector:@selector(observingWebbackAction:) name:_jmntf_ad_readweb object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerViewDidClick:) name:EBBannerViewDidClickNotification object:nil];
    [self getBaseSettingMethod:NO];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        /** 初始化键盘 **/
        [self BA_KeyboardSetting];
        /** 第三方登录类初始化 **/
        [BQLAuthEngine initialAuthEngine];
        /** 初始化友盟，极光SDK **/
        [self initThirdToolMethod:launchOptions];
    });
    
    /** 引导页启动页初始化 **/
    [self initLaunchMethod];
    NSDictionary* remoteNotification;
    if (launchOptions) {
        
    remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    }
    if (remoteNotification&&!self.isLaunched) {
        NSLog(@"remoteUserInfo:%@",remoteNotification);
        //APP未启动，点击推送消息，iOS10下还是跟以前一样在此获取
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            

        UITabBarController *tbc = (UITabBarController *)_window.rootViewController;
        //XYTabBarViewController *tbc = (XYTabBarViewController *)_window.rootViewController;
            
        
        XYNavigationController *nav = tbc.viewControllers[tbc.selectedIndex];
        
        FNBridgeViewController *bridge = [FNBridgeViewController new];
        bridge.model = remoteNotification ;
        bridge.isPopUp = NO;
        [nav pushViewController:bridge animated:NO];
        });
        
    }
    
    

    
    return YES;
}

- (void)networkChange:(NSNotification *)notification {
    Reachability *currReach = [notification object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
    if(status == NotReachable){
        
        return;
    }
    if (status == ReachableViaWiFi || status == ReachableViaWWAN) {
//        [self.ErrorController.view removeFromSuperview];
        
        if ([[UIApplication sharedApplication].keyWindow isKindOfClass: [FNWindow class]]) {
            [((FNWindow*)[UIApplication sharedApplication].keyWindow) reconnect];
            return;
        }
        
    }
    
    
    _networkStatus = status;
}
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
- (void)observingWebbackAction:(NSNotification *)ntf{
    if (self.gotSetting == YES) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self initBaiChuanSDKMethod];
        });
        [FNAdvertismentManager hideWithOptions:(UIViewAnimationOptionCurveEaseInOut)];
        self.window.rootViewController = self.TabBarController;
        [self.window makeKeyAndVisible];
    }else{
        self.readAD = YES;
        [self getBaseSettingMethod:self.readAD];
    }
}

/**
 *启动页引导页初始化
 */

-(void)initLaunchMethod{
    
    // 沙盒版本
    NSString *version =[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"version.data"]];
    // app当前版本
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"currentVersion:%@",currentVersion);
    [self getLaunchImgMethod];
    if ([currentVersion isEqualToString:version]) {
        NSDictionary *data = [[NSUserDefaults standardUserDefaults] valueForKey:XYLaunchData];
        if (data) {
            @weakify(self);
            FNAdvertismentManager* manager = [FNAdvertismentManager shareManager];
            manager.finishedWindow = ^{
                @strongify(self);
                self.readAD = YES;
                [self getBaseSettingMethod:YES];
            };
        }else{
            [CoreLaunchLite shareManager];
            [self getBaseSettingMethod:YES];
        }
    }else{
        //遍历引导页
        NSMutableArray *numArr  = [NSMutableArray array] ;
        int i;
        for (i = 1; i<=[YD_Num intValue]; i++) {
            [numArr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        NSLog(@"numArr is %@",numArr);
        XQNewFeatureVC *newVc = [[XQNewFeatureVC alloc] initWithFeatureImagesNameArray:numArr];
        newVc.pageControlHidden = JM_isHidePC.boolValue;
        self.window.rootViewController = newVc;
        if (!JM_isHideSTBtn.boolValue) {
            newVc.completeBtnTitle = JM_isHideSTBtnTitle;
            newVc.completeBtn.borderColor = FNWhiteColor;
            newVc.completeBtn.borderWidth = 1.0f;
        }
    
        newVc.completeBlock = ^{

            //获取基本设置
            [self getBaseSettingMethod:YES];

        };
        
        [self.window makeKeyAndVisible];
        //打印屏幕帧数
//#if defined(DEBUG) || defined(_DEBUG)
//        [[FHHFPSIndicator sharedFPSIndicator] show];
//        //        [FHHFPSIndicator sharedFPSIndicator].fpsLabelPosition = FPSIndicatorPositionTopRight;
//#endif

        // 保存当前版本
        [NSKeyedArchiver archiveRootObject:currentVersion toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"version.data"]];
    }
}
/**
 *  初始化京东
 */
-(void)initJDKepler{
    if ([FNBaseSettingModel settingInstance].JDAppKey.length!=0 && [FNBaseSettingModel settingInstance].JDAppSecret.length!=0) {
        
        [[KeplerApiManager sharedKPService]
         asyncInitSdk:[FNBaseSettingModel settingInstance].JDAppKey
         secretKey:[FNBaseSettingModel settingInstance].JDAppSecret sucessCallback:^(){
             NSLog(@"京东初始化成功");
         }failedCallback:^(NSError *error){
             NSLog(@"init JD error: %@", error.localizedDescription);
         }];
    }
}
/**
 *  初始化友盟，极光推送SDK
 */
-(void)initThirdToolMethod:(NSDictionary *)launchOptions{
    [self initializedUmeng];
    
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:JPushKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
}

#pragma mark - initialized umeng
- (void)initializedUmeng{
#ifdef DEBUG
    [UMConfigure setLogEnabled:YES];
    [UMCommonLogManager setUpUMCommonLogManager];
#else
    [UMConfigure setLogEnabled:NO];
#endif
    [UMConfigure initWithAppkey:UmengAppkey channel:nil];
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UmengAppkey];
    
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
    
}
- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WeChatAppID appSecret:JMWeChatAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppId/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /*
     设置新浪的appKey和appSecret
     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
     */
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaAppKey  appSecret:SinaAppSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    
}

-(void) initBaiChuanSDKMethod{
    @weakify(self)
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
        @strongify(self);
        [self initAlibc];
        NSLog(@"百川初始化成功");
    } failure:^(NSError *error) {
        NSLog(@"百川初始化失败%@",error.localizedDescription);
    }];
}

-(void) initAlibc{
    NSString *tmp = [FNBaseSettingModel settingInstance].appopentaobao_onoff?:@"0";
    NSString *IsForceH5 = [NSString stringWithFormat:@"%@",tmp];
    NSString* pid= nil;
    //    if ([ProfileModel profileInstance].is_sqdl.boolValue) {
    //        pid = [ProfileModel profileInstance].tg_pid;
    //    }else{
    pid = [FNBaseSettingModel settingInstance].TaoKePid;
    //    }
    // 外部使用只能用Release环境
    [[AlibcTradeSDK sharedInstance] setEnv:AlibcEnvironmentRelease];
    
    // 百川平台基础SDK初始化，加载并初始化各个业务能力插件
    //    NSString *appKey = @"23082328";
    
    
    
    // 开发阶段打开日志开关，方便排查错误信息
    [[AlibcTradeSDK sharedInstance] setDebugLogOpen:NO];
#warning 测试跟单
    // 配置全局的淘客参数
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
    taokeParams.pid = [FNBaseSettingModel settingInstance].TaoKePid;
    taokeParams.adzoneId =  [FNBaseSettingModel settingInstance].APP_adzoneId;
    
    taokeParams.extParams = @{@"taokeAppkey": [FNBaseSettingModel settingInstance].APP_alliance_appkey?:@""};
    
    taokeParams.unionId = nil;
    taokeParams.subPid = nil;
    [[AlibcTradeSDK sharedInstance] setTaokeParams:taokeParams];
    
    XYLog(@"bool is %d",!IsForceH5.boolValue);
    
    // 设置全局配置，是否强制使用h5
    [[AlibcTradeSDK sharedInstance] setIsForceH5:!IsForceH5.boolValue];
}

- (void)goToLaunchPage{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self initBaiChuanSDKMethod];
    });
    //[self downloadkittyGif];
    if (self.readAD) {
        [FNAdvertismentManager hideWithOptions:(UIViewAnimationOptionTransitionFlipFromLeft)];
    } else {
        [[CoreLaunchLite shareManager] hideImage];
    }
    
    self.window = [[FNWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    /** 加载首页 */
    self.window.rootViewController = self.TabBarController;
    self.isLaunched = YES;
    [self.window makeKeyAndVisible];
    
    NSString* content = [UIPasteboard generalPasteboard].string;
    if (content && ![content isEqualToString:@""] && ![[FNBaseSettingModel settingInstance].indexsearch_onoff isEqualToString:@"1"]) {
        [self requestPaste:content];
        
    }
    
    QJCheckVersionUpdate *update = [[QJCheckVersionUpdate alloc] init];
    [update showAlertView];

    
    //打印屏幕帧数
//#if defined(DEBUG) || defined(_DEBUG)
//    [[FHHFPSIndicator sharedFPSIndicator] show];
//    //        [FHHFPSIndicator sharedFPSIndicator].fpsLabelPosition = FPSIndicatorPositionTopRight;
//#endif
    

}

#pragma mark -  initialized base setting

-(void)getBaseSettingMethod:(BOOL)flag1{
    if (self.gotSetting == YES){
        if (flag1) {
            [self goToLaunchPage];
        }
        return;
    }
    
//    if (self.readAD) {
//        [FNAdvertismentManager hideWithOptions:(UIViewAnimationOptionTransitionFlipFromLeft)];
//    }
    [FNRequestTool startWithRequests:@[[self reqeustBaseSetting],[self requestTab]] withFinishedBlock:^(NSArray *erros) {
        BOOL __block flag = NO;
        if (erros.count>=1) {
            [erros enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.length>=1) {
                    flag = YES;
                }
            }];
        }
        
        if (flag) {
            if ([self.topViewController isKindOfClass: [XQNewFeatureVC class]]) {
                return;
            }
            if (self.readAD) {
                [FNAdvertismentManager hideWithOptions:(UIViewAnimationOptionTransitionFlipFromLeft)];
            }
            FNBaseSettingModel* model=[FNBaseSettingModel new];
            [FNBaseSettingModel saveSetting:model];
//            self.window.rootViewController = self.ErrorController;
            self.window = [[FNWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
            [(FNWindow*)self.window showNetworkError];
            [self.window makeKeyAndVisible];
        }else{
            if (flag1 ) {//判断是否读完广告
                [self goToLaunchPage];
            }else{
                self.gotSetting = YES;
            }
            [SVProgressHUD dismiss];
        }
    }];
}
- (FNRequestTool *) requestTab{//tab请求图片和标题
    return [FNRequestTool requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}] api:@"mod=appapi&act=dg_new_jk&ctrl=foot" respondType:(ResponseTypeNone) modelType:@"" success:^(NSDictionary* respondsObject) {
        //
        NSArray* tabs = respondsObject[DataKey];
        //NSLog(@"tabs===:%@",tabs);
        FNBaseSettingModel* defaultModel = [FNBaseSettingModel settingInstance];
        if (tabs.count>=1) {
            NSMutableArray* mtabs = [NSMutableArray new];
            [tabs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //NSLog(@"tabsname:%@",obj[@"show_name"]);
                [mtabs addObject:[FNTabModel mj_objectWithKeyValues:obj]];
            }];
            
            [FNTabManager shareInstance].tabs = mtabs;
            
        }
        defaultModel.tw = respondsObject[@"ggt"][@"tw"];
        defaultModel.ksrk = respondsObject[@"ggt"][@"ksrk"];
        [FNBaseSettingModel saveSetting:defaultModel];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
- (FNRequestTool *)reqeustBaseSetting{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:_api_others_getset respondType:(ResponseTypeModel) modelType:@"FNBaseSettingModel" success:^(id respondsObject) {
        NSLog(@"设置:%@",respondsObject);
        //
        FNBaseSettingModel* defaultModel = [FNBaseSettingModel settingInstance];
        FNBaseSettingModel* model = respondsObject;
//        model.tabs = defaultModel.tabs;
        model.ksrk = defaultModel.ksrk;
        model.tw = defaultModel.tw;
        [FNBaseSettingModel saveSetting:model];
        
        [[NSUserDefaults standardUserDefaults] setValue:model.extendreg forKey:XYextendreg];
        
        [[NSUserDefaults standardUserDefaults] setValue:model.appopentaobao_onoff forKey:XYappopentaobao_onoff];
        
        [[NSUserDefaults standardUserDefaults] setValue:model.WeChatAppSecret forKey:XYWeChatAppSecret];
        
        if (model.buy_jingdong_onoff.integerValue==1) {
            [self initJDKepler];//初始化京东
        }
        if ([model.iOS_Amap_key kr_isNotEmpty]){
            [AMapServices sharedServices].apiKey =model.iOS_Amap_key;
        }
    } failure:^(NSString *error) {
        
    } isHideTips:YES ];
}

- (void)requestPaste: (NSString*) content {
    
    if ([NSString isNumber:content]) {
        //纯数字不弹框
        return;
    }
    
    if ([content containsString:@"mobile.yangkeduo.com"]) {
        [self goodsPaste:content withtype:@"pdd"];
    } else if ([content containsString:@"u.jd.com"] || [content containsString:@"jd.com"]) {
        [self goodsPaste:content withtype:@"jd"];
    } else {
        [self goodsPaste:content withtype:@"search"];
    }
}

- (void)goodsPaste: (NSString*)content withtype: (NSString*)type {
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken}];
    NSString *url = @"mod=appapi&act=tbkNewApi&ctrl=parseTbWord";
    FNIntelligentSearchType pasteType = TaoBao;
    if ([type isEqualToString:@"jd"]) {
        pasteType = JD;
        params[@"url"] = content;
        url = @"mod=appapi&act=urlgetgid&ctrl=jd";
    } else if ([type isEqualToString:@"pdd"]) {
        pasteType = PDD;
        params[@"url"] = content;
        url = @"mod=appapi&act=urlgetgid&ctrl=pdd";
    } else {
        params[@"content"] = content;
    }
    @weakify(self)
    @weakify(pasteType)
    [FNRequestTool requestWithParams:params api:url respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        @strongify(pasteType)
        NSString *gid;
        if (pasteType == JD || pasteType == PDD) {
            gid = [respondsObject objectForKey:@"gid"];
        } else {
            gid = [respondsObject objectForKey:@"fnuo_id"];
        }
        UIViewController *vc = [UIViewController currentViewController];
        if (vc == nil) {
            return;
        }
        
        NSString *SkipUIIdentifier = [respondsObject objectForKey:@"SkipUIIdentifier"];
        if ([SkipUIIdentifier isEqualToString:@"pub_wph_goods"]) {
            pasteType = WPH;
        }
        
        StoreTypeBlock block = ^(FNIntelligentSearchType clickType, NSString *keyword,FNNewProductDetailModel* model) {
            [UIPasteboard generalPasteboard].string = @"";
            
            if ([SkipUIIdentifier isEqualToString:@"buy_integral"]) {
                FNIntegralMallDetailController *detail = [FNIntegralMallDetailController new];
                detail.goodsId =gid;
                [vc.navigationController pushViewController:detail animated:YES];
                return;
            } else if ([SkipUIIdentifier isEqualToString:@"buy_update_goods"] ) {
                FNUpGoodsDetailsNController *detail = [[FNUpGoodsDetailsNController alloc] init];
                detail.DetailsID =gid;
                [vc.navigationController pushViewController:detail animated:YES];
                return;
            } else if ([SkipUIIdentifier isEqualToString:@"buy_rebate_store"] ) {
                FNNewStoreDetailController *store = [[FNNewStoreDetailController alloc] init];
                NSDictionary *data = respondsObject[@"data"];
                store.storeID = data[@"store_id"];
                store.storeName = respondsObject[@"store_name"];
                store.isNeedJumpGoods = YES;
                store.goods_id = data[@"id"];
                // 先跳转小店店铺，再跳转商品，否则购物车不显示
                [vc.navigationController pushViewController:store animated:YES];
                return;
            }
            
            NSString *skipUIIdentifier = @"";
            if (clickType == Detail) {
                if (model) {
                    
                    UIViewController* detail = [FNControllerManager goProductVCWithModel: model];
                    [vc.navigationController pushViewController:detail animated:YES];
                    return;
                }
            }
            
            if (clickType == JD) {
                skipUIIdentifier=@"buy_jingdong";
            } else if (clickType == PDD) {
                skipUIIdentifier=@"buy_pinduoduo";
            } else if (clickType == TaoBao) {
                skipUIIdentifier=@"buy_taobao";
            } else if (clickType == WPH) {
                skipUIIdentifier=@"pub_wph_goods";
            }
            FNGoodsListViewController *VC=[FNGoodsListViewController new];
            VC.SkipUIIdentifier=skipUIIdentifier;
            VC.keyword=keyword;
            [vc.navigationController pushViewController:VC animated:YES];
            
        };
        NSString *keyword = content;
        if (![gid kr_isNotEmpty]) {
            NSString *key = [respondsObject objectForKey:@"keyword"];
            if ([key kr_isNotEmpty]) {
                keyword = key;
            }
        }
        
        if ([SkipUIIdentifier isEqualToString:@"buy_jingdong"]) {
            pasteType = JD;
        } else if ([SkipUIIdentifier isEqualToString:@"buy_pinduoduo"]) {
            pasteType = PDD;
        }
        NSString *yhq_url = respondsObject[@"yhq_url"];
        //积分商城商品/升级商品
        if ([SkipUIIdentifier isEqualToString:@"buy_integral"] || [SkipUIIdentifier isEqualToString:@"buy_update_goods"] || [SkipUIIdentifier isEqualToString:@"buy_rebate_store"] ) {
            [FNPasteSearchUpdateAlertView showWithData:[respondsObject objectForKey:@"data"] view:FNKeyWindow SkipUIIdentifier: SkipUIIdentifier withTypeblock:block];
        }
        else if ([[FNBaseSettingModel settingInstance].apptip_style_onoff isEqualToString:@"1"]) {
            [FNPasteSearchAlertView showWithContent:keyword view:FNKeyWindow withfnID:gid type: pasteType yhq_url: yhq_url storeTypeblock:block];
        } else {
            [FNIntelligentSearchNeView showWithContent:keyword view:FNKeyWindow withfnID:gid type: pasteType yhq_url: yhq_url storeTypeblock:block];
        }
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}



-(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    NSLog(@"执行图片下载函数");
    
    UIImage * result;
    
    
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    
    
    return result;
    
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

#pragma - mark 写缓存为了去掉网页的头部
-(void)loadDateMethod
{
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    
    NSString *url =[NSString stringWithFormat:@"%@%@%@",IP,_api_showorder_WirteCache,UserAccessToken];
    NSURL *webUrl = [NSURL URLWithString:url];
    NSURLRequest *request =[NSURLRequest requestWithURL:webUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    __unsafe_unretained UIWebView *webView = self.webView;
    webView.delegate = self;
    [webView loadRequest:request];
    self.webView.hidden = YES;
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
    
}
#endif

//- (void)application:(UIApplication *)application
//didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    [JPUSHService handleRemoteNotification:userInfo];
//    NSLog(@"收到通知:%@", [self logDic:userInfo]);
//
//}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
    completionHandler(UIBackgroundFetchResultNewData);
    
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
        NSLog(@"acitve or background");
        //        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即查看", nil];
        //        [alertView show];
        //
        //        NSNotification *notification =[NSNotification notificationWithName:@"GetNoti" object:nil userInfo:nil];
        //        //通过通知中心发送通知
        //        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }
    else//杀死状态下，直接跳转到跳转页面。
    {
        
        if(self.isLaunched){
            
            UITabBarController *tbc = (UITabBarController *)_window.rootViewController;

            XYNavigationController *nav = tbc.viewControllers[tbc.selectedIndex];

            FNBridgeViewController *bridge = [FNBridgeViewController new];
            bridge.model = userInfo ;
            bridge.isPopUp = NO;
            [nav pushViewController:bridge animated:NO];
//                        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%ld",application.applicationState] message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即查看", nil];
//                [alertView show];

        }

        
//
        
        
        
        
        
        
    }
//            UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%ld",application.applicationState] message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即查看", nil];
//    [alertView show];

//    NSLog(@"status is%(long)d",application.applicationState);

    
}



- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

#pragma mark - ***** 键盘处理
- (void)BA_KeyboardSetting
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}

-(void)getLaunchImgMethod{
    //    获取启动页广告图
    [FNRequestTool requestWithParams:nil api:@"act=api&ctrl=getstartpic" respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        //
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:XYLaunchImg];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"adurl"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:XYLaunchData];
        
        if (respondsObject.count>=1) {
            NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithDictionary:respondsObject[0]];
            [self filterDict:data];
            NSString* img = [data valueForKey:@"img"];
            if(img.length >=1){
                [[NSUserDefaults standardUserDefaults] setValue:img forKey:XYLaunchImg];
                [[NSUserDefaults standardUserDefaults] setValue:[data valueForKey:@"url"] forKey:@"adurl"];
                [[NSUserDefaults standardUserDefaults] setValue:data forKey:XYLaunchData];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES];
}

- (void)filterDict: (NSMutableDictionary*) data {
    for (NSString *keyStr in data.allKeys) {
        NSLog(@"!!!  %@   %@", keyStr, data[keyStr]);
        if ([[data objectForKey:keyStr] isEqual:[NSNull null]]) {
//            [data setValue:nil forKey:keyStr];
            data[keyStr] = nil;
        } else if ([[data objectForKey:keyStr] isKindOfClass:[NSArray class]] ) {
            for (NSMutableDictionary *dic in (NSArray*)[data objectForKey:keyStr]) {
                [self filterDict:dic];
            }
        } else if ([[data objectForKey:keyStr] isKindOfClass:[NSDictionary class]]) {
            [self filterDict:(NSMutableDictionary*)[data objectForKey:keyStr]];
        }
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    
    //处理其他app跳转到自己的app，如果百川处理过会返回YES
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url];
    result = [WXApi handleOpenURL:url delegate:self];
    if (!result) {
        if ([url.host isEqualToString:@"safepay"]) {
            // 支付跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
            }];
            
            // 授权跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                // 解析 auth code
                NSString *result = resultDic[@"result"];
                NSString *authCode = nil;
                if (result.length>0) {
                    NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                    for (NSString *subResult in resultArr) {
                        if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                            authCode = [subResult substringFromIndex:10];
                            break;
                        }
                    }
                }
                NSLog(@"授权结果 authCode = %@", authCode?:@"");
            }];
        }
//        else if ([url.scheme isEqualToString:[NSString stringWithFormat:@"%@",WXAppKey]]) {
//            return  [WXApi handleOpenURL:url delegate:[[BQLAuthEngine alloc] init]];
//        }else if ([url.scheme isEqualToString:[NSString stringWithFormat:@"tencent%@",QQAppID]]) {
//            return  [TencentOAuth HandleOpenURL:url];
//        }
        else if ([[AlibcTradeSDK sharedInstance] application:application openURL:url options:options]) {
            if([[ALBBSession sharedInstance] isLogin]){
                SuperViewController *VC=[SuperViewController new];
                VC.updateOrderStatus = YES;
                [VC initWebViewMethod];
            }
            return YES;
        }
//        return [[KeplerApiManager sharedKPService] handleOpenURL:url];
    }
    return YES;
    
    
}




/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    // 如果百川处理过会返回YES
    //    if ([[ALiTradeSDK sharedInstance] handleOpenURL:url]) {
    //        // 处理其他app跳转到自己的app
    //        return YES;
    //    }
    BOOL result =[[UMSocialManager defaultManager] handleOpenURL:url];
    result = [WXApi handleOpenURL:url delegate:self];
    if (!result) {
//        if ([url.scheme isEqualToString:[NSString stringWithFormat:@"%@",WXAppKey]]) {
//            return  [WXApi handleOpenURL:url delegate:[[BQLAuthEngine alloc] init]];
//        }else if ([url.scheme isEqualToString:[NSString stringWithFormat:@"tencent%@",QQAppID]]) {
//            return  [TencentOAuth HandleOpenURL:url];
//        }else
        if ([[AlibcTradeSDK sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation]) {
            if([[ALBBSession sharedInstance] isLogin]){
                SuperViewController *VC=[SuperViewController new];
                VC.updateOrderStatus = YES;
                [VC initWebViewMethod];
            }
            return YES;
        }else if ([url.host isEqualToString:@"safepay"]) {
            // 支付跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
            }];
            
            // 授权跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                // 解析 auth code
                NSString *result = resultDic[@"result"];
                NSString *authCode = nil;
                if (result.length>0) {
                    NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                    for (NSString *subResult in resultArr) {
                        if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                            authCode = [subResult substringFromIndex:10];
                            break;
                        }
                    }
                }
                NSLog(@"授权结果 authCode = %@", authCode?:@"");
            }];
        }
//        return [[KeplerApiManager sharedKPService] handleOpenURL:url];
    }
    return YES;
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    //处理其他app跳转到自己的app，如果百川处理过会返回YES
    //    if ([[ALiTradeSDK sharedInstance] handleOpenURL:url]) {
    //        return YES;
    //    }
    //    BOOL result = [UMSocialSnsService handleOpenURL:url];
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
//        if ([url.scheme isEqualToString:[NSString stringWithFormat:@"%@",WXAppKey]]) {
//            return  [WXApi handleOpenURL:url delegate:[[BQLAuthEngine alloc] init]];
//        }else if ([url.scheme isEqualToString:[NSString stringWithFormat:@"tencent%@",QQAppID]]) {
//            return  [TencentOAuth HandleOpenURL:url];
//            //return [QQApiInterface handleOpenURL:url delegate:[[BQLAuthEngine alloc] init]];
//        }else
        if ([[AlibcTradeSDK sharedInstance] handleOpenURL:url]) {
            if([[ALBBSession sharedInstance] isLogin]){
                SuperViewController *VC=[SuperViewController new];
                VC.updateOrderStatus = YES;
                [VC initWebViewMethod];
            }
            return YES;
        }else if ([url.host isEqualToString:@"safepay"]) {
            // 支付跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
            }];
            
            // 授权跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                // 解析 auth code
                NSString *result = resultDic[@"result"];
                NSString *authCode = nil;
                if (result.length>0) {
                    NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                    for (NSString *subResult in resultArr) {
                        if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                            authCode = [subResult substringFromIndex:10];
                            break;
                        }
                    }
                }
                NSLog(@"授权结果 authCode = %@", authCode?:@"");
            }];
        }
//        return [[KeplerApiManager sharedKPService] handleOpenURL:url];
    }
    return YES;
}



/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    XYLog(@"程序已经进入前台！");
    [application setApplicationIconBadgeNumber:0];
//    [self initializePastedBoard];

    
    
//    FNPastedModel* model = [FNPastedModel pastedModel];
//    if (model.changecount.integerValue != [UIPasteboard generalPasteboard].changeCount) {
//        model.changecount  =  [UIPasteboard generalPasteboard].changeCount? [NSString stringWithFormat:@"%ld",[UIPasteboard generalPasteboard].changeCount]:@"0";
//        model.c_is_closed = NO;
//    }
//    [FNPastedModel savePastedModel:model];
//    [FNNotificationCenter postNotificationName:@"pastedChange" object:nil];
    NSString* content = [UIPasteboard generalPasteboard].string;
    if (content && ![content isEqualToString:@""] && ![[FNBaseSettingModel settingInstance].indexsearch_onoff isEqualToString:@"1"]) {
        [self requestPaste:content];
//        [UIPasteboard generalPasteboard].string = @"";
    }
    return;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    XYLog(@"程序即将进入后台！");
    //    [self loadQuickStartDataMethod];
    
    
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    [self getLaunchImgMethod];
    //    [self loadQuickStartDataMethod];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    [self getLaunchImgMethod];
    self.isLaunched = NO;

    //    [self loadQuickStartDataMethod];
    
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    BOOL haveJDKeplerServiceNewContent = NO;
    [self fetchJDKeplerService:&haveJDKeplerServiceNewContent];
    if (haveJDKeplerServiceNewContent){
        completionHandler(UIBackgroundFetchResultNewData);
    } else {
        completionHandler(UIBackgroundFetchResultNoData);
    }
}
- (void)fetchJDKeplerService:(BOOL *)paramFetchedJDKeplerNewContent {
//    [[KeplerApiManager sharedKPService] checkUpdate]; //检测更新
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    XYLog(@"内存警告了");
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    [mgr cancelAll];
    [mgr.imageCache clearMemory];
}
- (NSMutableArray *)menuModelArray {
    if (!_menuModelArray) {
        _menuModelArray = [NSMutableArray array];
    }
    return _menuModelArray;
}

- (NSMutableArray *)categoryDataArray {
    if (!_categoryDataArray) {
        _categoryDataArray = [NSMutableArray array];
    }
    return _categoryDataArray;
}
-(void)downloadkittyGif{
    NSString *imageStr = [FNBaseSettingModel settingInstance].loading_goods_img;
    NSURL *imageURL = [NSURL URLWithString:imageStr];
    if([imageStr kr_isNotEmpty]){
        if([FNJZImageTool LocalHaveImage:@"kittyimage"]==YES){
        }else{
            dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
            dispatch_async(globalQueue, ^{
                
                //NSData *imageData = [NSData dataWithContentsOfURL:imageURL]; 
                //UIImage *kittyimage=[UIImage sd_animatedGIFWithData:imageData];
                //[FNJZImageTool  SaveImageToLocal:kittyimage Keys:@"kittyimage"];
                //NSLog(@"kittyimage:%@",[FNJZImageTool GetImageFromLocal:@"kittyimage"]);
                //[FNJZImageTool SaveImageDataToLocal:imageData Keys:@"kittyimageData"];
            });
        }
    }
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_async(globalQueue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        [defaults setObject:imageData forKey:@"kittyGif"];
        [defaults synchronize];
    });
    
}

-(void)bannerViewDidClick:(NSNotification*)noti{
    NSLog(@"%@",noti.object);
    FNChatModel *chat = noti.object;
    UIViewController *vc = [UIViewController currentViewController];
    FNConnectionsChatController *chatController = [[FNConnectionsChatController alloc] init];
    chatController.uid = chat.send_uid;
    chatController.target = chat.target;
    chatController.nickname = chat.nickname;
    chatController.room = chat.room;
    [vc.navigationController pushViewController:chatController animated:YES];
    
}
#pragma mark - WXApiDelegate

/*! @brief 收到一个来自微信的请求，第三方应用程序处理完后调用sendResp向微信发送结果
 *
 * 收到一个来自微信的请求，异步处理完成后必须调用sendResp发送处理结果给微信。
 * 可能收到的请求有GetMessageFromWXReq、ShowMessageFromWXReq等。
 * @param req 具体请求内容，是自动释放的
 */
-(void) onReq:(BaseReq*)req {
    NSLog(@"%@", req.openID);
}



/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void) onResp:(BaseResp*)resp {
    NSLog(@"%d", resp.type);
    
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        
        if (resp.errCode == WXSuccess) {
            NSNotification *notification =[NSNotification notificationWithName:@"Wx_Resp_Success" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        } else if (resp.errCode == WXErrCodeUserCancel) {
            NSNotification *notification =[NSNotification notificationWithName:@"Wx_Resp_Cancle" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        } else {
            NSNotification *notification =[NSNotification notificationWithName:@"Wx_Resp_Failed" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
        
    }else {
    }
}


@end
