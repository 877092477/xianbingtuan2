//
//  ALBBCustomWebViewController.m
//  THB
//
//  Created by zhongxueyu on 2017/4/12.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "ALBBCustomWebViewController.h"
#import "JMProductRebateRuleController.h"
#import "FNFunctionBtnView.h"

#import "FNAPIHome.h"
#import "JMProductDetailModel.h"
#import "FNCouponTransitionView.h"
#import "FNBaseProductModel.h"
#import "JMProductDetailToolView.h"

static const CGFloat _tool_height = 44;



@interface ALBBCustomWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)JMProductDetailToolView*  toolView;
@property (nonatomic, strong)NSLayoutConstraint* toolViewHeightCons;
@property (nonatomic, strong) UIView* rebateBgView;
@property (nonatomic, strong) UIView* rebateView;


@property (nonatomic, strong)JMProductDetailModel* model;

@property (nonatomic, assign)BOOL isFirst;

@property (nonatomic, strong)UIWebView* tmpwebview;
@property (nonatomic, assign)BOOL isSupport;
@property (nonatomic, copy)NSString* supportURL;
@end

@implementation ALBBCustomWebViewController
- (BOOL)isFullScreenShow {
    return YES;
}

#pragma mark - setter && getter
- (void)setModel:(JMProductDetailModel *)model{
    _model = model;
    _toolView.model = _model;
    
}
- (UIWebView *)tmpwebview{
    if (_tmpwebview == nil) {
        self.tmpwebview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
        //    _webView.autoresizingMask =  UIViewAutoresizingFlexibleHeight;
        self.tmpwebview.scrollView.scrollEnabled=YES;
        self.tmpwebview.backgroundColor = [UIColor clearColor];
        __unsafe_unretained UIWebView *webView = self.tmpwebview;
        webView.delegate = self;
        
        [self.view addSubview:self.tmpwebview];
        self.tmpwebview.hidden = YES;
    }
    return _tmpwebview;
}
- (void)setIsShow:(BOOL)isShow{
    _isShow = isShow;
    if (_isShow) {
        _toolView.hidden = YES;
        _toolViewHeightCons.constant = 0;
        self.navigationItem.rightBarButtonItems = nil;
        [self.view layoutIfNeeded];
    }
}
- (void)setDetailType:(DetailType)detailType{
    _detailType = detailType;
    switch (_detailType) {
        case DetailTypeInSite:{
            
            break;
        }
        case DetailTypeOutSite:{
            if (self.model) {
                self.model.commission = self.fcommission;
                self.model.str = [NSString stringWithFormat:@"购买此商品可返%.2f",[self.fcommission floatValue]];
                
            }
            self.toolView.likeView.hidden = YES;
            break;
        }
        default:
            break;
    }
}
#pragma mark - system
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.scrollView.scrollEnabled = YES;
        _webView.delegate = self;
        [self.view addSubview:_webView];
        _webView.scalesPageToFit = YES;
        
        
        _toolView = [[JMProductDetailToolView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0))];
        _toolView.borderColor = FNHomeBackgroundColor;
        _toolView.borderWidth = 1.0;
        [_toolView.helpBtn addTarget:self action:@selector(helpBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [self.view addSubview:_toolView];
        
        [_toolView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
        self.toolViewHeightCons = [_toolView autoSetDimension:(ALDimensionHeight) toSize:_tool_height];
        
        [_webView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
        [_webView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:_toolView];
        //        [FNNotificationCenter addObserver:self selector:@selector(receivedParams:) name:@"" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = FNWhiteColor;
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    
    UIButton* share = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [share setImage:IMAGE(@"good_detail_share")  forState:(UIControlStateNormal)];
    [share sizeToFit];
    share.size = CGSizeMake(share.width+10, share.height+10);
    [share addTarget:self action:@selector(shareBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareItme = [[UIBarButtonItem alloc]initWithCustomView:share];
    
    UIButton* refresh = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [refresh setImage:IMAGE(@"good_detail_refresh")  forState:(UIControlStateNormal)];
    [refresh sizeToFit];
    refresh.size = CGSizeMake(refresh.width+10, refresh.height+10);
    [refresh addTarget:self action:@selector(refreshBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* refreshItme = [[UIBarButtonItem alloc]initWithCustomView:refresh];
    
    self.navigationItem.rightBarButtonItems = @[refreshItme,shareItme];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIBarButtonItem* back = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"return") style:(UIBarButtonItemStyleDone) target:self action:@selector(backBtnAction)];
    UIBarButtonItem* dismiss = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"good_detail_close") style:(UIBarButtonItemStyleDone) target:self action:@selector(dismissAll)];
    
    self.navigationItem.leftBarButtonItems = @[back,dismiss];
}

#pragma mark - rebate view
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


#pragma mark - action
- (void)dismissAll{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)backBtnAction{
    self.isFirst = YES;
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)shareBtnAction{
    [self umengShare];
}
- (void)refreshBtnAction{
    [self.webView reload];
}
- (void)helpBtnAction{
    [self showRebateView];
}

-(void)umengShare{
    NSString* tgid = [UserTid kr_isNotEmpty] ? UserTid:@"";
    
    NSString* url =self.model.share_url?:[NSString stringWithFormat:@"%@%@%@",IP,registerPromotion,tgid];
    
    
    NSString *shareText = self.goods_title;             //分享内嵌文字
    NSString *shareUrl = [NSString encodeToPercentEscapeString:url];
    
    [self umengShareWithURL:shareUrl image:self.goods_img shareTitle:nil andInfo:shareText];
    
    
}
#pragma mark -  api request
- (void)apiRequesteDetailTool{
    if (_shop_id == nil || _shop_id.length <= 0) {
        return;
    }
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    if ([NSString checkIsSuccess:_shop_id andElement:@"1"]||[NSString checkIsSuccess:_shop_id andElement:@"2"]) {
        params[@"tburl"] =_couponURL?: _url;
        
    }else{
        params[@"jdurl"] =_couponURL?: _url;
    }
    @WeakObj(self);
    [FNAPIHome apiHomeRequestProductDetailToolWithParams:params success:^(id respondsObject) {
        JMProductDetailModel* model = respondsObject;
        if (selfWeak.detailType == DetailTypeOutSite) {
            model.commission = selfWeak.fcommission;
            model.str =  [NSString stringWithFormat:@"购买此商品可返%@",selfWeak.fcommission];
        }
        selfWeak.model = respondsObject;
        
    } failure:^(NSString *error) {
        
    } isHidden:NO];
    
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"second should request is %@",request.URL);
    if (self.backwebview == webView) {
        return NO;
    }
    if (self.tmpwebview == webView) {
        if ([request.URL.absoluteString containsString:@"tbopen://"]) {
            return NO;
        }else if ([request.URL.absoluteString containsString:@"tmall://"]) {
            return NO;
        }else if ([request.URL.absoluteString containsString:@"taobao://"]) {
            return NO;
        }
        return YES;
    }
    
    if ([request.URL.absoluteString containsString:@"detail"] &&  ([request.URL.absoluteString containsString:@"?id="] || [request.URL.absoluteString containsString:@"&id="]  )) {
        self.isSupport  = YES;
        self.supportURL = request.URL.absoluteString;
        if (self.isSupport) {
            NSString* ID = @"";
            if ([self.supportURL containsString:@"?id="] ) {
                NSArray* strings = [self.supportURL componentsSeparatedByString:@"?id="];
                NSString* str = [strings lastObject];
                NSArray* strings2 = [str componentsSeparatedByString:@"&"];
                NSString *tmp = [strings2 firstObject];
                
                if ([tmp kr_isNumber]) {
                    ID = tmp;
                }
            }else{
                NSArray* strings = [self.supportURL componentsSeparatedByString:@"&id="];
                NSString* str = [strings lastObject];
                NSArray* strings2 = [str componentsSeparatedByString:@"&"];
                NSString *tmp = [strings2 firstObject];
                
                if ([tmp kr_isNumber]) {
                    ID = tmp;
                }
            }
            NSString* url = [NSString stringWithFormat:@"%@act=gototaobao&gid=%@",IP,ID];
            XYLog(@"testurl is %@",url);
            [self.tmpwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
            if (!self.isPush && (![NSString checkIsSuccess:self.is_dq_yhqurl andElement:@"1"])) {
                if (self.isNotCoupon) {
                    return YES;
                }else{
                    if (![NSString checkIsSuccess:ID andElement:self.ID]) {
                        [self goTBDetailWithID:ID animated:NO];
                        return NO;
                    }else{
                        return YES;
                    }
                    
                }
                
            }
        }
    }else{
        self.isSupport = NO;
    }
    if ([request.URL.absoluteString containsString:@"act=gototaobao"] && self.isFirst) {
        [self.navigationController popViewControllerAnimated:YES];
        return NO;
    }
    else if ([request.URL.absoluteString containsString:@"tbopen://"]) {
        return NO;
    }else if ([request.URL.absoluteString containsString:@"tmall://"]) {
        return NO;
    }else if ([request.URL.absoluteString containsString:@"taobao://"]) {
        if (self.isWeb) {
            NSString*url = [request.URL.absoluteString stringByReplacingOccurrencesOfString:@"taobao://" withString:@"https://"];
            [self.webView loadRequest:[NSURLRequest requestWithURL:URL(url)]];
        }
        return NO;
    }else {
        return YES;
    }
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (self.tmpwebview == webView) {
        return;
    }
    //获取当前页面URL
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    NSLog(@"currentURL is %@",currentURL);
    //    _url = currentURL;
    //在这里查询数据
    
    NSString *allHtml = @"document.documentElement.innerHTML";
    NSString *allHtmlInfo = [webView stringByEvaluatingJavaScriptFromString:allHtml];
    NSLog(@"allHtmlInfo is %@",allHtmlInfo);
    if (webView == self.tmpwebview) {
        //获取当前页面URL
        NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
        NSLog(@"self.tmpwebviewcurrentURL is %@",currentURL);
        //    _url = currentURL;
        //在这里查询数据
        
        NSString *allHtml = @"document.documentElement.innerHTML";
        NSString *allHtmlInfo = [webView stringByEvaluatingJavaScriptFromString:allHtml];
        NSLog(@"self.tmpwebviewallHtmlInfo is %@",allHtmlInfo);
    
    }
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    _toolView.desLabel.text = [NSString stringWithFormat:@"购买此商品可返%@",self.fcommission];
    if (self.fcommission) {
        [_toolView.desLabel addSingleAttributed:@{NSForegroundColorAttributeName:RED} ofRange:[_toolView.desLabel.text rangeOfString:self.fcommission]];
    }
    [self apiRequesteDetailTool]; 
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    if (self.tmpwebview != webView) {
        self.product = [FNBaseProductModel new];
        
        if ([self.yhq_price kr_isNotEmpty] && [self.goods_cost_price kr_isNotEmpty] && [self.juanhou_price kr_isNotEmpty]) {
        
            self.product.yhq_price = self.yhq_price;
            self.product.goods_cost_price = self.goods_cost_price;
            self.product.juanhou_price =  self.juanhou_price;
            [FNCouponTransitionView showWithModel:self.product];
        }
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    if ([FNBaseSettingModel settingInstance].appopentaobao_onoff.boolValue) {
        [self initBaiChuanSDKMethod:[FNBaseSettingModel settingInstance].appopentaobao_onoff.boolValue];
    }
}


@end

