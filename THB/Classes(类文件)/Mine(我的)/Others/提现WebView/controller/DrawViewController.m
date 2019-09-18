//
//  DrawViewController.m
//  THB
//
//  Created by zhongxueyu on 16/4/15.
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


#import "DrawViewController.h"
#import "secondViewController.h"
#import "ProfileViewController.h"
@interface DrawViewController ()<UIWebViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) UIWebView *webView;
@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //注册通知
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(tongzhi:) name:@"PushProfile" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    //支持3DTouch
    if (iOS9) {
        self.webView.allowsLinkPreview = YES;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    //    NSURL  *url = self.url;
    //    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    //    self.webView.delegate = self;
    
    NSURL *webUrl = [NSURL URLWithString:self.url];
    NSURLRequest *request =[NSURLRequest requestWithURL:webUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    __unsafe_unretained UIWebView *webView = self.webView;
    webView.delegate = self;
    [webView loadRequest:request];
    __unsafe_unretained UIScrollView *scrollView = self.webView.scrollView;
    [self setupNav];
    [self.view addSubview:self.webView];
    scrollView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [webView reload];
    }];
    
    //    [scrollView.mj_header beginRefreshing];
    
}
/**
 *  接收搜索结果
 *
 *  @param noti <#noti description#>
 */
- (void)tongzhi:(NSNotification *)noti{
    XYLog(@"－－－－－push成功------");
    ProfileViewController *vc = [[ProfileViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
}
-(void)setupNav{
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage: [UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(0, 0, 25, 25);
    [leftbutton addTarget:self action:@selector(SaoMiao) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    [rightbutton setTitle:@"提现记录" forState:UIControlStateNormal];
    rightbutton.titleLabel.font = kFONT15;
    [rightbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(RightBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    
    //TitleView
    //    UIImageView *titleView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 198, 28)];
    //    titleView.image=[UIImage imageNamed:@"nav_search"];
    //    self.navigationItem.titleView=titleView;
    
    
}

-(void)SaoMiao{
    
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    //    [self.navigationController popViewControllerAnimated:YES];
}

-(void)RightBtnMethod{
    secondViewController *vc = [[secondViewController alloc]init];
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@",IP,_api_mine_DrawHistory,UserAccessToken];
    vc.url = urlString;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = NO;
    
    if (iOS7) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    }
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"second should request is %@",request.URL);
    NSLog(@"navtype is %ld",(long)navigationType);
    return YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.webView.scrollView.mj_header endRefreshing];
    //    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self.webView stopLoading];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [SVProgressHUD show];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.webView.scrollView.mj_header endRefreshing];
    //    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.mode = MBProgressHUDModeIndeterminate;
    //    hud.labelText = @"加载失败，请重新刷新页面";
    //    [hud hide:YES afterDelay:2];
    //    [self.view addSubview:hud];
    [SVProgressHUD dismiss];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad is %@",webView);
    [self.webView.scrollView.mj_header endRefreshing];
    //获取标题
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [SVProgressHUD dismiss];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@interface UIWebView (JavaScriptAlert)

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect *)frame;

@end

@implementation UIWebView (JavaScriptAlert)

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect *)frame {
    UIAlertView* customAlert;
    if ([message isEqualToString:@"没有绑定支付宝，请先绑定"]) {
        customAlert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        XYLog(@"message is %@",message);
    }else {
        customAlert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        XYLog(@"message is %@",message);
    }
    
    [customAlert show];
    
    
    
}

//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    MyLikeListModel *model = self.dataArray
    
        XYLog(@"点击事件123");
    NSNotification *notification =[NSNotification notificationWithName:@"PushProfile" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}
@end
