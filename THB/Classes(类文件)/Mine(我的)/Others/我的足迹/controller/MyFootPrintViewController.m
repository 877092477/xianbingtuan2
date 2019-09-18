//
//  MyFootPrintViewController.m
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

#import "MyFootPrintViewController.h"
#import "MyFootPrintCell.h"
#import "MyFootModel.h"


@interface MyFootPrintViewController ()<UITableViewDataSource,UITableViewDelegate>



@property (nonatomic,strong) UITableView *xy_TableView;

/** 列表数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 页数 */
@property (nonatomic, assign) int page;
@end
@implementation MyFootPrintViewController
@synthesize xy_TableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.title?self.title:@"我的足迹";
    self.page = 1;
    //初始化表格
    [self initTableView];
    [self loadDateMethod];
    __weak __typeof(self)weakSelf = self;
    xy_TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        weakSelf.page = 1;
        [weakSelf loadDateMethod];
    }];
    
}

-(void)postFootPrintMethpd:(NSString *)goodsId{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"goodsid":goodsId,
                                                                                 @"token":UserAccessToken}];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_addfootmark successBlock:^(id responseBody) {
        
        
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
    }];
}


#pragma 获取数据
-(void)loadDateMethod
{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"p":[NSNumber numberWithInt:self.page],
                                                                                 @"token":UserAccessToken}];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_getfootmark successBlock:^(id responseBody) {
        [xy_TableView.mj_header endRefreshing];
        [xy_TableView.mj_footer endRefreshing];
        NSDictionary *dict = responseBody;
        
        XYLog(@"responseBody2 is %@",responseBody);
        
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            
            NSArray *tempArray = [dict objectForKey:XYData];
            
            if (tempArray.count>0) {
                for (int i = 0; i < tempArray.count; i ++) {
                    MyFootModel *model = [MyFootModel mj_objectWithKeyValues:tempArray[i]];
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
                            [weakSelf loadDateMethod];
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
                    [FNTipsView showTips:@"请先去逛逛才会留下您的足迹哦~"];
                }
                
            }
            
            
        }else{
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
        [xy_TableView.mj_header endRefreshing];
    }];
    
}

-(void)initTableView
{
    xy_TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight-XYNavBarHeigth-XYStatusBarHeight) style:UITableViewStylePlain];
    xy_TableView.dataSource=self;
    xy_TableView.delegate=self;
    xy_TableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
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
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([MyFootPrintCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identfire];
        nibsRegistered = YES;
    }
    MyFootPrintCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
    
    
    if (self.dataArray.count>0) {
        cell.model = self.dataArray[indexPath.row];
        //        [cell.img setUrlImg:model.goods_img];
        //        cell.title.text = model.goods_title;
        //        cell.price.text =[NSString stringWithFormat:@"￥%@",model.goods_price];
        //        cell.rebates.text = [NSString stringWithFormat:@"返%@%@",model.returnfb,[FNBaseSettingModel settingInstance].CustomUnit];
        //        //        NSString *footString = model.goods_shop;
        //        if ([model.goods_shop isEqualToString:@""] ||model.goods_shop == nil) {
        //            cell.fromShop.text = @"";
        //        }else{
        //            cell.fromShop.text = [NSString stringWithFormat:@"来自:%@",model.goods_shop];
        //        }
        //        
        //        cell.rebatePercentage.text = [NSString stringWithFormat:@"(比例%.2f%%)",model.returnbl];
        //        cell.firstTime.text = [NSString stringWithFormat:@"首次查看%@",model.starttime];
        //        cell.lastTime.text = [NSString stringWithFormat:@"最后查看%@",model.endtime];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XYLog(@"index is %ld",(long)indexPath.row);
    MyFootModel *model = self.dataArray[indexPath.row];
    if (model.is_qiangguang.boolValue) {
        [FNTipsView showTips:@"商品太火爆了，已被抢光，赶紧看一下其他商品吧〜"];
    }else{
        [self goProductVCWithModel:model withData:nil];
    }
    
    
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
