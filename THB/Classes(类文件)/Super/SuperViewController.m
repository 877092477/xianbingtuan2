//
//  SuperViewController.m
//  THB
//
//  Created by zhongxueyu on 16/3/30.
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

#import "SuperViewController.h"
#import "FNLoginSecondController.h"
#define MARGIN 15
#import "MyWebViewController.h"
#import "secondViewController.h"
#import "FNMineSignUpController.h"
#import "FNProductDetailController.h"
#import "ALBBCustomWebViewController.h"
#import "FNCouponTransitionView.h"
#import "FNPorDetailForShareController.h"
#import "FNBrandSaleController.h"
#import "FNJDFeaturedController.h"
#import "FNHomeSecKillViewController.h"
#import "ShopRebatesViewController.h"
#import "ShakeViewController.h"
#import "HightRebatesViewController.h"
#import "FNMCouponPurchaseController.h"
#import "FNNewProDetailController.h"
#import "FNShareController.h"
#import "FNPSecKillController.h"
#import "FNPromotionalListController.h"
#import "FNPNormalProController.h"
#import "LoginViewController.h"
#import "FNProfitStatisticsController.h"
#import "FNFansController.h"
#import "FNTeamPromoteController.h"
#import "FNMinePromoteController.h"
#import "FNMineController.h"
#import "FNVideoMarketingHomeController.h"

#import "FNShareProdcutView.h"
#import "FNShareModel.h"
#import "FNShareCodeAlert.h"
#import "JMAlertView.h"
#import "CircleOfFriendsModel.h"

#import "FNPartnerCenterController.h"
#import "FNPartnerApplyController.h"
#import "JMMIneBillController.h"
#import "MyLikeViewController.h"
#import "DisCenterViewController.h"
#import "JMInviteFriendsController.h"
#import "JMMemberUpgradeController.h"
#import "MyFootPrintViewController.h"
#import "ContactWeViewController.h"
#import "FNMCAgentController.h"
#import "FNMCAgentApplyController.h"
#import "ShakeHistoryViewController.h"
#import "FNFindOrderController.h"
#import "FNPartnerGoodsController.h"
#import "FNPosterController.h"
#import "FNWelfareController.h"
#import "FNRMAccountManagementController.h"
#import "FNMembershipUpgradeViewController.h"
#import "FNFamilyController.h"
#import "IncomeViewController.h"
#import "FXQRCodeViewController.h"
#import "FNHeroRankController.h"
#import "MyTeamViewController.h"
#import "FXOrderNavBarViewController.h"
#import "invitationPullNewController.h"
#import "COFListController.h"
#import "FNPDDCategoryController.h"
#import "FNCategoryListingsController.h"
#import "FNMineBillNController.h"
#import "FNGradeOfMembershipController.h"
#import "FNEarningsMenuNController.h"
#import "FNPopUpTool.h"

#import "FNGoodsListViewController.h"
#import "FNCashGiftSeekNeController.h"

#import "WebViewJavascriptBridge.h"
#import "D3Generator.h"
#import "RebatesViewController.h"
#import "FNCashActivityNeController.h"
#import "FNCashAcShareNeController.h"
#import "FNpacketRedNeController.h"
#import "FNOddWelfareNeController.h"
#import "FNclienteleDeController.h"
#import "OrderViewController.h"
#import "FNReckoningSetDeController.h"
#import "FNstatisticsDeController.h"
#import "FNDefiniteStoreNeController.h"
#import "FNdefineRecommendNeController.h"
#import "FNdefineRecommendNeController.h"
#import "FNdefinConvertNeController.h"
#import "FNIntegralMallDetailController.h"
#import "FNFreeProductDetailModel.h"
#import "FNConnectionsHomeController.h"
#import "FNConnectionsCreateGroupsController.h"
#import "FNArrangesingleAeController.h"
#import "FNMemberGradeDeController.h"
#import "StoreWebModel.h"
#import "FNAuthController.h"
#import "FNConnectionsMessageController.h"
#import "FNPunchCardAeController.h"
#import "lhScanQCodeViewController.h"
#import "MsgCenterViewController.h"
#import "FNAuthAlertView.h"
#import "FNAuthFailedAlertView.h"
#import "StoreWebViewController.h"
#import "FNAccountReleatedController.h"
#import "FNMakeIntegralTController.h"
#import "FNCourseTeController.h"
#import "FNNewWelfareNeController.h"
#import "JDSDK/JDKeplerSDK.h"
#import "FNVideoWebController.h"
#import "FNMyVideoCardUseController.h"


#import "FNshopTendPlazaNeController.h"

#import "FNDouQuanController.h"


#import "FNshopTendPlazaNeController.h"
#import "FNDouQuanController.h"
#import "FNLiveBroadcastController.h"
#import "FNArticleNaController.h"
#import "FNArticleNewNaController.h" 
#import "FNArticleDetailsXController.h"
#import "FNWaresMultiNaController.h"

#import "FNLiveCouponeController.h"
#import "FNLiveCouponeCategoryController.h"
#import "FNDistrictCoinController.h"
#import "FNNewFreeProductDetailModel.h"
#import "FNNewFreeProductShareAlertView.h"

#import "FNCommodityFieldDeController.h"
#import "FNCommColumnItController.h"
#import "FNControllerManager.h"
#import "FNTBWebViewController.h"
#import "FNTabManager.h"
#import "FNSuperShareModel.h"
#import "HXPhotoTools.h"
#import "FNShareViewController.h"
#import "FNNewUpgradeGoodsNController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WechatOpenSDK/WXApi.h"

@interface SuperViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource, lhScanQCodeViewControllerDelegate>
@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic, strong)FNShareProdcutView* shareView;
@property (nonatomic, strong)FNShareModel* shareModel;
@property (nonatomic, strong)NSString* shareImg;
#pragma mark - js
@property(nonatomic,strong)WebViewJavascriptBridge *bridge;
@property (nonatomic, strong)id model;
@property (nonatomic, assign)BOOL requestSuccessful;

// js调用支付成功后，回调该链接
@property (nonatomic, copy) NSString *jsPayCallbackUrl;

/**
 detailmodel
 */
@property (nonatomic, strong)id deatilModel;
@end

@implementation SuperViewController{
    NSInteger fenxiangType;
}

- (BOOL)isFullScreenShow {
    return NO;
}

- (void)setIsNeedLogin: (BOOL)needLogin {
    _isNeedLogin = needLogin;
}

- (BOOL) needLogin {
    return _isNeedLogin;
}

#pragma mark - setter && getter
- (FNShareProdcutView *)shareView{
    if (_shareView == nil) {
        _shareView = [[FNShareProdcutView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0))];
        _shareView.cancelBtnBlock = ^{
            [FNPopUpTool hiddenAnimated:YES];
        };
        @weakify(self);
        _shareView.shareHeightBlock = ^{
            @strongify(self);
            [SVProgressHUD dismiss];
            [FNPopUpTool showViewWithContentView:self.shareView withDirection:(FMPopupAnimationDirectionBottom) finished:nil];
        };
        _shareView.shareBtnBlock = ^(NSInteger index) {
            [FNPopUpTool hiddenAnimated:YES];
            //Get the type of third-party share
            UMSocialPlatformType (^getShareType)(NSInteger index) = ^(NSInteger index){
                UMSocialPlatformType type = UMSocialPlatformType_WechatSession;
                if (index == 0) {
                    type = UMSocialPlatformType_WechatSession;
                }else if (index == 1){
                    type = UMSocialPlatformType_WechatTimeLine;
                }else if (index == 2){
                    type = UMSocialPlatformType_QQ;
                }
                return type;
            };
            @strongify(self);
            if (fenxiangType==0) {
                [[UIPasteboard generalPasteboard]setString:self.shareModel.str2];
                [FNShareCodeAlert showAlertWithContent:self.shareModel.str2 withClickeBlock:^(NSInteger ind) {
                    if (ind == 1) {
                        [self umengShareWithURL:self.shareModel.url image:self.shareImg shareTitle:self.shareModel.title1 andInfo:self.shareModel.title2 withType:(getShareType(index))];
                    }
                }];
            }else{
                [self umengShareWithURL:nil image:self.shareImg shareTitle:nil andInfo:nil withType:(getShareType(index))];
            }
        };
    }
    return _shareView;
}


- (UIWebView *)backwebview{
    if (_backwebview == nil) {
        _backwebview = [UIWebView new];
        
        [self.view addSubview:_backwebview];

        [self addRoute:_backwebview];
    }
    return _backwebview;
}
- (void)setJm_tableview:(UITableView *)jm_tableview{
    _jm_tableview = jm_tableview;
    _jm_tableview.emptyDataSetSource = self;
    _jm_tableview.emptyDataSetDelegate = self;
}
- (void)setJm_collectionview:(UICollectionView *)jm_collectionview{
    _jm_collectionview = jm_collectionview;
    _jm_collectionview.emptyDataSetDelegate = self;
    _jm_collectionview.emptyDataSetSource = self;
}
#pragma mark  - system
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.jm_page = 1;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
   
   
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [self initNavView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onJSWxSuccess) name:@"Wx_Resp_Success" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onJSWxCancle) name:@"Wx_Resp_Cancle" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onJSWxFailed) name:@"Wx_Resp_Failed" object:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //XYLog(@"出线....");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lookClick) name:@"FNLookGoods" object:nil];
}
-(void)lookClick{
    self.tabBarController.selectedIndex=0;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [SVProgressHUD dismiss];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//初始化导航
-(void)initNavView
{
    
}


#pragma mark - public
#pragma mark - //跳转淘宝商品详情
-(void)goToProductDetailsWithModel:(id)productModel{
    
    //苹果审核直接免授权
    if ([FNCurrentVersion isEqualToString:Setting_checkVersion]) {
        [self openTBDetailWithProductModel:productModel];
        return;
    }
    
    @weakify(self)
    [self requestTBDetail:productModel block:^(id model) {
        @strongify(self)
        @weakify(self)
        
        [self refreshSetting:^{
            FNBaseSettingModel *setting = [FNBaseSettingModel settingInstance];
            @strongify(self)
            if ([setting.tb_illegal isEqualToString:@"0"] && [self showNeedAuth:^(BOOL result) {
                
                [self openTBDetailWithProductModel:model];
                
            }]) {
                return ;
            }
            
            @weakify(self)
            [self bcAuth:^{
                @strongify(self)
                NSString *goods_Id = [model valueForKey:@"ID"];
                //获取商品浏览足迹
                if ([goods_Id kr_isNotEmpty]) {
                    [self postFootPrintMethpd:goods_Id];
                }
                [self openTBDetailWithProductModel:model];
            }];
        }];
    }];
    
}
#pragma mark - //跳转京东商品详情
-(void)goToJDProductDetailsWithModel:(id)productModel{
    NSString *fnuo_url = [productModel valueForKey:@"fnuo_url"];
    [self goToJDProductDetailsWithURL: fnuo_url];
}
-(void)goToJDProductDetailsWithURL:(NSString*)url{
    if ([[FNBaseSettingModel settingInstance].kepler_zeus isEqualToString:@"zeus"]) {
        [self goWebDetailWithWebType:@"2" URL:url];
    }else{
        if ([[FNBaseSettingModel settingInstance].jd_open_app integerValue]==0) {
            [self goWebDetailWithWebType:@"2" URL:url];
        }else{
            [SVProgressHUD show];
            [self.webView removeFromSuperview];
            self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
            self.webView.tag=48;
            //    _webView.autoresizingMask =  UIViewAutoresizingFlexibleHeight;
            _webView.scrollView.scrollEnabled=YES;
            self.webView.backgroundColor = [UIColor clearColor];
            __unsafe_unretained UIWebView *webView = self.webView;
            webView.delegate = self;
            
            [self.view addSubview:self.webView];
            self.webView.hidden = YES;
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
            [self.webView loadRequest:request];
        }
    }
}
#pragma mark - //跳转拼多多商品详情
-(void)goToPddProductDetailsWithModel:(id)productModel{
//    NSString *fnuo_url = [productModel valueForKey:@"fnuo_url"];
//    if ([[FNBaseSettingModel settingInstance].pdd_open_app integerValue]==0) {
//        [self goWebDetailWithWebType:@"0" URL:fnuo_url];
//    }else{
////        BOOL pddCheck=[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"pinduoduo://"]];
////        if (pddCheck) {
////            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:fnuo_url]];
////        }
//        [self goWebDetailWithWebType:@"0" URL:fnuo_url];
//    }
    NSString *fnuo_id = [productModel valueForKey:@"fnuo_id"];
    [self requestPdd: fnuo_id];
}

/**
 拼多多跳转购买链接获取

 @param fnuo_id fnuo_id
 */
- (void)requestPdd: (NSString*)fnuo_id{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"fnuo_id": fnuo_id}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appPddGoodsDetail&ctrl=pddUrl" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)

        NSString *url = respondsObject[@"url"];
        NSString *no_open_url = respondsObject[@"no_open_url"];
        
        BOOL pddCheck=[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"pinduoduo://"]];
        if (pddCheck) {
            [self goWebDetailWithWebType:@"0" URL:url];
        } else {
            [self goWebDetailWithWebType:@"0" URL:no_open_url];
        }
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

#pragma mark - //跳转唯品会商品详情
-(void)goToWphProductDetailsWithModel:(id)productModel{
    NSString *fnuo_url = [productModel valueForKey:@"fnuo_url"];
//    [self goWebDetailWithWebType:@"0" URL:fnuo_url];
    if ([fnuo_url hasPrefix:@"vipshop://"]) {
        BOOL wphCheck=[[UIApplication sharedApplication] canOpenURL:URL(fnuo_url)];
        if (wphCheck) {
            [[UIApplication sharedApplication] openURL:URL(fnuo_url)];
        } else {
            NSString *h5_url = (NSString*)[productModel valueForKey:@"h5_url"];
            [self goWebDetailWithWebType:@"0" URL:h5_url];
        }
    } else {
        [self goWebDetailWithWebType:@"0" URL:fnuo_url];
    }
}
#pragma mark - //根据类型跳转网页，webType:0.普通网页；1.淘宝站内网页;2.京东站内网页
-(void)goWebDetailWithWebType:(NSString *)webType URL:(NSString *)url{
    [self goWebDetailWithWebType:webType URL:url withHeaderInfo:nil];
}
-(void)goWebDetailWithWebType:(NSString *)webType URL:(NSString *)url withHeaderInfo: (NSString*)jsonInfo{
    if (webType == nil || [webType isEqualToString:@"0"]) {
        [self goWebWithUrl:url withHeader:jsonInfo];
    }else if ([webType isEqualToString:@"1"]) {
        [self goTBDetailWithUrl:url];
    }else if ([webType isEqualToString:@"2"]) {
        [self goJDWebWithUrl:url];
    }
}


#pragma mark - detail method
//跳转优惠券详情
- (void)goToProductDetailsWithId:(NSString *)goodsID couponDes:(NSString *)couponDes andCouponUrl:(NSString *)url{
    FNProductDetailController *detail = [FNProductDetailController new];
    detail.gid = goodsID;
    detail.couponUrl = url;
    detail.couponDes = couponDes;
    [self.navigationController pushViewController:detail animated:YES];
}
//打开淘宝单个商品详情
-(void)openTBDetailWithProductModel:(id)productModel{
    self.deatilModel=productModel;
    NSString *fnuo_url = [productModel valueForKey:@"fnuo_url"];
    
//    if([[productModel valueForKey:@"is_tlj"] isEqualToString:@"1"]){
//        //[SVProgressHUD show];
//        NSLog(@"is_tlj:%@",[productModel valueForKey:@"is_tlj"]);
//        NSString* url = [NSString stringWithFormat:@"%@&js=on",fnuo_url];
//        [self.backwebview loadRequest:[NSURLRequest requestWithURL:URL(url)]];
//    }else{
        [self openDetailWithModel:productModel];
//    }
    
}



- (void)openDetailWithID: (NSString*)fnuo_id withPid: (NSString*)pid adzoneId: (NSString*)adzoneId APP_alliance_appkey: (NSString*)APP_alliance_appkey{
    id<AlibcTradePage> page =[AlibcTradePageFactory itemDetailPage:fnuo_id];
    id<AlibcTradeService> service = [AlibcTradeSDK sharedInstance].tradeService;
    AlibcTradeShowParams *showParams = [[AlibcTradeShowParams alloc] init];
    
    showParams.openType = AlibcOpenTypeNative;
    showParams.linkKey = @"taobao_scheme";
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
    if ([pid isEqualToString:@""] || [adzoneId isEqualToString:@""] || [APP_alliance_appkey isEqualToString:@""]) {
        taokeParams = [[AlibcTradeTaokeParams alloc] init];
        taokeParams.pid = [FNBaseSettingModel settingInstance].TaoKePid;
        taokeParams.adzoneId = [FNBaseSettingModel settingInstance].APP_adzoneId;
        taokeParams.extParams = @{@"taokeAppkey":[FNBaseSettingModel settingInstance].APP_alliance_appkey?:@""};
    }else {
        taokeParams.pid = pid;
        taokeParams.adzoneId = adzoneId;
        taokeParams.extParams = @{@"taokeAppkey":APP_alliance_appkey?:@""};
    }
    taokeParams.unionId = nil;
    taokeParams.subPid = nil;
    
    [service show:self.navigationController page:page showParams:showParams taoKeParams:taokeParams trackParam:taokeParams.extParams tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
        [FNTipsView showTips:@"购买成功~"];
        NSString *order=[NSString stringWithFormat:@"%@",result.payResult.paySuccessOrders];
        self.orderNum = [self getOrderNumMethod:order];
        [self initWebViewMethod];
    } tradeProcessFailedCallback:^(NSError * _Nullable error) {
        NSDictionary *userInfo = error.userInfo;
        NSString *order=[NSString stringWithFormat:@"%@",[userInfo objectForKey:@"orderIdList"]];
        self.orderNum = [self getOrderNumMethod:order];
        [self initWebViewMethod];
    }];
}

-(void)openDetailWithModel:(id)model{
    [SVProgressHUD dismiss];
    NSString *fnuo_id = [model valueForKey:@"fnuo_id"];
    NSString *highcommission_url = [model valueForKey:@"highcommission_url"];
    NSString *yhq_url = [model valueForKey:@"yhq_url"];
    
    NSString *is_dq_yhqurl = [model valueForKey:@"is_dq_yhqurl"];
    id<AlibcTradePage> page;
    if ([model isKindOfClass:[StoreWebModel class]]) {
        StoreWebModel *webModel = model;
        page = [AlibcTradePageFactory page:webModel.url];
    } else{
            /** 1.优先级：优惠券链接>高佣链接>普通商品 **/
            page =[AlibcTradePageFactory itemDetailPage:fnuo_id];

            if ([highcommission_url kr_isNotEmpty]) {
                page =  [AlibcTradePageFactory page:highcommission_url];
            }
            if ([NSString checkIsSuccess:is_dq_yhqurl andElement:@"1"]) {
                page =  [AlibcTradePageFactory page:yhq_url];
            }

    }
//
    
    id<AlibcTradeService> service = [AlibcTradeSDK sharedInstance].tradeService;
    AlibcTradeShowParams *showParams = [[AlibcTradeShowParams alloc] init];

    showParams.openType = AlibcOpenTypeNative;
    showParams.linkKey = @"taobao_scheme";
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
    
    taokeParams.pid = [FNBaseSettingModel settingInstance].TaoKePid;
    taokeParams.adzoneId = [FNBaseSettingModel settingInstance].APP_adzoneId;
    taokeParams.extParams = @{@"taokeAppkey":[FNBaseSettingModel settingInstance].APP_alliance_appkey?:@""};


    taokeParams.unionId = nil;
    taokeParams.subPid = nil;
    
    
    // 绑定WebView
//    ALBBCustomWebViewController* vc = [[ALBBCustomWebViewController alloc] init];
    
    [service show:self.navigationController page:page showParams:showParams taoKeParams:taokeParams trackParam:taokeParams.extParams tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
        [FNTipsView showTips:@"购买成功~"];
        NSString *order=[NSString stringWithFormat:@"%@",result.payResult.paySuccessOrders];
        self.orderNum = [self getOrderNumMethod:order];
        [self initWebViewMethod];
    } tradeProcessFailedCallback:^(NSError * _Nullable error) {
        NSDictionary *userInfo = error.userInfo;
        NSString *order=[NSString stringWithFormat:@"%@",[userInfo objectForKey:@"orderIdList"]];
        self.orderNum = [self getOrderNumMethod:order];
        [self initWebViewMethod];
    }];
    
    // @return 0标识跳转到手淘打开了,1标识用h5打开,-1标识出错
//    NSInteger res = [service
//                     show:vc
//                     webView:vc.webView
//                     page:page
//                     showParams:showParams
//                     taoKeParams:taokeParams
//                     trackParam:taokeParams.extParams
//                     tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
//                         [FNTipsView showTips:@"购买成功~"];
//
//                         NSString *order=[NSString stringWithFormat:@"%@",result.payResult.paySuccessOrders];
//                         self.orderNum = [self getOrderNumMethod:order];
//                         vc.is_dq_yhqurl = @"0";
//                         [self initWebViewMethod];
//                     }
//                     tradeProcessFailedCallback:^(NSError * _Nullable error) {
//                         NSDictionary *userInfo = error.userInfo;
//                         NSString *order=[NSString stringWithFormat:@"%@",[userInfo objectForKey:@"orderIdList"]];
//                         vc.is_dq_yhqurl = @"0";
//                         self.orderNum = [self getOrderNumMethod:order];
//                         [self initWebViewMethod];
//                     }];
//
//
//    //     @return 0标识跳转到手淘打开了,1标识用h5打开,-1标识出错
//    if (res == 1) {
//        vc.hidesBottomBarWhenPushed = YES;
//        vc.ID =fnuo_id;
//        vc.shop_id = shop_id;
////        vc.url = fnuo_url;
////        if (isCoupon) {
////            vc.couponURL = fnuo_url;
////        }
//        vc.goods_img = goods_img;
//        vc.goods_title= goods_title;
//        vc.goods_cost_price = goods_cost_price;
//        vc.juanhou_price = goods_price;
//        vc.yhq_price =yhq_price;
////        vc.iscoupon = isCoupon;
//        vc.fcommission = fcommission;
//        vc.is_dq_yhqurl = is_dq_yhqurl;
//        if ([open_iid kr_isNotEmpty]) {
//            vc.detailType = DetailTypeOutSite;
//        }else{
//            vc.detailType = DetailTypeInSite;
//        }
//
//        [self.navigationController pushViewController:vc animated:YES];
//
//
//    }
}

#pragma mark - web method
/** 跳转普通网页 **/
- (void)goWebWithUrl:(NSString *)url{
    [self goWebDetailWithWebType:@"0" URL:url withHeaderInfo:nil];
}

- (void)goWebWithUrl:(NSString *)url withHeader: (nullable NSString*)header{
    if ((![NSString isEmpty:url]) && [url containsString:@"uin="] && [url containsString:@"&site"] && [url containsString:@"http://wpa.qq.com"]) {
        NSRange rang1 = [[FNBaseSettingModel settingInstance].ContactUs rangeOfString:@"uin="];
        NSRange rang2 = [[FNBaseSettingModel settingInstance].ContactUs rangeOfString:@"&site"];
        NSString* strin = [[FNBaseSettingModel settingInstance].ContactUs substringWithRange:NSMakeRange(rang1.location+rang1.length, rang2.location-(rang1.location+rang1.length))];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",strin]];
        [[UIApplication sharedApplication] openURL:url];
        if (![QQApiInterface isQQInstalled]) {
            
            NSLog(@"没安装qq或qq空间");
            [FNTipsView showTips:@"没安装qq或qq空间"];
            
        }
        return;
        
    }
    if ([url kr_isNotEmpty]) {
        StoreWebViewController *web = [StoreWebViewController new];
        web.url = url;
        web.jsonInfo = header;
        [self.navigationController pushViewController:web animated:YES];
    }
}

/** 跳转到京东网页 **/
-(void)goJDWebWithUrl:(NSString *)url{
    if ((![NSString isEmpty:url]) && [url containsString:@"uin="] && [url containsString:@"&site"] && [url containsString:@"http://wpa.qq.com"]) {
        NSRange rang1 = [[FNBaseSettingModel settingInstance].ContactUs rangeOfString:@"uin="];
        NSRange rang2 = [[FNBaseSettingModel settingInstance].ContactUs rangeOfString:@"&site"];
        NSString* strin = [[FNBaseSettingModel settingInstance].ContactUs substringWithRange:NSMakeRange(rang1.location+rang1.length, rang2.location-(rang1.location+rang1.length))];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",strin]];
        [[UIApplication sharedApplication] openURL:url];
        if (![QQApiInterface isQQInstalled]) {
            
            NSLog(@"没安装qq或qq空间");
            [FNTipsView showTips:@"没安装qq或qq空间"];
            
        }
        return;
        
    }
    if ([url kr_isNotEmpty]) {
        secondViewController *web = [secondViewController new];
        web.url = url;
        [self.navigationController pushViewController:web animated:YES];
    }
}

//打开淘宝网页
-(void)goTBDetailWithUrl:(NSString *)url{
    if ((![NSString isEmpty:url]) && [url containsString:@"uin="] && [url containsString:@"&site"] && [url containsString:@"http://wpa.qq.com"]) {
        NSRange rang1 = [[FNBaseSettingModel settingInstance].ContactUs rangeOfString:@"uin="];
        NSRange rang2 = [[FNBaseSettingModel settingInstance].ContactUs rangeOfString:@"&site"];
        NSString* strin = [[FNBaseSettingModel settingInstance].ContactUs substringWithRange:NSMakeRange(rang1.location+rang1.length, rang2.location-(rang1.location+rang1.length))];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",strin]];
        [[UIApplication sharedApplication] openURL:url];
        if (![QQApiInterface isQQInstalled]) {
            
            NSLog(@"没安装qq或qq空间");
            [FNTipsView showTips:@"没安装qq或qq空间"];
            
        }
        return;
        
    }
    if ([FNBaseSettingModel settingInstance].appopentaobao_onoff.boolValue) {
        [self initBaiChuanSDKMethod:YES];
    }
    id<AlibcTradePage> page = [AlibcTradePageFactory page:url];
    
    id<AlibcTradeService> service = [AlibcTradeSDK sharedInstance].tradeService;
    AlibcTradeShowParams *showParams = [[AlibcTradeShowParams alloc] init];
    
    showParams.linkKey = @"taobao_scheme";
    showParams.openType = AlibcOpenTypeNative;

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
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
/** 带底部和提示的商城网页 **/
-(void)goShopWebWithUrl:(NSString *)url{
    
}



-(void)goTBDetailWithID:(NSString *)ID animated:(BOOL)animated{
    id<AlibcTradePage> page = [AlibcTradePageFactory itemDetailPage:ID];
    
    id<AlibcTradeService> service = [AlibcTradeSDK sharedInstance].tradeService;
    AlibcTradeShowParams *showParams = [[AlibcTradeShowParams alloc] init];
    if ([FNBaseSettingModel settingInstance].appopentaobao_onoff.boolValue) {
        showParams.openType = 1;
        
    }else{
        showParams.openType = 2;
        
    }
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
        vc.isPush = YES;
        [self.navigationController pushViewController:vc animated:animated];
    }
    
}

- (void)goProductVCWithModel:(id)model {
    [self goProductVCWithModel:model withData:nil];
}
- (void)goProductVCWithModel:(id)model withData: (nullable NSDictionary*)data{
    [self goProductVCWithModel:model withData:data isLive:NO];
}
- (void)goProductVCWithModel:(id)model withData: (nullable NSDictionary*)data isLive: (BOOL)isLive{
//    if ([NSString isEmpty:UserAccessToken]&&[FNBaseSettingModel settingInstance].is_need_login.boolValue) {
//        [self warnToLogin];
//        return;
//    }
    
    
    UIViewController *vc = [FNControllerManager goProductVCWithModel: model withData: data isLive: isLive];
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
//    NSObject *item=model;
//    NSDictionary *dictry=item.keyValues;
//    FNBaseProductModel *modelL=[FNBaseProductModel mj_objectWithKeyValues:dictry];
//    //XYLog(@"dictry=:%@",dictry);
//    //XYLog(@"goods_title=:%@",dictry[@"goods_title"]);
//
//    FNNewProDetailController* detail = [FNNewProDetailController new];
//    if (data) {
//        detail.data = data;
//    } else {
//        // ！！！！ 兼容旧版本data，旧版本多次类型转换会导致data数据不全，若因data不全导致奇怪bug，使用显式传递data：
//        // - (void)goProductVCWithModel:(id)model withData: (nullable NSDictionary*)data
//        detail.data = dictry;
//    }
//    detail.fnuo_id = modelL.fnuo_id;// [model valueForKey:@"fnuo_id"];
//    detail.isLive = isLive;
//    if ([modelL.getGoodsType kr_isNotEmpty]){
//       detail.getGoodsType = modelL.getGoodsType;//[model valueForKey:@"getGoodsType"];
//    }
//    if (modelL.goods_title!=nil) {
//        detail.goods_title = modelL.goods_title;//[model valueForKey:@"goods_title"];
//    }
//    else if(modelL.goodsInfo!=nil){
//        detail.goods_title = modelL.goodsInfo;//[model valueForKey:@"goodsInfo"];
//    }
//    else{
//        detail.goods_title = @"";
//    }
//    detail.SkipUIIdentifier = modelL.shop_type;// [model valueForKey:@"shop_type"];
//    if ([modelL.pdd integerValue]==1) {
//        detail.SkipUIIdentifier = @"buy_pinduoduo";
//    }
//    if ([modelL.jd integerValue]==1) {
//        detail.SkipUIIdentifier = @"buy_jingdong";
//        detail.yhqUrl=modelL.yhq_url;//[model valueForKey:@"yhq_url"];
//    }
//    if ([model isKindOfClass:[FNBaseProductModel class]]) {
//        FNBaseProductModel* pro = model;
//        detail.isSearch = pro.ID == nil;
//    }
//
////    detail.dataDict = model;
//
//    [self.navigationController pushViewController:detail animated:YES];

}
- (void)goBaiChunWithoutCoupon:(NSString *)url{
    [self.backwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
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

//隐藏加载网页抓取数据
-(void)initWebViewMethod{
    if (self.updateOrderStatus) {
        if(![[ALBBSession sharedInstance] isLogin]){
            [[ALBBSDK sharedInstance]auth:self successCallback:^(ALBBSession *session) {
                
            } failureCallback:^(ALBBSession *session, NSError *error) {
                
            }];
        }
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
    [self.webView removeFromSuperview];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    self.webView.tag=38;
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
#pragma mark -UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
   
    
    if (webView == self.backwebview) {
        NSLog(@"testing url %@",request.URL.absoluteString);
        if ([request.URL.absoluteString containsString:@"tbopen://"]) {
            return NO;
        }else if ([request.URL.absoluteString containsString:@"tmall://"]) {
            return NO;
        }else if ([request.URL.absoluteString containsString:@"taobao://"]) {
            return NO;
        }
    }
    if (webView.tag==48) {
        if ([request.URL.host containsString:@"jd.com"]) {
            [SVProgressHUD dismiss];
            @weakify(self)
            NSString *requestUrl = request.URL.absoluteString;
            [[KeplerApiManager sharedKPService] openKeplerPageWithURL:requestUrl userInfo:nil failedCallback:^(NSInteger code, NSString *url) {
                @strongify(self)
                if (code != 200) {
                    [self goWebDetailWithWebType:@"2" URL:requestUrl];
                }
            }];
            return NO;
        }
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



#pragma mark - DZNEmptyDataSetSource
- (nullable NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSAttributedString *att = [[NSAttributedString alloc]initWithString:@"暂无数据" attributes:@{NSFontAttributeName:kFONT14,NSForegroundColorAttributeName:FNMainTextNormalColor}];
    return att;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"pcresults_empty"];
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    return YES;
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

- (void)shareMiniProgram: (NSString*)title content: (NSString*)content image: (UIImage*)image username: (NSString*)username path: (NSString*)path webpageUrl: (NSString*)webpageUrl
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareMiniProgramObject *shareObject = [UMShareMiniProgramObject shareObjectWithTitle:title descr:content thumImage:image];
    shareObject.webpageUrl = webpageUrl;
    shareObject.userName = username;
    shareObject.path = path;
    //    shareObject.hdImageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"]];

    NSData *imgData = [UIImage scaleData:image toKb:120];//小程序的节点高清大图, 小于128k
    shareObject.hdImageData = imgData;
    shareObject.miniProgramType = UShareWXMiniProgramTypeRelease; // 可选体验版和开发板
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        
    }];
}


- (void)umengShareWithURL:(NSString *)url image:(id)image shareTitle:(NSString*)shareTitle andInfo:(NSString *)info{
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaAppKey  appSecret:SinaAppSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession)]];
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        
        
        // 根据获取的platformType确定所选平台进行下一步操作
        //创建分享消息对象
        NSString *urlStr = url;
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        if (urlStr ) {
            
            //创建网页内容对象
            UIImage* thumbURL =  Share_AppIcon;
            UIImage* remoteimg = nil;
            if (image && ![image isKindOfClass:[UIImage class]]) {
                remoteimg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image]]];
            }else if([image isKindOfClass:[UIImage class]]){
                remoteimg = image;
            }
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:shareTitle?:[NSString stringWithFormat:@"来自%@",[FNBaseSettingModel settingInstance].AppDisplayName] descr:info?:[NSString stringWithFormat:@"您的好友分享了一个宝贝链接:%@",urlStr] thumImage:remoteimg?:thumbURL];
            shareObject.webpageUrl = urlStr;
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
        }else{
            NSData* img = [NSData data];
            if ([image isKindOfClass:[NSData class]]) {
                img = image;
            } else if ([image isKindOfClass:[UIImage class]]) {
                img = UIImagePNGRepresentation(image);
            } else{
                img = [NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
            }
            UMShareImageObject* imgObject = [[UMShareImageObject  alloc]init];
            [imgObject setShareImage:img];
            messageObject.shareObject = imgObject;
        }
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                [FNNotificationCenter postNotificationName:@"FNTaoLiJin" object:nil];
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            //        [self alertWithError:error];
        }];
        
    }];
}
- (void)umengShareWithURL:(NSString *)url image:(id)image shareTitle:(NSString *)shareTitle andInfo:(NSString *)info withType:(UMSocialPlatformType)type{
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaAppKey  appSecret:SinaAppSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    // 根据获取的platformType确定所选平台进行下一步操作
    //创建分享消息对象
    NSString *urlStr = url;
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    if (urlStr ) {
        
        //创建网页内容对象
        UIImage* thumbURL =  Share_AppIcon;
        UIImage* remoteimg = nil;
        if (image && ![image isKindOfClass:[UIImage class]]) {
            remoteimg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image]]];
        }else if([image isKindOfClass:[UIImage class]]){
            remoteimg = image;
        }
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:shareTitle?:[NSString stringWithFormat:@"来自%@",[FNBaseSettingModel settingInstance].AppDisplayName] descr:info?:[NSString stringWithFormat:@"您的好友分享了一个宝贝链接:%@",urlStr] thumImage:remoteimg?:thumbURL];
        shareObject.webpageUrl = urlStr;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }else{
        
        NSData* img = [NSData data];
        if ([image isKindOfClass:[NSData class]]) {
            img = image;
        } else if ([image isKindOfClass:[UIImage class]]) {
            img = UIImagePNGRepresentation(image);
        } else{
            img = [NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
        }
        UMShareImageObject* imgObject = [[UMShareImageObject  alloc]init];
        [imgObject setShareImage:img];
        messageObject.shareObject = imgObject;
    }
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //        [self alertWithError:error];
    }];
    
}

#pragma mark - Tabel view data source
- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}


- (void)goToOtherPageWithModel:(id)model{
    NSString* Identifier = [model valueForKey:@"UIIdentifier"];
    NSString*  keyWord = [model valueForKey:@"name"];
    NSString* view_type = [model valueForKey:@"view_type"];
    if (![NSString isEmpty:view_type]) {
        NSString* titleImg = [model valueForKey:@"goodslist_img"];
        NSString* title = [model valueForKey:@"goodslist_str"];
        NSString* show_name = [model valueForKey:@"show_name"];
        if ([NSString checkIsSuccess:view_type andElement:@"2"]) {
            //sec kill
            FNPSecKillController* seckill = [FNPSecKillController new];
            seckill.show_name=show_name;
            seckill.view_type = view_type;
            seckill.identifier = Identifier;
            seckill.title = title;
            seckill.titleImg = titleImg;
            [self.navigationController pushViewController:seckill animated:YES];
            return;
        }else if ([NSString checkIsSuccess:view_type andElement:@"1"]){
            FNPromotionalListController* list = [FNPromotionalListController new];
            list.show_name=show_name;
            list.viewmodel.view_type = view_type;
            list.viewmodel.identifier = Identifier;
            list.title = title;
            list.titleImg = titleImg;
            [self.navigationController pushViewController:list animated:YES];
            return;
        }else if ([NSString checkIsSuccess:view_type andElement:@"0"]){
            FNPNormalProController* product = [FNPNormalProController new];
            product.titleImg = titleImg;
            product.title = title;
            product.view_type = view_type;
            product.identifier = Identifier;
            [self.navigationController pushViewController:product animated:YES];
            return;
        }
        
    }
    if([Identifier isEqualToString:@"0"]){
        NSString*url = [model valueForKey:@"url"];
        if (([url rangeOfString:_api_others_yiyuanindex].location !=NSNotFound)) {//网页
            secondViewController *vc = [[secondViewController alloc]init];
            
            vc.url = url;
            vc.title = keyWord;
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            
            [self goWebDetailWithWebType:@"1" URL:url];
            
        }
    }
    else if([Identifier isEqualToString:@"1"]){//优惠券
        
#if APP_QN == 1
        [FNNotificationCenter postNotificationName:@"changeVC" object:nil userInfo:@{@"index":@1}];
#else
        [FNNotificationCenter postNotificationName:@"changeVC" object:nil userInfo:@{@"index":@3}];
#endif
        
    }
    else if ([Identifier isEqualToString:@"2"]) {//品牌特卖
        FNBrandSaleController* brand = [FNBrandSaleController new];
        brand.toIndex = 0;
        [self.navigationController pushViewController:brand animated:YES];
    }else if ([Identifier isEqualToString:@"3"]){//9块9
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainHRB" bundle:nil];
        HightRebatesViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SecondVC"];
        //        HightRebatesViewController *vc = [[HightRebatesViewController alloc]init];
        vc.type = 1;
        vc.title = keyWord;
        vc.fromHome = 1;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([Identifier isEqualToString:@"4"]){//商城返利
        if ([FNCurrentVersion isEqualToString:Setting_checkVersion]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainHRB" bundle:nil];
            HightRebatesViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SecondVC"];
//            vc.type = 3;//分类名类型
            vc.title = keyWord;
            vc.fromHome = 1;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            ShopRebatesViewController *vc = [[ShopRebatesViewController alloc] initWithShopType:@"" withStr:[model valueForKey:@"show_type_str"]];
            vc.title = keyWord;
            vc.type = [NSNumber numberWithInt:1];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if ([Identifier isEqualToString:@"5"]){//摇一摇
        
        if([UserAccessToken kr_isNotEmpty]){
            ShakeViewController *vc = [[ShakeViewController alloc]init];
            vc.title = keyWord;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [FNTipsView showTips:@"请先登录~"];
        }
        
    }else if([Identifier isEqualToString:@"6"]){//超高返
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainHRB" bundle:nil];
        HightRebatesViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SecondVC"];
//        vc.type = 3;//分类名类型
        vc.title = keyWord;
        vc.fromHome = 1;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if([Identifier isEqualToString:@"7"]){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainHRB" bundle:nil];
        HightRebatesViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SecondVC"];
        vc.type = 9;//分类名类型
        vc.realType = Identifier;
        vc.title = keyWord;
        vc.fromHome = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([Identifier isEqualToString:@"16"]){//限时抢购跳转
        
        FNHomeSecKillViewController *secKill = [FNHomeSecKillViewController new];
        [self.navigationController pushViewController:secKill animated:YES];
        
    }else if ([Identifier isEqualToString:@"27"]){
        //白菜馆
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainHRB" bundle:nil];
        HightRebatesViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SecondVC"];
        vc.realType = Identifier;
        vc.title = @"白菜馆";
        vc.fromHome = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([Identifier isEqualToString:@"28"]){
        //今日上新
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainHRB" bundle:nil];
        HightRebatesViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SecondVC"];
        vc.realType = Identifier;
        vc.title = @"今日上新";
        vc.fromHome = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([Identifier isEqualToString:@"29"]){
        FNJDFeaturedController* jd = [FNJDFeaturedController new];
        jd.type = FLVCTypeJD;
        jd.title = keyWord;
        [self.navigationController pushViewController:jd animated:YES];
    }else if ([Identifier isEqualToString:@"30"]){
        FNPorDetailForShareController* vc = [FNPorDetailForShareController new];
        vc.url = [model valueForKey:@"fnuo_url"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (FNRequestTool *)requestTBDetail: (id)model block: (void(^)(id)) block{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    NSString *APIUrl=@"mod=appapi&act=newgoods_detail&ctrl=index";

    params[@"fnuo_id"] = [model valueForKey:@"fnuo_id"];
    params[@"goods_title"] = [model valueForKey:@"goods_title"];
    params[@"getGoodsType"] = [model valueForKey:@"getGoodsType"];
    NSDictionary *data = [model valueForKey:@"data"];
    if (data) {
        NSError *error = nil;
        NSData * JSONData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
//        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        XYLog(@"detailModel is %@",jsonString);
        
        params[@"data"] = jsonString;
    }
    
    @weakify(self)
    return [FNRequestTool requestWithParams:params api:APIUrl respondType:(ResponseTypeModel) modelType:@"FNNewProductDetailModel" success:^(id respondsObject) {
        
        block(respondsObject);
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache:NO];
}


#pragma mark - share

- (void)authShare:(void (^) (BOOL isAuthed))block {
    NSString *token = UserAccessToken;
    if (!(token && token.length>=1)) {
        [FNTipsView showTips:@"请先登录〜"];
        return ;
    }
    @weakify(self)
    [self refreshSetting:YES block:^{
        @strongify(self)
        
        if ([FNBaseSettingModel settingInstance].all_fx_onoff.boolValue) {

            if ([self showNeedSwitchAccount:^(BOOL result) {  }]) {
                block(NO);
                return ;
            }
            
            if ([self showNeedAuth:^(BOOL result) { }]) {
                block(NO);
                return ;
            }
            block(YES);
        }else{
            [self loadMembershipUpgradeViewController];
        }
    }];
}

- (void)shareProductWithModel:(id)model{
    NSString *token = UserAccessToken;
    if (!(token && token.length>=1)) {
        [FNTipsView showTips:@"请先登录〜"];
        return;
    }
    @weakify(self)
    [self refreshSetting:YES block:^{
        @strongify(self)
        
        if ([FNBaseSettingModel settingInstance].all_fx_onoff.boolValue) {
            self.requestSuccessful = NO;
            self.model = model;
            if ([[self.model valueForKey:@"pdd"] integerValue]==1 || [[self.model valueForKey:@"jd"] integerValue]==1 || [[self.model valueForKey:@"wph"] integerValue]==1) {
                if (self.requestSuccessful == NO) {
                    self.requestSuccessful = YES;
                    [self productShare];
                }
            }else{
                @weakify(self)
                [self requestTBDetail:model block:^(id model) {
                    @strongify(self)
                    
                    @weakify(self)
                    if ([self showNeedSwitchAccount:^(BOOL result) {
                        @strongify(self)
                        [self shareProductWithModel:model];
                    }]) {
                        return ;
                    }
                    
                    if ([self showNeedAuth:^(BOOL result) {
                        @strongify(self)
                        //授权成功
                        [self shareProductWithModel:model];
                        
                    }]) {
                        return;
                    }
                    
                    if (self.requestSuccessful == NO) {
                        self.requestSuccessful = YES;
                        [self productShare];
                    }
                }];
                
            }
        }else{
            [self loadMembershipUpgradeViewController];
        }
    }];
    
   
    
}
- (void)productShare{
    NSString* fnuo_id = [self.model valueForKey:@"fnuo_id"];
    NSString* getGoodsType = [self.model valueForKey:@"getGoodsType"];
    fenxiangType=0;//分享模式(0普通 1多图模式 2纯图模式)
    NSString *SkipUIIdentifier;
    NSString *yhq_url;
    
    if ([[self.model valueForKey:@"wph"] integerValue]==1) {
        //唯品会使用三合一分享
        FNShareViewController *vc = [[FNShareViewController alloc] init];
        vc.SkipUIIdentifier = [self.model valueForKey:@"SkipUIIdentifier"];
        vc.fnuo_id = fnuo_id;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if ([[self.model valueForKey:@"pdd"] integerValue]==1) {
        SkipUIIdentifier = @"buy_pinduoduo";
        fenxiangType=[FNBaseSettingModel settingInstance].app_pddgoods_fenxiang_type.integerValue;
    }else if ([[self.model valueForKey:@"jd"] integerValue]==1) {
        SkipUIIdentifier = @"buy_jingdong";
        yhq_url=[self.model valueForKey:@"yhq_url"];
        fenxiangType = [FNBaseSettingModel settingInstance].app_jdgoods_fenxiang_type.integerValue;
    }else{
        SkipUIIdentifier = @"buy_taobao";
        fenxiangType=[FNBaseSettingModel settingInstance].app_goods_fenxiang_type.integerValue;
    }
    
    NSString *APIUrl;
    if (fenxiangType == 1) {
        FNShareController* share  = [FNShareController new];
        share.fnuo_id = fnuo_id;
        share.getGoodsType=getGoodsType;
        share.SkipUIIdentifier=SkipUIIdentifier;
        if ([SkipUIIdentifier isEqualToString:@"buy_jingdong"]){
            share.yhq_url=[self.model valueForKey:@"yhq_url"];
        }
        [self.navigationController pushViewController:share animated:YES];
        [SVProgressHUD dismiss];
        return;
    }else if (fenxiangType == 2){
        if ([SkipUIIdentifier isEqualToString:@"buy_taobao"]) {
            [FNRequestTool startWithRequests:@[[self requestShareImg:fnuo_id :getGoodsType]] withFinishedBlock:^(NSArray *erros) {
                [self requestShareModel:fnuo_id :getGoodsType];
            }];
            return;
        }else if ([SkipUIIdentifier isEqualToString:@"buy_jingdong"]){
            APIUrl=@"mod=appapi&act=appJdGoodsDetail&ctrl=share";
        }else if ([SkipUIIdentifier isEqualToString:@"buy_pinduoduo"]){
            APIUrl=@"mod=appapi&act=appPddGoodsDetail&ctrl=share";
        }
    } else if (fenxiangType == 3) {
        FNShareViewController *vc = [[FNShareViewController alloc] init];
        vc.SkipUIIdentifier = SkipUIIdentifier;
        vc.fnuo_id = fnuo_id;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    } else{
        [SVProgressHUD show];
        if ([SkipUIIdentifier isEqualToString:@"buy_taobao"]) {
            NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"fnuo_id":fnuo_id,@"getGoodsType":getGoodsType,TokenKey:UserAccessToken,@"type":@0}];
           
            [FNRequestTool requestWithParams:params api:@"mod=appapi&act=fenxiang" respondType:(ResponseTypeModel) modelType:@"FNShareModel" success:^(id respondsObject) {
                //
                self.shareModel = respondsObject;
                self.shareView.model = respondsObject;
                self.shareImg=self.shareModel.share_img;
            } failure:^(NSString *error) {
                //
            } isHideTips:NO];
            return;
        }else if ([SkipUIIdentifier isEqualToString:@"buy_jingdong"]){
            APIUrl=@"mod=appapi&act=appJdGoodsDetail&ctrl=share";
        }else if ([SkipUIIdentifier isEqualToString:@"buy_pinduoduo"]){
            APIUrl=@"mod=appapi&act=appPddGoodsDetail&ctrl=share";
        }
    }
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"fnuo_id":fnuo_id,TokenKey:UserAccessToken}];
    if ([SkipUIIdentifier isEqualToString:@"buy_jingdong"]){
        params[@"yhq_url"]=yhq_url;
    }
    [FNRequestTool requestWithParams:params api:APIUrl respondType:(ResponseTypeModel) modelType:@"FNShareModel" success:^(id respondsObject) {
        //
        self.shareModel = respondsObject;
        self.shareView.model = respondsObject;
        self.shareImg=self.shareModel.share_img;
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
- (void)dgShareProductWithModel:(id)model{
    NSString* fnuo_url= [model valueForKey:@"fnuo_url"];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"tburl":fnuo_url,TokenKey:UserAccessToken}];
    [SVProgressHUD show];
    [FNRequestTool requestWithParams:params api:_api_home_productdetailtool respondType:(ResponseTypeModel) modelType:@"FNBaseProductModel" success:^(id respondsObject) {
        //
        [SVProgressHUD dismiss];
        FNBaseProductModel* mdoel  = respondsObject;
        
        NSString* tgid = [UserTid kr_isNotEmpty] ? UserTid:@"";
        
        NSString* url =mdoel.share_url?:[NSString stringWithFormat:@"%@%@%@",IP,registerPromotion,tgid];
        
        
        NSString *shareText = mdoel.goods_title;             //分享内嵌文字
        NSString *shareUrl = [NSString encodeToPercentEscapeString:url];
        
        [self umengShareWithURL:shareUrl image:mdoel.goods_img shareTitle:shareText andInfo:shareText];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}

#pragma mark - request
- (FNRequestTool *)requestShareImg:(NSString*)fnuo_id :(NSString*)getGoodsType{
    return [FNRequestTool requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"fnuo_id":fnuo_id,@"getGoodsType":getGoodsType}] api:@"mod=appapi&act=appHhr&ctrl=ercode" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        //
        self.shareImg = respondsObject[@"img"];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
- (FNRequestTool *)requestShareModel:(NSString*)fnuo_id :(NSString*)getGoodsType{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"fnuo_id":fnuo_id,@"getGoodsType":getGoodsType,TokenKey:UserAccessToken,@"type":@0}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=fenxiang" respondType:(ResponseTypeModel) modelType:@"FNShareModel" success:^(id respondsObject) {
        //
        self.shareModel = respondsObject;
        self.shareView.model = respondsObject;
       
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}

#pragma mark- js
-(void)addRoute:(UIWebView*)webView{

//    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"ObjC received message from JS: %@", data);
//        responseCallback(@"发送消息给JS");
//
//        NSString *identifier = [data objectForKey:@"identifier"];
//        //NSString *typeTwo = [data objectForKey:@"identifier2"];
//        /*if([typeTwo kr_isNotEmpty]){
//            identifier=typeTwo;
//        }*/
//        // 根据不同的标识跳转
//        [self jumpToActionFromWebJSMethod:identifier data:data];
//
//    }];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    [self.bridge setWebViewDelegate:self];
    [self.bridge registerHandler:@"WebViewJavascriptBridge" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"js call ObjC, data from js is :%@", data);

        NSString *identifier = [data objectForKey:@"identifier"];
        NSString *typeTwo = [data objectForKey:@"identifier2"];
        if([typeTwo kr_isNotEmpty]){
           identifier=typeTwo;
        }
        // 根据不同的标识跳转
        [self jumpToActionFromWebJSMethod:identifier data:data]; 
    }];
    
    

}

-(void)jumpToActionFromWebJSMethod:(NSString *)identifier data:(id)data{
    if ([identifier isEqualToString:@"share_tdj_success"]) {
        self.requestSuccessful = YES;
        [self productShare];
    }else if ([identifier isEqualToString:@"no_coupon_url"]){
        NSString* url = [data objectForKey:@"comFrom"];
        [self goTBDetailNotGetCouponWithUrl:url];
    }else if ([identifier isEqualToString:@"open_web"]){
        
        NSString* url = [data objectForKey:@"comFrom"];
        [self.deatilModel setValue:url forKey:@"bc_url"];
        [self openDetailWithModel:self.deatilModel];
        
    }
    else if([identifier isEqualToString:@"externalBrowser"]){
        NSString *yhq_url = [data valueForKey:@"comFrom"];
        [self goWebDetailWithWebType:@"0" URL:yhq_url];
    }
    else if([identifier isEqualToString:@"TaoLiJin"]){
        NSString* url = [data objectForKey:@"comFrom"];
        [self.deatilModel setValue:url forKey:@"bc_url"];
        [self openDetailWithModel:self.deatilModel];
    }
    NSString *string = data[@"comFrom"];
    NSData *jsonString = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id dict = [NSJSONSerialization JSONObjectWithData:jsonString options:0 error:&error];
    if (dict == nil || error) {
        NSLog(@"%@", error.localizedDescription);
        return;
    }
    if ([identifier isEqualToString:@"jump_goodsdetail"]) {
        NSString *url = dict[@"url"];
//        [self apiRequesteDetail:url];
        @weakify(self)
        [FNControllerManager apiRequesteDetail: url block: ^(UIViewController* controller) {
            @strongify(self)
            [self.navigationController pushViewController:controller animated: YES];
        }];
        
    } else if ([identifier isEqualToString:@"jump_SkipUIIdentifier"]) {
        //        FNBaseProductModel *model = [FNBaseProductModel mj_objectWithKeyValues:dict];
        [self loadOtherVCWithModel:dict andInfo:nil outBlock:nil];
    } else if ([identifier isEqualToString:@"app_share"]) {
        
        NSString *string = data[@"comFrom"];
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (dict == nil || error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        NSString *share_title = dict[@"share_title"];
        NSString *share_content = dict[@"share_content"];
        NSString *share_img = dict[@"share_img"];
        NSString *share_url = dict[@"share_url"];
        NSString *share_type = dict[@"share_type"];
        @weakify(self)
//        [self apiRequestShareList:^{
//            @strongify(self)
//            [self shareProduct:share_title withImage:share_img withContent:share_content andUrl:share_url];
//        }];
        [self apiRequestShareList: share_type block:^(NSArray *list) {
//            [self shareProduct:share_title withImage:share_img withContent:share_content andUrl:share_url];
            [self shareProduct:list withType: share_type withTitle:share_title withImage:share_img withContent:share_content andUrl:share_url];
        }];
        
    } else if ([identifier isEqualToString:@"wechat_pay"]) {
        [self startWxPayment:dict];
        _jsPayCallbackUrl = dict[@"url"];
    } else if ([identifier isEqualToString:@"alipay_topay"]) {
        _jsPayCallbackUrl = dict[@"url"];
        NSString *code = dict[@"code"];
        [self startAliPayment:code];
    }
}

// 微信支付
- (void)startWxPayment:(NSDictionary*) dataDic {
    NSString *partnerid = dataDic[@"partnerid"];
    NSString *nonce_str = dataDic[@"noncestr"];
    NSString *prepay_id = dataDic[@"prepayid"];
    NSString *sign = dataDic[@"sign"];
    NSString *timeStamp = dataDic[@"timestamp"];
    
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = partnerid;
    request.prepayId= prepay_id;
    request.package = @"Sign=WXPay";
    request.nonceStr= nonce_str;
    request.timeStamp= timeStamp.intValue;
    
    request.sign= sign;
    [WXApi sendReq: request];
}

- (void)onJSWxSuccess {
    [FNTipsView showTips:@"支付成功"];
    [self goWebWithUrl: _jsPayCallbackUrl];
}

- (void)onJSWxCancle {
    [FNTipsView showTips:@"取消支付"];
}

- (void)onJSWxFailed {
    [FNTipsView showTips:@"支付失败"];
}

//支付宝支付
-(void)startAliPayment: (NSString*) code{
    NSLog(@"BalanceoidString:%@",code);
    [[AlipaySDK defaultService] payOrder:code fromScheme:AlisdkSchemes callback:^(NSDictionary *resultDic) {
        XYLog(@"支付:%@",resultDic);
        if ([NSString checkIsSuccess:resultDic[@"resultStatus"] andElement:@"9000"] ) {
            [FNTipsView showTips:ResultStatusDict[@"9000"]];
            [FNTipsView showTips:@"支付成功"];
            
            [self goWebWithUrl: _jsPayCallbackUrl];
        }else{
            [SVProgressHUD dismiss];
            [FNTipsView showTips:ResultStatusDict[resultDic[@"resultStatus"] ] withDuration:2.0];
        }
    }];
}


- (FNRequestTool *)apiRequestShareList: (NSString*)shareType block: (void(^)(NSArray*)) block{
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey: UserAccessToken}];
    if ([shareType kr_isNotEmpty]) {
        params[@"share_type"] = shareType;
    }
    
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=share_list&ctrl=index" respondType:(ResponseTypeArray) modelType:@"FNSuperShareModel" success:^(id respondsObject) {
        @strongify(self);
//        self.shareList = respondsObject;
        block(respondsObject);
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO];
}

- (void) shareProduct: (NSArray<FNSuperShareModel*>*)shareList withType: (NSString*)shareType withTitle: (NSString*)share_title withImage: (NSString*)share_img withContent: (NSString*)share_content andUrl: (NSString*)share_url {
    NSMutableArray *images = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (FNSuperShareModel *share in shareList) {
        if ([share.is_show isEqualToString:@"1"]) {
            [images addObject:share.img];
            [titles addObject:share.title];
        }
    }
    @weakify(self)
    [FNNewFreeProductShareAlertView showImages:images withTitles:titles bottomOffset:0 onClick:^(NSInteger index) {
        @strongify(self)
        
        [FNNewFreeProductShareAlertView dismiss];
        FNSuperShareModel *share = shareList[index];
        
        if ([share.type isEqualToString:@"copy_url"]) {
            [UIPasteboard generalPasteboard].string = share_url;
            [FNTipsView showTips: @"复制成功"];
            return;
        } else if ([share.type isEqualToString:@"save_img"]) {
            [SDWebImageManager.sharedManager downloadImageWithURL:URL(share_img) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                @strongify(self)
                if(error){
                    [FNTipsView showTips:@"图片保存失败"];
                }else if (finished) {
                    NSString *name = [NSString stringWithFormat:@"%lf", [NSDate dateWithTimeIntervalSinceNow:0].timeIntervalSince1970];
                    [HXPhotoTools savePhotoToCustomAlbumWithName:name photo: image];
                    [FNTipsView showTips:@"保存成功"];
                }
            }];
            return;
        }
        
        UMSocialPlatformType type = 0;
        if ([share.share_platform isEqualToString:@"wechat"]) {
            type = UMSocialPlatformType_WechatSession;
        } else if ([share.share_platform isEqualToString:@"wechat_circle"]) {
            type = UMSocialPlatformType_WechatTimeLine;
        } else if ([share.share_platform isEqualToString:@"qq"]) {
            type = UMSocialPlatformType_QQ;
        } else if ([share.share_platform isEqualToString:@"sina"]) {
            type = UMSocialPlatformType_Sina;
        } else if ([share.share_platform isEqualToString:@"qq_qzone"]) {
            type = UMSocialPlatformType_Qzone;
        }
        
        
            
            
        [SDWebImageManager.sharedManager downloadImageWithURL:URL(share_img) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            @strongify(self)
            
            //创建分享消息对象
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            if ([shareType isEqualToString:@"share_img"] || [shareType isEqualToString:@"share_save"] ) {  //分享/保存图片

                UMShareImageObject* imgObject = [[UMShareImageObject  alloc]init];
                [imgObject setShareImage:image];
                messageObject.shareObject = imgObject;
                
            } else  {
                //创建网页内容对象
                UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:share_title descr:share_content thumImage:image];
                //设置网页地址
                shareObject.webpageUrl = share_url;
                //分享消息对象设置分享内容对象
                messageObject.shareObject = shareObject;

            }
            
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    NSLog(@"************Share fail with error %@*********",error);
                }else{
                    NSLog(@"response data is %@",data);
                }
            }];
            
        }];
        
        
        
    }];
}

-(void)goTBDetailNotGetCouponWithUrl:(NSString *)url{
    
    if ([FNBaseSettingModel settingInstance].appopentaobao_onoff.boolValue) {
        [self initBaiChuanSDKMethod:NO];
    }
    id<AlibcTradePage> page = [AlibcTradePageFactory page:url];
    
    id<AlibcTradeService> service = [AlibcTradeSDK sharedInstance].tradeService;
    AlibcTradeShowParams *showParams = [[AlibcTradeShowParams alloc] init];
    
    showParams.linkKey = @"taobao_scheme";
    showParams.openType = 1;
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
        vc.isNotCoupon = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (void)gologin{
//    LoginViewController *vc= [[LoginViewController alloc]init];
    FNLoginSecondController* vc = [FNLoginSecondController new];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)presentLogin {
    FNLoginSecondController* vc = [FNLoginSecondController new];
    [self presentViewController:vc animated:NO completion:nil];
}
-(void)loadOtherVCWithModel:(id)model andInfo:(id)info outBlock:(void (^)(id))block{
    
    NSString* SkipUIIdentifier = [model valueForKey:@"SkipUIIdentifier"];
    
    if ([NSString checkIsSuccess:SkipUIIdentifier andElement:@"pub_returnlastview"]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    SuperViewController *vc = [FNControllerManager controllerWithModel:model];
    
    if (vc == nil) {
        if ([SkipUIIdentifier isEqualToString:@"pub_wailian"]) {
            return ;
        }
        FNMCouponPurchaseController* coupon = [FNMCouponPurchaseController new];
        coupon.type=VCTypeCoupon;
        vc = coupon;
    }
    
    vc.understand = NO;
    vc.isNotHome = YES;
    
    if ([vc isKindOfClass: [lhScanQCodeViewController class]]) {
        ((lhScanQCodeViewController*)vc).delegate = self;
    }
    
    if ([vc isKindOfClass: [FNTBWebViewController class]]) {
        //淘宝外链，直接打开淘宝
        [(FNTBWebViewController*)vc openTB];
        return ;
    }
    
    UIViewController *parentController = [self getSuperController];
    UIViewController *rootController = [self.navigationController.viewControllers objectAtIndex:0];
    
    if (parentController == rootController) {
        NSArray *tabArr=[FNTabManager shareInstance].tabs;
        for (NSInteger index = 0; index < tabArr.count; index++) {
            FNTabModel *model = tabArr[index];
            if ([model.SkipUIIdentifier isEqualToString:SkipUIIdentifier]
                && ![vc isFullScreenShow]
                && ![SkipUIIdentifier isEqualToString:@"pub_wailian"]
                && ![SkipUIIdentifier isEqualToString:@"pub_taobao_wailian"] ) {
                self.tabBarController.selectedIndex = index;
                return;
            }
        }
    }
    
    
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 获取navigationtroller管理下的父控制器，防止出现一个控制器管理多个控制器的问题

 @return
 */
- (UIViewController *)getSuperController
{
    UIViewController *vc = nil;
    for (UIView* next = self.view; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return vc;
        }
        else if ([nextResponder isKindOfClass:[UIViewController class]]) {
            vc = (UIViewController*)nextResponder;
        }
    }
    return vc;
}

- (void)warnToLogin{
    
    JMAlertView* alert = [JMAlertView alertWithTitle:@"提示" content:@"要登录才能访问哦〜" firstTitle:@"取消" andSecondTitle:@"去登录" alertType:(AlertTypeAlert) clickBlock:^(NSInteger index) {
        if (index == 1) {
            [self gologin];
        }
    }];
    [alert showAlert];
    
}



- (void)loadMembershipUpgradeViewController {
    if ([FNCurrentVersion isEqualToString:Setting_checkVersion]) {
        FNPDDCategoryController* vc = [FNPDDCategoryController new];
        vc.SkipUIIdentifierString = @"pub_gettaobao";
        vc.keywordString = @"";
        vc.sortType = @"";
        vc.understand=NO;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        
        NSInteger iupdate_goods_onoffInt=[[FNBaseSettingModel settingInstance].update_goods_onoff integerValue];
        if (iupdate_goods_onoffInt == 3) {
            FNNewUpgradeGoodsNController *goodsVC=[[FNNewUpgradeGoodsNController alloc]init];
            [self.navigationController pushViewController:goodsVC animated:YES];
        } else {
            [FNTipsView showTips:@"升级更高等级享受分享赚"];
            FNMembershipUpgradeViewController* VC = [FNMembershipUpgradeViewController new];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
}


#pragma mark - Auth

- (void)refreshSetting: (void(^)(void)) block {
    [self refreshSetting:false block:block];
}

- (void)refreshSetting:(BOOL)is_share block: (void(^)(void)) block {
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    if (is_share) {
        params[@"is_share"] = @"1";
    }
    [FNRequestTool requestWithParams:params api:_api_others_getset respondType:(ResponseTypeModel) modelType:@"FNBaseSettingModel" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        FNBaseSettingModel* defaultModel = [FNBaseSettingModel settingInstance];
        FNBaseSettingModel* model = respondsObject;
//        model.tabs = defaultModel.tabs;
        model.ksrk = defaultModel.ksrk;
        model.tw = defaultModel.tw;
        [FNBaseSettingModel saveSetting:model];
        [[NSUserDefaults standardUserDefaults] setValue:model.extendreg forKey:XYextendreg];
        [[NSUserDefaults standardUserDefaults] setValue:model.appopentaobao_onoff forKey:XYappopentaobao_onoff];
        [[NSUserDefaults standardUserDefaults] setValue:model.WeChatAppSecret forKey:XYWeChatAppSecret];
        
        block();
        
    } failure:^(NSString *error) {
        
    } isHideTips:NO isCache: NO];
}

- (BOOL)showNeedSwitchAccount: (void(^)(BOOL)) block  {
    FNBaseSettingModel *setting = [FNBaseSettingModel settingInstance];
    if ([setting.tb_illegal isEqualToString:@"1"]) {
        
        NSString *errorMsg = [[NSUserDefaults standardUserDefaults] stringForKey:@"AUTH_FAIL_MSG"];
        
        FNAuthFailedAlertView *alert = [[FNAuthFailedAlertView alloc] init];
        @weakify(self)
        [alert showTitle:setting.realtion_oauth_error_str withDesc:errorMsg leftTitle:@"取消" rightTitle:@"重新授权" leftBlock:^{
         
        } rightBlock:^{
            @strongify(self)
            
            @weakify(self)
            [self setIllegal:NO block:^(BOOL result) {
                [[ALBBSDK sharedInstance] logoutWithCallback:^{
                    @strongify(self)
                    if ([setting.oauth_url kr_isNotEmpty] &&
                        ![FNCurrentVersion isEqualToString:Setting_checkVersion]) {
                        @weakify(self)
                        [self bcAuth:^{
                            FNAuthController *auth = [[FNAuthController alloc] init];
                            auth.url = setting.oauth_url;
                            auth.block = block;
                            [self_weak_.navigationController pushViewController:auth animated:YES];
                        }];
                    }
                    
                }];
            }];
            
            
            
        }];
        
        return YES;
    }
    
    return NO;
}

- (void)setIllegal: (BOOL)isIllegal block: (void(^)(BOOL)) block  {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey: UserAccessToken, @"tb_illegal": isIllegal ? @"add" : @"del" }];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=tb_illegal&ctrl=set" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        block(YES);
    } failure:^(NSString *error) {
        block(NO);
    } isHideTips:YES isCache:NO];
}

- (BOOL)showNeedAuth: (void(^)(BOOL)) block {
    
    FNBaseSettingModel *setting = [FNBaseSettingModel settingInstance];
    
    if ([setting.oauth_url kr_isNotEmpty] &&
        ![FNCurrentVersion isEqualToString:Setting_checkVersion]) {
        
        FNAuthAlertView *alert = [[FNAuthAlertView alloc] initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight)];
        @weakify(self)
        [alert showTitle:@"请完成淘宝授权" withDesc:setting.oauth_str block:^{
            @strongify(self)
            @weakify(self)
            [self bcAuth:^{
                FNAuthController *auth = [[FNAuthController alloc] init];
                auth.url = setting.oauth_url;
                auth.block = block;
                [self_weak_.navigationController pushViewController:auth animated:YES];
            }];
        }];

        return YES;
    } else {
        return NO;
    }
}


/**
 百川授权登录
 */
-(void)bcAuth: (void(^)())callback {
    
    if ([FNCurrentVersion isEqualToString:Setting_checkVersion]) {
        callback();
        return;
    }
    // 授权获取百川openId和token
    [[ALBBSDK sharedInstance]auth:self successCallback:^(ALBBSession *session) {
        ALBBUser *user = [session getUser];
        XYLog(@"getUser is %@",[session getUser]);
        
        [self requestSetAlibc:user.openId topAccessToken:user.topAccessToken nickname:user.nick callback:callback];
        
    } failureCallback:^(ALBBSession *session, NSError *error) {
        
    }];
    
}

- (void)requestSetAlibc: (NSString*)openId topAccessToken: (NSString*)topAccessToken nickname: (NSString*)nick callback:(void(^)())callback {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey: UserAccessToken, @"BC_OpenId": openId, @"BC_AccessToken": topAccessToken, @"tb_name": nick }];
    @weakify(self)
    [FNRequestTool requestWithParams:params api:@"mod=timer&act=bc_order&ctrl=set_open_id" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        
        callback();
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

//普通跳转
-(void)didFNSkipController:(NSString*)controller{
    if([controller kr_isNotEmpty]){
        UIViewController *vc = [NSClassFromString(controller) new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - lhScanQCodeViewControllerDelegate
- (void)didCodeScan:(NSString *)result {
    [self goWebWithUrl:result];
}

#pragma Js交互
//-(void)jumpToActionFromWebJSMethod:(NSString *)identifier data:(id)data{
//    NSString *string = data[@"comFrom"];
//    NSData *jsonString = [string dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *error;
//    id dict = [NSJSONSerialization JSONObjectWithData:jsonString options:0 error:&error];
//    if (dict == nil || error) {
//        NSLog(@"%@", error.localizedDescription);
//        return;
//    }
//    if ([identifier isEqualToString:@"jump_goodsdetail"]) {
//        NSString *url = dict[@"url"];
//        [self apiRequesteDetail:url];
//
//    } else if ([identifier isEqualToString:@"jump_SkipUIIdentifier"]) {
//        //        FNBaseProductModel *model = [FNBaseProductModel mj_objectWithKeyValues:dict];
//        [self loadOtherVCWithModel:dict andInfo:nil outBlock:nil];
//    }
//}


//- (void)apiRequesteDetail: (NSString*)url{
//    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"url": url}];
//
//    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_rebate_store&ctrl=check_tb_goods" respondType:ResponseTypeModel modelType:@"StoreWebModel" success:^(id respondsObject) {
//        StoreWebModel *store = respondsObject;
//        if (store.is_jump_detail.integerValue == 1) {
//            FNNewProDetailController* detail = [FNNewProDetailController new];
//            detail.fnuo_id = store.fnuo_id;
//            detail.getGoodsType = @"";
//            detail.goods_title = @"";
//            if ([store.shop_type isEqualToString:@"jd"])
//                detail.SkipUIIdentifier = @"buy_jingdong";
//            else
//                detail.SkipUIIdentifier = @"";
//            [self.navigationController pushViewController:detail animated:YES];
//
//        } else {
//            [self goProductVCWithModel:store];
//        }
//    } failure:^(NSString *error) {
//
//    } isHideTips:NO isCache:NO];
//}

@end
