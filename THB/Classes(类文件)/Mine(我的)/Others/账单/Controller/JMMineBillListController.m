//
//  JMMineBillListController.m
//  THB
//
//  Created by jimmy on 2017/3/30.
//  Copyright © 2017年 方诺科技. All rights reserved.
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
#import "JMMineBillListController.h"
#import "JMMineBillListCell.h"
//#import "JMMineAPITool.h"

#import "FNAPIMine.h"
@interface JMMineBillListController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView* tableView;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray* list;
@end

@implementation JMMineBillListController
- (NSMutableArray *)list
{
    if (_list == nil) {
        _list = [NSMutableArray new];
    }
    return _list;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializedSubviews];
    [SVProgressHUD show];
    self.page = 1;
    [self apiRequestList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.jm_tableview = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-0)) style:(UITableViewStylePlain)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.hidden = YES;
    self.jm_tableview.backgroundColor = FNWhiteColor;
    [self.jm_tableview removeEmptyCellRows];
    [self.view addSubview:self.jm_tableview];
    @WeakObj(self);
    self.jm_tableview.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.page = 1;
        [selfWeak apiRequestList];
    }];
}
#pragma mark - api request
- (void)apiRequestList{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":_statu,PageNumber:@(self.page),TokenKey:UserAccessToken}];
    @WeakObj(self);
    [FNAPIMine apiMineApiForMineBillWithParams:params success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        NSArray *array  = respondsObject;
        if (selfWeak.page == 1) {
            [selfWeak.list removeAllObjects];
            [selfWeak.list addObjectsFromArray:array];
            if (array.count >= 10) {
                selfWeak.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.page ++;
                    [selfWeak apiRequestList];
                }];
            }else{
                selfWeak.jm_tableview.mj_footer = nil;
            }
        }else{
            [selfWeak.list addObjectsFromArray:array];
            if (array.count >= 10) {
                [selfWeak.jm_tableview.mj_footer endRefreshing];
            }else{
                [selfWeak.jm_tableview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        self.jm_tableview.hidden = NO;
        [selfWeak.jm_tableview.mj_header endRefreshing];
        [selfWeak.jm_tableview reloadData];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
        self.jm_tableview.hidden = NO;
        [selfWeak.jm_tableview.mj_header endRefreshing];
        
    } isHidden:NO];
}


#pragma mark - Tabel view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JMMineBillListCell* cell = [JMMineBillListCell cellWithTableView:tableView atIndexPath:indexPath];
    cell.model = self.list[indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 10))];
    view.backgroundColor = FNHomeBackgroundColor;
    return view;
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
@end
