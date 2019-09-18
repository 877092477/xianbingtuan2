//
//  MyLikeViewController.m
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

#import "MyLikeViewController.h"
#import "MyLikeCell.h"
#import "MyLikeListModel.h"

@interface MyLikeViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

/** 列表数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 页数 */
@property (nonatomic, assign) int page;

@property (nonatomic,assign) NSInteger tapIndex;
@end
@implementation MyLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =self.title?:@"我的喜欢";
    self.page = 1;
    //初始化表格
    [self initTableView];
    //    [self setupNav];
    [self loadProductListMethod];
    __weak __typeof(self)weakSelf = self;
    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        weakSelf.page = 1;
        [weakSelf loadProductListMethod];
    }];
    
}

-(void)postFootPrintMethpd:(NSString *)goodsId{
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                  @"time":[NSString GetNowTimes],
                                                                                  @"goodsid":goodsId,
                                                                                  @"token":UserAccessToken
                                                                                  }];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_mine_addfootmark successBlock:^(id responseBody) {
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
    }];
}


#pragma 获取数据
-(void)loadProductListMethod
{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"p":[NSNumber numberWithInt:self.page],
                                                                                 @"token":UserAccessToken}];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_getmylike isCache: NO successBlock:^(id responseBody) {
        [self.jm_tableview.mj_header endRefreshing];
        [self.jm_tableview.mj_footer endRefreshing];
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            NSArray *tempArray = [dict objectForKey:XYData];
            
            if (tempArray.count>0) {
                for (int i = 0; i < tempArray.count; i ++) {
                    MyLikeListModel *model = [MyLikeListModel mj_objectWithKeyValues:tempArray[i]];
                    [self.dataArray addObject:model];
                    
                }
                
                if (tempArray.count <10) {
                    self.jm_tableview.mj_footer = nil;
                }else {
                    if (!self.jm_tableview.mj_footer) {
                        __weak __typeof(self)weakSelf = self;
                        self.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                            // 进入刷新状态后会自动调用这个block
                            weakSelf.page += 1;
                            [weakSelf loadProductListMethod];
                        }];
                        
                    }
                }
            }else{
                
                if(self.page >1 ){
                    [FNTipsView showTips:XYMsg];
                    [self.jm_tableview.mj_footer endRefreshingWithNoMoreData];
                }else if ( self.page == 1){
                    [FNTipsView showTips:@"请先添加您喜欢的商品"];
                }
            }
        }else{
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        
        [self.jm_tableview reloadData];
        [SVProgressHUD dismiss];
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
        [self.jm_tableview.mj_footer endRefreshing];
    }];
    
}

-(void)setupNav{
    
    
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(50, 0, 80, 40)];
    [rightbutton setTitle:@"删除过期" forState:UIControlStateNormal];
    rightbutton.titleLabel.font = kFONT15;
    [rightbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(RightBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    
}

-(void)RightBtnMethod:(UIButton *)sender
{
    
}
-(void)initTableView
{
    self.jm_tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight-XYNavBarHeigth-XYStatusBarHeight) style:UITableViewStylePlain];
    self.jm_tableview.dataSource=self;
    self.jm_tableview.delegate=self;
    self.jm_tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.jm_tableview];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count>0) {
        return self.dataArray.count;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 102;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identfire=@"Cell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([MyLikeCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identfire];
        nibsRegistered = YES;
    }
    MyLikeCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
    
    
    if (self.dataArray>0) {
        cell.model = self.dataArray[indexPath.row];
    }
    
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)deleteBtnMethod:(UIButton *)sender
{
    self.tapIndex = sender.tag;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"删除喜欢"
                                                    message:@"该商品将从您的喜欢列表中删除，是否确认？"
                                                   delegate:self
                                          cancelButtonTitle:@"我再看看"
                                          otherButtonTitles:@"确认删除",nil];
    //设置标题与信息，通常在使用frame初始化AlertView时使用
    [alert show];
}

#pragma marks -- UIAlertViewDelegate --
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    MyLikeListModel *model = self.dataArray
    if(buttonIndex == 1){
        [self DeleteMyLikeMethod:self.tapIndex];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XYLog(@"index is %ld",(long)indexPath.row);
    MyLikeListModel *model = self.dataArray[indexPath.row];
    
    if (model.is_qiangguang.boolValue) {
        [FNTipsView showTips:@"商品太火爆了，已被抢光，赶紧看一下其他商品吧〜"];
    }else{
        [self goProductVCWithModel:model];
    }
    
    
    
    
    
}

//删除我的喜欢
-(void)DeleteMyLikeMethod:(NSInteger)tapIndex{
    MyLikeListModel *model = self.dataArray[tapIndex];
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"token":UserAccessToken,
                                                                                 @"goodsid":model.goodsid}];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    XYLog(@"param is %@",param);
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_home_deletemylike successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            [self loadProductListMethod];
            [SVProgressHUD dismiss];
        }else{
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
    } failureBlock:^(NSString *error) {
        [XYNetworkAPI cancelAllRequest];
        [self.jm_tableview.mj_footer endRefreshing];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -Getter
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
