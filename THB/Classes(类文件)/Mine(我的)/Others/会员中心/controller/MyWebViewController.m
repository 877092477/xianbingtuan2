//
//  MyWebViewController.m
//  ALBBSDKPrivateAPIDemo
//
//  Created by zhoulai on 15/10/27.
//  Copyright © 2015年 Alibaba. All rights reserved.
//
#define UIColorFromRGB(rgbValue)                                       \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0    \
blue:((float)(rgbValue & 0xFF)) / 255.0             \
alpha:1.0]


#import "MyWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "D3Generator.h"
#import "NSObject+D3.h"

@interface MyWebViewController ()

@property (nonatomic, strong) UIWebView *webView;

@property(nonatomic,strong)WebViewJavascriptBridge *bridge;

@end

@implementation MyWebViewController

- (void)dealloc {
    
    _webView.delegate = nil;
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

-(void)postOrderMethod:(NSString *)orderNum{
    NSString* str=orderNum;
    //1. 去掉首尾空格和换行符
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //2. 去掉所有空格和换行符
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];

    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"oid":str,
                                                                                 @"token":UserAccessToken}];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_tbrecord successBlock:^(id responseBody) {
        XYLog(@"responseBody is%@",responseBody);
        
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect frame = self.view.bounds;
    id<AlibcTradePage> page = [AlibcTradePageFactory page:self.openUrl];
    id<AlibcTradeService> service = [AlibcTradeSDK sharedInstance].tradeService;
    AlibcTradeShowParams *showParams = [[AlibcTradeShowParams alloc] init];
    showParams.isNeedPush = YES;
    showParams.openType =0;
    // 绑定WebView
    // @return 0标识跳转到手淘打开了,1标识用h5打开,-1标识出错
    [service
     show:showParams.isNeedPush ? self.navigationController : self
     webView:self.webView
     page:page
     showParams:showParams
     taoKeParams:nil
     trackParam:nil
     tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
         NSString *order=[NSString stringWithFormat:@"%@",result.payResult.paySuccessOrders];
         [self getPayResultInfoMethod:order];

         [self.navigationController popViewControllerAnimated:NO];
         [self.navigationController dismissViewControllerAnimated:NO completion:^{
             
         }];
     }
     tradeProcessFailedCallback:^(NSError * _Nullable error) {
         NSDictionary *userInfo = error.userInfo;
         NSString *order=[NSString stringWithFormat:@"%@",[userInfo objectForKey:@"orderIdList"]];
         [self getPayResultInfoMethod:order];
//         [self getWebHTMLInfoMethod];
         [self.navigationController popViewControllerAnimated:NO];
         [self.navigationController dismissViewControllerAnimated:NO completion:^{
         }];

     }];

    
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height )];
    _webView.autoresizingMask =  UIViewAutoresizingFlexibleHeight;
    [_webView setBackgroundColor:UIColorFromRGB(0xeeeeee)];
    _webView.scrollView.scrollEnabled=YES;
    [self.view addSubview:_webView];
    _webView.delegate=self;
    [self addRoute:_webView];

    // _webViewProxy=[[MyWebviewProxy alloc] initWithWebview:_webView];
//    [self loadUrl];
    [self initNavView];
}

-(void)addRoute:(UIWebView*)webView{
    /*_bridge = [WebViewJavascriptBridge bridgeForWebView:webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC received message from JS: %@", data);
        [D3Generator createViewControllerWithDictAndPush:data];

        //        if ([data[@"className"] isEqualToString:@"HightRebatesViewController"]) {
        //            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainHRB" bundle:nil];
        //            HightRebatesViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SecondVC"];
        //            //        HightRebatesViewController *vc = [[HightRebatesViewController alloc]init];
        //            vc.type = 3;//分类名类型
        //            vc.title = @"超高返";
        //            [self.navigationController pushViewController:vc animated:YES];
        //        }
        responseCallback(@"发送消息给JS");
        
    }];*/
}




-(void)initNavView
{
    
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage: [UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(0, 0, 21, 21);
    [leftbutton addTarget:self action:@selector(LeftBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
}
-(void)LeftBtnMethod:(UIButton *)sender
{
    
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:NO];
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];    }
    
}

-(void)getWebHTMLInfoMethod{
    
    NSURL *url =[[NSURL alloc] initWithString:@"https://buyertrade.taobao.com/trade/itemlist/list_bought_items.htm?spm=a21bo.50862.1997525045.2.seHJMH"];
    NSURLRequest *request =  [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    self.webView.hidden = YES;
    NSString *allHtml = @"document.documentElement.innerHTML";
    NSString *allHtmlInfo = [self.webView stringByEvaluatingJavaScriptFromString:allHtml];
    NSLog(@"allHtmlInfo is %@",allHtmlInfo);
    [SVProgressHUD dismiss];

}

-(void)getPayResultInfoMethod:(NSString *) orderInfo{
    if (![orderInfo isEqualToString:@"(null)"]) {
        [self postOrderMethod:orderInfo];
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) loadUrl{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.openUrl]];
    [_webView loadRequest:request];
    //[_webViewProxy loadRequest:request];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma mark -  UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    BOOL isAllowLoadURLRequest=YES;
    //另外一种拦截调用方式，请先注销    [[[ALBBSDK sharedInstance] getService:@protocol(ALBBWebViewService)] bindLoginService:_webView sourceViewController:self];
    
    //先执行开发者自己的拦截逻辑
    
    //最后加载前调用百川的拦截逻辑
    [self getWebHTMLInfoMethod];
    //    isAllowLoadURLRequest=[[[ALBBSDK sharedInstance] getService:@protocol(ALBBWebViewService)] isAllowLoadURLRequest:[request URL] webview:webView sourceViewController:self];
    
    
    //    isAllowLoadURLRequest=[[[ALBBSDK sharedInstance] getService:@protocol(ALBBWebViewService)] isAllowLoadURLRequest:[request URL] webviewProxy:_webViewProxy sourceViewController:self];
    return isAllowLoadURLRequest;
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [SVProgressHUD show];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
    //    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.mode = MBProgressHUDModeIndeterminate;
    //    hud.labelText = @"加载失败，请重新刷新页面";
    //    [hud hide:YES afterDelay:2];
    //    [self.view addSubview:hud];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad is %@",webView);
    [self.webView.scrollView.mj_header endRefreshing];
    //获取标题
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [SVProgressHUD dismiss];
    NSString *allHtml = @"document.documentElement.innerHTML";
    NSString *allHtmlInfo = [self.webView stringByEvaluatingJavaScriptFromString:allHtml];
    NSLog(@"allHtmlInfo is %@",allHtmlInfo);

    
}



@end
