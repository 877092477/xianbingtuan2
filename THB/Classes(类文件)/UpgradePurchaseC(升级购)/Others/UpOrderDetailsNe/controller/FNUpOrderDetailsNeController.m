//
//  FNUpOrderDetailsNeController.m
//  THB
//
//  Created by Jimmy on 2018/9/30.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpOrderDetailsNeController.h"
//view
#import "FNUpOrderDetailsMeCell.h"
#import "FNUpOrderDetailsHeadMeView.h"
//model
//#import "FNUpOrderdetailitemNewModel.h"
#import "FNUpOrderdetailitemNeHModel.h"
@interface FNUpOrderDetailsNeController ()<UITableViewDelegate,UITableViewDataSource,FNUpOrderDetailsHeadMeViewDelegate>

/** 详情 **/
@property(nonatomic,strong)FNUpOrderdetailitemNeHModel *dataModel;

@end

@implementation FNUpOrderDetailsNeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"订单详情";
    [self apiRequestOrderdetail];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.jm_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight) style:UITableViewStylePlain];
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.estimatedRowHeight = 0;
        self.jm_tableview.estimatedSectionFooterHeight = 0;
        self.jm_tableview.estimatedSectionHeaderHeight= 0;
        self.jm_tableview.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
    self.jm_tableview.rowHeight=280;
    self.jm_tableview.sectionHeaderHeight=110;
    [self.view addSubview:self.jm_tableview];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FNUpOrderDetailsMeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailsMeCell"];
    if (cell==nil) {
        cell = [[FNUpOrderDetailsMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderDetailsMeCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model=self.dataModel;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FNUpOrderDetailsHeadMeView *HeadView =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OrderDetailsHeadMeView"];
    if(HeadView==nil){
        HeadView = [[FNUpOrderDetailsHeadMeView alloc] initWithReuseIdentifier:@"OrderDetailsHeadMeView"];
    }
    HeadView.model=self.dataModel;
    HeadView.delegate=self;
    return HeadView;
}
#pragma mark - FNUpOrderDetailsHeadMeViewDelegate 复制
- (void)HeadMeViewDuplicateOdd{
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    NSString *string = self.dataModel.wl_id;
    [pab setString:string];
}
#pragma mark - 订单详情
- (void)apiRequestOrderdetail{
    @WeakObj(self);
    [SVProgressHUD show];
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"oid":self.orderID}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=update_order&ctrl=detail" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"订单详情:%@",respondsObject);
        NSDictionary *dictry =  respondsObject [DataKey];
        selfWeak.dataModel= [FNUpOrderdetailitemNeHModel mj_objectWithKeyValues:dictry];
        [self.jm_tableview reloadData];
        [UIView animateWithDuration:0.2 animations:^{
            [SVProgressHUD dismiss];
        }];
    } failure:^(NSString *error) {
        [self apiRequestOrderdetail];
    } isHideTips:NO];
}
@end
