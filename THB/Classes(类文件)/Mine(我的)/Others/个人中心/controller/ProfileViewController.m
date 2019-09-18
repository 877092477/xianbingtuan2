//
//  ProfileViewController.m
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

#import "ProfileViewController.h"
#import "UserPictureCell.h"
#import "ProfileCell.h"
#import "RenameViewController.h"
#import "BlindAliPayViewController.h"
#import "BindEmailViewController.h"
#import "BlindPhoneViewController.h"
#import "GetProvinceViewController.h"
#import "FNPhoneCheckController.h"
#import "FNRMAccountManagementController.h"
#import "JMASBindAlipayController.h"
#import "ModifyPaymentPasswordController.h"
#import "FNModifyLoginPasswordController.h"
@interface ProfileViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property (nonatomic,strong) UITableView *xy_TableView;

/** 数据数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) ProfileModel *model;
@end

@implementation ProfileViewController
@synthesize xy_TableView,model;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    //注册通知
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(tongzhi:) name:@"EditProfile" object:nil];
    [self initTableView];
    [self loadDataMethod];
    [self requestData];
}

/**
 *  接收搜索结果
 *
 *  @param noti <#noti description#>
 */
- (void)tongzhi:(NSNotification *)noti{
    XYLog(@"－－－－－修改成功------");
    [self postUserInfo:[noti.userInfo objectForKey:@"isPhone"]];
}
#pragma 获取数据
-(void)loadDataMethod {
    [self loadDataMethodWithCache:YES];
}
-(void)loadDataMethodWithCache: (BOOL)isCache
{
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                  @"token":UserAccessToken,
                                                                                  @"time":[NSString GetNowTimes]
                                                                                  }];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_mine_getUserInfo isCache:isCache successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        
        XYLog(@"UserInforesponseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            
            model = [ProfileModel mj_objectWithKeyValues:[dict objectForKey:XYData]];
            
            //将用户信息保存在本地
            [[NSUserDefaults standardUserDefaults] setValue:model.nickname forKey:XYUserNick];
            [[NSUserDefaults standardUserDefaults] setValue:model.head_img forKey:XYhead_img];
            [[NSUserDefaults standardUserDefaults] setValue:model.checkTime forKey:XYcheckTime];
            [[NSUserDefaults standardUserDefaults] setValue:model.vip forKey:XYvip];
            [[NSUserDefaults standardUserDefaults] setValue:model.phone forKey:XYUserPhone];
            [[NSUserDefaults standardUserDefaults] setValue:model.sex forKey:XYsex];
            [[NSUserDefaults standardUserDefaults] setValue:model.realname forKey:XYrealname];
            [[NSUserDefaults standardUserDefaults] setValue:model.taobao_au forKey:XYtaobao_au];
            [[NSUserDefaults standardUserDefaults] setValue:model.money forKey:XYmoney];
            [[NSUserDefaults standardUserDefaults] setValue:model.loginname forKey:XYloginname];
            [[NSUserDefaults standardUserDefaults] setValue:model.checkNum forKey:XYcheckNum];
            [[NSUserDefaults standardUserDefaults] setValue:model.zfb_au forKey:XYzfb_au];
            [[NSUserDefaults standardUserDefaults] setValue:model.growth forKey:XYgrowth];
            [[NSUserDefaults standardUserDefaults] setValue:model.integral forKey:XYintegral];
            [[NSUserDefaults standardUserDefaults] setValue:model.qq forKey:XYqq];
            [[NSUserDefaults standardUserDefaults] setValue:model.email forKey:XYemail];
            [[NSUserDefaults standardUserDefaults] setValue:model.qq_au forKey:XYqq_au];
            [[NSUserDefaults standardUserDefaults] setValue:model.sina_au forKey:XYsina_au];
            [[NSUserDefaults standardUserDefaults] setValue:model.returnmoney forKey:XYReturnMoney];
            [[NSUserDefaults standardUserDefaults] setValue:model.commission forKey:XYFcommission];
            [[NSUserDefaults standardUserDefaults] setValue:model.tid forKey:XYTid];
            [[NSUserDefaults standardUserDefaults] setValue:model.three_nickname forKey:XYthree_nickname];
            [[NSUserDefaults standardUserDefaults] setValue:model.like_count forKey:XYlike_count];
            [[NSUserDefaults standardUserDefaults] setValue:model.address forKey:XYAddress];
            [[NSUserDefaults standardUserDefaults] setValue:model.zztx forKey:XYzztx];
            [[NSUserDefaults standardUserDefaults] setValue:model.gywm forKey:XYgywm];
            [[NSUserDefaults standardUserDefaults] setValue:model.lhbtx forKey:XYlhbtx];
            [[NSUserDefaults standardUserDefaults] setValue:model.hbtx forKey:XYhbtx];
            [[NSUserDefaults standardUserDefaults] setValue:model.extend_id forKey:XYextend_id];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [xy_TableView reloadData];
            [SVProgressHUD dismiss];
        }else{
            
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
        [xy_TableView.mj_footer endRefreshing];
    }];
}

- (FNRequestTool *)requestData{
    return [FNRequestTool requestWithParams:nil api:@"mod=appapi&act=dg_app_updatestr&ctrl=set" respondType:(ResponseTypeModel) modelType:@"FNdg_app_updatestrModel" success:^(id respondsObject) {
        //
        self.strModel=respondsObject;
        [xy_TableView reloadData];
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}


#pragma mark 初始化界面
-(void)initTableView{
    
    xy_TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight) style:UITableViewStyleGrouped];
    xy_TableView.dataSource=self;
    xy_TableView.delegate=self;
    xy_TableView.showsVerticalScrollIndicator = NO;
    xy_TableView.showsHorizontalScrollIndicator = YES;
    xy_TableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:xy_TableView];
}

#pragma mark 配置TableView数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
    {
        return 2;
    }
    else if(section == 1)
    {
        return 6;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            return 80;
        }else{
            return 55;
        }
    }
    else if(indexPath.section == 1)
    {
        return 55;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }else if (section == 1)
    {
        return 30;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, 50)];
        view.backgroundColor = RGB(240, 240, 240);
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 30)];
        lable.text = @"账号";
        lable.font = kFONT16;
        [view addSubview:lable];
        return view;
        
    }
    return nil;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *ID = @"UserPictureCell";
            UserPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"UserPictureCell" owner:self options:nil] lastObject];
            }
            [cell.userImg sd_setImageWithURL:URL(Userhead_img) placeholderImage:IMAGE(@"tx")];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *ID = @"ProfileCell";
            ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ProfileCell" owner:self options:nil] lastObject];
                
            }
            cell.rightLbl.text = [[NSUserDefaults standardUserDefaults] valueForKey:XYUserNick];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    else if (indexPath.section == 1)
    {
        static NSString *ID = @"ProfileCell";
        ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ProfileCell" owner:self options:nil] lastObject];
            
        }
        NSArray *leftLblStr = [NSArray arrayWithObjects:self.strModel.mem_set_str1? self.strModel.mem_set_str1:@"支付宝",@"设置支付密码",@"设置登录密码",@"手机号",@"邮箱",@"所在地",@"账户关联", nil];
        cell.leftLbl.text = leftLblStr[indexPath.row];
        cell.rightLbl.text = @"";
        if (indexPath.row == 0) {
            NSString *rightString = [[NSUserDefaults standardUserDefaults] valueForKey:XYzfb_au];
            if ([rightString kr_isNotEmpty]) {
                cell.rightLbl.text = rightString;
            }else{
                cell.rightLbl.text = self.strModel.mem_set_str2? self.strModel.mem_set_str2:@"立即绑定拿返利";
                cell.rightLbl.textColor = RED;
            }
            
        }
        if (indexPath.row == 3) {
            NSString *rightString = [[NSUserDefaults standardUserDefaults] valueForKey:XYUserPhone];
            if ([rightString kr_isNotEmpty]) {
                cell.rightLbl.text = rightString;
            }else{
                cell.rightLbl.text = self.strModel.mem_set_str2? self.strModel.mem_set_str2:@"立即绑定获取返利信息";
                cell.rightLbl.textColor = RED;
            }
            
        }
        
        if (indexPath.row == 4) {
            NSString *rightString = [[NSUserDefaults standardUserDefaults] valueForKey:XYemail];
            if ([rightString kr_isNotEmpty]) {
                cell.rightLbl.text = rightString;
            }else{
                cell.rightLbl.text = self.strModel.mem_set_str2? self.strModel.mem_set_str2:@"立即绑定获取返利信息";
                cell.rightLbl.textColor = RED;
            }
            
        }
        if (indexPath.row == 5) {
            NSString *rightString = UserAddress;
            XYLog(@"UserAddress is %@",UserAddress);
            if ([rightString kr_isNotEmpty]) {
                cell.rightLbl.text = rightString;
            }else{
                cell.rightLbl.text = @"请选择您的所在地";
                cell.rightLbl.textColor = RED;
            }
        }

        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
}

#pragma TableView代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //弹出ActionSheet
    if(indexPath.section == 0)
    {
        if (indexPath.row == 1) {
            RenameViewController *vc = [[RenameViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.navigationController.navigationBarHidden = NO;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            if ([Userzfb_au kr_isNotEmpty]) {
                FNRMAccountManagementController* vc = [FNRMAccountManagementController new];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                if (![NSString isEmpty:[ProfileModel profileInstance].phone]) {
                    JMASBindAlipayController *vc = [[JMASBindAlipayController alloc]init];
                    vc.vcstring = @"ProfileViewController";
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    BlindPhoneViewController *vc = [[BlindPhoneViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
            }
        } else if (indexPath.row == 1) {
            ModifyPaymentPasswordController *controller = [[ModifyPaymentPasswordController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }else if (indexPath.row == 2) {
            FNModifyLoginPasswordController *controller = [[FNModifyLoginPasswordController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }else if (indexPath.row == 4){
            if ([Useremail kr_isNotEmpty]) {
                FNPhoneCheckController * phone = [FNPhoneCheckController new];
                phone.username = [ProfileModel profileInstance].phone;
                phone.title = @"修改邮箱";
                phone.successCheckBlock = ^(NSString *username, UIViewController *VC) {
                    BindEmailViewController *vc = [[BindEmailViewController alloc]init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.navigationController.navigationBarHidden = NO;
                    [self.navigationController pushViewController:vc animated:YES];
                };
                [self.navigationController pushViewController:phone animated:YES];
            }else{
                BindEmailViewController *vc = [[BindEmailViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.navigationController.navigationBarHidden = NO;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
        }else if (indexPath.row == 3){
            
            if ([UserPhone kr_isNotEmpty]) {
                FNPhoneCheckController * phone = [FNPhoneCheckController new];
                phone.username = [ProfileModel profileInstance].phone;
                phone.title = @"修改手机号";
                phone.sourceType = @"phone_update";
                phone.successCheckBlock = ^(NSString *username, UIViewController *VC) {
                    BlindPhoneViewController *vc = [[BlindPhoneViewController alloc]init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.navigationController.navigationBarHidden = NO;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                };
                [self.navigationController pushViewController:phone animated:YES];
            }else{
                BlindPhoneViewController *vc = [[BlindPhoneViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.navigationController.navigationBarHidden = NO;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else if (indexPath.row == 5){
            GetProvinceViewController *vc = [[GetProvinceViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.navigationController.navigationBarHidden = NO;
            vc.title = @"选择省份";
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 6){
            [self.navigationController pushViewController:[UIViewController getVCByClassName:@"FNAccountReleatedController" orIdentifier:nil andParams:nil] animated:YES];
        }
    }
    
}

-(void)postUserInfo:(NSString *)isZhifubao{
    NSMutableDictionary* param;
    if ([isZhifubao isEqualToString:@"1"]) {
        param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                @"nickname":UserNick,
                                                                @"email":Useremail,
                                                                @"phone":UserPhone,
                                                                @"token":UserAccessToken,
                                                                @"address":UserAddress}];
        param[SignKey] = [NSString getSignStringWithDictionary:param];
    }else{
        param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                @"nickname":UserNick,
                                                                
                                                                @"email":Useremail,
                                                                @"token":UserAccessToken,
                                                                @"address":UserAddress}];
        param[SignKey] = [NSString getSignStringWithDictionary:param];
    }
    
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_updateUser successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            
            [SVProgressHUD dismiss];
            [FNTipsView showTips:@"修改成功"];
            
            [self loadDataMethodWithCache:NO];
        }else
        {
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        
        
    } failureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
        [XYNetworkAPI cancelAllRequest];
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = NO;
    
    if (iOS7) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
