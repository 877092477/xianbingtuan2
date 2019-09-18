//
//  FNMCAgentController.m
//  THB
//
//  Created by jimmy on 2017/7/27.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNMCAgentController.h"
#import "FNImgTitleCell.h"
#import "FNMCAgentDayCell.h"
#import "FNMCAgentMonthCell.h"
#import "FNMCAgentHeader.h"
#import "FNMCAOrderDetailController.h"
#import "FNMCAgentModel.h"
@interface FNMCAgentController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign)NSInteger sections;
@property (nonatomic, strong)FNMCAgentHeader* agentHeader;
@property (nonatomic, strong)FNMCAgentModel* model;
@property (nonatomic, assign)BOOL isToday;
@end

@implementation FNMCAgentController
- (void)setModel:(FNMCAgentModel *)model{
    _model = model;
    if (_model) {
        [_agentHeader.avatarImgView setUrlImg:_model.head_img];
        _agentHeader.namelabel.text = _model.nickname;
        _agentHeader.phoneLabel.text =[NSString stringWithFormat:@"%@",[ProfileModel profileInstance].tg_pid];
        
    }
}
- (FNMCAgentHeader *)agentHeader{
    if (_agentHeader == nil) {
        _agentHeader = [[FNMCAgentHeader alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0))];
        _agentHeader.backgroundColor = FNMainGobalControlsColor;
    }
    return _agentHeader;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isToday = YES;
    self.title = self.title?:@"代理";
    [self setupviews];
    [self apiRequestAgentCenter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - api requset
- (void)apiRequestAgentCenter{
    @WeakObj(self);
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    [FNRequestTool requestWithParams:params api:@"mod=new_share&act=agency&ctrl=dl_list" respondType:(ResponseTypeModel) modelType:@"FNMCAgentModel" success:^(id respondsObject) {
        //
        selfWeak.model = respondsObject;
        [UIView animateWithDuration:0.3 animations:^{
            selfWeak.jm_tableview.alpha = 1.0;
        } completion:^(BOOL finished) {
            [selfWeak.jm_tableview reloadData];
        }];
    } failure:^(NSString *error) {
        //
        [UIView animateWithDuration:0.3 animations:^{
            selfWeak.jm_tableview.alpha = 1.0;
        } completion:^(BOOL finished) {
            [selfWeak.jm_tableview reloadData];
        }];
    } isHideTips:NO];
}
#pragma mark - initializedSubviews
- (void)setupviews
{
    // navigation bar button
    
    //table view
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.alpha = 0.0;
    self.jm_tableview.tableHeaderView = self.agentHeader;
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    self.sections = 3;
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sections;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    @WeakObj(self);
    if (indexPath.section == 0) {
        FNMCAgentMonthCell* cell = [FNMCAgentMonthCell cellWithTableView:tableView atIndexPath:indexPath];
        cell.widthdrawAction = ^{
            //
            [selfWeak goWebWithUrl:selfWeak.model.tx_url];
        };
        cell.lastMonth = selfWeak.model.syyg;
        cell.thisMonth = selfWeak.model.byyg;
        cell.balance = selfWeak.model.dlcommission;
        return cell;
    }else if (indexPath.section == 2){
        
        FNMCAgentDayCell* cell = [FNMCAgentDayCell cellWithTableView:tableView atIndexPath:indexPath];
        cell.todaybtn.selected = self.isToday;
        cell.yesterdaybtn.selected = !self.isToday;
        cell.changeDateBlock = ^(BOOL flag) {
            selfWeak.isToday = flag;
            [selfWeak.jm_tableview reloadData];
        };
        if (self.model.today_yes.count>=1) {
            NSInteger row = self.isToday ? 0 : 1;
            cell.money = self.model.today_yes[row].hl_money;
            cell.today = self.model.today_yes[row].count;
            cell.yesterday = self.model.today_yes[row].money;
        }
        return cell;
    }else{
        FNImgTitleCell* cell = [FNImgTitleCell cellWithTableView:tableView atIndexPath:indexPath];
        [cell setImage:@"agent_order" andTitle:@"订单明细"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 44;
    if (indexPath.section == 0) {
        height = _amc_cell_h;
    }else if (indexPath.section == 2){
        height = _adc_cell_height;
    }
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        FNMCAOrderDetailController* detail = [FNMCAOrderDetailController new];
        [self.navigationController pushViewController:detail animated:YES];
    }
}
@end
