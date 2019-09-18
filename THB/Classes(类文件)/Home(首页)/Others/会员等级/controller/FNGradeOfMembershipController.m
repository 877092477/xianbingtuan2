//
//  FNGradeOfMembershipController.m
//  THB
//
//  Created by Jimmy on 2018/9/7.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
//会员等级
#import "FNGradeOfMembershipController.h"
#import "secondViewController.h"
#import "FNUpgradeStrategyNController.h"

#import "FNCustomeNavigationBar.h"
#import "FNmemberMatterCell.h"
#import "FNmemberMessageHeaderview.h"

#import "GradeMemberNModel.h"

@interface FNGradeOfMembershipController ()<UITableViewDataSource,UITableViewDelegate>
/** 会员数据 **/
@property(nonatomic,strong)GradeMemberNModel *MemberNModel;
@property(nonatomic,strong)NSMutableArray *datalist;
@end

@implementation FNGradeOfMembershipController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if ([NSString isEmpty:UserAccessToken]) {
        [self warnToLogin];
    }
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.title=@"会员等级";
    if([UserAccessToken kr_isNotEmpty]){
       [self apiRequestMemberList];
    }
    
    [self initbillSubviews];
}
- (void)navigationView{
    FNCustomeNavigationBar* navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    
    navigationView.backgroundColor=FNColor(255, 64, 64);
    UIButton* MemberbackBtn = [UIButton buttonWithTitle:@"" titleColor:FNWhiteColor font:kFONT12 target:self action:@selector(backAction)];
    [MemberbackBtn setImage:IMAGE(@"return2member") forState:(UIControlStateNormal)];
    [MemberbackBtn sizeToFit];
    MemberbackBtn.size = CGSizeMake(MemberbackBtn.width+_jmsize_10, 20);
    navigationView.leftButton = MemberbackBtn;
    navigationView.leftButton.hidden = self.understand;
    
    UIButton* ruleBtn = [UIButton buttonWithTitle:@"  规则 > " titleColor:FNWhiteColor font:kFONT12 target:self action:@selector(ruleBtnAction)];
    //[ruleBtn setImage:IMAGE(@"return") forState:(UIControlStateNormal)];
    [ruleBtn sizeToFit];
    ruleBtn.size = CGSizeMake(ruleBtn.width+_jmsize_10, 20);
    navigationView.rightButton = ruleBtn;
    navigationView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:navigationView];
    
}
//返回
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//规则
-(void)ruleBtnAction{
     if([UserAccessToken kr_isNotEmpty]){
        secondViewController *web = [secondViewController new];
        web.url =self.MemberNModel.url;
        //web.isLaunch = YES;
        [self.navigationController pushViewController:web animated:YES];
    }else{
        [self gologin];
    }
}

#pragma mark - initializedSubviews
- (void)initbillSubviews
{
    self.jm_tableview = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight)) style:(UITableViewStyleGrouped)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.backgroundColor = FNWhiteColor;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.jm_tableview];
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.estimatedRowHeight = 0;
        self.jm_tableview.estimatedSectionFooterHeight = 0;
        self.jm_tableview.estimatedSectionHeaderHeight= 0;
        self.jm_tableview.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
    @WeakObj(self);
    self.jm_tableview.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.jm_page = 1;
        [self apiRequestMemberList];
    }];
    self.jm_tableview.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        selfWeak.jm_page  = 1;
        [self apiRequestMemberList];
    }];
    
    [self.jm_tableview registerClass:[FNmemberMessageHeaderview class]  forHeaderFooterViewReuseIdentifier:@"MessageNView"];
    [self navigationView];
    
}
#pragma mark - Tabel view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datalist.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    FNmemberMatterCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MatterCellID"];
    if (cell == nil) {
        cell = [[FNmemberMatterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MatterCellID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    GradeAdvertisingNModel *model=self.datalist[indexPath.row];
    cell.model=model;
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    FNmemberMessageHeaderview *heardView = [[FNmemberMessageHeaderview alloc]initWithReuseIdentifier:@"MessageNView"];
    heardView.backgroundColor=[UIColor whiteColor];
    heardView.model=self.MemberNModel;
    @weakify(self);
    heardView.stickupClickString = ^(GradeMemberNModel *model) {
        //NSLog(@"tgid:%@",model.tgid);
        @strongify(self);
        if([UserAccessToken kr_isNotEmpty]){
            [[UIPasteboard generalPasteboard] setString:model.tgid];
        } else{
            [self gologin];
        }
    };
    heardView.SelectedGradeClick = ^(GradeMemberNModel *model) {
        FNUpgradeStrategyNController *StrategyVC = [FNUpgradeStrategyNController new];
        StrategyVC.StrategyModel=model;
        [self.navigationController pushViewController:StrategyVC animated:YES];
    };
    
    return heardView;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self loadOtherVCWithModel:self.MemberNModel.guanggao[indexPath.row] andInfo:nil outBlock:nil];
   
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 285;
}

#pragma mark - Request
//用于获取搜索会员
- (FNRequestTool *)apiRequestMemberList{
    [self.jm_tableview.mj_footer endRefreshing];
    [self.jm_tableview.mj_header endRefreshing];
    [SVProgressHUD show];
    @WeakObj(self);
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appHigh&ctrl=memlv_index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"会员等级:%@",respondsObject);
        NSDictionary *dic=  respondsObject [DataKey];
        selfWeak.MemberNModel= [GradeMemberNModel mj_objectWithKeyValues:dic];
        NSArray *arrAy=dic[@"guanggao"];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dictDict in arrAy) {
            [arrM addObject:[GradeAdvertisingNModel mj_objectWithKeyValues:dictDict]];
        }
        selfWeak.datalist=arrM;
 
       [UIView animateWithDuration:0.2 animations:^{
            [SVProgressHUD dismiss];
            [selfWeak.jm_tableview reloadData];
        }];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
- (NSMutableArray *)datalist
{
    if (_datalist == nil) {
        _datalist = [NSMutableArray new];
    }
    return _datalist;
}
@end
