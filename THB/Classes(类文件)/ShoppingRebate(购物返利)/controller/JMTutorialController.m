//
//  JMTutorialController.m
//  THB
//
//  Created by jimmy on 2017/4/22.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMTutorialController.h"
#import "FNMBOrderManageBarTitleView.h"
#import "FNTabManager.h"
//商城返利：http://meilitao.vc-store.com/?mod=wap&act=shouTu&ctrl=scjc  ；淘宝返利：http://meilitao.vc-store.com/?mod=wap&act=help&ctrl=course
static NSString* const _tutorail_url_shop = @"mod=wap&act=shouTu&ctrl=scjc";
static NSString* const _tutorail_url_taobao = @"mod=wap&act=help&ctrl=course";
@interface JMTutorialController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView* webView;

@property (nonatomic, strong) UIView* topView;
@property (nonatomic, strong)FNMBOrderManageBarTitleView* titleView;
@property (nonatomic, copy)NSString* url;
@end

@implementation JMTutorialController
- (void)setUrl:(NSString *)url{
    _url = url;
    if (_url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新手教程";
 
    [self initializedSubviews];
    switch (self.tutorialType) {
        case TutorialTypeTaoBao:
        {
            self.url = [NSString stringWithFormat:@"%@%@",IP,_tutorail_url_taobao];
            break;
        }
        case TutorialTypeShop:
        {
            self.url = [NSString stringWithFormat:@"%@%@",IP,_tutorail_url_shop];
            break;
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    //top view
    _topView = [UIView new];
    [self.view addSubview:_topView];
    [_topView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    CGFloat __block height = 40;
    if ([FNTabManager shareInstance].tabs.count>=1) {
        [[FNTabManager shareInstance].tabs enumerateObjectsUsingBlock:^(FNTabModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.SkipUIIdentifier isEqualToString:@"pub_gouwufanli_taobao"]) {
                height = 0;
                self.tutorialType = TutorialTypeTaoBao;
            }
            if ([obj.SkipUIIdentifier isEqualToString:@"pub_shangchengfanli"]) {
                height = 0;
                self.tutorialType = TutorialTypeShop;
            }
        }];
    }
    [_topView autoSetDimension:(ALDimensionHeight) toSize:height];
    if (height == 40) {
        self.topView.hidden = NO;
    }else{
        self.topView.hidden = YES;
    }
    
    @WeakObj(self);
    _titleView = [[FNMBOrderManageBarTitleView alloc]initWithFrame:CGRectMake(0, 0,6*15*2+20*2, 34) titles:@[@"淘宝返利还教程",@"商城返利还教程"]];
    _titleView.backgroundColor  = FNDefaultBarColor;
    _titleView.center = CGPointMake(FNDeviceWidth*0.5, 22);
    _titleView.clickedBtnAtIndex = ^(NSInteger index){
        if (index == 1) {
            selfWeak.url = [NSString stringWithFormat:@"%@%@",IP,_tutorail_url_shop];
        }else{
            selfWeak.url = [NSString stringWithFormat:@"%@%@",IP,_tutorail_url_taobao];
        }

    };
    [_topView addSubview:_titleView];
    [_titleView setButtonOnAtIndex:0];
    [_titleView autoCenterInSuperview];
    [_titleView autoSetDimensionsToSize:(CGSizeMake(6*15*2+20*2, 34))];

    //set up web view
    _webView = [UIWebView new];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    [_webView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [_webView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_topView];
}
#pragma mark -  UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD show];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    XYLog(@"%@",request);
    return YES;
}
@end
