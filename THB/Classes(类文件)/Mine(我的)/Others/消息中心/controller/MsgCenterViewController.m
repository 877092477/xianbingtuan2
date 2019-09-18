//
//  MsgCenterViewController.m
//  THB
//
//  Created by zhongxueyu on 16/3/31.
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

#import "MsgCenterViewController.h"
#import "MessageCell.h"
#import "MsgModel.h"
#import "ContactWeViewController.h"
#import "NotificationViewController.h"
#import "OrderBaseViewController.h"
#import "FNclienteleDeController.h"
#import "FNhistoryListDeController.h"
#import "OrderViewController.h"
@interface MsgCenterViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *xy_TableView;

/** 数据数组 */
@property (nonatomic, strong) NSMutableArray *MyMsgdataArray;

/** 数据数组 */
@property (nonatomic, strong) NSMutableArray *SysMsgdataArray;

/** 数据数组 */
@property (nonatomic, strong) NSMutableArray *OrderMsgdataArray;
@end

@implementation MsgCenterViewController
@synthesize xy_TableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息中心";
    //初始化表格
    [self initTableView];
    [self loadMyMsgDataMethod];
    [self loadSysMsgDataMethod];
    [self loadOrderMsgDataMethod];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
#pragma 获取数据
-(void)loadMyMsgDataMethod
{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"token":UserAccessToken,
                                                                                 @"type":@1                  }];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_getMsg successBlock:^(id responseBody) {
        
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            
            NSArray *tempArray = [dict objectForKey:XYData];
            NSError *error = nil;
            NSData * JSONData = [NSJSONSerialization dataWithJSONObject:tempArray options:kNilOptions error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
            
            XYLog(@"MyjsonData is %@",jsonString);
            [self.MyMsgdataArray removeAllObjects];
            if (tempArray) {
                for (int i = 0; i < tempArray.count; i ++) {
                    MsgModel *model = [MsgModel mj_objectWithKeyValues:tempArray[i]];
                    [self.MyMsgdataArray addObject:model];
                    
                }
                [xy_TableView reloadData];
                 [SVProgressHUD dismiss];
            }
        
        }else{
            
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
        [xy_TableView.mj_footer endRefreshing];
    }];
   
}
-(void)loadSysMsgDataMethod
{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"token":UserAccessToken,
                                                                                 @"type":@2                }];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_getMsg successBlock:^(id responseBody) {
        [xy_TableView.mj_header endRefreshing];
        [xy_TableView.mj_footer endRefreshing];
        NSDictionary *dict = responseBody;
        XYLog(@"SysresponseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
        
            NSArray *tempArray = [dict objectForKey:XYData];
            NSError *error = nil;
            NSData * JSONData = [NSJSONSerialization dataWithJSONObject:tempArray options:kNilOptions error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
            
            XYLog(@"jsonData is %@",jsonString);
            [self.SysMsgdataArray removeAllObjects];
            if (tempArray) {
                for (int i = 0; i < tempArray.count; i ++) {
                    MsgModel *model = [MsgModel mj_objectWithKeyValues:tempArray[i]];
                    [self.SysMsgdataArray addObject:model];
                }
                [xy_TableView reloadData];
                [SVProgressHUD dismiss];
            }
            
        }else{
            
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
        [xy_TableView.mj_footer endRefreshing];
    }];
    
    
    
}
-(void)loadOrderMsgDataMethod{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"token":UserAccessToken,         }];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:@"mod=appapi&act=dg_app_updatestr&ctrl=message" successBlock:^(id responseBody) {
        [xy_TableView.mj_header endRefreshing];
        [xy_TableView.mj_footer endRefreshing];
        NSDictionary *dict = responseBody;
        XYLog(@"SysresponseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            [self.OrderMsgdataArray removeAllObjects];
            MsgModel *model = [MsgModel mj_objectWithKeyValues:[dict objectForKey:XYData]];
            [self.OrderMsgdataArray addObject:model];
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

-(void)initTableView
{
    xy_TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight) style:UITableViewStylePlain];
    xy_TableView.dataSource=self;
    xy_TableView.delegate=self;
    xy_TableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:xy_TableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identfire=@"Cell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([MessageCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identfire];
        nibsRegistered = YES;
    }
    MessageCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
    
    NSArray *imgArray = [NSArray arrayWithObjects:@"system_new",@"my_new2",@"my_fan",@"my_service",@"FJ_msgimg", nil];
    NSArray *titleArray = [NSArray arrayWithObjects:@"系统通知",@"我的消息",@"返利助手",@"客服中心",@"推送历史",nil];
#if APP_YWXJ == 1
    titleArray = [NSArray arrayWithObjects:@"系统通知",@"订单详情",@"返利助手",@"客服中心",@"推送历史",nil];
#endif
    cell.img.image = IMAGE(imgArray[indexPath.row]);
    cell.title.text = titleArray[indexPath.row];
    if (indexPath.row == 0) {
        if (self.SysMsgdataArray.count>0) {
            MsgModel *model = self.SysMsgdataArray[0];
            cell.title.text=model.title;
            cell.messageLbl.text = model.msg;
            cell.date.hidden = NO;
            cell.date.text = model.time;
        }else{
            cell.messageLbl.text = @"系统消息";
        }
    }else if (indexPath.row == 1) {
        if (self.MyMsgdataArray.count>0) {
            MsgModel *model = self.MyMsgdataArray[0];
            cell.messageLbl.text = model.msg;
            cell.date.hidden = NO;
            cell.date.text = model.time;
        }else{
            cell.messageLbl.text = @"专属权益、积分提醒等在这里查看哦";
        }
    }else if (indexPath.row == 2){
        if (self.OrderMsgdataArray.count>0) {
            MsgModel *model = self.OrderMsgdataArray[0];
            cell.title.text=model.mess_for_str1;
            cell.messageLbl.text = model.mess_for_str2;
            [cell.img setUrlImg:model.mess_for_img];
        }else{
            cell.messageLbl.text = @"订单返利信息在这里查看哦~";
#if APP_YWXJ == 1
            cell.messageLbl.text = @"订单详情在这里查看哦~";
#endif
        }
    }else if (indexPath.row == 3){
        cell.messageLbl.text = @"有任何问题点我为您服务哦~";
    }
    else if (indexPath.row == 4){
        cell.messageLbl.text = @"查看之前收到的推送信息";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XYLog(@"index is %ld",(long)indexPath.row);
    if (indexPath.row == 0) {
        NotificationViewController *vc = [[NotificationViewController alloc]init];
        vc.type = @2;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        NotificationViewController *vc = [[NotificationViewController alloc]init];
        vc.type = @1;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        //订单
        //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"OrderStoryboard" bundle:nil];
        //OrderBaseViewController *vc = [sb instantiateViewControllerWithIdentifier:@"OrderBaseVC"];
        //vc.status = @0;
        //vc.hidesBottomBarWhenPushed = YES;
        //vc.navigationController.navigationBarHidden = NO;
        
        //[self.navigationController pushViewController:vc animated:YES];
        //订单
        OrderViewController *vc = [OrderViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3){
        //ContactWeViewController *vc = [[ContactWeViewController alloc]init];
        //vc.hidesBottomBarWhenPushed = YES;
        //[self.navigationController pushViewController:vc animated:YES];
        
        FNclienteleDeController*vc = [[FNclienteleDeController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        FNhistoryListDeController *vc=[[FNhistoryListDeController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)MyMsgdataArray {
    if (!_MyMsgdataArray) {
        _MyMsgdataArray = [NSMutableArray array];
    }
    return _MyMsgdataArray;
}

- (NSMutableArray *)SysMsgdataArray {
    if (!_SysMsgdataArray) {
        _SysMsgdataArray = [NSMutableArray array];
    }
    return _SysMsgdataArray;
}

- (NSMutableArray *)OrderMsgdataArray {
    if (!_OrderMsgdataArray) {
        _OrderMsgdataArray = [NSMutableArray array];
    }
    return _OrderMsgdataArray;
}

@end
