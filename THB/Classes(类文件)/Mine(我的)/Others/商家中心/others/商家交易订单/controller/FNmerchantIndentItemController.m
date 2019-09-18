//
//  FNmerchantIndentItemController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerchantIndentItemController.h"
#import "FNmerchentOrderDetailsController.h"
#import "JMASBindAlipayController.h"
#import "FNWithdrawController.h"
#import "FNmerchantIndentItemCell.h"
#import "FNmerchantIndentHeadView.h"
#import "JXCategoryView.h"
#import "FNmerchentSDateView.h"
#import "FNcalendarPopDeView.h"
#import "FNmerchantIndentItemCancleAlertView.h"
#import "JMAlertView.h"
@interface FNmerchantIndentItemController ()<JXCategoryViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNcalendarPopDeViewDegate>
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)NSMutableArray *dateArr;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSString *dateString;
@property (nonatomic, strong)NSString *startTimeString;
@property (nonatomic, strong)NSString *endTimeString;
@property (nonatomic, strong)NSString *typeFilter;
@property (nonatomic, assign)NSInteger dateState;
@property (nonatomic, strong)FNmerchantIndentModel *listModel; 
@property (nonatomic, strong)FNmerchentSDateView *customView;
@property (nonatomic, strong)FNmerchantIndentItemCancleAlertView *cancleAlert;
@end

@implementation FNmerchantIndentItemController

-(FNmerchantIndentItemCancleAlertView *)cancleAlert {
    if (_cancleAlert == nil) {
        _cancleAlert = [[FNmerchantIndentItemCancleAlertView alloc] init];
        [self.view addSubview:_cancleAlert];
        [_cancleAlert mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    
    return _cancleAlert;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
#pragma mark - set up views
- (void)jm_setupViews{
    self.view.backgroundColor=RGB(246, 245, 245);
    [self insSubTopViews];
    CGFloat baseGap=SafeAreaTopHeight+40+33; 
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 33, FNDeviceWidth, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    self.jm_collectionview.alpha = 1;
    self.jm_collectionview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNmerchantIndentItemCell class] forCellWithReuseIdentifier:@"FNmerchantIndentItemCellID"];
    [self.jm_collectionview registerClass:[FNmerchantIndentHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNmerchantIndentHeadViewID"];
    
    [self requestIndentList];
}
#pragma mark - 排序类型
-(void)insSubTopViews{
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 1, FNDeviceWidth-80, 33)];
    self.categoryView.delegate = self;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.categoryView];
    self.categoryView.titleFont=kFONT13;
    self.categoryView.titleSelectedFont=kFONT13;
    self.categoryView.titleColor=RGB(140, 140, 140);
    self.categoryView.titleSelectedColor=[UIColor colorWithHexString:self.indentModel.select_color];
    
    NSArray *arrM=self.indentModel.date;
    if(arrM.count>0){
        NSMutableArray *nameArray=[NSMutableArray arrayWithCapacity:0];
        NSMutableArray *tyArray=[NSMutableArray arrayWithCapacity:0];
        [arrM enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNmerchantIndentTypeModel *model=[FNmerchantIndentTypeModel mj_objectWithKeyValues:obj];
            [nameArray addObject:model.title];
            [tyArray addObject:model];
        }];
        self.dateArr=tyArray;
        self.categoryView.titles =nameArray;
        FNmerchantIndentTypeModel *oneModel=self.dateArr[0];
        self.dateString=oneModel.date;
        [self.categoryView reloadData];
        [self requestIndentList];
    }
    
    UIButton *rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    rightBtn.tag=1100;
    [rightBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [rightBtn setImage:IMAGE(@"FJ_norsj_img") forState:UIControlStateNormal];
    [rightBtn setImage:IMAGE(@"FJ_orsj_img") forState:UIControlStateSelected];
    [rightBtn setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
    rightBtn.titleLabel.font=kFONT13;
    [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:rightBtn];
    rightBtn.backgroundColor=[UIColor whiteColor];
    
    UIView *lineView=[[UIView alloc]init];
    [self.view addSubview:lineView];
    lineView.backgroundColor=RGB(223, 223, 223);
    
    rightBtn.sd_layout
    .rightSpaceToView(self.view, 0).heightIs(33).centerYEqualToView(self.categoryView).widthIs(80);
    [rightBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    lineView.sd_layout
    .rightSpaceToView(rightBtn, 0).heightIs(14).centerYEqualToView(self.categoryView).widthIs(1);
    
    
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNmerchantIndentItemModel *itemModel=[FNmerchantIndentItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
    FNmerchantIndentItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerchantIndentItemCellID" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    cell.delegate = self;
    cell.model=itemModel;
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=135;
    CGFloat itemWith=FNDeviceWidth-20;
    CGSize  size = CGSizeMake(itemWith, itemHeight);
    return  size;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FNmerchantIndentHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNmerchantIndentHeadViewID" forIndexPath:indexPath];
    headerView.backgroundColor=[UIColor clearColor];
    headerView.topModel=self.indentModel;
    headerView.bottomModel=self.listModel;
    [headerView.rightBtn addTarget:self action:@selector(rightWithdrawClick)];
    return headerView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat headWith=FNDeviceWidth;
    CGFloat headHight=125;
    return CGSizeMake(headWith,headHight);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNmerchantIndentItemModel *itemModel=[FNmerchantIndentItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
    FNmerchentOrderDetailsController *vc=[[FNmerchentOrderDetailsController alloc]init];
    vc.orderId=itemModel.order_id;
    [self.naviController pushViewController:vc animated:YES];
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=10;
    CGFloat bottomGap=0;
    CGFloat rightGap=10;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
#pragma mark - 点击
//点击时间排序
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    self.startTimeString=@"";
    self.endTimeString=@"";
    FNmerchantIndentTypeModel *model=self.dateArr[index];
    self.dateString=model.date;
    self.jm_page=1;
    [self requestIndentList];
    [self cancelBtnDiss];
    XYLog(@"%@",model.date);
}
//筛选
-(void)rightBtnAction:(UIButton *)btn{
    btn.selected=!btn.selected;
    if (btn.selected==YES) {
        CGFloat topGap=33;
        self.customView = [[FNmerchentSDateView alloc] initWithFrame:CGRectMake(0, topGap, FNDeviceWidth, FNDeviceHeight-topGap)];
        [self.customView.cancelBtn addTarget:self action:@selector(cancelBtnDiss)];
        [self.customView.confirmBtn addTarget:self action:@selector(confirmBtnClick)];
        [self.customView.startBtn addTarget:self action:@selector(startBtnClick)];
        [self.customView.endBtn addTarget:self action:@selector(endBtnClick)];
        [self.view addSubview:self.customView];
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in self.indentModel.type) {
            [titles addObject: dict[@"str"]];
        }
        [self.customView showView: titles];
    }else{
        [self.customView hideViewAction];
    }
    
}
//取消
-(void)cancelBtnDiss{
    UIButton *rightBtn=(UIButton*)[self.view viewWithTag:1100];
    [self rightBtnAction:rightBtn];
}
//确定
-(void)confirmBtnClick{
    NSArray *selecteds = [self.customView getSelecteds];
    NSMutableString *type = [[NSMutableString alloc] init];
    BOOL isFirst = YES;
    for (NSInteger index = 0; index < self.indentModel.type.count && index < selecteds.count; index++) {
        NSDictionary *dict = self.indentModel.type[index];
        if ([selecteds[index] isEqual:@(1)]) {
            if (isFirst)
                [type appendString:dict[@"type"]];
            else
                [type appendString:[NSString stringWithFormat:@",%@", dict[@"type"]]];
            isFirst = NO;

        }
    }
    self.typeFilter = type;
    UIButton *rightBtn=(UIButton*)[self.view viewWithTag:1100];
    [self rightBtnAction:rightBtn];

    self.jm_page=1;
    [self requestIndentList];

}
//开始时间
-(void)startBtnClick{
    self.dateState=1;
    FNcalendarPopDeView *calendarView = [[FNcalendarPopDeView alloc]init];
    calendarView.delegate=self;
    [[UIApplication sharedApplication].delegate.window addSubview:calendarView];
}
//结束时间
-(void)endBtnClick{
    self.dateState=2;
    FNcalendarPopDeView *calendarView = [[FNcalendarPopDeView alloc]init];
    calendarView.delegate=self;
    [[UIApplication sharedApplication].delegate.window addSubview:calendarView];
}
#pragma mark - FNcalendarPopDeViewDegate // 选择日期
- (void)popSeletedDateClick:(NSString *)date{
    if(self.dateState==1){
        self.startTimeString=date;
        [self.customView.startBtn setTitle:date forState:UIControlStateNormal];
    }
    if(self.dateState==2){ 
        self.endTimeString=date;
        [self.customView.endBtn setTitle:date forState:UIControlStateNormal];
    }
    XYLog(@"选择日期=:%@",date);
}
//立即提现
-(void)rightWithdrawClick{
    if (![UserAccessToken kr_isNotEmpty]) {
        [self gologin];
        return;
    }
    if ([[ProfileModel profileInstance].zfb_au kr_isNotEmpty]) {
            FNWithdrawController* vc = [[FNWithdrawController alloc]init];
            [self.naviController pushViewController:vc animated:YES];
    } else {
            JMASBindAlipayController* alipay = [JMASBindAlipayController new];
            [self.naviController pushViewController:alipay animated:YES];
    }
}
- (NSMutableArray *)dateArr{
    if (!_dateArr) {
        _dateArr = [NSMutableArray array];
    }
    return _dateArr;
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
#pragma mark - // request
//订单列表
-(FNRequestTool*)requestIndentList{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    if([self.type kr_isNotEmpty]){
        params[@"status"]=self.type;
    }
    if([self.dateString kr_isNotEmpty]){
        params[@"date"]=self.dateString;
    }
    if([self.startTimeString kr_isNotEmpty]){
        params[@"start_time"]=self.startTimeString;
    }
    if([self.endTimeString kr_isNotEmpty]){
        params[@"end_time"]=self.endTimeString;
    }
    if ([self.typeFilter kr_isNotEmpty]) {
        params[@"type"] = self.typeFilter;
    }
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=order_list" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary *dictry=respondsObject[DataKey];
        self.listModel=[FNmerchantIndentModel mj_objectWithKeyValues:dictry];
        NSArray *array =dictry[@"list"];
        if (self.jm_page == 1) {
            if (array.count == 0) {
                [self.dataArr removeAllObjects];
                [self.jm_collectionview reloadData]; 
                return ;
            }
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.jm_page ++;
                    [self requestIndentList];
                }];
            }else{
            }
        } else {
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                [self.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self.jm_collectionview reloadData];
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:NO];
}
#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

- (void)listDidAppear {
    XYLog(@"显示JXList");
    
    //[FNNotificationCenter addObserver:self selector:@selector(updateNOIsCache) name:@"FBupdateNOIsCache" object:nil];
}
- (void)listDidDisappear {
    XYLog(@"消失itemVC");
    UIButton *rightBtn=(UIButton*)[self.view viewWithTag:1100];
    if(rightBtn.selected==YES){
      [self rightBtnAction:rightBtn];
    }
}

-(void)updateNOIsCache{
    self.jm_page=1;
    [self requestIndentList];
    XYLog(@"JXList已刷新");
}
-(void)dealloc{
    [FNNotificationCenter removeObserver:self];
}


#pragma mark - FNmerchantIndentItemCellDelegate

- (void) indentItemStateClick: (FNmerchantIndentItemCell*)cell {
    NSIndexPath *indexPath = [self.jm_collectionview indexPathForCell:cell];
    
    FNmerchantIndentItemModel *itemModel=[FNmerchantIndentItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
    if ([itemModel.status isEqualToString:@"apply_refund"]) {//退款申请
        @weakify(self)
        [self.cancleAlert show: ^(BOOL isAgree, NSString *msg) {
            @strongify(self)
            [self apiRequestMain: itemModel.order_id isAgree: isAgree content: msg];
            [self.cancleAlert dismiss];
        }];
    } else if ([itemModel.status isEqualToString:@"confirm_service"] ){//确认送达
        JMAlertView* alert = [JMAlertView alertWithTitle:@"" content:@"确认消费者已收到商品了吗" firstTitle:@"取消" andSecondTitle:@"已送达" alertType:(AlertTypeAlert) clickBlock:^(NSInteger index) {
            if (index == 1) {
                [self apiRequestConfirm:itemModel.order_id];
            }
        }];
        [alert.firstButton setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
        [alert.secondButton setTitleColor:RGB(250, 120, 0) forState:UIControlStateNormal];
        [alert showAlert];
    } else {
        [self collectionView:self.jm_collectionview didSelectItemAtIndexPath:indexPath];
    }
}

#pragma - mark Networking


- (FNRequestTool *)apiRequestMain: (NSString*)orderId isAgree: (BOOL)isAgree content: (NSString*)content{
    
    @weakify(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"id": orderId}];
    
    if(isAgree){
        params[@"type"]=@"agree";
    } else {
        params[@"type"]=@"refuse";
        if ([content kr_isNotEmpty]) {
            params[@"refuse_str"] = content;
        }
    }
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=confirm_refund" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        
        @strongify(self)
        self.jm_page = 1;
        [self requestIndentList];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

- (FNRequestTool *)apiRequestConfirm: (NSString*)orderId {
    
    @weakify(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"id": orderId}];
    
    return [FNRequestTool requestWithParams:params api:@"mod=&act=under_rebate_store&ctrl=order_use" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        
        @strongify(self)
        self.jm_page = 1;
        [self requestIndentList];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

@end
