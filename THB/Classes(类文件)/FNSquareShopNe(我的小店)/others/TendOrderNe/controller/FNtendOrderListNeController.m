//
//  FNtendOrderListNeController.m
//  69橙子
//
//  Created by Jimmy on 2018/12/3.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//商品
#import "FNtendOrderListNeController.h"
//view
#import "FNtendOrderItemDaNeCell.h"
//controller
#import "FNTeOrderDetailsDeController.h"
#import "FNmeMemberEvaluatesController.h"
//model
#import "FNtendOderItemNeModel.h"
@interface FNtendOrderListNeController ()<UITableViewDelegate,UITableViewDataSource,FNtendOrderItemDaNeCellDelegate>
/**  支付方式   **/
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation FNtendOrderListNeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDateMethod];
    [self tendOrderListTableView];
    //self.view.backgroundColor=[UIColor redColor];
}

#pragma mark - 单元
-(void)tendOrderListTableView{
    //CGFloat tableHeight=FNDeviceHeight;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.jm_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight-XYNavBarHeigth-35) style:UITableViewStylePlain];
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.rowHeight=165;
    self.jm_tableview.showsVerticalScrollIndicator=NO;
    self.jm_tableview.showsHorizontalScrollIndicator=NO;
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.estimatedRowHeight = 0;
        self.jm_tableview.estimatedSectionFooterHeight = 0;
        self.jm_tableview.estimatedSectionHeaderHeight= 0;
        self.jm_tableview.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.jm_tableview];
    self.jm_tableview.backgroundColor=FNColor(240,240,240);
//    self.jm_tableview.sd_layout
//    .topSpaceToView(self.view, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNtendOrderItemDaNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"tendOrderItemDaNeCellID"];
    if (cell == nil) {
        cell = [[FNtendOrderItemDaNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tendOrderItemDaNeCellID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate=self;
    cell.indexPath=indexPath;
    cell.model=self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FNtendOderItemNeModel *model=self.dataArray[indexPath.row];
    
    if ([model.buy_type isEqualToString:@"faceToFace"]) {
        //当面付不可进详情 https://www.showdoc.cc/14126?page_id=2147150236791477
        
        return;
    }
    
    FNTeOrderDetailsDeController *vc=[[FNTeOrderDetailsDeController alloc]init];
//    vc.state=indexPath.row;
    vc.oidString=model.orderId;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - FNtendOrderItemDaNeCellDelegate <NSObject>
// 选择
- (void)InTendOrderItemAction:(NSIndexPath *)indexPath{
    XYLog(@"选择:%ld",(long)indexPath.row);
    FNtendOderItemNeModel *model=self.dataArray[indexPath.row];
    FNTeOrderDetailsDeController *vc=[[FNTeOrderDetailsDeController alloc]init];
//    vc.state=indexPath.row;
    vc.oidString=model.orderId;
    [self.navigationController pushViewController:vc animated:YES];
}
//评论订单
- (void)InTendOrderCommentAction:(NSIndexPath *)indexPath {
    FNtendOderItemNeModel *model=self.dataArray[indexPath.row];
    FNmeMemberEvaluatesController *vc = [[FNmeMemberEvaluatesController alloc] init];
    vc.orderId = model.id;
    vc.store_id = model.store_id;
    [self.navigationController pushViewController:vc animated:YES];
}

//确认送达
- (void)InTendOrderConfirmAction:(NSIndexPath *)indexPath {
    FNtendOderItemNeModel *model=self.dataArray[indexPath.row];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"订单确定送达吗？"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    @weakify(self);
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"已送达" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         @strongify(self);
                                                         [self requestConfirm: model.id];
                                                     }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

// 取消订单
- (void)InTendOrderCancleAction:(NSIndexPath *)indexPath{
    XYLog(@"选择:%ld",(long)indexPath.row);
    FNtendOderItemNeModel *model=self.dataArray[indexPath.row];
    if ([model.apply_refund isEqualToString:@"1"]) {
        [self cancleOrder: model];
    } else if ([model.apply_refund isEqualToString:@"2"]) {
        [self cancleRequest: model];
    }
}
// 申请取消
- (void) cancleOrder:(FNtendOderItemNeModel*)model {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"确定取消订单吗？"
                                                                   message:@"请先联系商家确认后取消（退款后金额将返还到账户余额）"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    @weakify(self);
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"取消订单" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         @strongify(self);
                                                         [self requestCancle: model.id];
                                                     }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
// 取消申请
- (void) cancleRequest:(FNtendOderItemNeModel*)model {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"确定取消申请吗？"
                                                                   message:@"取消订单申请退款吗？（申请后订单将可以继续使用）"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    @weakify(self);
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"取消申请" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         @strongify(self);
                                                         [self requestCancle: model.id];
                                                     }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma - mark 获取数据
-(void)loadDateMethod{
    @WeakObj(self);
    NSString *APIUrl=@"mod=appapi&act=rebate_order&ctrl=order_list";
    NSMutableDictionary *params= [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"p":@(self.jm_page),@"status":self.state}];
    
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:APIUrl successBlock:^(id responseBody) {
        [self.jm_tableview.mj_header endRefreshing];
        [self.jm_tableview.mj_footer endRefreshing];
        NSDictionary *dict = responseBody;
        [SVProgressHUD dismiss];
        XYLog(@"responseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            if (self.jm_page == 1) {
                [self.dataArray removeAllObjects];
            }
            NSArray *tempArray = [dict objectForKey:XYData];
            XYLog(@"tempArray.count is %lu",(unsigned long)tempArray.count);
            if (tempArray.count>0) {
                for (int i = 0; i < tempArray.count; i ++) {
                    FNtendOderItemNeModel *model = [FNtendOderItemNeModel mj_objectWithKeyValues:tempArray[i]];
                    [self.dataArray addObject:model];
                }
                if (tempArray.count <1 ) {
                    self.jm_tableview.mj_footer = nil;
                }else {
                    if (!self.jm_tableview.mj_footer) {
                        __weak __typeof(self)weakSelf = self;
                        self.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                            // 进入刷新状态后会自动调用这个block
                            weakSelf.jm_page += 1;
                            [weakSelf loadDateMethod];
                        }];
                    }
                }
            }else{
                if(self.jm_page >1 ){
                    [self.jm_tableview.mj_footer endRefreshingWithNoMoreData];
                }
                if (self.jm_page == 1) {
                    self.jm_tableview.emptyDataSetSource = self;
                    self.jm_tableview.emptyDataSetDelegate = self;
                }
            }
        }else{
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        self.jm_tableview.alpha = 1;
        [self.jm_tableview reloadData];
    } failureBlock:^(NSString *error) {
        self.jm_tableview.alpha = 1;
        [self.jm_tableview reloadData];
        [XYNetworkAPI cancelAllRequest];
        [self.jm_tableview.mj_header endRefreshing];
    }];
    
}

- (void)requestCancle: (NSString*)orderId{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"id": orderId}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_order&ctrl=apply_refund" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        self.jm_page = 1;
        [self loadDateMethod];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestConfirm: (NSString*)orderId{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"id": orderId}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_order&ctrl=confirm_service" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        [self loadDateMethod];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
