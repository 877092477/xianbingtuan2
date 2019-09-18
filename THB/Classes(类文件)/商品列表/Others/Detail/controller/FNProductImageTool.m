//
//  FNProductImageTool.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/17.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNProductImageTool.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "WKWebViewJavascriptBridge.h"

@interface FNProductImageTool ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *hideWebview;
@property (nonatomic, strong) WKWebViewJavascriptBridge *bridge;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, strong) ImageBlock block;

@end

@implementation FNProductImageTool

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    //1、该对象提供了通过js向web view发送消息的途径
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    //添加在js中操作的对象名称，通过该对象来向web view发送消息
    [userContentController addScriptMessageHandler:self name:@"WebViewJavascriptBridge"];
    
    //2、
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    config.userContentController = userContentController;
    config.allowsInlineMediaPlayback = YES;
    
    self.hideWebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight) configuration:config];
    [self addSubview:self.hideWebview];
    
//    NSString *url =[NSString stringWithFormat:@"%@%@%@",IP,_api_showorder_WirteCache,UserAccessToken];
//    NSURL *webUrl = [NSURL URLWithString:url];
//    NSURLRequest *request =[NSURLRequest requestWithURL:webUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
//
//    [self.hideWebview loadRequest:request];
    self.hideWebview.UIDelegate = self;
    self.hideWebview.navigationDelegate = self;
    self.hideWebview.hidden = YES;

}

- (void)loadUrl: (NSString*)url block: (ImageBlock) block {
//    NSString *url =[NSString stringWithFormat:@"%@%@%@",IP,_api_showorder_WirteCache,UserAccessToken];
    self.block = block;
    NSURL *webUrl = [NSURL URLWithString:url];
    NSURLRequest *request =[NSURLRequest requestWithURL:webUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    [self.hideWebview loadRequest:request];
}

- (void)getImages {
    NSString *base64 = [FNBaseSettingModel settingInstance].tb_detail_js;
    
    NSString *jsFunctStr= [base64 kr_decodeBase64];
    @weakify(self)
    [self.hideWebview evaluateJavaScript:jsFunctStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        @strongify(self)
        if (error) {
            NSLog(@"sendMessage error: %@", error);
        }
        NSLog(@"===%@", result);
    }];
}

#pragma mark - Web view delegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}
// 当内容开始到达时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSString *currentURL = webView.URL.absoluteString;
    NSLog(@"????? %@", currentURL);
    [self getImages];
    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.hideWebview];
    [self.bridge setWebViewDelegate:self];
    @weakify(self)
    [self.bridge registerHandler:@"WebViewJavascriptBridge" handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self)

        NSString *identifier = [data objectForKey:@"identifier"];
        if ([identifier isEqualToString:@"tb_detail"]) {
            NSString* content = [data objectForKey:@"comFrom"];
            NSData *d = [content dataUsingEncoding:NSUTF8StringEncoding];
            NSArray<NSString*>* json = [NSJSONSerialization JSONObjectWithData:d options:0 error:nil];
            if (self.block) {
                self.block(json);
            }
        }
    }];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailProvisionalNavigation %@", error.localizedDescription);
    [webView reload];
}


@end
