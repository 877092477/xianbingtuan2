//
//  MyTeamViewController.m
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

#import "MyTeamViewController.h"
#import "MyTeamCell.h"
#import "MyTeamModel.h"
@interface MyTeamViewController ()<UITableViewDataSource,UITableViewDelegate>
/** TableView */
@property (nonatomic,strong) UITableView *xy_TableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) MyTeamModel *model;

/** 页数 */
@property (nonatomic, assign) int page;


@end

@implementation MyTeamViewController
@synthesize xy_TableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    
    self.title = @"团队成员";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavView];
    //初始化表格
    [self initTableView];
    [self getFXInfoMethod];
    __weak __typeof(self)weakSelf = self;
    xy_TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        weakSelf.page = 1;
        [weakSelf getFXInfoMethod];
    }];
    
    
}

#pragma mark - 网络请求
-(void)getFXInfoMethod{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"token":UserAccessToken,
                                                                                 @"p":[NSNumber numberWithInt:self.page],
                                                                                 @"id":self.user_Id?self.user_Id:@""}];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_threesale_qdcy successBlock:^(id responseBody) {
        [xy_TableView.mj_header endRefreshing];
        [xy_TableView.mj_footer endRefreshing];
        
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody2 is %@",responseBody);
        self.title = dict[@"title"];
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            NSArray *tempArray = [dict objectForKey:XYData];
            NSArray *Array = [tempArray valueForKey:@"list"];
            
            NSError *error = nil;
            NSData * JSONData = [NSJSONSerialization dataWithJSONObject:tempArray options:kNilOptions error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
            
            XYLog(@"MyjsonData is %@",jsonString);
            if (Array.count>0) {
                for (int i = 0; i < Array.count; i ++) {
                    _model = [MyTeamModel mj_objectWithKeyValues:Array[i]];
                    [self.dataArray addObject:_model];
                    
                }
                
                if (Array.count <10) {
                    xy_TableView.mj_footer = nil;
                }else {
                    if (!xy_TableView.mj_footer) {
                        __weak __typeof(self)weakSelf = self;
                        xy_TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                            // 进入刷新状态后会自动调用这个block
                            weakSelf.page += 1;
                            [weakSelf getFXInfoMethod];
                        }];
                        
                    }
                }
                [SVProgressHUD dismiss];
                [self.view addSubview:xy_TableView];
                [xy_TableView reloadData];
                
            }else {
                if(self.page >1 ){
                    [FNTipsView showTips:XYMsg];
                    [xy_TableView.mj_footer endRefreshingWithNoMoreData];
                }else if ( self.page == 1){
                    [FNTipsView showTips:@"暂未邀请好友"];
                }
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


#pragma tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTeamCell"];
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTeamModel *model = self.dataArray[indexPath.row];
    if ([model.is_xj isEqualToString:@"1"]) {
        MyTeamViewController *vc = [[MyTeamViewController alloc]init];
        vc.user_Id = model.id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma marl - UI
-(void)initTableView
{
    xy_TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight-64) style:UITableViewStylePlain];
    xy_TableView.backgroundColor=FNHomeBackgroundColor;
    xy_TableView.dataSource=self;
    xy_TableView.delegate=self;
    xy_TableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [xy_TableView registerNib:[UINib nibWithNibName:@"MyTeamCell" bundle:nil] forCellReuseIdentifier:@"MyTeamCell"];
    [xy_TableView removeEmptyCellRows];
}


-(void)initNavView
{
    
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage: [UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(0, 0, 21, 21);
    [leftbutton addTarget:self action:@selector(LeftBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
}

-(void)LeftBtnMethod:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    //    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, kFONT17, NSFontAttributeName, nil]];
    
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //    self.navigationController.navigationBar.barTintColor = FXRedColor;
    //    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;//导航栏的背景色是黑色, 字体为白色
    //    if (iOS7) { // 判断是否是IOS7
    //        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    //    }
    
    
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
