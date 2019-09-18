//
//  NotificationViewController.m
//  THB
//
//  Created by zhongxueyu on 16/4/12.
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

#import "NotificationViewController.h"
#import "MsgModel.h"
#import "DetailMsgCell.h"
#import "MsgDetailViewController.h"
@interface NotificationViewController ()<UITableViewDataSource,UITableViewDelegate>


/** TableView */
@property (nonatomic,strong) UITableView *xy_TableView;
/** 列表数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation NotificationViewController
@synthesize xy_TableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if([self.type isEqualToNumber:@1]){
        self.title = @"我的消息";
    }else if ([self.type isEqualToNumber:@2]){
        self.title = @"系统通知";
    }

    [self loadMyMsgDataMethod];
}

#pragma - mark 获取数据
-(void)loadMyMsgDataMethod
{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"token":UserAccessToken,
                                                                                 @"type":self.type              }];
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
            [self.dataArray removeAllObjects];
            if (tempArray.count>0) {
                for (int i = 0; i < tempArray.count; i ++) {
                    MsgModel *model = [MsgModel mj_objectWithKeyValues:tempArray[i]];
                    [self.dataArray addObject:model];
                    
                }
                
                [SVProgressHUD dismiss];
            }else{
                [FNTipsView showTips:@"暂时还没有消息到达~"];
            }
            [self initTableView];
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
#pragma - mark TableView
-(void)initTableView
{
    xy_TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight-XYNavBarHeigth) style:UITableViewStyleGrouped];
    xy_TableView.dataSource=self;
    xy_TableView.delegate=self;
    xy_TableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    xy_TableView.showsHorizontalScrollIndicator = NO;
    xy_TableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:xy_TableView];
    
    if (IOS11) {
        xy_TableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataArray.count>0) {
        return self.dataArray.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 146;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identfire=@"Cell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([DetailMsgCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identfire];
        nibsRegistered = YES;
    }
    DetailMsgCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
    
    if(self.dataArray.count>0){
        MsgModel *model = self.dataArray[indexPath.section];
        cell.time.text = [NSString stringWithFormat:@"— %@ —",model.time];
        cell.msgTitle.text = model.title;
        cell.msgContent.text = model.msg;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XYLog(@"index is %ld",(long)indexPath.section);
    MsgModel *model = self.dataArray[indexPath.section];
    MsgDetailViewController *vc = [[MsgDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.type = self.type;
    vc.msgId = model.id;
    vc.msgDetails = model.msg;
    vc.title = model.title;
    [self.navigationController pushViewController:vc animated:YES];
    
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

@end
