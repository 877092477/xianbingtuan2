//
//  FNSettingAccountSecurityController.m
//  THB
//
//  Created by jimmy on 2017/5/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNSettingAccountSecurityController.h"
#import "FNPhoneCheckController.h"
#import "JMASBindAlipayController.h"
#import "BlindPhoneViewController.h"
#import "FNImgTitleCell.h"
#import "FNRMAccountManagementController.h"
#import "FNdg_app_updatestrModel.h"
@interface FNSettingAccountSecurityController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)FNdg_app_updatestrModel* strModel;
@property (nonatomic, strong)NSArray* titles;
@property (nonatomic, strong)NSArray* images;
@property (nonatomic, strong)NSArray* contents;
@end

@implementation FNSettingAccountSecurityController
- (NSArray *)titles{
    if (_titles == nil) {
        _titles = @[@[@"设置手机号"],@[self.strModel.mem_set_str1? self.strModel.mem_set_str1:@"设置支付宝账户"],@[@"账号关联"]];
    }
    return _titles;
}
- (NSArray *)images{
    if (_images == nil) {
        _images = @[@[@"phone"],@[self.strModel.mem_set_img? self.strModel.mem_set_img:@"alipay"],@[@"safe_relation"]];
    }
    return  _images;
}
- (NSArray *)contents
{
    
    if (_contents == nil) {
        NSString* phone  = JMEmptyCheck([ProfileModel profileInstance].phone, @"设置手机号");
        NSString* alipay  = JMEmptyCheck([ProfileModel profileInstance].zfb_au, self.strModel.mem_set_str2? self.strModel.mem_set_str2:@"设置支付宝账户");
        _contents = @[@[phone],@[alipay],@[@""]];
    }
    return _contents;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializedSubviews];
    [self requestData];
    
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(tongzhi:) name:@"EditProfile" object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.jm_tableview) {
        @weakify(self);
        [self requestMine].CompleteBlock = ^(NSString *error) {
            @strongify(self);
            self.contents = nil;
            [self.jm_tableview reloadData];
        };
        
    }
}
- (FNRequestTool *)requestData{
    return [FNRequestTool requestWithParams:nil api:@"mod=appapi&act=dg_app_updatestr&ctrl=set" respondType:(ResponseTypeModel) modelType:@"FNdg_app_updatestrModel" success:^(id respondsObject) {
        //
        self.strModel=respondsObject;
        self.titles = nil;
        self.images = nil;
        self.contents = nil;
        [self.jm_tableview reloadData];
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}
-(FNRequestTool *)requestMine{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:_api_mine_getUserInfo respondType:(ResponseTypeModel) modelType:@"ProfileModel" success:^(id respondsObject) {
        //
        [ProfileModel saveProfile:respondsObject];
    } failure:^(NSString *error) {
        //
        ProfileModel* model = [ProfileModel new];
        [ProfileModel saveProfile:model];
    } isHideTips:YES];
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.title = @"账户安全";
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    self.jm_tableview.dataSource=self;
    self.jm_tableview.delegate=self;
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    self.jm_tableview.showsHorizontalScrollIndicator = YES;
    self.jm_tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.jm_tableview.scrollEnabled = NO;
    [self.view addSubview:self.jm_tableview];
    
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
}
#pragma mark 配置TableView数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titles.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray* array = self.titles[section];
    
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNImgTitleCell* cell = [FNImgTitleCell cellWithTableView:tableView atIndexPath:indexPath];
    
    [cell setImage:self.images[indexPath.section][indexPath.row] andTitle:self.titles[indexPath.section][indexPath.row]];
    cell.subTitleLabel.text = self.contents[indexPath.section][indexPath.row];
    cell.subTitleLabel.font = kFONT12;
    cell.subTitleLabel.textColor = FNMainTextNormalColor;
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if ([[ProfileModel profileInstance].phone kr_isNotEmpty]) {
            FNPhoneCheckController * phone = [FNPhoneCheckController new];
            phone.username = [ProfileModel profileInstance].phone;
            phone.title = @"修改手机号";
            phone.sourceType = @"phone_update";
            phone.successCheckBlock = ^(NSString *username, UIViewController *VC) {
                BlindPhoneViewController *vc = [[BlindPhoneViewController alloc]init];
            
                [self.navigationController pushViewController:vc animated:YES];
                
            };
            [self.navigationController pushViewController:phone animated:YES];
        }else{
            BlindPhoneViewController *vc = [[BlindPhoneViewController alloc]init];
        
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
    }else if (indexPath.section == 1){
        //set alipay account
        
        //judge phone valid or not
        if ([[ProfileModel profileInstance].zfb_au kr_isNotEmpty]) {

            FNRMAccountManagementController* vc = [FNRMAccountManagementController new];
            [self.navigationController pushViewController:vc animated:YES];
            
        } else {
            //unvalid,need to bind phone number
            if (![NSString isEmpty:[ProfileModel profileInstance].phone]) {
                JMASBindAlipayController *vc = [[JMASBindAlipayController alloc]init];
                vc.vcstring = @"FNSettingAccountSecurityController";
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                BlindPhoneViewController *vc = [[BlindPhoneViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
        }

        
    }else if(indexPath.section == 2){
        [self.navigationController pushViewController:[UIViewController getVCByClassName:@"FNAccountReleatedController" orIdentifier:nil andParams:nil] animated:YES];
    }
}

- (void)tongzhi:(NSNotification *)noti{
    XYLog(@"－－－－－修改成功------");
    [self postUserInfo:[noti.userInfo objectForKey:@"isPhone"]];
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
            
//            [self loadDataMethodWithCache:NO];
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
@end
