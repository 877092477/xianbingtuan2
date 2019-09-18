//
//  FNMCAOrderDetailController.m
//  THB
//
//  Created by jimmy on 2017/7/27.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNMCAOrderDetailController.h"
#import "FNMCAOrderDetailCell.h"
#import "FNMCAOrderDetailModel.h"
@interface FNMCAOrderDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray<FNMCAOrderDetailModel *>* list;
@end

@implementation FNMCAOrderDetailController
- (NSMutableArray<FNMCAOrderDetailModel *> *)list
{
    if (_list == nil) {
        _list = [NSMutableArray new];
    }
    return _list;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.title?:@"订单明细";
    [self setupviews];
    [self apiRequestList:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - api request
- (void)apiRequestList:(BOOL)flag{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,PageNumber:@(self.jm_page)}];
    @WeakObj(self);
    [FNRequestTool requestWithParams:params api:@"mod=new_share&act=agency&ctrl=dl_order" respondType:(ResponseTypeArray) modelType:@"FNMCAOrderDetailModel" success:^(NSArray* respondsObject) {
        //
        if (selfWeak.jm_page == 1) {
            [UIView animateWithDuration:0.3 animations:^{
                selfWeak.jm_tableview.alpha = 1.0;
            }];
            [selfWeak.list removeAllObjects];
            [selfWeak.list addObjectsFromArray:respondsObject];
            if (respondsObject.count>=_jm_pageszie) {
                selfWeak.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiRequestList:YES];
                }];
            }else{
                selfWeak.jm_tableview.mj_footer = nil;
            }
        }else{
            [selfWeak.list addObjectsFromArray:respondsObject];
            if (respondsObject.count>=_jm_pageszie) {
                [selfWeak.jm_tableview.mj_footer endRefreshing];
            }else{
                [selfWeak.jm_tableview.mj_footer  endRefreshingWithNoMoreData];
            }
        }
        [selfWeak.jm_tableview reloadData];
        [selfWeak.jm_tableview.mj_header endRefreshing];
    } failure:^(NSString *error) {
        //
        [UIView animateWithDuration:0.3 animations:^{
            selfWeak.jm_tableview.alpha = 1.0;
        }];
        [selfWeak.jm_tableview.mj_header endRefreshing];
        [selfWeak.jm_tableview.mj_footer endRefreshing];
    } isHideTips:flag];
}
#pragma mark - initializedSubviews
- (void)setupviews
{
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    self.jm_tableview.dataSource =self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.alpha = 0.0;
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
    @WeakObj(self);
    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.jm_page = 1;
        [selfWeak apiRequestList:YES];
    }];
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNMCAOrderDetailCell* cell = [FNMCAOrderDetailCell cellWithTableView:tableView atIndexPath:indexPath];
    cell.model = self.list[indexPath.section];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = _aodc_cell_height;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
@end
