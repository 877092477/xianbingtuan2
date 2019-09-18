//
//  FNVideoWebController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/1.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNVideoWebController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "WKWebViewJavascriptBridge.h"

@interface FNVideoWebController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *hideWebview;
@property (nonatomic, strong) WKWebViewJavascriptBridge *bridge;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, copy) NSString* videoUrl;

@end

@implementation FNVideoWebController

- (BOOL)isFullScreenShow {
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [self.title kr_isNotEmpty] ? self.title : [FNBaseSettingModel settingInstance].movie_top_str;
    
    //1、该对象提供了通过js向web view发送消息的途径
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    //添加在js中操作的对象名称，通过该对象来向web view发送消息
    [userContentController addScriptMessageHandler:self name:@"WebViewJavascriptBridge"];
    
    //2、
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    config.userContentController = userContentController;
    config.allowsInlineMediaPlayback = YES;
    
    self.hideWebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight) configuration:config];
    [self.view addSubview:self.hideWebview];
    
    NSString *url =[NSString stringWithFormat:@"%@%@%@",IP,_api_showorder_WirteCache,UserAccessToken];
    NSURL *webUrl = [NSURL URLWithString:url];
    NSURLRequest *request =[NSURLRequest requestWithURL:webUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    [self.hideWebview loadRequest:request];
    self.hideWebview.UIDelegate = self;
    self.hideWebview.navigationDelegate = self;
    self.hideWebview.hidden = YES;
    
    _button = [[UIButton alloc] init];
    [_button setImage:IMAGE(@"button_video_play") forState:UIControlStateNormal];
    [self.view addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.bottom.equalTo(@-100);
    }];
    [_button addTarget:self action:@selector(showVideo)];
    _button.hidden = YES;
}

- (void)showVideo {
    if ([_videoUrl kr_isNotEmpty]) {
//        NSURLRequest *request =[NSURLRequest requestWithURL:URL(_videoUrl) cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
//        [self.webView loadRequest:request];
        self.url = _videoUrl;
        [self loadUrl];
    }
}

- (void)checkMovie: (NSString*)url {
    NSString *jsFunctStr=[NSString stringWithFormat: @"movie_check('%@', 'ios')", url];
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
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"second should request is %@",request.URL);
    NSLog(@"navtype is %ld",(long)navigationType);
    if ([request.URL.absoluteString containsString:@"https://"] ||
        [request.URL.absoluteString containsString:@"http://"]) {
        return YES;
    }
    
    return NO;
}


-(void)webViewDidStartLoad:(UIWebView *)webView{
    self.button.hidden = YES;
    self.videoUrl = @"";
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.webView.scrollView.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad is %@",webView.request.URL);
    
    [self checkMovie:webView.request.URL.absoluteString];
    [self.webView.scrollView.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    
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
    if ([currentURL containsString:_api_showorder_WirteCache]) {
        NSLog(@"缓存写入成功");
        
        NSString *url = @"mod=appapi&act=movie&ctrl=js";
        NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        urlStr = [[NSMutableString stringWithString:IP] stringByAppendingFormat:@"%@",url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                        [NSURL URLWithString: urlStr]];
        [self.hideWebview loadRequest:request];
        
        return;
    }
    
    if ([currentURL containsString:@"mod=appapi&act=movie&ctrl=js"]) {
        self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.hideWebview];
        [self.bridge setWebViewDelegate:self];
        @weakify(self)
        [self.bridge registerHandler:@"WebViewJavascriptBridge" handler:^(id data, WVJBResponseCallback responseCallback) {
            @strongify(self)
            
            NSString *identifier = [data objectForKey:@"identifier"];
            if ([identifier isEqualToString:@"app_movie"]) {
                NSString* content = [data objectForKey:@"comFrom"];
                NSLog(@"!!! %@", content);
                NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (json) {
                    NSString *js = [json objectForKey:@"js"];
                    self.videoUrl = [json objectForKey:@"url"];
                    [self.webView stringByEvaluatingJavaScriptFromString:js];
                    self.button.hidden = NO;
//                    [self.webView stringByEvaluatingJavaScriptFromString:@"app_movie()"];
                }
            }
        }];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailProvisionalNavigation %@", error.localizedDescription);
    [webView reload];
}

@end
