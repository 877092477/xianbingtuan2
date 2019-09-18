//
//  XYTabBarViewController.m
//  FnuoApp
//
//  Created by zhongxueyu on 16/2/22.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "XYTabBarViewController.h"

#import "XYNavigationController.h"
#import "ALBBCustomWebViewController.h"
#import "JMMemberUpgradeController.h"
#import "secondViewController.h"
#import "HightRebatesViewController.h"
#import "FNMineController.h"
#import "ProductListViewController.h"
#import "FNPSecKillController.h"
#import "FNPromotionalListController.h"
#import "FNPNormalProController.h"
#import "FNPartnerApplyController.h"
#import "FNMCAgentApplyController.h"
#import "FNMCAgentController.h"
#import "FNPorDetailForShareController.h"
#import "FNLoginSecondController.h"
#import "ShopRebatesViewController.h"
#import "JMInviteFriendsController.h"
#import "FNGoodsListViewController.h"
#import "COFListController.h"
#import "FNCategoryListingsController.h"
#import "XYTabBar.h"
#import "FNHomePromotionalView.h"
#import "FNMembershipUpgradeViewController.h"
#import "JMControllerSelectTool.h"
#import "FNShareProdcutView.h"
#import "FNShareModel.h"
#import "FNParseTbWordModel.h"
#import "FNShareCodeAlert.h"
#import "JMAlertView.h"
#import "FNGradeOfMembershipController.h"
#import "FNEarningsMenuNController.h"
#import "FNIntelligentSearchNeView.h"
#import "FNNewProDetailController.h"
#import "FNCashGiftSeekNeController.h"
#import "FNCashActivityNeController.h"
#import "FNHomeSecKillViewController.h"
#import "FNPDDCategoryController.h"
#import "FNSortHomeDeController.h"
#import "FNOddWelfareNeController.h"
#import "FNstatisticsDeController.h"
#import "FNDefiniteStoreNeController.h"
#import "FNdefineRecommendNeController.h"
#import "FNdefinConvertNeController.h"
#import "FNPunchCardAeController.h"
#import "FNChatManager.h"
#import "FNConnectionsHomeController.h"
#import "FNMakeIntegralTController.h"
#import "FNVideoMarketingHomeController.h"
#import "FNMyVideoCardUseController.h"
#import "StoreWebViewController.h"
#import "FNCourseTeController.h"
#import "FNshopTendPlazaNeController.h"
#import "FNLiveBroadcastController.h"
#import "FNArticleNaController.h"
#import "FNArticleNewNaController.h"
#import "FNArticleDetailsXController.h"
#import "FNWaresMultiNaController.h"
#import "FNChatManager.h"
#import "FNLiveCouponeController.h"
#import "FNLiveCouponeCategoryController.h"

#import "FNDistrictCoinController.h"
#import "FNDouQuanController.h"
#import "FNLoginSecondController.h"
#import "FNCommodityFieldDeController.h"
#import "FNCommColumnItController.h"
#import "StoreWebViewController.h"
#import "FNControllerManager.h"
#import "FNTBWebViewController.h"
#import "UIViewController+DefaultProperyMethod.h"
#import "FNTabManager.h"

@interface XYTabBarViewController ()<UIWebViewDelegate, UITabBarControllerDelegate>

@property (nonatomic,strong) UIWebView *webView;
#pragma mark - params
/** 是否要更新订单状态 **/
@property (nonatomic,assign) BOOL updateOrderStatus;

/** 订单号 **/
@property (nonatomic,strong) NSString *orderNum;
@property (nonatomic, strong)UIWebView* backwebview;

@property (nonatomic, strong) NSMutableArray<UIViewController*>* tabControllers;

@end

@implementation XYTabBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _tabControllers = [[NSMutableArray alloc] init];
    [self loadDateMethod];
    self.tabBar.tintColor  = RED;
    self.delegate = self;
    
    [FNChatManager.shareInstance enroll];

    //添加子控制器
    [self main_initVC];

    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(tongzhi:) name:@"RefreshToken" object:nil];
    [FNNotificationCenter addObserver:self selector:@selector(observingSelected:) name:@"changeVC" object:nil];
    
    if (![NSString checkIsSuccess:[FNBaseSettingModel settingInstance].indexsearch_onoff andElement:@"1"]) {
        //[FNNotificationCenter addObserver:self selector:@selector(observingPastedChange:) name:@"pastedChange" object:nil];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//    _tabControllers[tabBarController.selectedIndex];
    //找到点击的下标
    NSInteger index = 0;
    for ( ;index < tabBarController.viewControllers.count; index ++) {
        if ([viewController isEqual:tabBarController.viewControllers[index]]) {
            break;
        }
    }
    if (index >= tabBarController.viewControllers.count || index >= _tabControllers.count) {
        return YES;
    }
    
    if ([_tabControllers[index] isKindOfClass:[SuperViewController class]]) {
        SuperViewController *vc = (SuperViewController*) _tabControllers[index];
        if ([vc needLogin] && ![UserAccessToken kr_isNotEmpty]) {
            FNLoginSecondController* login = [FNLoginSecondController new];
            UIViewController *currentVC= tabBarController.childViewControllers[tabBarController.selectedIndex];
            if ([currentVC isKindOfClass:[UINavigationController class]]) {
                [((UINavigationController*)currentVC) pushViewController:login animated:YES];
            }
            return NO;
        }
        else if ([vc isFullScreenShow]) {
            
            UIViewController* vc = [self controllerSelectorWithModel:[FNTabManager shareInstance].tabs[index]];
            
            if ([vc isKindOfClass: [FNTBWebViewController class]]) {
                //淘宝外链，直接打开淘宝
                [(FNTBWebViewController*)vc openTB];
                return NO;
            }
            
            [[UIViewController currentViewController].navigationController pushViewController:vc animated:YES];
            return NO;
        }
    }
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}

#pragma mark - notification
- (void)observingPastedChange:(NSNotification*)ntf{
            
}

- (void)dealloc
{
    if (![NSString checkIsSuccess:[FNBaseSettingModel settingInstance].indexsearch_onoff andElement:@"1"]) {
        [FNNotificationCenter removeObserver:self name:@"pastedChange" object:nil];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
- (void)observingSelected:(NSNotification *)ntf{
    NSDictionary* dict = ntf.userInfo;
    NSNumber* num = dict[@"index"];
    self.selectedIndex = num.integerValue;
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


/**
 *  接收刷新token通知
 *
 *  @param noti <#noti description#>
 */
- (void)tongzhi:(NSNotification *)noti{
    XYLog(@"－－－－－刷新成功------");
    for ( UIView * child in  self.tabBar.subviews) {
        
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
    //添加子控制器
    [self main_initVC];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)main_initVC{
    NSArray* titles = @[@"首页",@"超高返",@"购物返利",@"超级券",@"我的"];
    NSArray* images = @[@"home_off",@"shopping_off",@"return_off",@"quan_off",@"me_off"];
    NSArray* selectedImgs = @[@"home_on",@"shopping_on",@"return_on",@"quan_on",@"me_on"];
    [_tabControllers removeAllObjects];
    if ([FNTabManager shareInstance].tabs.count>=1) {
        NSLog(@"item:%@",[FNTabManager shareInstance].tabs);
        NSString* __block color = nil;
        [[FNTabManager shareInstance].tabs enumerateObjectsUsingBlock:^(FNTabModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIViewController* vc = [self controllerSelectorWithModel:obj];
            if (vc == nil) {
                vc = [UIViewController new];
            }
            [self setupChildViewController:vc title:obj.show_name imageName:obj.img seleceImageName:obj.img1];
            if (color == nil) {
                color = obj.color_val;
            }
        }];
        self.tabBar.tintColor = [UIColor colorWithHexString:color];
    }else{
        UIViewController *firstVC = [UIViewController getVCByClassName:nil orIdentifier:@"pub_shouye" andParams:nil];
    
        [self setupChildViewController:firstVC title:titles[0] imageName:images[0] seleceImageName:selectedImgs[0]];
    
    
        FNMCouponPurchaseController* rebate = [FNMCouponPurchaseController new];
        rebate.type = VCTypeHighRebate;
        [self setupChildViewController:rebate title:titles[1] imageName:images[1] seleceImageName:selectedImgs[1]];
    
        if (![FNCurrentVersion isEqualToString:Setting_checkVersion]) {
            UIStoryboard *sb2 = [UIStoryboard storyboardWithName:@"ShopRebates" bundle:nil];
    
            UIViewController *thirdVC = [sb2 instantiateViewControllerWithIdentifier:@"RebatesVC"];
            [self setupChildViewController:thirdVC title:titles[2] imageName:images[2] seleceImageName:selectedImgs[2]];
        }
    
    
        FNMCouponPurchaseController* coupon = [FNMCouponPurchaseController new];
        coupon.type = VCTypeCoupon;
        [self setupChildViewController:coupon title:titles[3] imageName:images[3] seleceImageName:selectedImgs[3]];
    
    

        FNMineController* fifthVC = [FNMineController new];
        [self setupChildViewController:fifthVC title:titles[4] imageName:images[4] seleceImageName:selectedImgs[4]];

    }

}

-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
    controller.title = title;
    CGSize size = CGSizeMake(20, 20);
    if ([imageName containsString:@"http"]) {
        controller.tabBarItem.image = [IMAGE(@"empty")imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [SDWebImageManager.sharedManager downloadImageWithURL:URL(imageName) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {

            if (image)
                controller.tabBarItem.image = [[image transformtoSize:size] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }];
    }else{
        controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    if ([selectImageName containsString:@"http"]) {
        controller.tabBarItem.selectedImage = [IMAGE(@"empty") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [SDWebImageManager.sharedManager downloadImageWithURL:URL(selectImageName) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            if (image)
                controller.tabBarItem.selectedImage = [[image transformtoSize:size] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }];
    }else{
        controller.tabBarItem.selectedImage =  [[ UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    //包装导航控制器
    XYNavigationController *nav = [[XYNavigationController alloc]initWithRootViewController:controller];
    [self addChildViewController:nav];
    [_tabControllers addObject:controller];
}


+ (instancetype)mainViewController {
    XYTabBarViewController *mainCtrl = [[XYTabBarViewController alloc]init];
    return mainCtrl;
}

#pragma mark - 设置自主控制器

- (UIViewController *)controllerSelectorWithModel:(id)model{
  
    
    SuperViewController *vc = [FNControllerManager controllerWithModel:model];
   
    if (vc == nil) {
        FNMCouponPurchaseController* coupon = [FNMCouponPurchaseController new];
        coupon.type=VCTypeCoupon;
        vc = coupon;
    }
    vc.understand = YES;
    vc.isNotHome = NO;
    return vc;
}
- (void)warnToLogin:(UIViewController *)target{
    
    JMAlertView* alert = [JMAlertView alertWithTitle:@"提示" content:@"要登录才能访问哦〜" firstTitle:@"取消" andSecondTitle:@"去登录" alertType:(AlertTypeAlert) clickBlock:^(NSInteger index) {
        if (index == 1) {
            FNLoginSecondController* vc = [FNLoginSecondController new];
            target.navigationController.navigationBar.hidden = NO;
            [target.navigationController pushViewController:vc animated:YES];
        }
    }];
    [alert showAlert];
    
}



//根据类型跳转网页，webType:0.普通网页；1.淘宝站内网页;2.京东站内网页
-(UIViewController *)goWebDetailWithWebType:(NSString *)webType URL:(NSString *)url withHeaderInfo: (NSString*)jsonInfo{
    UIViewController* vc = nil;
    if (webType == nil || [webType isEqualToString:@"0"]) {
        
        vc= [self goWebWithUrl:url];
        
    }else if ([webType isEqualToString:@"1"]) {
        
        vc = [self goTBDetailWithUrl:url];
        
    }else{//2
        vc = [self goJDWebWithUrl:url];
    }
    if ([vc isKindOfClass: [StoreWebViewController class]]) {
        ((StoreWebViewController*)vc).jsonInfo = jsonInfo;
    }
    return vc;
    
}
#pragma mark - web method

/** 跳转普通网页 **/
- (UIViewController *)goWebWithUrl:(NSString *)url{
    secondViewController *web = [StoreWebViewController new];
    web.url = url;
    return web;
}

/** 跳转到京东网页 **/
-(UIViewController *)goJDWebWithUrl:(NSString *)url{
    secondViewController *web = [StoreWebViewController new];
    web.url = url;
    return web;
}

//打开淘宝网页
-(UIViewController *)goTBDetailWithUrl:(NSString *)url{
    
    if ([FNBaseSettingModel settingInstance].appopentaobao_onoff.boolValue) {
        [self initBaiChuanSDKMethod:YES];
    }
    id<AlibcTradePage> page = [AlibcTradePageFactory page:url];
    
    id<AlibcTradeService> service = [AlibcTradeSDK sharedInstance].tradeService;
    AlibcTradeShowParams *showParams = [[AlibcTradeShowParams alloc] init];
    
    showParams.linkKey = @"taobao_scheme";
    
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
    taokeParams.pid = [FNBaseSettingModel settingInstance].TaoKePid;
    taokeParams.adzoneId = [FNBaseSettingModel settingInstance].APP_adzoneId;
    taokeParams.extParams = @{@"taokeAppkey":[FNBaseSettingModel settingInstance].APP_alliance_appkey?:@""};
    taokeParams.unionId = nil;
    taokeParams.subPid = nil;
    // 绑定WebView
    ALBBCustomWebViewController* vc = [[ALBBCustomWebViewController alloc] init];
    
    // @return 0标识跳转到手淘打开了,1标识用h5打开,-1标识出错
    NSInteger res = [service
                     show:vc
                     webView:vc.webView
                     page:page
                     showParams:showParams
                     taoKeParams:taokeParams
                     trackParam:taokeParams.extParams
                     tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
                         [FNTipsView showTips:@"购买成功~"];
                         
                         NSString *order=[NSString stringWithFormat:@"%@",result.payResult.paySuccessOrders];
                         self.orderNum = [self getOrderNumMethod:order];
                         
                         [self initWebViewMethod];
                     }
                     tradeProcessFailedCallback:^(NSError * _Nullable error) {
                         NSDictionary *userInfo = error.userInfo;
                         NSString *order=[NSString stringWithFormat:@"%@",[userInfo objectForKey:@"orderIdList"]];
                         
                         self.orderNum = [self getOrderNumMethod:order];
                         [self initWebViewMethod];
                     }];
    // @return 0标识跳转到手淘打开了,1标识用h5打开,-1标识出错
    if (res == 1) {
        vc.isShow = YES;
        vc.isWeb = YES;
        
    }
    return vc;
    
}
//隐藏加载网页抓取数据
-(void)initWebViewMethod{
    if (self.updateOrderStatus) {
        if(![[ALBBSession sharedInstance] isLogin]){
            
        }
        
        [[ALBBSDK sharedInstance]auth:self successCallback:^(ALBBSession *session) {
            
        } failureCallback:^(ALBBSession *session, NSError *error) {
            
        }];
        
        
    }
    
    if ([self.orderNum kr_isNotEmpty]) {
        [self getPayResultInfoMethod:self.orderNum];
        
    }
    
    
    id<AlibcTradePage> page = [AlibcTradePageFactory page:TBPCURL];
    
    id<AlibcTradeService> service = [AlibcTradeSDK sharedInstance].tradeService;
    AlibcTradeShowParams *showParams = [[AlibcTradeShowParams alloc] init];
    showParams.openType = 2;
    
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
    taokeParams.pid = [FNBaseSettingModel settingInstance].TaoKePid;
    taokeParams.adzoneId = [FNBaseSettingModel settingInstance].APP_adzoneId;
    XYLog(@"addzi is %@",[FNBaseSettingModel settingInstance].APP_adzoneId);
    taokeParams.extParams = @{@"taokeAppkey":[FNBaseSettingModel settingInstance].APP_alliance_appkey};
    taokeParams.unionId = nil;
    taokeParams.subPid = nil;
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    //    _webView.autoresizingMask =  UIViewAutoresizingFlexibleHeight;
    _webView.scrollView.scrollEnabled=YES;
    self.webView.backgroundColor = [UIColor clearColor];
    
    [service
     show:showParams.isNeedPush ? self.navigationController : self
     webView:self.webView
     page:page
     showParams:showParams
     taoKeParams:taokeParams
     trackParam:taokeParams.extParams
     tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
         
     }
     tradeProcessFailedCallback:^(NSError * _Nullable error) {
         
     }];
    
    
    __unsafe_unretained UIWebView *webView = self.webView;
    webView.delegate = self;
    
    [self.view addSubview:self.webView];
    self.webView.hidden = YES;
    
}

#pragma mark - Bai Chuan
-(void)initBaiChuanSDKMethod:(BOOL)setIsForceH5{
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
    
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
        
    } failure:^(NSError *error) {
        
    }];
#warning 测试跟单
    // 开发阶段打开日志开关，方便排查错误信息
    [[AlibcTradeSDK sharedInstance] setDebugLogOpen:NO];
    
    // 配置全局的淘客参数
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
    taokeParams.pid = [FNBaseSettingModel settingInstance].TaoKePid;
    taokeParams.adzoneId =  [FNBaseSettingModel settingInstance].APP_adzoneId;
    taokeParams.extParams = @{@"taokeAppkey": [FNBaseSettingModel settingInstance].APP_alliance_appkey?:@""};
    taokeParams.subPid = nil;
    [[AlibcTradeSDK sharedInstance] setTaokeParams:taokeParams];
    
    // 设置全局配置，是否强制使用h5
    [[AlibcTradeSDK sharedInstance] setIsForceH5:setIsForceH5];
}

#pragma mark -UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if (webView == self.backwebview) {
        NSLog(@"testing url %@",request.URL.absoluteString);
    }
    
    return YES;
}
//网页加载完成后抓取订单数据
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //获取网页数据
    NSString *allHtml = @"document.documentElement.innerHTML";
    NSString *allHtmlInfo = [webView stringByEvaluatingJavaScriptFromString:allHtml];
    
    NSLog(@"allHtmlInfo is start----  %@   -----allHtmlInfo end",allHtmlInfo);
    
    if ([allHtmlInfo containsString:@"订单回收站"]) {////
        NSLog(@"allHtmlInfo is start----  %@   -----allHtmlInfo end",allHtmlInfo);
        
        [self getApiUrlMethod:allHtmlInfo];
        
    }else{
        XYLog(@"没有订单数据");
        [FNNotificationCenter postNotificationName:_jmntf_order_finished object:nil];
    }
    
    
}
#pragma 跟单部分
//把订单传给后台（通过百川消息服务)
-(void)postOrdeWithBaiChuanrMethod:(NSString *)orderNum{
    NSString* str=orderNum;
    //1. 去掉首尾空格和换行符
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //2. 去掉所有空格和换行符
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                  @"time":[NSString GetNowTimes],
                                                                                  @"oid":str,
                                                                                  @"token":UserAccessToken
                                                                                  }];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_mine_tbrecord successBlock:^(id responseBody) {
        XYLog(@"responseBody is%@",responseBody);
        
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
    }];
    
}
//把抓取的数据传给后台
-(void)postOrderMethod:(NSString *)htmlInfo{
    NSDictionary *param;
    if (self.updateOrderStatus) {
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"code":htmlInfo,@"token":UserAccessToken}];
        params[SignKey] = [NSString getSignStringWithDictionary:params];
        param = params;
        
    }else{
        
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"oid":self.orderNum,@"code":htmlInfo,@"fnuo_id":@"",@"token":UserAccessToken}];
        params[SignKey] = [NSString getSignStringWithDictionary:params];
        param = params;
        
    }
    
    
    XYLog(@"param is %@",param);
    
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_others_htmlFllowOrder successBlock:^(id responseBody) {
        XYLog(@"responseBody is%@",responseBody);
        [FNNotificationCenter postNotificationName:_jmntf_order_finished object:nil];
        
    } failureBlock:^(NSString *error) {
        [FNNotificationCenter postNotificationName:_jmntf_order_finished object:nil];
        [XYNetworkAPI cancelAllRequest];
    }];
}

//添加浏览足迹
-(void)postFootPrintMethpd:(NSString *)goodsId{
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"goodsid":goodsId,@"token":UserAccessToken }];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_mine_addfootmark successBlock:^(id responseBody) {
        
        XYLog(@"footresponseBody is %@",responseBody);
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
    }];
}

//把百川返回的订单传给后台
-(void)getPayResultInfoMethod:(NSString *) orderInfo{
    if (![orderInfo isEqualToString:@"(null)"]) {
        [self postOrdeWithBaiChuanrMethod:orderInfo];
        
    }
    
}

//字符串分割
-(NSString *)getApiUrlMethod:(NSString *)paramsStr{
    //    //获取开头
    //    NSRange firstRange;
    //    //获取尾
    //    NSRange secondRange;
    //
    //    //获取开头
    //    NSRange firstRange2;
    //    //获取尾
    //    NSRange secondRange2;
    //    NSString *subString = nil;
    //
    //    firstRange = [paramsStr rangeOfString:@"var data = "];
    //
    //    secondRange = [paramsStr rangeOfString:@"\"type\":\"t3\"}]}"];
    //
    //    //第二次匹配
    //    firstRange2 = [paramsStr rangeOfString:@"{\"error\""];
    //
    //    secondRange2 = [paramsStr rangeOfString:@"订单回收站\",\"type\":\"t3\"}]}"];
    //    if (firstRange.location != NSNotFound) {////第一次匹配
    //        NSLog(@"first found at location = %lu, length = %lu",(unsigned long)firstRange.location,(unsigned long)firstRange.length);
    //
    //        NSLog(@"found at location = %lu, length = %lu",(unsigned long)secondRange.location,(unsigned long)secondRange.length);
    //
    //        int range =(secondRange.location +secondRange.length)-(firstRange.location+firstRange.length);
    //
    //        NSString *str = [paramsStr substringWithRange:NSMakeRange(firstRange.location+firstRange.length, range)];
    //        XYLog(@"subString is-------- %@ end---------",str);
    //        if ([str kr_isNotEmpty]) {
    //            [self postOrderMethod:str];
    //
    //        }
    //        return subString;
    //    }else  if (firstRange2.location != NSNotFound) {
    //        NSLog(@"第二次匹配");
    //
    //        NSLog(@"second found at location = %lu, length = %lu",(unsigned long)firstRange2.location,(unsigned long)firstRange2.length);
    //
    //        NSLog(@"secondfound at location = %lu, length = %lu",(unsigned long)secondRange2.location,(unsigned long)secondRange2.length);
    //
    //        int range =(secondRange2.location +secondRange2.length)-firstRange2.location;
    //
    //        NSString *str = [paramsStr substringWithRange:NSMakeRange(firstRange2.location, range)];
    //        XYLog(@"secondsubString is-------- %@ end---------",str);
    //        if ([str kr_isNotEmpty]) {
    //            [self postOrderMethod:str];
    //
    //        }
    //        return subString;
    //
    //    }else if ([paramsStr rangeOfString:@"忘记密码"].location == NSNotFound &&[paramsStr rangeOfString:@"亲，请登录"].location == NSNotFound) {
    //        NSLog(@"不需要");//判断是否需要登录
    //    } else {
    //        //未登录时唤起淘宝授权
    //        [[ALBBSDK sharedInstance]auth:self successCallback:^(ALBBSession *session) {
    //            //更新状态
    //            self.updateOrderStatus = YES;
    //            [self initWebViewMethod];
    //        } failureCallback:^(ALBBSession *session, NSError *error) {
    //
    //        }];
    //    }
    //
    
    [self postOrderMethod:paramsStr];
    
    
    
    return nil;
}



//去除括号和空格获取订单号
-(NSString *)getOrderNumMethod:(NSString *)orderNum{
    NSString* str=orderNum;
    //1. 去掉首尾空格和换行符
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //2. 去掉所有空格和换行符
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return str;
}
@end
