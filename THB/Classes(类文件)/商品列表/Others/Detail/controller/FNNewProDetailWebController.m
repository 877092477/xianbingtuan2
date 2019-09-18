//
//  FNNewProDetailWebController.m
//  THB
//
//  Created by Weller Zhao on 2018/12/29.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNNewProDetailWebController.h"

@interface FNNewProDetailWebController ()

@property (nonatomic, strong) UIView *vBottom;
@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UIButton *btnRight;

@end

@implementation FNNewProDetailWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.model && [self.model.shop_type isEqualToString: @"taobao"]) {
        self.btnLeft.backgroundColor = [UIColor colorWithHexString:self.model.bj_color];
        [self.btnLeft setTitle:self.model.str forState:UIControlStateNormal];
        [self.btnLeft setTitleColor:[UIColor colorWithHexString:self.model.font_color] forState:UIControlStateNormal];
        self.btnLeft.titleLabel.font = kFONT14;
        self.btnLeft.enabled = NO;
        
        self.btnRight.backgroundColor = [UIColor colorWithHexString:self.model.bj_color1];
        [self.btnRight setTitle:self.model.str1 forState:UIControlStateNormal];
        [self.btnRight setTitleColor:[UIColor colorWithHexString:self.model.font_color1] forState:UIControlStateNormal];
        self.btnRight.titleLabel.font = kFONT14;
        
    }
}

- (void)configUI {
    self.vBottom = [[UIView alloc] init];
    self.btnLeft = [[UIButton alloc] init];
    self.btnRight = [[UIButton alloc] init];
    
    [self.view addSubview:self.vBottom];
    [self.vBottom addSubview:self.btnLeft];
    [self.vBottom addSubview:self.btnRight];
    
    [self.vBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(isIphoneX ? 88 : 60);
    }];
    
    [self.btnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
        make.right.equalTo(@0).multipliedBy(0.7);
    }];
    [self.btnRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnLeft.mas_right);
        make.top.right.bottom.equalTo(@0);
    }];
    
    self.webView.scrollView.bounces = NO;
    [self.btnRight addTarget:self action:@selector(onBuyClick)];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"webView will load %@",request.URL);
    NSLog(@"navtype is %ld",(long)navigationType);
    NSString *url = request.URL.absoluteString;
    if ([url containsString:@"tbopen://m.taobao.com/tbopen/index.html"] ||
        [url containsString:@"tmall://page.tm/appLink"] ||
        [url containsString:@"alipays://platformapi/startapp"]) {
        return NO;
    }else {
        return YES;
    }
}

#pragma mark - Action

- (void)onBuyClick {
    if ([NSString isEmpty:UserAccessToken]) {
        if ([FNBaseSettingModel settingInstance].is_need_login.boolValue) {
            [self warnToLogin];
            return;
        }
    }
    
    [self requestCoupon];
    [self judgeNeedPay];

}

- (FNRequestTool *)requestCoupon{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"fnuo_id":self.model.fnuo_id}];
    
    return  [FNRequestTool requestWithParams:params api:@"mod=appapi&act=newgoods_detail&ctrl=click_yhq" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}

-(void)judgeNeedPay{
    [self goToProductDetailsWithModel:self.model];
//    // 授权获取百川openId和token
//    [[ALBBSDK sharedInstance]auth:self successCallback:^(ALBBSession *session) {
//        ALBBUser *user = [session getUser];
//        XYLog(@"getUser is %@",[session getUser]);
//
//        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey: UserAccessToken, @"BC_OpenId": user.openId, @"BC_AccessToken": user.topAccessToken }];
//        @weakify(self)
//        [FNRequestTool requestWithParams:params api:@"mod=timer&act=bc_order&ctrl=set_open_id" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
//
////            [self_weak_ openDetailWithModel:self.model];
//
//        } failure:^(NSString *error) {
//            //
//        } isHideTips:YES];
//    } failureCallback:^(ALBBSession *session, NSError *error) {
//
//    }];
    
}
@end
