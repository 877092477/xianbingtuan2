//
//  FNmakeSingleDeController.m
//  THB
//
//  Created by Jimmy on 2018/12/19.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//单页
#import "FNmakeSingleDeController.h"
#import "FNshareMakeDeView.h"
//分享
#import "JhPageItemModel.h"
#import "MJExtension.h"
#import "JhScrollActionSheetView.h"
@interface FNmakeSingleDeController ()<UIWebViewDelegate,FNshareMakeDeViewDelegate>
@end

@implementation FNmakeSingleDeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    [self initializedSubviews];
}

#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.scrollView.scrollEnabled = YES;
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    [self loadUrl];
    
    __unsafe_unretained UIScrollView *scrollView = self.webView.scrollView;
    [self.view addSubview:self.webView];

    scrollView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.webView reload];
    }];
}
-(void)setupNav{
    //self.title=self.title;
    UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setImage: [UIImage imageNamed:@"FN_makeShare_img"] forState:UIControlStateNormal];
    rightbtn.frame=CGRectMake(0, 0, 30, 30);
    [rightbtn addTarget:self action:@selector(rightbtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
}
-(void)rightbtnAction{
    XYLog(@"分享");
    FNshareMakeDeView *alertView =[FNshareMakeDeView popoverView];
    alertView.itemWidth=80;
    alertView.currentH=185;
    alertView.backgroundColor=[UIColor clearColor];
    alertView.delegate=self;
    alertView.showShade = YES; // 显示阴影背景
    [alertView showWithActions];
    
    //朋友圈分享
//    NSArray *data = @[@{@"text" : @"微信",@"img" : @"FJ_wximg"},@{@"text" : @"朋友圈",@"img" : @"FJ_pyimg"},@{@"text" : @"QQ",@"img" : @"FJ_qqimg"},@{@"text" : @"微博",@"img" : @"FJ_wbimg"},@{@"text" : @"保存图片",@"img" : @"FJ_bcimg"}];
//    NSMutableArray *shareArray=[NSMutableArray arrayWithCapacity:0];
//    shareArray = [JhPageItemModel mj_objectArrayWithKeyValuesArray:data];
//    NSString *hintString=@"注：由于新版微信调整了分享策略，如遇到多图无法分享至朋友圈，请先保存图片再打开微信分享。";
//    [JhScrollActionSheetView  showShareActionSheetWithTitle:@"分享方式" withdescribe:hintString shareDataArray:shareArray handler:^(JhScrollActionSheetView *actionSheet, NSInteger index) {
//        NSLog(@" 点击分享 index %ld ",(long)index);
//    }];
    
}
//FNshareMakeDeViewDelegate
// 分享
-(void)shareBtnClick:(NSInteger)sender{
    UMSocialPlatformType type=UMSocialPlatformType_WechatSession;
    if (sender==0) {
        type=UMSocialPlatformType_WechatSession;
    }else if (sender==1) {
        type=UMSocialPlatformType_WechatTimeLine;
    }else if (sender==2) {
        type=UMSocialPlatformType_QQ;
    }
    else if (sender==3) {
        type=UMSocialPlatformType_Sina;
    }
    else if (sender==4) {
        type=UMSocialPlatformType_Qzone;
    }
    [self umengShareWithURL:self.url image:nil shareTitle:nil andInfo:nil withType:type];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.webView.scrollView.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad is %@",webView.request.URL);
    [self.webView.scrollView.mj_header endRefreshing];
    //获取标题
    //self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [SVProgressHUD dismiss];
}
-(void)loadUrl{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];//@"https://www.baidu.com"
    [_webView loadRequest:request]; 
}

@end
