//
//  LoginViewController.m
//  THB
//
//  Created by zhongxueyu on 16/3/16.
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
#ifndef ALBBService
#define ALBBService(__protocol__) ((id <__protocol__>) ([[TaeSDK sharedInstance] getService:@protocol(__protocol__)]))
#endif

#import "LoginViewController.h"
#import "SizeMacros.h"
#import "RegisterViewController.h"
#import "ForgetViewController.h"
#import "UserInfoModel.h"
#import "ProfileModel.h"
#import "UIView+KRKit.h"
#import "BlindTidViewController.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"


#import "BQLAuthEngine.h"

#import <UMSocialCore/UMSocialCore.h>

@interface LoginViewController ()<UIWebViewDelegate>
{
    BQLAuthEngine *_bqlAuthEngine;
    
}
@property (nonatomic,strong) UITextField *userName;

@property (nonatomic,strong) UITextField *pwd;

@property (nonatomic,assign) BOOL isConfirm;

/** Model数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;

//@property (nonatomic, assign) UserInfoModel *model;

//第三方登录要传的参数
@property (nonatomic,strong) NSString *userId;

@property (nonatomic,strong) NSString *userNikeName;

@property (nonatomic,strong) NSString *userHeadImg;

@property (nonatomic,strong) NSNumber *type;

@property (nonatomic,strong) UIWebView *webView;


@end

@implementation LoginViewController
@synthesize userName,pwd;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    _bqlAuthEngine = [[BQLAuthEngine alloc] init];
    
    [self initInputView];

}
/** 第三方登录
 userId:SDK返回的openid
 userNickName:SDK返回的用户的昵称
 userSex：SDK返回的用户的性别
 userAddress：SDK返回的用户的地址
 userHeadImg：SDK返回的用户的头像
 type:1.qq，2.淘宝，3.微信
 **/
-(void)postToThirdLogin:(NSString *)userId userNikeName:(NSString *)userNikeName userSex:(NSString *)userSex userAddress:(NSString *)userAddress userHeadImg:(NSString *)userHeadImg Type:(NSNumber *)type{
    NSMutableDictionary *param;
    if ([type isEqualToNumber:@1]&& [userId kr_isNotEmpty]) {
        NSMutableDictionary* _param = [NSMutableDictionary dictionaryWithDictionary:@{@"openid":userId,
                                                                                      @"time":[NSString GetNowTimes],
                                                                                      @"nickname":userNikeName,
                                                                                      @"figureurl_qq_2":userHeadImg,
                                                                                      @"user_address":userAddress,
                                                                                      @"type":type                    }];
        _param[SignKey] = [NSString getSignStringWithDictionary:_param];
        param = _param;
    }else if([type isEqualToNumber:@2]&& [userId kr_isNotEmpty]){
        NSMutableDictionary* _param = [NSMutableDictionary dictionaryWithDictionary:@{@"taobaoid":userId,
                                                                                      @"time":[NSString GetNowTimes],
                                                                                      @"user_nick_name_taobao":userNikeName,
                                                                                      @"taobao_avatar_hd":userHeadImg,
                                                                                      @"type":type                   }];
        _param[SignKey] = [NSString getSignStringWithDictionary:_param];
        param = _param;
    }else if ([type isEqualToNumber:@3]&& [userId kr_isNotEmpty]){
        NSMutableDictionary* _param = [NSMutableDictionary dictionaryWithDictionary:@{@"weixinid":userId,
                                                                                      @"time":[NSString GetNowTimes],
                                                                                      @"weixin_screen_name":userNikeName,
                                                                                      @"weixin_avatar_hd":userHeadImg,
                                                                                      @"type":type                  }];
        _param[SignKey] = [NSString getSignStringWithDictionary:_param];
        param = _param;
    }
    if ([userId kr_isNotEmpty]) {
        //    [SVProgressHUD show];
        [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_login_threelogin successBlock:^(id responseBody) {
            NSDictionary *dict = responseBody;
            XYLog(@"responseBody2 is %@",responseBody);
            if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
                
                NSArray *tempArray = [dict objectForKey:XYData];
                [self.dataArray removeAllObjects];
                //            ProfileModel *model;
                if (tempArray) {
                    NSString *token = [tempArray valueForKey:@"token"];

                    
                    NSString *isBind = [tempArray valueForKey:@"phone"];
                    XYLog(@"isBind is %@",isBind);
                    [SVProgressHUD dismiss];
                    if (![isBind kr_isNotEmpty]) {
                        BlindTidViewController *vc = [[BlindTidViewController alloc]init];
                        vc.source_type = @"three_reg";
                        vc.type = @2;
                        vc.token = token;
                        vc.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:vc animated:YES];
                    }else{
                        
                        if (self.isFromWeb) {
                            [self loadDateMethod];
                            
                            _isConfirm = YES;
                            //这里回调
                            
                            [self.navigationController popViewControllerAnimated:NO];
                            self.callBackBlock(); //返回
                            return ;
                        }
                        
                        [[NSUserDefaults standardUserDefaults] setValue:token forKey:XYAccessToken];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        XYTabBarViewController *mainCtrl = [XYTabBarViewController mainViewController];
                        [UIApplication sharedApplication].delegate.window.rootViewController = mainCtrl;
                    }
                }
            }else
            {
                
                [XYNetworkAPI queryFinishTip:dict];
                [XYNetworkAPI cancelAllRequest];
            }
            
            
        } failureBlock:^(NSString *error) {
            //        [SVProgressHUD dismiss];
            [XYNetworkAPI cancelAllRequest];
        }];
    }
    
    
}

-(void)clickToLoginWithQQMethod{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        
        NSLog(@"install--");
        [_bqlAuthEngine authLoginQQWithSuccess:^(id response) {
            
            NSDictionary *param = response;
            NSString *province = [param valueForKey:@"province"];
            NSString *city = [param valueForKey:@"city"];
            NSString *sex = [param valueForKey:@"gender"];
            
            [self postToThirdLogin:UserQQOpenID userNikeName:[param valueForKey:@"nickname"]  userSex:sex userAddress:[NSString stringWithFormat:@"%@%@",province,city] userHeadImg:[param valueForKey:@"figureurl_qq_2"] Type:@1];
        } Failure:^(NSError *error) {
            
            [FNTipsView showTips:[NSString stringWithFormat:@"%@",error]];
        }];
        
        
    }else{
        
        NSLog(@"no---");
        //        [FNTipsView showTips:@"您未安装QQ，请使用其它登录方式~"];
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                
            } else {
                UMSocialUserInfoResponse *resp = result;
                // 第三方平台SDK源数据
                NSLog(@"QQ originalResponse: %@", resp.originalResponse);
                NSDictionary *param =  resp.originalResponse;
                NSString *province = [param valueForKey:@"province"];
                NSString *city = [param valueForKey:@"city"];
                NSNumber *sexString = [param valueForKey:@"sex"];
                NSString *sex;
                if ([sexString isEqual:@1]) {
                    sex = @"男";
                }else if ([sexString isEqual:@0]){
                    sex = @"女";
                    
                }
                [self postToThirdLogin:resp.openid userNikeName:resp.name  userSex:sex userAddress:[NSString stringWithFormat:@"%@%@",province,city] userHeadImg:[param valueForKey:@"figureurl_qq_2"] Type:@1];
            }
        }];
        
        
    }
    
    
    
}

-(void)clickToLoginWithWeChatMethod{
    if ([WXApi isWXAppInstalled]) {
        //判断是否有微信
        [_bqlAuthEngine authLoginWeChatWithSuccess:^(id response) {
            
            NSLog(@"WeChatsuccess:%@",response);
            NSDictionary *param = response;
            NSString *province = [param valueForKey:@"province"];
            NSString *city = [param valueForKey:@"city"];
            NSNumber *sexString = [param valueForKey:@"sex"];
            NSString *sex;
            if ([sexString isEqual:@1]) {
                sex = @"男";
            }else if ([sexString isEqual:@0]){
                sex = @"女";
                
            }
            [self postToThirdLogin:[param valueForKey:@"openid"] userNikeName:[param valueForKey:@"nickname"]  userSex:sex userAddress:[NSString stringWithFormat:@"%@%@",province,city] userHeadImg:[param valueForKey:@"headimgurl"] Type:@3];
        } Failure:^(NSError *error) {
            
            [FNTipsView showTips:[NSString stringWithFormat:@"%@",error]];
        }];
    }else{
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                
            } else {
                UMSocialUserInfoResponse *resp = result;
                
                NSDictionary *param = resp.originalResponse;
                NSNumber *sexString = [param valueForKey:@"sex"];
                NSString *sex;
                if ([sexString isEqual:@1]) {
                    sex = @"男";
                }else if ([sexString isEqual:@0]){
                    sex = @"女";
                    
                }
                NSString *province = [param valueForKey:@"province"];
                NSString *city = [param valueForKey:@"city"];
                // 第三方平台SDK源数据
                NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
                
                XYLog(@"wxresp.openid is %@",resp.openid);
                [self postToThirdLogin:resp.openid userNikeName:resp.name  userSex:sex userAddress:[NSString stringWithFormat:@"%@%@",province,city] userHeadImg:[param valueForKey:@"headimgurl"] Type:@3];
            }
        }];
    }
    
}

-(void)initInputView{
    userName = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, LeftSpace, InputWidth, InputHeight)];
    userName.borderStyle = UITextBorderStyleRoundedRect;
    [userName setBackground:IMAGE(@"")];
    userName.placeholder = @"请输入用户名/手机号";
    
    
    [self.view addSubview:userName];
    
    pwd = [[UITextField alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(userName.frame)+15, InputWidth, InputHeight)];
    pwd.borderStyle = UITextBorderStyleRoundedRect;
    [pwd setBackground:IMAGE(@"")];
    pwd.placeholder = @"请输入密码";
    pwd.secureTextEntry = YES;
    [self.view addSubview:pwd];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(pwd.frame)+15, InputWidth, InputHeight)];
    [loginBtn setTitle:@"马上登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = kFONT15;
    loginBtn.titleLabel.textColor = [UIColor whiteColor];
    loginBtn.backgroundColor = RED;
    [loginBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.tag = 1;
    [self.view addSubview:loginBtn];
    
    
    UIButton *forgetBtn = [[UIButton alloc]init];
    [forgetBtn setTitleColor:RED forState:UIControlStateNormal];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = kFONT14;
    [forgetBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    forgetBtn.tag = 2;
    [self.view addSubview:forgetBtn];
    
    UIButton *registerBtn = [[UIButton alloc]init];
    [registerBtn setTitleColor:RED forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = kFONT14;
    registerBtn.titleLabel.textColor = RED;
    registerBtn.backgroundColor = [UIColor clearColor];
    registerBtn.tag = 3;
    [registerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    forgetBtn.sd_layout
    .leftSpaceToView(self.view,LeftSpace)
    .topSpaceToView(loginBtn,15)
    .widthIs(60)
    .heightIs(22);
    
    registerBtn.sd_layout
    .rightSpaceToView(self.view,LeftSpace)
    .topSpaceToView(loginBtn,15)
    .widthIs(60)
    .heightIs(22);
    int margin ;
    if(XYScreenHeight<568){
        margin = 60;
    }else{
        margin = 110;
    }
    
    if (![FNCurrentVersion isEqualToString:Setting_checkVersion]) {
        NSArray *iconArray = [NSArray array];
        
        if ([WXApi isWXAppInstalled] && [QQApiInterface isQQInstalled]) {
            iconArray = [NSArray arrayWithObjects:@"login_taobao",@"login_weixin",@"login_qq", nil];
        }
        else if (![WXApi isWXAppInstalled] && ![QQApiInterface isQQInstalled]){
            iconArray = [NSArray arrayWithObjects:@"login_taobao",@"login_weixin",@"login_qq", nil];
            
        }
        //    else if(![WXApi isWXAppInstalled]){
        //        iconArray = [NSArray arrayWithObjects:@"taobao",@"qq", nil];
        //
        //    }else if (![QQApiInterface isQQInstalled]){
        //        iconArray = [NSArray arrayWithObjects:@"taobao",@"weixin", nil];
        //
        //    }
        //下面的第三方登录View
        for (int i = 0; i<iconArray.count; i++) {
            
            UIView *btnBg = [[UIView alloc]initWithFrame:CGRectMake(i*(XYScreenWidth/3), XYScreenHeight/2+margin, XYScreenWidth/3, XYScreenWidth/3)];
            //        btnBg.backgroundColor = [UIColor redColor];
            [self.view addSubview:btnBg];
            UIButton *thirdBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnBg.frame.size.width/4, btnBg.frame.size.width-(btnBg.frame.size.width/2), btnBg.frame.size.width/3, btnBg.frame.size.width/3)];
            [thirdBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [thirdBtn setBackgroundImage:IMAGE(iconArray[i]) forState:UIControlStateNormal];
            thirdBtn.tag = i+10;
            //        [thirdBtn setBackgroundColor:[UIColor redColor]];
            [btnBg addSubview:thirdBtn];
            
        }
    }
    
    
    
    
}
#pragma 第三方登录方法
-(void)showTBLogin{

    __block LoginViewController *controller = self;

    [[ALBBSDK sharedInstance]auth:self successCallback:^(ALBBSession *session) {
        XYLog(@"getUser is %@",[session getUser]);
        controller.userId =[session getUser].openId;
        controller.userNikeName = [session getUser].nick;
        controller.userHeadImg = [session getUser].avatarUrl;
        controller.type = @2;
        [controller postToThirdLogin:controller.userId userNikeName:controller.userNikeName  userSex:nil userAddress:nil userHeadImg:controller.userHeadImg Type:controller.type];
    } failureCallback:^(ALBBSession *session, NSError *error) {
        
    }];
    //    if(![[TaeSession sharedInstance] isLogin]){
    //        [ALBBService(ALBBLoginService) showLogin:self successCallback:_loginSuccessCallback failedCallback:_loginFailedCallback];
    //    }else{
    //        TaeSession *session=[TaeSession sharedInstance];
    //        NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@,登录时间:%@",[session getUser],[session getLoginTime]];
    //        NSLog(@"%@", tip);
    //
    //        [[MyAlertView alertViewWithTitle:@"登录成功" message:tip onBtnClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    //
    //    }
}


-(BOOL)checkLoginMethod
{
    
    //Type类型 1.手机 2.邮箱
    if (![userName.text kr_isNotEmpty]) {
        [FNTipsView showTips:@"请输入用户名"];
        [userName kr_shake];
    }else if (![pwd.text kr_isNotEmpty]){
        
        [FNTipsView showTips:@"请输入密码"];
        [pwd kr_shake];
    }
    else{

        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{
              @"username":userName.text,
              @"time":[NSString GetNowTimes],
              @"pwd":[NSString md5:pwd.text]
              }];
        params[SignKey] = [NSString getSignStringWithDictionary:params];
        
        [SVProgressHUD show];
        [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_login_login successBlock:^(id responseBody) {
            NSDictionary *dict = responseBody;
            XYLog(@"responseBody2 is %@",responseBody);
            if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
                
                NSArray *tempArray = [dict objectForKey:XYData];
                [self.dataArray removeAllObjects];
                if (tempArray) {
                    for (int i = 0; i < tempArray.count; i ++) {
                        //                        model = [UserInfoModel mj_objectWithKeyValues:tempArray[i]];
                        //                        [self.dataArray addObject:model];
                        NSString *token = [tempArray valueForKey:@"token"];
                        [[NSUserDefaults standardUserDefaults] setValue:token forKey:XYAccessToken];
                            [JPUSHService setAlias:token callbackSelector:(nil) object:(nil)];
                            
                        
                    }
                    
                    
                    [SVProgressHUD dismiss];
                    _isConfirm = YES;
                    if (self.isFromWeb) {
                        //这里回调
                        [self loadDateMethod];
                        
                        [self.navigationController popViewControllerAnimated:NO];
                        self.callBackBlock(); //返回
                        return ;
                    }
                    XYTabBarViewController *mainCtrl = [XYTabBarViewController mainViewController];
                    [UIApplication sharedApplication].delegate.window.rootViewController = mainCtrl;
                    
                }
            }else
            {
                _isConfirm = NO;
                
                [XYNetworkAPI queryFinishTip:dict];
                [XYNetworkAPI cancelAllRequest];
            }
            
            
        } failureBlock:^(NSString *error) {
            [SVProgressHUD dismiss];
            [XYNetworkAPI cancelAllRequest];
        }];
        
    }
    
    return _isConfirm;
}

-(void)btnClick:(UIButton *)sender{
    NSInteger tag = sender.tag;
    XYLog(@"tag is %ld",(long)tag);
    if (tag == 1) {
        [self checkLoginMethod];
        
        
    }
    else if (tag == 2)
    {
        ForgetViewController *vc = [[ForgetViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (tag == 3)
    {
        RegisterViewController *vc = [[RegisterViewController alloc]init];
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (tag == 10)
    {
        [self showTBLogin];
    }
    else if (tag == 11)
    {
        [self clickToLoginWithWeChatMethod];
    }
    else if (tag == 12)
    {
        [self clickToLoginWithQQMethod];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    
}

#pragma - mark 写缓存为了去掉网页的头部
-(void)loadDateMethod
{
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    
    NSString *url =[NSString stringWithFormat:@"%@%@%@",IP,_api_showorder_WirteCache,UserAccessToken];
    NSURL *webUrl = [NSURL URLWithString:url];
    NSURLRequest *request =[NSURLRequest requestWithURL:webUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    __unsafe_unretained UIWebView *webView = self.webView;
    webView.delegate = self;
    [webView loadRequest:request];
    self.webView.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.userName resignFirstResponder];
}
#pragma mark -Getter
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
