//
//  IncomeViewController.m
//  THB
//
//  Created by zhongxueyu on 16/7/30.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "IncomeViewController.h"
#import "IncomeHeaderCell.h"
#import "IncomeDetailCell.h"
#import "IncomeModel.h"


@interface IncomeViewController ()<UITableViewDataSource,UITableViewDelegate>
/** TableView */
@property (nonatomic,strong) UITableView *xy_TableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UIButton *drawBtn;

@property (nonatomic,strong) IncomeModel *model;

@end

@implementation IncomeViewController
@synthesize xy_TableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"收益统计";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, kFONT17, NSFontAttributeName, nil]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.barTintColor = RGB(233, 0, 56);
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;//导航栏的背景色是黑色, 字体为白色
    if (iOS7) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    
    [self initNavView];
    //初始化表格
    [self initTableView];
    if (IOS11) {
        xy_TableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self getFXInfoMethod];
}


#pragma mark - 网络请求
-(void)getFXInfoMethod{
    NSString *is_hhr=@"1";
    if (self.No_hhr==YES) {
        is_hhr=@"0";
    }
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"token":UserAccessToken,
                                                                                 @"is_hhr":is_hhr}];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_threesale_sytj successBlock:^(id responseBody) {
        [xy_TableView.mj_header endRefreshing];
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            
            [self.dataArray removeAllObjects];
            NSArray *tempArray = [dict objectForKey:XYData];
            NSError *error = nil;
            NSData * JSONData = [NSJSONSerialization dataWithJSONObject:tempArray options:kNilOptions error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
            
            XYLog(@"MyjsonData is %@",jsonString);
            
            _model = [IncomeModel mj_objectWithKeyValues:[dict objectForKey:XYData]];
            [self.dataArray addObject:_model];
            [SVProgressHUD dismiss];
            [self.view addSubview:xy_TableView];
            [xy_TableView reloadData];
        }else{
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
        [xy_TableView.mj_footer endRefreshing];
    }];
}




-(void)initNavView
{
    
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage: [UIImage imageNamed:@"return-white"] forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(0, 0, 21, 21);
    [leftbutton addTarget:self action:@selector(LeftBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
}

-(void)LeftBtnMethod:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    //导航栏样式设置
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    if (iOS7) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    }
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, kFONT17, NSFontAttributeName, nil]];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
}
#pragma tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return _model.djtg_lv.integerValue;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 180;
    }else if (indexPath.section == 1){
        return 50;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        IncomeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IncomeHeaderCell"];
        cell.titleLabel.text = [NSString stringWithFormat:@"预计收益(%@)",[FNBaseSettingModel settingInstance].CustomUnit];
        cell.IncomeLabel.text = _model.money0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        IncomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IncomeDetailCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.rightLabel.textColor = RGB(249, 93, 104);
            cell.leftTitleLabel.text = [NSString stringWithFormat:@"一级预估%@",[FNBaseSettingModel settingInstance].YJCustomUnit];
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",_model.money1];
        }else if (indexPath.row == 1){
            cell.rightLabel.textColor = RGB(243, 228, 79);
            cell.leftTitleLabel.text = [NSString stringWithFormat:@"二级预估%@",[FNBaseSettingModel settingInstance].YJCustomUnit];
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",_model.money2];
        }else if (indexPath.row == 2){
            cell.rightLabel.textColor = RGB(125, 198, 253);
            cell.leftTitleLabel.text = [NSString stringWithFormat:@"三级预估%@",[FNBaseSettingModel settingInstance].YJCustomUnit];
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",_model.money3];
        }else if (indexPath.row == 3){
            cell.rightLabel.textColor = RGB(125, 198, 253);
            cell.leftTitleLabel.text = [NSString stringWithFormat:@"四级预估%@",[FNBaseSettingModel settingInstance].YJCustomUnit];
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",_model.money4];
        }else if (indexPath.row == 4){
            cell.rightLabel.textColor = RGB(125, 198, 253);
            cell.leftTitleLabel.text = [NSString stringWithFormat:@"五级预估%@",[FNBaseSettingModel settingInstance].YJCustomUnit];
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",_model.money5];
        }else if (indexPath.row == 5){
            cell.rightLabel.textColor = RGB(125, 198, 253);
            cell.leftTitleLabel.text = [NSString stringWithFormat:@"六级预估%@",[FNBaseSettingModel settingInstance].YJCustomUnit];
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",_model.money6];
        }else if (indexPath.row == 6){
            cell.rightLabel.textColor = RGB(125, 198, 253);
            cell.leftTitleLabel.text = [NSString stringWithFormat:@"七级预估%@",[FNBaseSettingModel settingInstance].YJCustomUnit];
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",_model.money7];
        }else if (indexPath.row == 7){
            cell.rightLabel.textColor = RGB(125, 198, 253);
            cell.leftTitleLabel.text = [NSString stringWithFormat:@"八级预估%@",[FNBaseSettingModel settingInstance].YJCustomUnit];
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",_model.money8];
        }else if (indexPath.row == 8){
            cell.rightLabel.textColor = RGB(125, 198, 253);
            cell.leftTitleLabel.text = [NSString stringWithFormat:@"九级预估%@",[FNBaseSettingModel settingInstance].YJCustomUnit];
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",_model.money9];
        }
        [cell.rightLabel HttpLabelLeftImage:[FNBaseSettingModel settingInstance].mon_icon label:cell.rightLabel imageX:0 imageY:-1.5 imageH:15 atIndex:0];
        return cell;
    }
    return nil;
    
}


#pragma marl - UI
-(void)initTableView
{
    xy_TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight) style:UITableViewStyleGrouped];
    xy_TableView.dataSource=self;
    xy_TableView.delegate=self;
    xy_TableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets =NO;//高度可以到导航栏
    //    xy_TableView.backgroundView = [[UIImageView alloc] initWithImage:IMAGE(@"me_bg1")];
    [xy_TableView registerNib:[UINib nibWithNibName:@"IncomeHeaderCell" bundle:nil] forCellReuseIdentifier:@"IncomeHeaderCell"];
    [xy_TableView registerNib:[UINib nibWithNibName:@"IncomeDetailCell" bundle:nil] forCellReuseIdentifier:@"IncomeDetailCell"];
    
    [self.view addSubview:xy_TableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Getter
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
