//
//  StoreWebViewController.m
//  THB
//
//  Created by Weller Zhao on 2018/12/29.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "StoreWebViewController.h"
#import "StoreWebModel.h"
#import "FNNewProDetailController.h"
#import "FNNewProDetailWebController.h"
#import <AlibabaAuthSDK/ALBBSDK.h>
#import "WebViewJavascriptBridge.h"
#import "FNControllerManager.h"

@interface StoreWebViewController ()<UIWebViewDelegate>

@property (nonatomic, assign) BOOL isFirst;

@property(nonatomic,strong)WebViewJavascriptBridge *bridge;
@property (nonatomic, strong) NSString *allHtmlInfo;

@end

@implementation StoreWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isFirst = YES;
     
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
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

- (BOOL)isFullScreenShow {
    return YES;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_isFirst) {
        _isFirst = NO;
        return;
    }

    
    if (![_allHtmlInfo kr_isNotEmpty]) {
        if (self.webView.canGoBack) {
            [self.webView goBack];
        }else {
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
}

#pragma mark - Web view delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [super webViewDidFinishLoad: webView];
    
    NSString *allHtml = @"document.documentElement.innerText";
    _allHtmlInfo = [self.webView stringByEvaluatingJavaScriptFromString:allHtml];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"StoreWebViewController webView will load %@",request.URL);
    NSLog(@"navtype is %ld",(long)navigationType);
    NSString *url = request.URL.absoluteString;
    if ([url containsString:@"tbopen://m.taobao.com/tbopen/index.html"] ||
        [url containsString:@"taobaotravel://"] ||
        [url containsString:@"tmall://page.tm/appLink"]) {
        return NO;
    } else if ([url containsString:@"taobao.com/awp/core/detail.htm"] ||
               [url containsString:@"tmall.com/item.htm"] ||
               [url containsString:@"detail.tmall.hk/hk/item.htm"] ||
               [url containsString:@"detail.m.tmall.hk/item.htm"] ||
               [url containsString:@"item.m.jd.com/product"] ||
               [url containsString:@"h5.m.taobao.com/trip/travel-detail/index/index.htm"] ||
               ([url containsString:@"item.m.jd.com/ware/view.action"] && [url containsString:@"wareId="])) {
//        [self apiRequesteDetail:url];
        @weakify(self)
        [FNControllerManager apiRequesteDetail: url block: ^(UIViewController* controller) {
            @strongify(self)
//            self.isNavHidden = YES;
//            [self.navigationController setNavigationBarHidden:YES animated:YES];
//            [self.view addSubview: controller.view];
            [self.navigationController pushViewController: controller animated: YES];
        }];
        return NO;
    } else if ([url containsString:@"login.taobao.com/member/login.jhtml"] ||
               [url containsString:@"login.m.taobao.com/login.htm"]) {
        [[ALBBSDK sharedInstance] auth:self successCallback:^(ALBBSession *session) {
            [self.webView reload];
        } failureCallback:^(ALBBSession *session, NSError *error) {
            
        }];
        return NO;
    } else if ([url containsString:@"pinduoduo://"]) {
        [[UIApplication sharedApplication] openURL:URL(url)];
        [self.navigationController popViewControllerAnimated:NO];
        return NO;
    }
    else {
        return YES;
    }
}

//- (void)apiRequesteDetail: (NSString*)url{
//    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"url": url}];
//
//    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_rebate_store&ctrl=check_tb_goods" respondType:ResponseTypeModel modelType:@"StoreWebModel" success:^(id respondsObject) {
//        StoreWebModel *store = respondsObject;
//        UIViewController *vc;
//        if (store.is_jump_detail.integerValue == 1) {
//            FNNewProDetailController* detail = [FNNewProDetailController new];
//            detail.fnuo_id = store.fnuo_id;
//            detail.getGoodsType = @"";
//            detail.goods_title = @"";
//            if ([store.shop_type isEqualToString:@"jd"])
//                detail.SkipUIIdentifier = @"buy_jingdong";
//            else
//                detail.SkipUIIdentifier = @"";
////            [self.navigationController pushViewController:detail animated:YES];
//            vc = detail;
//
//        } else {
//            vc = [FNControllerManager goProductVCWithModel:store];
//        }
//
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        [self.view addSubview: vc.view];
//
//    } failure:^(NSString *error) {
//
//    } isHideTips:NO isCache:NO];
//}

@end
