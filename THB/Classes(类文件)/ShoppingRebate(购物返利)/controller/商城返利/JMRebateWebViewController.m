//
//  JMRebateWebViewController.m
//  THB
//
//  Created by jimmy on 2017/4/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMRebateWebViewController.h"
#import "secondViewController.h"
#import "JMRebateRuleView.h"
#import "FNPopUpTool.h"

static const CGFloat _rebate_bottomViewHeight = 44;
static const CGFloat _rebate_alertlogoWidth = 80;
@interface JMRebateWebViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
@property (nonatomic, strong)UIWebView* webView;
@property (nonatomic, strong)UIView* bottomview;
@property (nonatomic, strong)UILabel* rebateLabel;
@property (nonatomic, strong)UIButton* iconBtn;
@property (nonatomic, strong)NSLayoutConstraint* bottomViewHeightCons;

@property (nonatomic, strong)UIView* alertBgView;
@property (nonatomic, strong)UIView* alertView;
@property (nonatomic, strong)UIImageView* logoImgView;
@property (nonatomic, strong)UIView* tipsView;
@property (nonatomic, strong)UILabel* tipsLabel;
@property (nonatomic, strong)NSLayoutConstraint* logoHeightCons;

@property (nonatomic, strong)UIView* detailBgView;
@property (nonatomic, strong)JMRebateRuleView* detailWebView;

@end

@implementation JMRebateWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = FNWhiteColor;
    [self initializedSubviews];
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    if (IOS11) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self setUpAlertView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:URL(self.url)]];
    
}
#pragma 一些系统的方法
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
    //获取快速入口数据
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsCompact];
    //导航栏样式设置
    self.navigationController.navigationBar.barTintColor = RED;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];//用于去除导航栏的底线，也就是周围的边线
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;//导航栏的背景色是黑色, 字体为白色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:FNWhiteColor}];
    if (iOS7) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    //导航栏样式设置
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:FNBlackColor}];
  
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (iOS7) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.webView = [UIWebView new];
    [self.view addSubview:self.webView];
    
    [self.webView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    @WeakObj(self);
    _bottomview = [UIView new];
    _bottomview.backgroundColor = RED;
    [_bottomview addJXTouch:^{
        if (selfWeak.iconBtn.selected) {
            [UIView animateWithDuration:0.3 animations:^{
                selfWeak.detailBgView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [selfWeak.detailBgView removeFromSuperview];
            }];
            
        }else{

            selfWeak.detailBgView.alpha = 0.0;
            [FNKeyWindow addSubview:selfWeak.detailBgView];
            [UIView animateWithDuration:0.3 animations:^{
                selfWeak.detailBgView.alpha = 1.0;
            } ];
        }
        selfWeak.iconBtn.selected = !selfWeak.iconBtn.selected;
    }];
    [self.view addSubview:_bottomview];
    [_bottomview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    self.bottomViewHeightCons = [_bottomview autoSetDimension:(ALDimensionHeight) toSize:_rebate_bottomViewHeight];
    [self.webView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:_bottomview];
    
    _rebateLabel = [UILabel new];
    _rebateLabel.textColor  =FNWhiteColor;
    _rebateLabel.font = kFONT14;
    _rebateLabel.text = [NSString stringWithFormat:@"最高返%@",_scdg_bili];
    
    [_bottomview addSubview:_rebateLabel];
    [_rebateLabel autoAlignAxis:(ALAxisVertical) toSameAxisOfView:self.bottomview withOffset:_iconBtn.width*0.5];
    [_rebateLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    
    _iconBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _iconBtn.userInteractionEnabled = NO;
    [_iconBtn setImage:IMAGE(@"vipshop_sbout") forState:UIControlStateNormal];
    [_iconBtn setImage:IMAGE(@"vipshop_down") forState:UIControlStateSelected];
    [_iconBtn sizeToFit];
    [_bottomview addSubview:_iconBtn];
    [_iconBtn autoSetDimensionsToSize:_iconBtn.size];
    [_iconBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_iconBtn autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_rebateLabel withOffset:3];
    
    [self setUpDetailWebView];
    
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage: [UIImage imageNamed:@"return-white"] forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(0, 0, 25, 25);
    [leftbutton addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    //
    UIButton *refreshBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [refreshBtn setImage: [UIImage imageNamed:@"vipshop_refresh"] forState:UIControlStateNormal];
    refreshBtn.frame=CGRectMake(0, 0, 25, 25);
    [refreshBtn addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
 
    
    UIButton *rightbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setImage: [UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
    rightbutton.frame=CGRectMake(0, 0, 25, 25);
    [rightbutton addTarget:self action:@selector(dismissAll) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setRightBarButtonItems:@[[[UIBarButtonItem alloc]initWithCustomView:rightbutton],[[UIBarButtonItem alloc]initWithCustomView:refreshBtn]]];
    
}
- (void)setUpAlertView{
    _alertBgView = [[UIView alloc]initWithFrame:FNKeyWindow.bounds];
    _alertBgView.backgroundColor = [FNBlackColor colorWithAlphaComponent:0.3];
    
    _alertView = [UIView new];
    _alertView.backgroundColor = FNWhiteColor;
    _alertView.cornerRadius = 5;
    [_alertBgView addSubview:_alertView];
    [_alertView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
    [_alertView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin];
    [_alertView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    
    UILabel* titlelabel = [UILabel new];
    titlelabel.text = @"您已经进入";
    titlelabel.font = kFONT14;
    titlelabel.textAlignment = NSTextAlignmentCenter;
    [_alertView addSubview:titlelabel];
    [titlelabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
    [titlelabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin];
    [titlelabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jm_leftMargin];
    
    @WeakObj(self);
    _logoImgView = [UIImageView new];
    [_alertView addSubview:_logoImgView];
    [_logoImgView autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    [_logoImgView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:titlelabel withOffset:_jm_margin10];
    [_logoImgView autoSetDimension:(ALDimensionWidth) toSize:_rebate_alertlogoWidth];
    self.logoHeightCons = [_logoImgView autoSetDimension:(ALDimensionHeight) toSize:0];
    [_logoImgView sd_setImageWithURL:[NSURL URLWithString:_scdg_logo] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            selfWeak.logoHeightCons.constant = image.size.height*_rebate_alertlogoWidth/image.size.width;
            [selfWeak.alertView layoutIfNeeded];
        }
    }];
    
    UIView* line = [UIView new];
    line.backgroundColor = FNHomeBackgroundColor;
    [_alertView addSubview:line];
    [line autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_logoImgView withOffset:_jm_leftMargin];
    [line autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin];
    [line autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
    
   /*
        tips view
    */
    _tipsView = [UIView new];
    _tipsView.backgroundColor = RED;
    [_alertView addSubview:_tipsView];
    [_tipsView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [_tipsView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_tipsView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_logoImgView withOffset:_jm_leftMargin*2];
    [_tipsView autoSetDimension:(ALDimensionHeight) toSize:60];
    
    _tipsLabel = [UILabel new];
    _tipsLabel.font = kFONT14;
    _tipsLabel.text = @"点击红色底栏上的返利比例，可以查看返利规则";
    _tipsLabel.textColor = FNWhiteColor;
    _tipsLabel.numberOfLines = 2;
    [_tipsView addSubview:_tipsLabel];
    [_tipsLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
    [_tipsLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin];
    [_tipsLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_alertView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_tipsView withOffset:_jm_leftMargin*2];
    
    [self showAlertView];
}
- (void)showAlertView{
    [FNKeyWindow addSubview:_alertBgView];
    @WeakObj(self);
    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [selfWeak.alertView.layer setValue:@(0) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.23 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [selfWeak.alertView.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.09 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [selfWeak.alertView.layer setValue:@(.9) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.05 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [selfWeak.alertView.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3 delay:3.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                         [selfWeak.alertView.layer setValue:@(0.1) forKeyPath:@"transform.scale"];
                    } completion:^(BOOL finished) {
                        [selfWeak.alertBgView removeFromSuperview];
                        selfWeak.alertBgView = nil;
                    }];
                }];
            }];
        }];
    }];
    

}

- (void)setUpDetailWebView{
    @WeakObj(self);
    _detailBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-_rebate_bottomViewHeight)];
    _detailBgView.backgroundColor = [FNBlackColor colorWithAlphaComponent:0.3];
    [_detailBgView addJXTouch:^{
        if (selfWeak.detailBgView) {
            [UIView animateWithDuration:0.3 animations:^{
                selfWeak.detailBgView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [selfWeak.detailBgView removeFromSuperview];
            }];
        }
    }];
    
    _detailWebView = [[JMRebateRuleView alloc]initWithFrame:(CGRectMake(0, FNDeviceHeight*0.5-_rebate_bottomViewHeight, FNDeviceWidth, FNDeviceHeight*0.5))];
    _detailWebView.backgroundColor = FNWhiteColor;
    [_detailWebView.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_scxq_url]]];
    [_detailWebView.rebateBtn setTitle:_rebateLabel.text forState:UIControlStateNormal];
    [_detailWebView.rebateDetailBtn addJXTouch:^{
        [selfWeak detailRule];
    }];
    [_detailWebView.logoImgView sd_setImageWithURL:[NSURL URLWithString:_scdg_logo] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            selfWeak.detailWebView.imgHeightCons.constant = image.size.height*_rebate_alertlogoWidth/image.size.width;
            [selfWeak.detailWebView layoutIfNeeded];
        }
    }];
    [_detailBgView addSubview:_detailWebView];
    
}

#pragma mark - action
- (void)detailRule{
    @WeakObj(self);
    [UIView animateWithDuration:0.3 animations:^{
        selfWeak.detailBgView.alpha = 0.0;
    } completion:^(BOOL finished) {
        selfWeak.iconBtn.selected = !selfWeak.iconBtn.selected;
        [selfWeak.detailBgView removeFromSuperview];
        secondViewController* second = [secondViewController new];
        second.url = _scxq_url;
        [selfWeak.navigationController pushViewController:second animated:YES];
    }];
 
}
- (void)refreshAction{
    [self.webView reload];
}
- (void)backBtnAction{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)dismissAll{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= 64 ) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [UIView animateWithDuration:0.2 animations:^{
            self.bottomViewHeightCons.constant = 0;
        }];
        [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        [UIView animateWithDuration:0.2 animations:^{
            self.bottomViewHeightCons.constant = _rebate_bottomViewHeight;
        }];
        [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    }
}

#pragma mark - 
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [SVProgressHUD dismiss];
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [SVProgressHUD dismiss];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];

    //获取标题
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];

}
@end
