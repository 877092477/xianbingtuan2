//
//  OrderViewController.m
//  THB
//
//  Created by Weller Zhao on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "OrderViewController.h"
#import "FNLogisticsInfosController.h"
#import "SliderControl.h"
#import "OrderCell.h"
#import "OrderHeaderView.h"
#import "FNSearchView.h"
#import "OrderModel.h"
#import "FNcalendarPopDeView.h"
#import "FNReckChildDeView.h"
@interface OrderViewController() <UITableViewDelegate, UITableViewDataSource, SliderControlDelegate, FNSearchViewDelegate, OrderHeaderViewDelegate, FNcalendarPopDeViewDegate, OrderCellDelegate,FNReckChildDeViewDegate>

@property (nonatomic, strong) SliderControl* sldStores;
@property (nonatomic, strong) SliderControl* sldType;
@property (nonatomic, strong) OrderHeaderView* headerView;
@property (nonatomic, strong) FNSearchView *searchView;

@property (nonatomic, strong) NSArray<OrderCateModel*>* allCategories;
@property (nonatomic, strong) NSArray<OrderStatusModel*>* allStatus;
@property (nonatomic, strong) NSMutableArray<OrderModel*>* allOrders;

@property (nonatomic, copy) NSString *SkipUIIdentifier;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, assign) NSInteger dateState;

@property (nonatomic, strong) FNReckChildDeView *childView;
@property (nonatomic, strong) NSString *screentype;
@property (nonatomic, strong) NSArray  *screenArr;
@property (nonatomic, strong) NSString *indentName;
@end

@implementation OrderViewController

- (BOOL)isFullScreenShow {
    return YES;
}

- (BOOL) needLogin {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allOrders = [[NSMutableArray alloc] init];
    
    [self configNav];
    [self configUI];
    
    [self requestCategory];
}

- (void)configNav {
    
    UIButton *leftButton = [[UIButton alloc] init];
    [leftButton setTitle:@"订单明细" forState:UIControlStateNormal];
    [leftButton setTitleColor:RGB(60, 60, 60) forState:UIControlStateNormal];
    leftButton.titleLabel.font = kFONT16;
    [leftButton setImage:IMAGE(@"return") forState:UIControlStateNormal];
    [leftButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:4];
    [leftButton sizeToFit];
    [leftButton addTarget:self action:@selector(onBackClick)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.searchView = [[FNSearchView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    self.navigationItem.titleView = self.searchView;
    self.searchView.delegate = self;
    CGFloat width = XYScreenWidth - leftButton.bounds.size.width - 40;
    
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(30);
    }];
    
}

- (void) configUI {
    self.view.backgroundColor = FNHomeBackgroundColor;
    
    _sldStores = [[SliderControl alloc] init];
    [self.view addSubview:_sldStores];
    
    _sldType = [[SliderControl alloc] init];
    [self.view addSubview:_sldType];
    
    [_sldStores mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.mas_equalTo(36);
    }];

    [_sldType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(_sldStores.mas_bottom).offset(1);
        make.height.mas_equalTo(36);
    }];

    self.sldStores.backgroundColor = FNWhiteColor;
    self.sldStores.font = kFONT12;
    self.sldStores.textColor = RGB(102, 102, 102);
    self.sldStores.textHighlightColor = RGB(255, 90, 0);
    self.sldStores.highlightColor = RGB(255, 90, 0);
    self.sldStores.autoSize = YES;
    self.sldStores.delegate = self;
    
    
    self.sldType.backgroundColor = FNWhiteColor;
    self.sldType.font = kFONT11;
    self.sldType.textColor = RGB(140, 140, 140);
    self.sldType.textHighlightColor = RGB(255, 90, 0);
    self.sldType.highlightColor = UIColor.clearColor;
    self.sldType.autoSize = YES;
    self.sldType.delegate = self;
    
    self.headerView = [[OrderHeaderView alloc] init];
    [self.view addSubview: self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(_sldType.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    
    self.jm_tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.jm_tableview];
    self.jm_tableview.delegate = self;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.rowHeight = UITableViewAutomaticDimension;
    self.jm_tableview.estimatedRowHeight = 120;
    self.jm_tableview.backgroundColor = FNHomeBackgroundColor;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.jm_tableview registerClass:[OrderCell class] forCellReuseIdentifier:@"OrderCell"];
    if (@available(iOS 11.0, *)) {
        
        self.jm_tableview.estimatedSectionFooterHeight = 0;
        self.jm_tableview.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(self.headerView.mas_bottom);
    }];
    
    @weakify(self);
    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.jm_page = 1;
        if (self.SkipUIIdentifier ==nil || self.status == nil || self.keyword ==nil) {
            [self requestCategory];
            return;
        }
        [self requestOrders];
    }];
    self.jm_tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestOrders)];
    self.indentName=@"";
    self.headerView.startTime = @"开始时间";
    self.headerView.endTime = @"结束时间";
    self.headerView.delegate = self;
    self.headerView.jointTime = @"";
    [self.headerView.screenBtn addTarget:self action:@selector(screenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self childViewPortion];
    
}

#pragma mark - Network

- (FNRequestTool *)requestCategory{
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appAllOrder&ctrl=cate" respondType:(ResponseTypeArray) modelType:@"OrderCateModel" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        @strongify(self);
        self.allCategories = respondsObject;
        NSMutableArray *names = [[NSMutableArray alloc] init];
        for (OrderCateModel *cate in self.allCategories) {
            [names addObject:cate.name];
        }
        [self.sldStores setTitles:names];
        if (self.allCategories.count > 0) {
            self.SkipUIIdentifier = self.allCategories[0].SkipUIIdentifier;
            [self.sldStores setSelected:0 animated:NO];
            [self requestStatus];
            [self apiRequestScreens];
        }
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:YES];
}

- (FNRequestTool *)requestStatus{
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"SkipUIIdentifier": self.SkipUIIdentifier}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appAllOrder&ctrl=status_cate" respondType:(ResponseTypeArray) modelType:@"OrderStatusModel" success:^(id respondsObject) {
        @strongify(self);
        [SVProgressHUD dismiss];
        self.keyword = @"";
        self.allStatus = respondsObject;
        
        NSMutableArray *names = [[NSMutableArray alloc] init];
        for (OrderStatusModel *status in self.allStatus) {
            [names addObject:status.name];
        }
        [self.sldType setTitles:names];
        if (self.allStatus.count > 0) {
            self.status = self.allStatus[0].status;
            [self.sldType setSelected:0 animated:NO];
            self.jm_page = 1;
            [self requestOrders];
        } else {
            [self.allOrders removeAllObjects];
            self.headerView.lblOrder.text = @"";
            [self.jm_tableview reloadData];
        }
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:YES];
}

- (FNRequestTool *)requestOrders{
    if (self.SkipUIIdentifier ==nil || self.status == nil || self.keyword ==nil) {
        [self.jm_tableview.mj_footer endEditing:YES];
        return nil;
    }
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"SkipUIIdentifier": self.SkipUIIdentifier, @"status": self.status, @"keyword": self.keyword, @"p": @(self.jm_page)}];
    if (self.startTime && ![self.startTime isEqualToString:@""]) {
        params[@"start_time"] = self.startTime;
    }
    if (self.endTime && ![self.endTime isEqualToString:@""]) {
        params[@"end_time"] = self.endTime;
    }
    if([self.screentype kr_isNotEmpty]){
        params[@"tg_type"] = self.screentype;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appAllOrder&ctrl=index" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        
        NSString *str = [respondsObject objectForKey:@"str"];
        NSArray *list = [respondsObject objectForKey:@"list"];
        NSString *jointStr=[NSString stringWithFormat:@"%@ %@",str,self.indentName];
        self.headerView.lblOrder.text = jointStr;
        
        
//        [OrderModel mj_objectWithKeyValues:obj]
        NSArray *array = [[OrderModel class] mj_objectArrayWithKeyValuesArray:list];
        
        if (self.jm_page == 1) {
            [self.allOrders removeAllObjects];
        }
        if (array.count > 0)
            self.jm_page ++;
        [self.allOrders addObjectsFromArray:array];
        [self.jm_tableview reloadData];
        [self.jm_tableview.mj_footer endRefreshing];
        [self.jm_tableview.mj_header endRefreshing];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:YES];
}

/**
 重设筛选条件
 */
- (void)resetFilter {
    self.jm_page = 1;
    self.keyword = @"";
    self.startTime = @"";
    self.endTime = @"";
    self.searchView.text = @"";
    self.headerView.startTime = @"开始时间";
    self.headerView.endTime = @"结束时间";
}

#pragma mark - Action

- (void) onBackClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allOrders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
    OrderModel *model = self.allOrders[indexPath.row];
    [cell.imgHeader sd_setImageWithURL:URL(model.goods_img)];
    cell.lblTitle.text = model.goodsInfo;
    cell.lblMoney.text = [NSString stringWithFormat:@"¥%@", model.payment];
    cell.lblTime.text = model.time_str;
    cell.lblOrderNum.text = model.order_str;
    cell.lblShop.text = model.shop_type;
    cell.lblShop.textColor = [UIColor colorWithHexString:model.shop_type_color];
    cell.lblType.text = model.label_str;
    cell.lblCommissionTitle.text = model.fan_all_str;
    cell.lblCommission.text = model.fcommission;
    cell.lblState.text = model.status;
    cell.lblState.textColor = [UIColor colorWithHexString:model.status_fontcolor];
    cell.vState.backgroundColor = [UIColor colorWithHexString:model.status_color];
    if(model.is_show_wl==0){
       cell.logisticsBtn.hidden=YES;
    }else{
       cell.logisticsBtn.hidden=NO; 
       [cell.logisticsBtn sd_setBackgroundImageWithURL:URL(model.wl_btn) forState:UIControlStateNormal];
    }
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    OrderModel *model = self.allOrders[indexPath.row];
//    [self goProductVCWithModel:model];
}

#pragma mark - SliderControlDelegate
- (void)sliderControl:(SliderControl *)slider didCellSelectedAtIndex:(NSInteger)index {
    if (slider == self.sldStores) {
        self.SkipUIIdentifier = self.allCategories[index].SkipUIIdentifier;
        [self resetFilter];
        [self requestStatus];
        [self apiRequestScreens];
    } else if (slider == self.sldType) {
        self.status = self.allStatus[index].status;
        self.jm_page = 1;
        [self requestOrders];
    }
}

#pragma mark - FNSearchViewDelegate

- (void)searchView:(FNSearchView *)searchView didSearch:(NSString *)text {
    self.keyword = text;
    self.jm_page = 1;
    [self requestOrders];
}

#pragma mark - OrderHeaderViewDelegate
- (void)didStartTimeClick:(OrderHeaderView *)headerView {
    self.dateState = 1;
    [self showcalendarView];
}

- (void)didEndTimeClick:(OrderHeaderView *)headerView {
    self.dateState = 2;
    [self showcalendarView];
}

#pragma mark - //显示日历
-(void)showcalendarView{
    FNcalendarPopDeView *calendarView = [[FNcalendarPopDeView alloc]init];
    calendarView.delegate=self;
    [[UIApplication sharedApplication].delegate.window addSubview:calendarView];
}

#pragma mark - FNcalendarPopDeViewDelegate

- (void)popSeletedDateClick:(NSString *)date {
    XYLog(@"选择日期=:%@",date);
    if(self.dateState==1){
        self.startTime=date;
        self.headerView.startTime = date;
    }
    if(self.dateState==2){
        self.endTime=date;
        self.headerView.endTime = date;
    }
    self.jm_page = 1;
    [self requestOrders];
}

#pragma mark - OrderCellDelegate

- (void)didCopyClick:(OrderCell *)cell {
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    OrderModel *model = self.allOrders[indexPath.row];
    [FNTipsView showTips:@"复制成功"];
    [[UIPasteboard generalPasteboard] setString:model.orderId];
}
- (void)didCheckLogisticsClick: (OrderCell*)cell{
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    OrderModel *model = self.allOrders[indexPath.row];
    XYLog(@"查看..");
    FNLogisticsInfosController *vc=[[FNLogisticsInfosController alloc]init];
    vc.orderID=model.ID;
    vc.SkipUIIdentifier=self.SkipUIIdentifier;
    [self.navigationController pushViewController:vc animated:YES];
}
//点击筛选
- (void)screenBtnClick:(UIButton*)btn{
    //if(self.screenArr.count>0){
        btn.selected=!btn.selected;
        if (btn.selected==YES) {
            self.childView.hidden=NO;
            [self.childView showOneView];
        }else{
            [self.childView hideViewAction];
        }
//    }else{
//        [self apiRequestScreens];
//    }
}
#pragma mark - 筛选
-(void)childViewPortion{
    self.childView=[[FNReckChildDeView alloc]init];
    self.childView.hidden=YES;
    self.childView.OneSingSeleted=YES;
    self.childView.typeInt=1;
    self.childView.delegate=self;
    [self.view addSubview:self.childView];
    [self.childView.resetBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.childView.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.childView.confirmBtn setBackgroundColor:RGB(240, 87, 38)];
    CGFloat topGap=112;
    self.childView.sd_layout
    .topSpaceToView(self.view, topGap).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
}
//取消
-(void)inChildCancelRefresh{
    self.headerView.screenBtn.selected=NO;
    [self.childView hideViewAction];
}
// 确定条件
- (void)inConditionConfirmClick:(NSArray*)arr withStart:(NSString*)startdate withOver:(NSString*)overdate{
    
    
    if(arr.count>0){
        NSMutableArray *joiArr=[NSMutableArray arrayWithCapacity:0];
        FNreckSetScreenDeModel *Model=arr[0];
        [Model.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNreckScreenItemModel *model=[FNreckScreenItemModel mj_objectWithKeyValues:obj];
            if(model.state==1){
                [joiArr addObject:model];//model.tg_type
            }
        }];
        if(joiArr.count>0){
            FNreckScreenItemModel *seletedModel=joiArr[0];
            self.screentype= seletedModel.tg_type;
            self.indentName=seletedModel.name;
            XYLog(@"screentype=%@",self.screentype);
            
        }
    }
    
    self.headerView.screenBtn.selected=NO;
    self.startTime=startdate;
    self.endTime=overdate;
    NSString *joint=@"";//@"开始时间-结束时间"
    if([startdate kr_isNotEmpty]&& ![overdate kr_isNotEmpty]){
        joint=startdate;
    }
    else if(![startdate kr_isNotEmpty]&& [overdate kr_isNotEmpty]){
        joint=overdate;
    }
    else if(![startdate kr_isNotEmpty]&& ![overdate kr_isNotEmpty]){
        joint=@"";
    }
    else if([startdate kr_isNotEmpty]&& [overdate kr_isNotEmpty]){
        joint=[NSString stringWithFormat:@"%@ - %@",startdate,overdate];
    }
//    if([startdate kr_isNotEmpty]&& [overdate kr_isNotEmpty] &&[self.screentype kr_isNotEmpty]){
//        self.jm_page = 1;
//        [self requestOrders];
//    }
    if([startdate kr_isNotEmpty]|| [overdate kr_isNotEmpty] ||[self.screentype kr_isNotEmpty]){
        self.jm_page = 1;
        [self requestOrders];
    }
    self.headerView.jointTime = joint;
    
}
#pragma mark - //订单推广类型接口
- (FNRequestTool *)apiRequestScreens{
    if (self.SkipUIIdentifier ==nil) {
        [self.jm_tableview.mj_footer endEditing:YES];
        return nil;
    }
    @weakify(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    if([self.SkipUIIdentifier kr_isNotEmpty]){
       params[@"SkipUIIdentifier"]=self.SkipUIIdentifier;
    } 
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appAllOrder&ctrl=screen" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
         NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
         NSMutableArray *itemArrM=[NSMutableArray arrayWithCapacity:0];
         NSDictionary *dictry=respondsObject[DataKey];
         NSArray* arrList = dictry[@"cate"];
         self.screenArr=arrList;
         FNreckSetScreenDeModel *zonModel=[[FNreckSetScreenDeModel alloc]init];
         zonModel.name=dictry[@"str"];
         [arrList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNreckScreenItemModel *model=[FNreckScreenItemModel mj_objectWithKeyValues:obj];
                if(idx==0){
                    model.state=1;
                }
                model.typeInt=1;
                model.stateID=200+idx;
                [itemArrM addObject:model];
        }];
        zonModel.list=itemArrM;
        [arrM addObject:zonModel];
        self.childView.typeDataArr=arrM;
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
@end
