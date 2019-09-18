//
//  secondViewController.m
//  FQSW
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

#import "secondViewController.h"

#import "JMProductRebateRuleController.h"

#import "WebViewJavascriptBridge.h"
#import "D3Generator.h"
#import "ALBBDetailsViewController.h"

#import "FNAPIHome.h"
#import "JMProductDetailToolView.h"
#import "JMProductDetailModel.h"
#import "FNLoginSecondController.h"
#import "FNCustomeNavigationBar.h"
#import "FNWebviewProgressView.h"
#import "FNWebViewHeaderModel.h"

#import "SDWebImage/UIButton+WebCache.h"

@interface secondViewController ()<UIWebViewDelegate, UIScrollViewDelegate>


@property (nonatomic, strong)JMProductDetailToolView*  toolView;
@property (nonatomic, strong)NSLayoutConstraint* toolViewHeightCons;
@property(nonatomic,strong)WebViewJavascriptBridge *bridge;
@property (nonatomic, strong)JMProductDetailModel* model;
@property (nonatomic, strong) UIView* rebateBgView;
@property (nonatomic, strong) UIView* rebateView;

@property (nonatomic,strong) FNWebviewProgressView  *progressView;


@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton* backBtn;
@property (nonatomic, strong)UIButton* closeBtn;
@property (nonatomic, strong)UILabel* lblTitle;

//@property (nonatomic, copy) NSString *outlink_style;
@property (nonatomic, strong)UIColor *fromNavColor;
@property (nonatomic, strong)UIColor *toNavColor;
@property (nonatomic, strong)UIColor *fromTextColor;
@property (nonatomic, strong)UIColor *toTextColor;
@property (nonatomic, strong)FNWebViewHeaderModel *headerModel;

@end

@implementation secondViewController
#pragma mark - setter && getter
- (void)setModel:(JMProductDetailModel *)model{
    _model = model;
    _toolView.model = _model;
    
}
- (void)setIsBottom:(BOOL)isBottom{
    _isBottom = isBottom;
    if (_isBottom) {
        _toolViewHeightCons.constant = 44;
        _toolView.hidden = NO;
    }else{
        _toolViewHeightCons.constant = 0;
        _toolView.hidden = YES;
    }
}
#pragma mark - system
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //
    // 默认渐变前与渐变后颜色一样
    
    if ([_jsonInfo kr_isNotEmpty]) {
        NSData *data = [_jsonInfo dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error == nil && json) {
            self.headerModel = [FNWebViewHeaderModel mj_objectWithKeyValues:json];
//            _outlink_style = json[@"outlink_style"];
            NSString *outlink_check_fontcolor = _headerModel.outlink_check_fontcolor;
            NSString *outlink_check_bgcolor = _headerModel.outlink_check_bgcolor;
            
            _fromNavColor = [[UIColor colorWithHexString:outlink_check_bgcolor] colorWithAlphaComponent:0];
            _toNavColor = [UIColor colorWithHexString:outlink_check_bgcolor];
            
            
            _fromTextColor = [[UIColor colorWithHexString:outlink_check_fontcolor] colorWithAlphaComponent:0];
            _toTextColor = [UIColor colorWithHexString:outlink_check_fontcolor];
            
            self.navigationView.backgroundColor = _fromNavColor;
            self.navigationView.titleLabel.textColor = _fromTextColor;
        }
    }

    [self initializedSubviews];
    [self setupNav];
    
    //监听UIWindow隐藏
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(endFullScreen) name:UIWindowDidBecomeHiddenNotification object:nil];
}

-(void)endFullScreen{
    NSLog(@"退出全屏");
    [[UIApplication sharedApplication]setStatusBarHidden:false animated:false];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    _webView.delegate = nil;
}

- (void)addSwitch{
    UIView* noteView = [UIView new];
    UILabel* label = [UILabel new];
    label.text = @"提醒开关";
    label.textColor = FNMainTextNormalColor;
    label.font = kFONT12;
    [label sizeToFit];
    [noteView addSubview:label];
    
    NSString* flag = Userhbtx;
    UIButton* noteSwitch = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [noteSwitch setImage:IMAGE(@"rp_switch_on") forState:UIControlStateSelected];
    [noteSwitch setImage:IMAGE(@"rp_switch_off") forState:UIControlStateNormal];
    [noteSwitch addTarget:self action:@selector(noteSwitchAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [noteSwitch sizeToFit];
    noteSwitch.selected = flag.boolValue;
    [noteView addSubview:noteSwitch];
    [noteSwitch autoSetDimensionsToSize:noteSwitch.size];
    [noteSwitch autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [noteSwitch autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [label autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [label autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:noteSwitch withOffset:-5];
    noteView.size = CGSizeMake(label.width+noteSwitch.width+5, noteSwitch.height);
    
    [noteView autoSetDimensionsToSize:noteView.size];//iOS 11会把noteView frame 无效化
    UIBarButtonItem* item =[[UIBarButtonItem alloc]initWithCustomView:noteView];
    
    self.navigationItem.rightBarButtonItem =item;
    
    UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setImage: [UIImage imageNamed:@"good_detail_close"] forState:UIControlStateNormal];
    rightbtn.frame=CGRectMake(0, 0, 25, 25);
    [rightbtn addTarget:self action:@selector(dismissAll) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage: [UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(0, 0, 25, 25);
    [leftbutton addTarget:self action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc]initWithCustomView:leftbutton],[[UIBarButtonItem alloc]initWithCustomView:rightbtn]];
 
}
- (void)noteSwitchAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    [self apiRequestSetNote:btn.selected];
}
- (void)apiRequestSetNote:(BOOL)flag{
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"hbtx":@(flag),TokenKey:UserAccessToken,@"type":@0}];
    [FNAPIHome apiHomeRequestSetNoticeWithParams:params success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",flag] forKey:XYhbtx];
        [FNTipsView showTips:flag?@"已打开":@"已关闭"];
    } failure:^(NSString *error) {
        
    } isHidden:NO];

}
-(void) loadUrl{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [_webView loadRequest:request];
    //[_webViewProxy loadRequest:request];
}
-(void)returnAction{
    
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        if (self.isLaunch) {
            [FNNotificationCenter postNotificationName:_jmntf_ad_readweb object:nil];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setShadowImage:nil];
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    
//    if (iOS7) { // 判断是否是IOS7
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
//    }
    if (self.headerModel && [self.headerModel.outlink_style isEqualToString:@"1"]) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    self.navigationController.navigationBarHidden = NO;
    [self.webView.scrollView.mj_header endRefreshing];
    //    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self.webView stopLoading];
    [SVProgressHUD dismiss];
    if (self.headerModel && [self.headerModel.outlink_style isEqualToString:@"1"]) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}


#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.view.backgroundColor = [UIColor clearColor];
    
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.scrollView.scrollEnabled = YES;
    _webView.delegate = self;
    _webView.scrollView.delegate = self;
    _webView.layer.masksToBounds = YES;
    _webView.allowsInlineMediaPlayback = YES;
    _webView.mediaPlaybackRequiresUserAction = NO;
    _webView.backgroundColor = UIColor.whiteColor;
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
    }
    
    [self.view addSubview:_webView];
    //支持3DTouch
    if (iOS9) {
        self.webView.allowsLinkPreview = YES;
    }
    
    
    _progressView = [[FNWebviewProgressView alloc] initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 4)];
    _progressView.lineColor = RED;
    [self.view addSubview:_progressView];
    
    _toolView = [[JMProductDetailToolView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0))];
    _toolView.borderColor = UIColor.whiteColor;
    _toolView.borderWidth = 1.0;
    _toolView.hidden = !self.isBottom;
    [_toolView.helpBtn addTarget:self action:@selector(helpBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_toolView];
    
    //layout
    [_toolView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    self.toolViewHeightCons = [_toolView autoSetDimension:(ALDimensionHeight) toSize:self.isBottom ?44:0];
    
    [_webView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [_webView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:_toolView];
    
    
    __unsafe_unretained UIWebView *webView = self.webView;
    webView.delegate = self;
    
    [self loadUrl];
    __unsafe_unretained UIScrollView *scrollView = self.webView.scrollView;
    [self.view addSubview:self.webView];
    [self addRoute:_webView];
    
    
    if (self.headerModel && [self.headerModel.outlink_pull_onoff isEqualToString: @"1"]) {
        scrollView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [webView reload];
        }];
    } else {
        scrollView.mj_header= nil;
    }
    
    

}

- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];

        self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backBtn setImage: [UIImage imageNamed:@"return"] forState:UIControlStateNormal];
        [self.backBtn addTarget:self action:@selector(returnAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.backBtn.frame=CGRectMake(0, 0, 25, 25);

        self.closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.closeBtn setImage: [UIImage imageNamed:@"good_detail_close"] forState:UIControlStateNormal];
        self.closeBtn.frame=CGRectMake(0, 0, 25, 25);
        [self.closeBtn addTarget:self action:@selector(dismissAll) forControlEvents:UIControlEventTouchUpInside];
        self.closeBtn.size = CGSizeMake(self.closeBtn.width+_jmsize_10, self.closeBtn.height+10);
        

        _navigationView.leftButton = self.backBtn;
        _navigationView.rightButton = self.closeBtn;
        
//        _navigationView.titleLabel.textColor = UIColor.redColor;
//        _navigationView.titleLabel.text = @"aaaaaa";
        self.navigationView.titleLabel.sd_layout
        .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
        [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];

    }
    return _navigationView;
}

-(void)setupNav{
    if (self.headerModel && [self.headerModel.outlink_style isEqualToString:@"1"]) {
        
        [self.view addSubview:self.navigationView];
        [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
        [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
        
        if ([self.headerModel.outlink_returnimg kr_isNotEmpty]) {
            [self.backBtn sd_setImageWithURL:URL(self.headerModel.outlink_returnimg) forState:UIControlStateNormal];
        }
        
        if ([self.headerModel.outlink_closeimg kr_isNotEmpty]) {
            [self.closeBtn sd_setImageWithURL:URL(self.headerModel.outlink_closeimg) forState:UIControlStateNormal];
        }
        
    } else {
    
        UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];

        [leftbutton setImage: [UIImage imageNamed:@"return"] forState:UIControlStateNormal];
        leftbutton.frame=CGRectMake(0, 0, 25, 25);
        [leftbutton addTarget:self action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
        
      
//        if (self.islucky) {\
//            [self addSwitch];
//        }else{
            UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [rightbtn setImage: [UIImage imageNamed:@"good_detail_close"] forState:UIControlStateNormal];
            rightbtn.frame=CGRectMake(0, 0, 25, 25);
            [rightbtn addTarget:self action:@selector(dismissAll) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
//        }
    }
    
    
    if (self.headerModel && [self.headerModel.outlink_navhide_onoff isEqualToString:@"1"] )
        self.navigationView.hidden = YES;
}
- (void)dismissAll{
    if (self.isLaunch) {
        [FNNotificationCenter postNotificationName:_jmntf_ad_readweb object:nil];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Web view delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"second should request is %@",request.URL);
    NSLog(@"navtype is %ld",(long)navigationType);
    BOOL isAllowLoadURLRequest=YES;
    
    return isAllowLoadURLRequest;
}


-(void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD show];
    
    [self.view bringSubviewToFront:self.progressView];
    [self.progressView startLoadingAnimation];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.webView.scrollView.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [self.progressView endLoadingAnimation];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad is %@",webView.request.URL);
    [self.webView.scrollView.mj_header endRefreshing];
    [self.progressView endLoadingAnimation];
    //获取标题
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    NSLog(@"html is %@",[self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerHTML"]);
    
    self.navigationView.titleLabel.text = self.title;
    [SVProgressHUD dismiss];
    
    if (self.isBottom) {
        if (self.fcommission) {
            _toolView.desLabel.text = [NSString stringWithFormat:@"购买此商品可返%@",self.fcommission];
            [_toolView.desLabel addSingleAttributed:@{NSForegroundColorAttributeName:RED} ofRange:[_toolView.desLabel.text rangeOfString:self.fcommission]];
        }
        [self apiRequesteDetailTool];
    }
    
    CGSize contentSize = webView.scrollView.contentSize;
    CGSize viewSize = self.view.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    
    webView.scrollView.minimumZoomScale = rw;
    webView.scrollView.maximumZoomScale = rw;
    webView.scrollView.zoomScale = rw;
}


#pragma mark- js
-(void)addRoute:(UIWebView*)webView{
    /*_bridge = [WebViewJavascriptBridge bridgeForWebView:webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC received message from JS: %@", data);
        responseCallback(@"发送消息给JS");
        
        NSString *identifier = [data objectForKey:@"identifier"];
        
        // 根据不同的标识跳转
        [self jumpToActionFromWebJSMethod:identifier data:data];
        
    }];*/
}

-(void)jumpToActionFromWebJSMethod:(NSString *)identifier data:(id)data{
    if ([identifier isEqualToString:@"1"]) {
        //        [D3Generator createViewControllerWithDictAndPush:data];
        FNLoginSecondController *vc = [[FNLoginSecondController alloc]init];
        vc.isFromWeb = YES;
        vc.callBackBlock = ^(){
            //            [self.webView reload];
            //            [self.webView reload];
            
            [self.webView.scrollView.mj_header beginRefreshing];
            
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    [super jumpToActionFromWebJSMethod:identifier data:data];
}

#pragma mark -  api request
- (void)apiRequesteDetailTool{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    params[@"jdurl"] = _url;
    
    @WeakObj(self);
    [FNAPIHome apiHomeRequestProductDetailToolWithParams:params success:^(id respondsObject) {
        selfWeak.model = respondsObject;
    } failure:^(NSString *error) {
        
    } isHidden:NO];
    
}

- (void)helpBtnAction{
    [self showRebateView];
}
- (void)setupRebateView{
    CGFloat maxHeight = FNKeyWindow.height-20*2;
    CGFloat width = FNDeviceWidth - _jm_leftMargin*2;
    
    CGFloat __block tvHeight = _product_headerHeight ;
    if (self.model.rule.count > 0) {
        [self.model.rule enumerateObjectsUsingBlock:^(JMProductDetailRuleModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            tvHeight += obj.height;
        }];
    }
    if (tvHeight > maxHeight) {
        tvHeight = maxHeight;
    }
    @WeakObj(self);
    JMProductRebateRuleController* rebateVC = [JMProductRebateRuleController new];
    rebateVC.list = self.model.rule;
    rebateVC.closeButtonBlock = ^{
        [selfWeak hideRebateView];
    };
    rebateVC.commission = self.model.commission;
    [FNKeyWindow.rootViewController addChildViewController:rebateVC];
    rebateVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    _rebateBgView = [[UIView alloc]initWithFrame:FNKeyWindow.bounds];
    _rebateBgView.backgroundColor = [FNBlackColor colorWithAlphaComponent:0.4];
    
    
    CGFloat margin = (FNDeviceHeight-tvHeight)*0.5;
    _rebateView = [[UIView alloc]initWithFrame:(CGRectMake(_jm_leftMargin, margin, width, tvHeight))];
    _rebateView.cornerRadius = 5;
    _rebateView.backgroundColor = FNWhiteColor;
    [_rebateBgView addSubview:_rebateView];
    
    rebateVC.view.size = _rebateView.size;
    [_rebateView addSubview:rebateVC.view];
    [rebateVC didMoveToParentViewController:FNKeyWindow.rootViewController];
    
    
}
- (void)showRebateView{
    if (_model) {
        [self setupRebateView];
        [FNKeyWindow addSubview:_rebateBgView];
        @WeakObj(self);
        [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [selfWeak.rebateView.layer setValue:@(0) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.23 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [selfWeak.rebateView.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.09 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [selfWeak.rebateView.layer setValue:@(.9) forKeyPath:@"transform.scale"];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.05 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        [selfWeak.rebateView.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                    } completion:^(BOOL finished) {
                        
                    }];
                }];
            }];
        }];
        
    }
    
    
}
- (void)hideRebateView{
    @WeakObj(self);
    [UIView animateWithDuration:0.2 animations:^{
        [selfWeak.rebateView.layer setValue:@(1.1) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            [selfWeak.rebateView.layer setValue:@(0.8) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                [selfWeak.rebateView.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    [selfWeak.rebateView.layer setValue:@(0.1) forKeyPath:@"transform.scale"];
                } completion:^(BOOL finished) {
                    [_rebateBgView removeFromSuperview];
                    _rebateBgView = nil;
                }];
            }];
            
        }];
        
    }];
    
}

#pragma mark - Table view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    
    if (self.headerModel && [self.headerModel.outlink_style isEqualToString:@"1"]) {
    
        if (conY>0 && conY<=JMNavBarHeigth) {
            //滚动中
            float percent = conY/JMNavBarHeigth;
            self.navigationView.backgroundColor = [UIColor calcColorfromColor:_fromNavColor toColor:_toNavColor withPercent:percent];
            self.lblTitle.textColor = [UIColor calcColorfromColor:_fromTextColor toColor:_toTextColor withPercent:percent];
        }else if (conY > JMNavBarHeigth){
            self.navigationView.backgroundColor = _toNavColor;
            self.navigationView.titleLabel.textColor = _toTextColor;
            
            if ([self.headerModel.outlink_checkreturnimg kr_isNotEmpty]) {
                [self.backBtn sd_setImageWithURL:URL(self.headerModel.outlink_checkreturnimg) forState:UIControlStateNormal];
            }
            
            if ([self.headerModel.outlink_checkcloseimg kr_isNotEmpty]) {
                [self.closeBtn sd_setImageWithURL:URL(self.headerModel.outlink_checkcloseimg) forState:UIControlStateNormal];
            }
        }else{
            self.navigationView.backgroundColor = _fromNavColor;
            self.navigationView.titleLabel.textColor = _fromTextColor;
            
            if ([self.headerModel.outlink_returnimg kr_isNotEmpty]) {
                [self.backBtn sd_setImageWithURL:URL(self.headerModel.outlink_returnimg) forState:UIControlStateNormal];
            }
            
            if ([self.headerModel.outlink_closeimg kr_isNotEmpty]) {
                [self.closeBtn sd_setImageWithURL:URL(self.headerModel.outlink_closeimg) forState:UIControlStateNormal];
            }
        }
    }
}
@end
