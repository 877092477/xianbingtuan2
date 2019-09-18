//
//  FNEarningsMenuNController.m
//  THB
//
//  Created by 李显 on 2018/9/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNEarningsMenuNController.h"
#import "secondViewController.h"
#import "FNMineBillNController.h"
#import "FNWithdrawController.h"
#import "JMASBindAlipayController.h"

#import "FNCustomeNavigationBar.h"
#import "FNgatherHeadNCell.h"
#import "FNEarningsDayNCell.h"
#import "FNEarningsOneHeadView.h"
#import "FNEarningsDayNHeadView.h"
#import "FNBrokerageDetailHeadView.h"

#import "FNEarnigsNModel.h"

@interface FNEarningsMenuNController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)FNEarnigsNModel *EarningsDic;

@property (nonatomic,strong)NSMutableArray *lastList;
@property (nonatomic,strong)NSMutableArray *todayList;
@property (nonatomic,strong)NSMutableArray *yesList;
@end

@implementation FNEarningsMenuNController
-(NSMutableArray *)lastList{
    if (!_lastList) {
        _lastList = [NSMutableArray array];
    }
    return _lastList;
}
-(NSMutableArray *)todayList{
    if (!_todayList) {
        _todayList = [NSMutableArray array];
    }
    return _todayList;
}
-(NSMutableArray *)yesList{
    if (!_yesList) {
        _yesList = [NSMutableArray array];
    }
    return _yesList;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    NSString *token = UserAccessToken;
    if (!(token && token.length>=1)) {
        [self warnToLogin];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"收益表单";
    if([UserAccessToken kr_isNotEmpty]){
       [self apiRequestEarnings];
    }
    [self initMenuTableView];
}

#pragma mark - initializedNavBar 导航栏
- (void)setMenuNaviBar{
    FNCustomeNavigationBar*_cuNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    _cuNaivgationbar.backgroundColor=[UIColor clearColor];
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backBtn setImage:[UIImage imageNamed:@"return-white"] forState:UIControlStateNormal];
    [backBtn sizeToFit];
    backBtn.size = CGSizeMake(backBtn.width+10, backBtn.height+10);
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    if(self.understand==YES){
       backBtn.hidden=YES;
    }else{
       backBtn.hidden=NO;
    }
    UIButton *msgBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [msgBtn setImage:[UIImage imageNamed:@"agent_help"] forState:UIControlStateNormal];
    [msgBtn sizeToFit];
    msgBtn.size = CGSizeMake(msgBtn.width+10, msgBtn.height+10);
    [msgBtn addTarget:self action:@selector(messageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _cuNaivgationbar.leftButton = backBtn;
    _cuNaivgationbar.rightButton = msgBtn;
    [self.view addSubview:_cuNaivgationbar];
}

-(void)backBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)messageBtnAction{
    NSString *token = UserAccessToken;
    if (!(token && token.length>=1)) {
        [self gologin];
        return;
    }
    secondViewController *web = [secondViewController new];
    web.url =self.EarningsDic.topUrl;
    [self.navigationController pushViewController:web animated:YES];
    
}
#pragma mark - initMenuTableView
- (void)initMenuTableView
{
    CGFloat tableHeight=FNDeviceHeight;
    if(self.understand==YES){
        tableHeight=FNDeviceHeight-XYTabBarHeight;
    }
    self.jm_tableview = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, tableHeight)) style:(UITableViewStyleGrouped)];
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
    if([UserAccessToken kr_isNotEmpty]){
        @WeakObj(self);
        self.jm_tableview.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            selfWeak.jm_page = 1;
            [self apiRequestEarnings];
        }];
    }
    
    self.jm_tableview.sectionFooterHeight=0;
    [self.jm_tableview registerClass:[FNEarningsDayNHeadView class]  forHeaderFooterViewReuseIdentifier:@"DayheadView"];
    
    [self.jm_tableview registerClass:[UITableViewHeaderFooterView class]  forHeaderFooterViewReuseIdentifier:@"MessageNView"];
    [self.jm_tableview registerClass:[FNBrokerageDetailHeadView class]  forHeaderFooterViewReuseIdentifier:@"DetailNView"];
    [self.jm_tableview registerClass:[FNEarningsOneHeadView class]  forHeaderFooterViewReuseIdentifier:@"EarningsView"];
    
    [self setMenuNaviBar];
    
}
#pragma mark - Tabel view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        FNgatherHeadNCell* gathercell = [tableView dequeueReusableCellWithIdentifier:@"gatherCellID"];
        if (gathercell == nil) {
            gathercell = [[FNgatherHeadNCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"gatherCellID"];
        }
        gathercell.modelArr=self.lastList;
        gathercell.selectionStyle = UITableViewCellSelectionStyleNone;
        return gathercell;
    }
     else if(indexPath.section==2 ||indexPath.section==3){
         FNEarningsDayNCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MatterCellID"];
         if (cell == nil) {
             cell = [[FNEarningsDayNCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MatterCellID"];
         }
         if(indexPath.section==2){
             cell.modelArr=self.todayList;
         }
         if(indexPath.section==3){
             cell.modelArr=self.yesList;
         }
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
     }else{
         UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
         if (cell == nil) {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
         }
         cell.backgroundColor=[UIColor whiteColor];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
     }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
     if(section==0){
        
        FNEarningsOneHeadView *EarningsView = [[FNEarningsOneHeadView alloc]initWithReuseIdentifier:@"EarningsView"];
        EarningsView.model=self.EarningsDic;
        EarningsView.BgImageView.userInteractionEnabled = YES;
        NSString *is_tx=[[NSUserDefaults standardUserDefaults] objectForKey:@"JM_MPM_wallet_is_tx"];
        if ([NSString checkIsSuccess:is_tx andElement:@"1"]) {
            @weakify(self);
            [EarningsView.depositiImg addJXTouch:^{
                @strongify(self);
                if ([[ProfileModel profileInstance].zfb_au kr_isNotEmpty]) {
                    FNWithdrawController* vc = [[FNWithdrawController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                } else {
                    JMASBindAlipayController* alipay = [JMASBindAlipayController new];
                    [self.navigationController pushViewController:alipay animated:YES];
                }
            }];
        } 
        return EarningsView;
     }else if(section==2 ||section==3){
        
        FNEarningsDayNHeadView *DayheardView = [[FNEarningsDayNHeadView alloc]initWithReuseIdentifier:@"DayheadView"];
         if(section==2){
             DayheardView.headTitle.text=@"今日";
             DayheardView.headImageView.image=IMAGE(@"agent_day");
         }
         if(section==3){
             DayheardView.headTitle.text=@"昨日";
             DayheardView.headImageView.image=IMAGE(@"agent_yesterday");
         }
         
        return DayheardView;
     }else if(section==4){
         
        FNBrokerageDetailHeadView *DetailView = [[FNBrokerageDetailHeadView alloc]initWithReuseIdentifier:@"DetailNView"];
        
        DetailView.headTitle.text=@"结算佣金明细";
        DetailView.headImageView.image=IMAGE(@"issue_right");
         
        DetailView.userInteractionEnabled = YES;
        UITapGestureRecognizer *Detailtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DetailViewclick)];
        [DetailView addGestureRecognizer:Detailtap];
        return DetailView;
     }else{
         UITableViewHeaderFooterView *heardView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"MessageNView"];
         return heardView;
     } 
}
-(void)DetailViewclick{
    NSLog(@"详情");
    NSString *token = UserAccessToken;
    if (!(token && token.length>=1)) {
        [self gologin];
        return;
    }
    FNMineBillNController * BillVC=[[FNMineBillNController alloc]init];
    [self.navigationController pushViewController:BillVC animated:YES];
 
}
-(void)extractCilck{
    NSString *token = UserAccessToken;
    if (!(token && token.length>=1)) {
        [self gologin];
        return;
    }
    if ([[ProfileModel profileInstance].zfb_au kr_isNotEmpty]) {
        FNWithdrawController* vc = [[FNWithdrawController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        JMASBindAlipayController* alipay = [JMASBindAlipayController new];
        [self.navigationController pushViewController:alipay animated:YES];
    }
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        return 0.01;
    }else if (indexPath.section==1){
        return 120;
    }
    else if (indexPath.section==2 || indexPath.section==3){
        return 85;
    }
    else{
        return 0.1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
         return 240;
    }else if (section==1){
        return 0.01;
    }else if (section==4){
        return 50;
    }
    else{
        return 40;
    }
   
}
#pragma mark - Request
//获取分类列表左边
- (FNRequestTool *)apiRequestEarnings{
    [self.jm_tableview.mj_header endRefreshing];
    [self.jm_tableview.mj_footer endRefreshing];
    @WeakObj(self);
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appAgentReport&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        
        NSLog(@"收益:%@",respondsObject);
        NSDictionary *dictry=respondsObject[DataKey];
        NSArray *oneArr=dictry[@"lastList"];
        NSArray *twoArr=dictry[@"todayList"];
        NSArray *threeArr=dictry[@"yesList"];
        NSMutableArray *arrO=[NSMutableArray arrayWithCapacity:0];
         NSMutableArray *arrT=[NSMutableArray arrayWithCapacity:0];
         NSMutableArray *arrH=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in oneArr) {
            [arrO addObject:[FNEarnigsItemNModel mj_objectWithKeyValues:dic]];
        }
        for (NSDictionary *dic in twoArr) {
            [arrT addObject:[FNEarnigsItemNModel mj_objectWithKeyValues:dic]];
        }
        for (NSDictionary *dic in threeArr) {
            [arrH addObject:[FNEarnigsItemNModel mj_objectWithKeyValues:dic]];
        }
        selfWeak.EarningsDic=[FNEarnigsNModel mj_objectWithKeyValues:dictry];
        selfWeak.lastList=arrO;
        selfWeak.todayList=arrT;
        selfWeak.yesList=arrH;
        [selfWeak.jm_tableview reloadData];
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}

@end
