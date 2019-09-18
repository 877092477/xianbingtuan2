//
//  FXOrderListViewController.m
//  THB
//
//  Created by zhongxueyu on 16/8/11.
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

#import "FXOrderListViewController.h"
#import "FXOrderCell.h"
#import "FXOrderModer.h"
@interface FXOrderListViewController ()<UITableViewDataSource,UITableViewDelegate>

/** TableView */
@property (nonatomic,strong) UITableView *xy_TableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

/** 页数 */
@property (nonatomic, assign) int page;

//@property (nonatomic,strong) FXCenterInfoModel *model;

@end

@implementation FXOrderListViewController
@synthesize xy_TableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    self.page = 1;

    self.view.backgroundColor = [UIColor whiteColor];
    if (self.navigationController) {
        // 导航条上面高度
        //        CGFloat navBarH = 64;
        
        // 查看自己标题滚动视图设置的高度，我这里设置为3
        //        CGFloat titleScrollViewH = 35;
        
        xy_TableView.contentInset = UIEdgeInsetsMake( 0, 0, XYNavBarHeigth, 0);
    }
    
    
    //初始化表格
    [self initTableView];
    if (IOS11) {
        xy_TableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
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
    NSString *APIUrl=_api_threesale_fxorder;
    if ([self.SkipUIIdentifier isEqualToString:@"buy_jingdong"]) {
        APIUrl=@"mod=appapi&act=appJdShareOrder&ctrl=fxOrder";
    }
    if ([self.SkipUIIdentifier isEqualToString:@"buy_pinduoduo"]) {
        APIUrl=@"mod=appapi&act=appPddShareOrder&ctrl=fxOrder";
    }
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                   @"token":UserAccessToken,
                                   @"t":self.type,
                                   @"p":[NSNumber numberWithInt:self.page]
                                   }];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:APIUrl successBlock:^(id responseBody) {
        [xy_TableView.mj_header endRefreshing];
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            NSArray *tempArray = [dict objectForKey:XYData];
            
            if (tempArray.count>0) {
                for (int i = 0; i < tempArray.count; i ++) {
                    FXOrderModer *model = [FXOrderModer mj_objectWithKeyValues:tempArray[i]];
                    [self.dataArray addObject:model];
                    
                }
                
                if (tempArray.count <10) {
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
                [self.view addSubview:xy_TableView];
                
                [xy_TableView reloadData];
                [SVProgressHUD dismiss];
            }else{
                
                if(self.page >1 ){
                    [FNTipsView showTips:XYMsg];
                    [xy_TableView.mj_footer endRefreshingWithNoMoreData];
                }else if ( self.page == 1){
                    [FNTipsView showTips:@"暂时还没有订单哦~"];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 107;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FXOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FXOrderCell"];
    
    cell.model = self.dataArray [indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}


#pragma marl - UI
-(void)initTableView
{
    xy_TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight-XYNavBarHeigth-35) style:UITableViewStyleGrouped];
    xy_TableView.dataSource=self;
    xy_TableView.delegate=self;
    xy_TableView.separatorStyle=UITableViewCellSeparatorStyleNone;

    [xy_TableView registerNib:[UINib nibWithNibName:@"FXOrderCell" bundle:nil] forCellReuseIdentifier:@"FXOrderCell"];
    
    
    
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
