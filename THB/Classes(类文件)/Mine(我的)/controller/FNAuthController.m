//
//  FNAuthController.m
//  THB
//
//  Created by Weller Zhao on 2019/1/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNAuthController.h"
#import "FNAuthFailedAlertView.h"

@interface FNAuthController () <NSURLConnectionDataDelegate>

@end

@implementation FNAuthController

#pragma mark - Web view delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"FNAuthController should request is %@",request.URL);
    NSString *url = request.URL.absoluteString;
    if ([url containsString:@"tbopen://m.taobao.com/tbopen/index.html"] ||
        [url containsString:@"tmall://page.tm/appLink"] ||
        [url containsString:@"alipays://platformapi/startapp"]) {
        return NO;
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [SVProgressHUD dismiss];
    
    NSString *currentURL = webView.request.URL.absoluteString;
    if ([currentURL containsString:@"comm/tbredirect.php"] &&
        ![currentURL containsString:@"oauth.m.taobao.com"] &&
        ![currentURL containsString:@"oauth.taobao.com"]) {
        
        NSString *allHtml = @"document.documentElement.innerText";
        NSString *allHtmlInfo = [webView stringByEvaluatingJavaScriptFromString:allHtml];
        
        @weakify(self)
        [self refreshSetting:^{
            @strongify(self)
            [self showResult:allHtmlInfo];
        }];
    }
}

- (void)showResult: (NSString*)msg {
    
    [NSNotificationCenter.defaultCenter postNotificationName:@"UserDidAuth" object:nil];
    
    @weakify(self)
    [self bcAuth:^{
        @strongify(self)
        if ([msg containsString:@"成功"]) {
            [self showSuccess:msg];
        } else {
            [self showFailed: msg];
        }
    }];
    
}

- (void)showSuccess: (NSString*)msg {
    [FNTipsView showTips:msg];
    [self.navigationController popViewControllerAnimated:YES];
    
    if (_block) {
        _block(YES);
        _block = nil;
    }
}

- (void)showFailed: (NSString*)msg {
    [[NSUserDefaults standardUserDefaults] setObject:msg forKey:@"AUTH_FAIL_MSG"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    @weakify(self)
    [self setIllegal:YES block:^(BOOL result) {
        @strongify(self)
        if (self.block) {
            self.block(NO);
            self.block = nil;
        }
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
//    FNAuthFailedAlertView *alert = [[FNAuthFailedAlertView alloc] init];
//    FNBaseSettingModel *setting = [FNBaseSettingModel settingInstance];
//    @weakify(self)
//
//    [alert showTitle:setting.realtion_oauth_error_str withDesc:msg leftTitle:@"确定" rightTitle:@"" leftBlock:^{
//        @strongify(self)
//        [self.navigationController popViewControllerAnimated:YES];
//    } rightBlock:^{
//
//    }];
}

//-(void)returnAction {
//    [super returnAction];
//    [self showResult:@""];
//}
//- (void)dismissAll {
//    [super dismissAll];
//    [self showResult:@""];
//}

@end
