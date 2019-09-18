//
//  SettingViewController.m
//  THB
//
//  Created by zhongxueyu on 16/3/30.
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
#import "SettingViewController.h"
#import "FeedBackViewController.h"
#import "FNSettingAccountSecurityController.h"

#import "FNImgTitleCell.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"

#import "FNclienteleDeController.h"



@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
@property (nonatomic,strong) UITableView *xy_TableView;

@property (nonatomic,strong) UIButton *logoutBtn;

@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic, strong)NSArray* titles;
@property (nonatomic, strong)NSArray* images;


@end

@implementation SettingViewController
@synthesize xy_TableView,logoutBtn;
- (NSArray *)titles{
    if (_titles == nil) {
        if ([UserAccessToken kr_isNotEmpty]) {
            _titles = @[@[@"帮助与客服"],@[@"账户安全",@"关于我们",@"意见反馈",@"常见问题",@"服务协议"],@[@"清空缓存"],@[@"退出登录"]];
        } else {
            _titles = @[@[@"帮助与客服"],@[@"账户安全",@"关于我们",@"意见反馈",@"常见问题",@"服务协议"],@[@"清空缓存"]];
        }
    }
    return _titles;
}
- (NSArray *)images{
    if (_images == nil) {
        if ([UserAccessToken kr_isNotEmpty]) {
            _images = @[@[@"service"],@[@"safe",@"our",@"opinion",@"set_help",@"agreement"],@[@"clear"],@[@""]];
        } else {
            _images = @[@[@"service"],@[@"safe",@"our",@"opinion",@"set_help",@"agreement"],@[@"clear"]];
        }
    }
    return  _images;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(239, 239, 244);
    // Do any additional setup after loading the view.
    self.title = @"设置";
    [self initTableView];
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initLogoViewMethod{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, XYScreenHeight-140, XYScreenWidth, 50)];
    
    [self.view addSubview:bgView];
    
    UIImageView *logoImg = [[UIImageView alloc]initWithFrame:CGRectMake(XYScreenWidth/2-22.5, 0, 45, 15)];
    logoImg.image = JM_AppLogo;
    [bgView addSubview:logoImg];
    
    
    UILabel *companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(logoImg.frame)+3, XYScreenWidth, 21)];
    companyLabel.text = [NSString stringWithFormat:@"©%@",JM_CompanyName];
    companyLabel.textAlignment = NSTextAlignmentCenter;
    companyLabel.font = kFONT13;
    companyLabel.textColor = GrayColor;
    [bgView addSubview:companyLabel];
    
    
}
#pragma mark 初始化界面
-(void)initTableView{
    
    xy_TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, FNDeviceHeight) style:UITableViewStyleGrouped];
    xy_TableView.dataSource=self;
    xy_TableView.delegate=self;
    xy_TableView.showsVerticalScrollIndicator = NO;
    xy_TableView.showsHorizontalScrollIndicator = YES;
    xy_TableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    xy_TableView.scrollEnabled = NO;
    [self.view addSubview:xy_TableView];
    
    
    //退出按钮
    logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(xy_TableView.frame)+5, XYScreenWidth-LeftSpace*2, 45)];
    [logoutBtn.layer setMasksToBounds:YES];
    [logoutBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    logoutBtn.titleLabel.font = kFONT13;
    logoutBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [logoutBtn setBackgroundColor:RED];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    logoutBtn.tag = 1;
    [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(clickToLougoutMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutBtn];
    
    if ([JM_CompanyName kr_isNotEmpty]) {
        [self initLogoViewMethod];

    }
}

-(void)clickToLougoutMethod:(UIButton *)sender
{
    [self loadDateMethod];
    [self cleanCacheAndCookie];
    [[ALBBSDK sharedInstance]logout];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:XYAccessToken];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:XYUserID];
        [JPUSHService setAlias:@"" callbackSelector:(nil) object:(nil)];
        
    XYTabBarViewController *mainCtrl = [XYTabBarViewController mainViewController];
    [UIApplication sharedApplication].delegate.window.rootViewController = mainCtrl;
    [self reqeustBaseSetting];
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
#pragma mark 配置TableView数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titles.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray* array = self.titles[section];

    return array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.01;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 55;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNImgTitleCell* cell = [FNImgTitleCell cellWithTableView:tableView atIndexPath:indexPath];

    [cell setImage:self.images[indexPath.section][indexPath.row] andTitle:self.titles[indexPath.section][indexPath.row]];
    if (indexPath.section == 3) {
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        UILabel* titleLabel = [UILabel new];
        titleLabel.font = kFONT14;
        titleLabel.text = self.titles[indexPath.section][indexPath.row];
        [cell.contentView addSubview:titleLabel];
        [titleLabel autoCenterInSuperview];
    }else{
        if (indexPath.section != 2) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
             cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section == 0) {
        //帮助与客服
        [self goWebDetailWithWebType:@"0" URL:[NSString stringWithFormat:@"%@%@",IP,_api_mine_usehelp]];
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                if ([UserAccessToken kr_isNotEmpty]) {
                    //account security
                    FNSettingAccountSecurityController* account = [FNSettingAccountSecurityController new];
                    [self.navigationController pushViewController:account animated:YES];
                } else {
                    [self gologin];
                }
                break;
            }
            case 1:{
                //about us
                 [self goWebWithUrl:Usergywm];
                break;
            }
            case 2:{
                //feedback
                FeedBackViewController *vc = [[FeedBackViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 3:{
                if([FNCurrentVersion isEqualToString:Setting_checkVersion]) {
                    FNclienteleDeController *vc = [[FNclienteleDeController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                } else {
                //help center
                    [self goWebDetailWithWebType:@"0" URL:[NSString stringWithFormat:@"%@%@",IP,_api_mine_commproblem]];
                }
                break;
            }
            case 4:{
                //service proxy
                [self goWebDetailWithWebType:@"0" URL:[NSString stringWithFormat:@"%@%@",IP,_api_mine_ServiceProxy]];
                break;
            }
                
                
            default:
                break;
        }
    }else if (indexPath.section == 2){
        //clean memery
        [self clearFile];
    }else if (indexPath.section == 3) {
        if ([UserAccessToken kr_isNotEmpty]) {
            [self clickToLougoutMethod:nil];
        }
    }
    
}

#pragma mark - clean
-(void)clearCachSuccess
{
    int time = (arc4random() % 4) + 1;
    
    [FNTipsView showTips:@"正在清除缓存.."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //                [SVProgressHUD dismiss];
        [FNTipsView showTips:@"清理成功"];
        
    });
    [xy_TableView reloadData];
}
// 清理缓存

- (void)clearFile
{
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    
    NSLog ( @"cachpath = %@" , cachPath);
    
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
            
        }
        
    }
    
    [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone : YES ];
    [XYNetworkCache.shareInstance clearCache];
}

/**清除缓存和cookie*/
- (void)cleanCacheAndCookie{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

//获取基本设置
- (FNRequestTool *)reqeustBaseSetting{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:_api_others_getset respondType:(ResponseTypeModel) modelType:@"FNBaseSettingModel" success:^(id respondsObject) {
        //
        FNBaseSettingModel* defaultModel = [FNBaseSettingModel settingInstance];
        FNBaseSettingModel* model = respondsObject;
//        model.tabs = defaultModel.tabs;
        model.ksrk = defaultModel.ksrk;
        model.tw = defaultModel.tw;
        [FNBaseSettingModel saveSetting:model];
        [[NSUserDefaults standardUserDefaults] setValue:model.extendreg forKey:XYextendreg];
        [[NSUserDefaults standardUserDefaults] setValue:model.appopentaobao_onoff forKey:XYappopentaobao_onoff];
        [[NSUserDefaults standardUserDefaults] setValue:model.WeChatAppSecret forKey:XYWeChatAppSecret];
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache: NO];
}

@end
