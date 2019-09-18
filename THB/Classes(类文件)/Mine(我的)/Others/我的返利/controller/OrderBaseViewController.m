//
//  OrderBaseViewController.m
//  THB
//
//  Created by zhongxueyu on 16/4/6.
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

#import "OrderBaseViewController.h"
#import "FNAPIHome.h"
#import "FDSlideBar.h"
#import "HotSearchHeadColumnModel.h"
#import "ShopOrderViewController.h"//商城订单
#import "TBOrderViewController.h"//淘宝订单
#import "JDOrderViewController.h"//京东订单
#import "PDDOrderViewController.h"//拼多多订单
#import "FNUpgradeOrderListNeController.h"//升级订单
@interface OrderBaseViewController ()<UIWebViewDelegate,UIActionSheetDelegate>
@property (nonatomic, strong)FDSlideBar *slideBar;
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation OrderBaseViewController{
    NSMutableArray *title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.useNavigationBarButtonItemsOfCurrentViewController = YES;
    self.useToolbarItemsOfCurrentViewController = YES;
    
    NSMutableArray *initialViewController = [NSMutableArray array];
    UIViewController *VC=[UIViewController new];
    VC.view.backgroundColor=FNWhiteColor;
    [initialViewController addObject:VC];
    self.viewController = initialViewController;
    [self loadDateMethod];
    
    [SVProgressHUD show];
    [FNAPIHome startWithRequests:@[[self apiRequestHotSearchHeadColumn]] withFinishedBlock:^(NSArray *erros) {
        _slideBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(50, 0, FNDeviceWidth-50, 40)];
        _slideBar.backgroundColor = FNWhiteColor;
        _slideBar.is_middle=YES;
        _slideBar.itemsTitle = title;
        _slideBar.itemColor = FNGlobalTextGrayColor;
        _slideBar.itemSelectedColor = FNMainGobalTextColor;
        _slideBar.sliderColor = FNMainGobalTextColor;
        _slideBar.fontSize=13;
        _slideBar.SelectedfontSize=14;
        [self slideBarItemSelected];
        self.navigationItem.titleView = _slideBar;
    }];
}

-(void)slideBarItemSelected{
    [self showViewController:[self.mutableViewController objectAtIndex:0] animated:NO];
    [_slideBar slideBarItemSelectedCallback:^(NSUInteger index) {
        [self showViewController:[self.mutableViewController objectAtIndex:index] animated:NO];
    }];
}

#pragma - mark 访问以下获取多麦的订单
-(void)loadDateMethod
{

    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];

    NSString *url =[NSString stringWithFormat:@"%@%@",IP,_api_mine_getShopOrder];
    NSURL *webUrl = [NSURL URLWithString:url];
    NSURLRequest *request =[NSURLRequest requestWithURL:webUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    __unsafe_unretained UIWebView *webView = self.webView;
    webView.delegate = self;
    [webView loadRequest:request];
    [self.view addSubview:self.webView];
    self.webView.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取商品栏目（淘宝，京东，拼多多那几个大栏目）
- (FNRequestTool *)apiRequestHotSearchHeadColumn{
    /*NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@"3"}];
    return [FNAPIHome apiHomeForHotSearchHeadColumnWithParams:params success:^(id respondsObject) {
        title=[[NSMutableArray alloc]init];
        NSMutableArray *initialViewController = [NSMutableArray array];
        [respondsObject enumerateObjectsUsingBlock:^(HotSearchHeadColumnModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [title addObject:obj.name];
            
            if ([obj.SkipUIIdentifier isEqualToString:@"buy_taobao"]) {
                TBOrderViewController *VC = [TBOrderViewController new];
                VC.selectIndex=self.status.integerValue;
                [initialViewController addObject:VC];
            }
            if ([obj.SkipUIIdentifier isEqualToString:@"buy_jingdong"]) {
                JDOrderViewController *VC = [JDOrderViewController new];
                VC.selectIndex=self.status.integerValue;
                [initialViewController addObject:VC];
            }
            if ([obj.SkipUIIdentifier isEqualToString:@"buy_pinduoduo"]) {
                PDDOrderViewController *VC = [PDDOrderViewController new];
                VC.selectIndex=self.status.integerValue;
                [initialViewController addObject:VC];
            }
            if ([obj.SkipUIIdentifier isEqualToString:@"buy_shangcheng"]) {
                ShopOrderViewController *VC = [ShopOrderViewController new];
                VC.selectIndex=self.status.integerValue;
                [initialViewController addObject:VC];
            } 
            if([obj.SkipUIIdentifier isEqualToString:@"buy_update_order"]){
                FNUpgradeOrderListNeController *VC = [FNUpgradeOrderListNeController new];
                VC.selectIndex=self.status.integerValue;
                [initialViewController addObject:VC];
            }
        }];
        self.viewController = initialViewController;
    } failure:^(NSString *error) {
        
    } isHidden:YES];*/
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appJdPdd&ctrl=orderType" respondType:(ResponseTypeArray) modelType:@"HotSearchHeadColumnModel" success:^(id respondsObject) {
        title=[[NSMutableArray alloc]init];
        NSMutableArray *initialViewController = [NSMutableArray array];
        [respondsObject enumerateObjectsUsingBlock:^(HotSearchHeadColumnModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [title addObject:obj.name];
            
            if ([obj.SkipUIIdentifier isEqualToString:@"buy_taobao"]) {
                TBOrderViewController *VC = [TBOrderViewController new];
                VC.selectIndex=self.status.integerValue;
                [initialViewController addObject:VC];
            }
            if ([obj.SkipUIIdentifier isEqualToString:@"buy_jingdong"]) {
                JDOrderViewController *VC = [JDOrderViewController new];
                VC.selectIndex=self.status.integerValue;
                [initialViewController addObject:VC];
            }
            if ([obj.SkipUIIdentifier isEqualToString:@"buy_pinduoduo"]) {
                PDDOrderViewController *VC = [PDDOrderViewController new];
                VC.selectIndex=self.status.integerValue;
                [initialViewController addObject:VC];
            }
            if ([obj.SkipUIIdentifier isEqualToString:@"buy_shangcheng"]) {
                ShopOrderViewController *VC = [ShopOrderViewController new];
                VC.selectIndex=self.status.integerValue;
                [initialViewController addObject:VC];
            }
            if([obj.SkipUIIdentifier isEqualToString:@"buy_update_order"]){
                FNUpgradeOrderListNeController *VC = [FNUpgradeOrderListNeController new];
                VC.selectIndex=self.status.integerValue;
                [initialViewController addObject:VC];
            }
        }];
        self.viewController = initialViewController;
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

@end
