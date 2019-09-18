//
//  FNTBWebViewController.m
//  新版嗨如意
//
//  Created by Weller on 2019/5/31.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNTBWebViewController.h"
#import "FNControllerManager.h"
#import "StoreWebViewController.h"
#import "secondViewController.h"

@interface FNTBWebViewController ()

@end

@implementation FNTBWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self openTB];
}


- (BOOL)isFullScreenShow {
    return YES;
}

- (void)openTB {
    NSString *url = _url;
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
//    showParams.openType = AlibcOpenTypeH5;
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
                         vc.orderNum = [self getOrderNumMethod:order];
                         
                         [vc initWebViewMethod];
                     }
                     tradeProcessFailedCallback:^(NSError * _Nullable error) {
                         NSDictionary *userInfo = error.userInfo;
                         NSString *order=[NSString stringWithFormat:@"%@",[userInfo objectForKey:@"orderIdList"]];
                         
                         vc.orderNum = [self getOrderNumMethod:order];
                         [vc initWebViewMethod];
                     }];
    // @return 0标识跳转到手淘打开了,1标识用h5打开,-1标识出错
    if (res == 1) {
        vc.isShow = YES;
        vc.isWeb = YES;
//        return vc;
//        [[UIViewController currentViewController].navigationController pushViewController:vc animated:NO];
        secondViewController *store = [[secondViewController alloc] init];
        store.url = url;
        [[UIViewController currentViewController].navigationController pushViewController:store animated:NO];
    }
}


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
