//
//  ALBBDetailsViewController.m
//  Top61
//
//  Created by zhongxueyu on 16/7/6.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "ALBBDetailsViewController.h"




#import "TaoKeMacros.h"


@interface ALBBDetailsViewController ()
{
    NSMutableDictionary  *taoKeParams;
    NSMutableDictionary  *customParams;
}



@end
static ALBBDetailsViewController *ALBBDetailsViewControllerinstance = nil;

@implementation ALBBDetailsViewController

+ (ALBBDetailsViewController *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ALBBDetailsViewControllerinstance = [[ALBBDetailsViewController alloc] init];
    });
    return ALBBDetailsViewControllerinstance;
}

-(void)LeftBtnMethod:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    //    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    XYLog(@"_highcommission_url is %@",_highcommission_url);
    
    taoKeParams=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[FNBaseSettingModel settingInstance].TaoKePid, @"pid",@"",@"unionId",@"", @"subPid",nil];
    
    //打开商品详情
    [self getProductDetailMethod:_goodsId productId:_fnuoId wapUrl:_highcommission_url];
    
}

//把订单传给后台
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

//添加浏览足迹
-(void)postFootPrintMethpd:(NSString *)goodsId{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"goodsid":goodsId,
                                                                                 @"token":UserAccessToken}];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_addfootmark successBlock:^(id responseBody) {
        
        XYLog(@"footresponseBody is %@",responseBody);
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
    }];
}

- (NSDictionary *)trackParams {
    return @{@"isv_code": [NSString stringWithFormat:@"%@%@",My_isv_code,_goodsId]};
}

-(void)getProductDetailMethod:(NSString *)goodsId productId:(NSString *)productId wapUrl:(NSString *)url{
    customParams=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"taobaoH5", @"_viewType",[NSString stringWithFormat:@"%@%@",My_isv_code,goodsId],@"isv_code",@"123",@"goodsId",nil];
    //    TaeWebViewUISettings *viewSettings =[self getWebViewSetting];
    //    ALiTradeTaokeParams*taoKeParam=[self getTaoKeParams];
    
    url = _highcommission_url;
    if ([goodsId kr_isNotEmpty]) {
        [self postFootPrintMethpd:goodsId];
        
    }
    if(![_highcommission_url kr_isNotEmpty]){
        //根据商品ID打开详情
        
        
        XYLog(@"productId is %@",productId);
        id<AlibcTradePage> page = [AlibcTradePageFactory itemDetailPage:[NSString encodeToPercentEscapeString:[NSString stringWithFormat:@"%@",productId]]];
        id<AlibcTradeService> service = [AlibcTradeSDK sharedInstance].tradeService;
        AlibcTradeShowParams *showParams = [[AlibcTradeShowParams alloc] init];
        showParams.openType =0;
//                showParams.isNeedPush = YES;
        [service
         show:showParams.isNeedPush ? self.navigationController : self
         page:page
         showParams:showParams
         taoKeParams:nil
         trackParam:[self trackParams]
         tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
             [self.navigationController popViewControllerAnimated:NO];
             [self.navigationController dismissViewControllerAnimated:NO completion:^{
                 
             }];
             [FNTipsView showTips:@"购买成功~"];
             NSString *order=[NSString stringWithFormat:@"%@",result.payResult.paySuccessOrders];
             if (![order isEqualToString:@"(null)"]) {
                 [self postOrderMethod:order];
                 
             }
         } tradeProcessFailedCallback:^(NSError * _Nullable error) {
             NSDictionary *userInfo = error.userInfo;
             NSString *order=[NSString stringWithFormat:@"%@",[userInfo objectForKey:@"orderIdList"]];
             if (![order isEqualToString:@"(null)"]) {
                 [self postOrderMethod:order];
                 
             }
             [self.navigationController popViewControllerAnimated:NO];
             [self.navigationController dismissViewControllerAnimated:NO completion:^{
                 
             }];
             
         }];
        
        
    }else{
        
        
        id<AlibcTradePage> page = [AlibcTradePageFactory page:url];
        id<AlibcTradeService> service = [AlibcTradeSDK sharedInstance].tradeService;
        AlibcTradeShowParams *showParams = [[AlibcTradeShowParams alloc] init];
        showParams.openType = 0;
        showParams.isNeedPush = YES;
        [service
         show:showParams.isNeedPush ? self.navigationController : self
         page:page
         showParams:showParams
         taoKeParams:nil
         trackParam:[self trackParams]
         tradeProcessSuccessCallback:^(AlibcTradeResult *_Nullable result) {
             [self.navigationController popViewControllerAnimated:NO];
             [self.navigationController dismissViewControllerAnimated:NO completion:^{
                 
             }];
             [FNTipsView showTips:@"购买成功~"];
             NSString *order=[NSString stringWithFormat:@"%@",result.payResult.paySuccessOrders];
             if (![order isEqualToString:@"(null)"]) {
                 [self postOrderMethod:order];
                 
             }
         } tradeProcessFailedCallback:^(NSError * _Nullable error) {
             [self.navigationController popViewControllerAnimated:NO];
             [self.navigationController dismissViewControllerAnimated:NO completion:^{
                 
             }];
             NSDictionary *userInfo = error.userInfo;
             NSString *order=[NSString stringWithFormat:@"%@",[userInfo objectForKey:@"orderIdList"]];
             if (![order isEqualToString:@"(null)"]) {
                 [self postOrderMethod:order];
                 
             }         }];
        
        
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
