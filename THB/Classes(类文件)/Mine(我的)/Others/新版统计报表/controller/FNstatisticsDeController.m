//
//  FNstatisticsDeController.m
//  THB
//
//  Created by Jimmy on 2018/12/27.
//  Copyright © 2018 方诺科技. All rights reserved.
//  财务报表

#import "FNstatisticsDeController.h"
//controller
#import "FNWithdrawController.h"
#import "JMASBindAlipayController.h"
#import "OrderViewController.h"
//头部1cell
#import "FNstatisticsCanDeCell.h"
#import "FNReckoningSetDeController.h"
//预估cell 60
#import "FNstatiPlanItemDeCell.h"
#import "FNtypeStatementDeCell.h"
#import "FNreportValDeCell.h"
#import "FNstartiTextDeFooterView.h"
#import "FNcartogramImgCell.h"
#import "FNReckChildDeView.h"
//model
#import "FNstatisticsDeModel.h"
#import "FNreckSetDeModel.h"
@interface FNstatisticsDeController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNReckChildDeViewDegate,FNtypeStatementDeCellDegate,FNstartiTextDeFooterViewDegate,FNstatisticsCanDeCellDegate>
@property(nonatomic,strong)FNReckChildDeView *childView;
@property(nonatomic,strong)FNstatisticsDeModel *dataModel;
@property(nonatomic,strong)FNstatisticsAnReportModel *modeDrawing;
//天数数据
@property(nonatomic,strong)NSMutableArray *timeArray;
//订单类型数据
@property(nonatomic,strong)NSMutableArray *ordertypeArray;
//筛选
@property(nonatomic,strong)NSMutableArray *screenArray;
//订单1
@property(nonatomic,strong)NSMutableArray *commissionArr;
//财务报表底部数据
@property(nonatomic,strong)NSMutableArray *reportArr;

@property(nonatomic,strong)NSMutableArray *reportTopArr;

@property(nonatomic,strong)NSMutableArray *picDataArr;

//时间type time_type
@property(nonatomic,strong)NSString *dateType;
//报表类型
@property(nonatomic,strong)NSString *type;
//订单类型 order_type
@property(nonatomic,strong)NSString *order_type;
//筛选页面的条件 screen_type
@property(nonatomic,strong)NSString *screen_type;
@property(nonatomic,assign)NSInteger topOneType;
@property(nonatomic,strong)NSString *start_time;
@property(nonatomic,strong)NSString *end_time;
//date_time
@property(nonatomic,strong)NSString *date_time;
@end

@implementation FNstatisticsDeController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![UserAccessToken kr_isNotEmpty]) {
        [self warnToLogin];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topOneType=0;
    
    [self navStatistics];
    
    [self statisticsCollectionview];
    
    [self childViewPortion];
    
    if([UserAccessToken kr_isNotEmpty]){
       [self apiRequestStatement];
       [self apiRequestScreening];
    }
    
    [FNNotificationCenter addObserver:self selector:@selector(obserStatisticsChange) name:@"refreshStatistics" object:nil];
}
-(void)obserStatisticsChange{
    
    
    FNstatisticsItemTimeModel *item=[FNstatisticsItemTimeModel mj_objectWithKeyValues:self.picDataArr[0]];
    self.date_time=item.time;
    [self apiRequestReportImg];
    //[self moniArrView];
   
    
}
-(void)dealloc{
    [FNNotificationCenter removeObserver:self];
}
-(void)moniArrView{
    //模拟数据
//    NSInteger random=100 +  (arc4random() % 1000);
//    NSString *jointString=[NSString stringWithFormat:@"%ld",(long)random];
//    NSInteger random1=50 +  (arc4random() % 200);
//    NSString *jointString1=[NSString stringWithFormat:@"%ld",(long)random1];
//    NSArray *arr=@[
//  @{@"time":@"12/01",@"val":jointString,@"val1":jointString1,@"val_color":@"66A3FF",@"val1_color":@"FF3E3E",@"name":@"1",@"name1":@"2"},
//  @{@"time":@"12/*2",@"val":jointString,@"val1":jointString1,@"val_color":@"66A3FF",@"val1_color":@"FF3E3E",@"name":@"1",@"name1":@"2"}];
    NSMutableArray *ratherArr=[NSMutableArray arrayWithCapacity:0];
    NSMutableArray *zonArr=[NSMutableArray arrayWithCapacity:0];
    //for (NSDictionary *dictry  in arr) {
    //    FNstatisticsItemTimeModel *item=[FNstatisticsItemTimeModel mj_objectWithKeyValues:dictry];
    //    [ratherArr addObject:item];
    //}
    for(int i=0;i<365;i++){
        NSInteger random=100 +  (arc4random() % 1000);
        NSString *jointString=[NSString stringWithFormat:@"%ld",(long)random];
        NSInteger random1=50 +  (arc4random() % 200);
        NSString *jointString1=[NSString stringWithFormat:@"%ld",(long)random1];
        FNstatisticsItemTimeModel *item=[FNstatisticsItemTimeModel mj_objectWithKeyValues:@{@"time":@"12/01",@"val":jointString,@"val1":jointString1,@"val_color":@"66A3FF",@"val1_color":@"FF3E3E",@"name":@"1",@"name1":@"2"}];
        
        [ratherArr addObject:item];
    }
    if (self.jm_page == 1) {
        [self.picDataArr removeAllObjects];
        [self.picDataArr addObjectsFromArray:ratherArr];
        
    } else {
        [zonArr addObjectsFromArray:ratherArr];
        [zonArr addObjectsFromArray:self.picDataArr];
        self.picDataArr=zonArr;
    }
    [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:4]];
    
}
#pragma mark - 导航栏
-(void)navStatistics{
    self.title=self.title?self.title:@"统计报表";
    UIButton *leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [leftBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [leftBtn sizeToFit];
    leftBtn.size = CGSizeMake(leftBtn.width+10, leftBtn.height+10);
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    if(self.understand==YES){
        leftBtn.hidden=YES; 
    }
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 主视图
-(void)statisticsCollectionview{
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight;
    CGFloat topInterval=SafeAreaTopHeight;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 10;
    flowlayout.minimumInteritemSpacing = 10;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, tableHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    //self.jm_collectionview.hidden=YES;
    [self.view addSubview:self.jm_collectionview];
    
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FNreckSetDeCellId"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNreckDeHeaderViewID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footViewID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footNoViewID"];
    
    [self.jm_collectionview registerClass:[FNstatisticsCanDeCell class] forCellWithReuseIdentifier:@"statisticsCanDeCellId"];
    [self.jm_collectionview registerClass:[FNstatiPlanItemDeCell class] forCellWithReuseIdentifier:@"statiPlanItemDeCellId"];
    [self.jm_collectionview registerClass:[FNtypeStatementDeCell class] forCellWithReuseIdentifier:@"typeStatementDeCellId"]; 
    
    [self.jm_collectionview registerClass:[FNreportValDeCell class] forCellWithReuseIdentifier:@"reportValDeCellId"];
    
    [self.jm_collectionview registerClass:[FNcartogramImgCell class] forCellWithReuseIdentifier:@"cartogramImgCellId"];
    
    [self.jm_collectionview registerClass:[FNstartiTextDeFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"TextDeFooterViewID"];
    self.jm_collectionview.backgroundColor=RGB(246, 245, 245);
}

#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==1){
        //FNstatisticsSYModel *model=[FNstatisticsSYModel mj_objectWithKeyValues:self.dataModel.sy_list];
        //NSArray *commArr=model.commission_data;
        return self.commissionArr.count;
    }
    else if(section==3){
        return self.reportTopArr.count;
    }
    else if(section==4){

        return 1;

    }
    else{
        return 1;
    }
   
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        FNstatisticsCanDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"statisticsCanDeCellId" forIndexPath:indexPath];
        cell.backgroundColor =RGB(246, 245, 245);
        FNstatisticsTXModel *model=[FNstatisticsTXModel mj_objectWithKeyValues:self.dataModel.tx_list];
        [cell.detailBtn addTarget:self action:@selector(moreAction)];
        cell.delegate=self;
        cell.model=model;
        return cell;
    }
    else if(indexPath.section==1){
        FNstatiPlanItemDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"statiPlanItemDeCellId" forIndexPath:indexPath];
        cell.backgroundColor =[UIColor whiteColor];
        //FNstatisticsSYModel *model=[FNstatisticsSYModel mj_objectWithKeyValues:self.dataModel.sy_list];
        //NSArray *commArr=model.commission_data;
        FNstatisticsCommissionModel *itemModel=self.commissionArr[indexPath.row];
        cell.model=itemModel;
        return cell;
    }
    else if(indexPath.section==2){
        FNtypeStatementDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"typeStatementDeCellId" forIndexPath:indexPath];
        cell.backgroundColor =[UIColor whiteColor];
        //cell.model=self.dataModel;
        cell.ordertypeArray=self.ordertypeArray;
        cell.timeArray=self.timeArray;
        cell.indexPath=indexPath;
        cell.delegate=self; 
        return cell;
    }
    else if(indexPath.section==3){
        FNreportValDeCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reportValDeCellId" forIndexPath:indexPath]; 
        cell.indexPath=indexPath;
        cell.model=self.reportTopArr[indexPath.row];
        cell.backgroundColor =[UIColor whiteColor];
        return cell;
    }
    else if(indexPath.section==4){
        FNcartogramImgCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cartogramImgCellId" forIndexPath:indexPath];
        //cell.indexPath=indexPath;
        cell.backgroundColor =[UIColor whiteColor];
        [cell.moreBtn addTarget:self action:@selector(orderMoreAction)];
        //cell.model=self.modeDrawing;
        cell.picDataArr=self.picDataArr;
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction)];
        swipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [cell.aaChartView addGestureRecognizer:swipe];
        return cell;
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNreckSetDeCellId" forIndexPath:indexPath];
    cell.backgroundColor =[UIColor whiteColor];
    return cell;
}
-(void)swipeAction{
    XYLog(@"向左滑");
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat gap_inter=0;
    if(section==1){
        gap_inter=1;
    }
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=35;
    if(indexPath.section==0){
        hight=120;
    }
    else if(indexPath.section==1){
        hight=70;
        with=FNDeviceWidth/2-0.5;
    }
    else if(indexPath.section==2){
        hight=80;
        with=FNDeviceWidth;
    }
    else if(indexPath.section==3){
        hight=75;
        with=FNDeviceWidth/2;
    }
    else if(indexPath.section==4){
        hight=290;
        with=FNDeviceWidth;
//        NSMutableArray *jointArr=[NSMutableArray arrayWithCapacity:0];
//        for (NSDictionary *dictry  in self.picDataArr) {
//            FNstatisticsItemTimeModel *item=[FNstatisticsItemTimeModel mj_objectWithKeyValues:dictry];
//            NSString *str1=[NSString stringWithFormat:@"%@",item.val];
//            NSString *str2=[NSString stringWithFormat:@"%@",item.val1];
//            [jointArr addObject:str1];
//            [jointArr addObject:str2];
//        }
//        NSMutableArray *fairlyArr=[NSMutableArray arrayWithCapacity:0];
//        for (NSString *string in jointArr) {
//            if([string isEqualToString:@"0"]){
//               [fairlyArr addObject:string];
//            }
//        }
//        if(fairlyArr.count==jointArr.count){
//            hight=0;
//        }else{
//            hight=290;
//        }
    }
    CGSize size = CGSizeMake(with, hight);
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ( [kind isEqual: UICollectionElementKindSectionHeader] ) {
       UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNreckDeHeaderViewID" forIndexPath:indexPath];
       headerView.backgroundColor=[UIColor whiteColor];
       return headerView;
    }else{
        if(indexPath.section==1){
            FNstartiTextDeFooterView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"TextDeFooterViewID" forIndexPath:indexPath];
            FNstatisticsSYModel *model=[FNstatisticsSYModel mj_objectWithKeyValues:self.dataModel.sy_list];
            footView.hintLB.text=model.str;
            footView.model=self.dataModel;
            footView.delegate=self;
            footView.topOneType=self.topOneType;
            return footView;
        }
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footNoViewID" forIndexPath:indexPath];
        footView.backgroundColor=[UIColor whiteColor];
        return footView;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=0;
    if(section==1){
        hight=20;
    }
    return CGSizeMake(with,hight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=0;
    if(section==1){
        hight=85;
    }
    return CGSizeMake(with,hight);
}
-(void)moreAction{
    secondViewController *vc = [[secondViewController alloc]init];
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@",IP,_api_mine_DrawHistory,UserAccessToken];
    vc.url = urlString;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)orderMoreAction{
    if (![UserAccessToken kr_isNotEmpty]) {
        [self gologin];
        return;
    }
    if([self.type isEqualToString:@"order_sum"]){
        FNReckoningSetDeController *vc=[FNReckoningSetDeController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        OrderViewController *vc = [OrderViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - FNstatisticsCanDeCellDegate // 立即提现
- (void)inStatisticsCanwithdraw{
    if (![UserAccessToken kr_isNotEmpty]) {
        [self gologin];
        return;
    }
    FNstatisticsTXModel *model=[FNstatisticsTXModel mj_objectWithKeyValues:self.dataModel.tx_list];
    NSString *is_tx=model.is_tx;
    if ([NSString checkIsSuccess:is_tx andElement:@"1"]) {
        if ([[ProfileModel profileInstance].zfb_au kr_isNotEmpty]) {
            FNWithdrawController* vc = [[FNWithdrawController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            JMASBindAlipayController* alipay = [JMASBindAlipayController new];
            [self.navigationController pushViewController:alipay animated:YES];
        }
    }
}
#pragma mark - //FNstartiTextDeFooterViewDegate // 选择财务报表 或订单报表 
- (void)intypeStairScreenType:(NSInteger)send{
    self.topOneType=send;
    NSArray *tabArr=self.dataModel.tab_list;
    FNstatisticsTABModel *oneModel=[FNstatisticsTABModel mj_objectWithKeyValues:tabArr[send]];
    self.type=oneModel.type;
    XYLog(@"oneModel=:%@",oneModel.type);
    if([self.type kr_isNotEmpty]){
        self.jm_page=1;
        [self apiRequestDateCate];
    }
     NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:2];
     FNtypeStatementDeCell* cell = (FNtypeStatementDeCell *)[self.jm_collectionview cellForItemAtIndexPath:index];
     if(cell.screenBtn.selected==YES){
        cell.screenBtn.selected=NO;
        [self.childView hideViewAction];
     } 
}
#pragma mark - //FNtypeStatementDeCellDegate 筛选选择
// 筛选选择
- (void)intypeStateScreenDupAction:(NSIndexPath*)index withState:(NSInteger)state{
    
    if (![UserAccessToken kr_isNotEmpty]) {
        [self gologin];
        return;
    }
    
    if (state==1) {
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.jm_collectionview setContentOffset:CGPointMake(0,255) animated:YES];
        } completion:^(BOOL finished) {
            self.childView.hidden=NO;
            [self.childView showOneView];
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            [self.childView hideViewAction];
        } completion:^(BOOL finished) {
            [self.jm_collectionview setContentOffset:CGPointMake(0,0) animated:YES];
        }];
    }
}
// 天数 二级筛选
- (void)intypeStairScreenTwoType:(NSInteger)send{
    FNstatisticsTimeModel *model=self.timeArray[send];
    self.dateType=model.type;
    if([self.dateType kr_isNotEmpty]){
        self.date_time=@"";
        [self apiRequestReportImg];
        NSString *piccount=[NSString stringWithFormat:@"%lu",self.picDataArr.count];
        NSDictionary *dictry=@{@"Fate":piccount};
        [FNNotificationCenter postNotificationName:@"movementFate" object:nil userInfo:dictry];
    }
    NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:2];
    FNtypeStatementDeCell* cell = (FNtypeStatementDeCell *)[self.jm_collectionview cellForItemAtIndexPath:index];
    if(cell.screenBtn.selected==YES){
        cell.screenBtn.selected=NO;
        [self.childView hideViewAction];
    } 
}

// 三级筛选
- (void)intypeStairScreenThreeType:(NSInteger)send{
    FNstatisticsTimeModel *model=self.ordertypeArray[send];
    self.order_type=model.type;
    if([self.order_type kr_isNotEmpty]){
        self.date_time=@"";
        [self apiRequestReportImg];
        NSString *piccount=[NSString stringWithFormat:@"%lu",self.picDataArr.count];
        NSDictionary *dictry=@{@"Fate":piccount};
        [FNNotificationCenter postNotificationName:@"movementFate" object:nil userInfo:dictry];
    }
}
#pragma mark - //财务报表
- (FNRequestTool *)apiRequestStatement{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=financial_statements&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"财务报表:%@",respondsObject);
        NSDictionary *dictry=respondsObject[DataKey];
        FNstatisticsDeModel*modelM=[FNstatisticsDeModel mj_objectWithKeyValues:dictry];
        FNstatisticsSYModel*syDicModel=[FNstatisticsSYModel mj_objectWithKeyValues:modelM.sy_list];
        NSMutableArray *commissionlistArr=[NSMutableArray arrayWithCapacity:0];
        [syDicModel.commission_data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNstatisticsCommissionModel *CommissionModel=[FNstatisticsCommissionModel mj_objectWithKeyValues:obj];
                NSInteger palce=idx % (2);
                CommissionModel.place=palce;//idx+200;
                [commissionlistArr addObject:CommissionModel];
        }];
        selfWeak.commissionArr=commissionlistArr;
        selfWeak.dataModel=[FNstatisticsDeModel mj_objectWithKeyValues:dictry];
        NSArray *tabArr=selfWeak.dataModel.tab_list;
        FNstatisticsTABModel *timeModel=[FNstatisticsTABModel mj_objectWithKeyValues:tabArr[0]];
        selfWeak.type=timeModel.type;
        [self apiRequestDateCate];
        [UIView performWithoutAnimation:^{
            [selfWeak.jm_collectionview reloadData];
        }];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - //财务报表的时间分类
- (FNRequestTool *)apiRequestDateCate{
    @WeakObj(self);
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    if([self.type kr_isNotEmpty]){
        params[@"type"]=self.type;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=financial_statements&ctrl=time_cate" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"时间分类:%@",respondsObject);
        NSDictionary *darr=respondsObject[DataKey];
        FNstatisticsAnCateModel *model=[FNstatisticsAnCateModel mj_objectWithKeyValues:darr];
        NSMutableArray *timeArrM=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in model.day_list) {
            FNstatisticsTimeModel *itemModel=[FNstatisticsTimeModel mj_objectWithKeyValues:dic];
            [timeArrM addObject:itemModel];
        }
        selfWeak.timeArray=timeArrM;
        NSMutableArray *cateArrM=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in model.ordertype_list) {
            FNstatisticsTimeModel *itemModel=[FNstatisticsTimeModel mj_objectWithKeyValues:dic];
            [cateArrM addObject:itemModel];
        }
        selfWeak.ordertypeArray=cateArrM;
        //[selfWeak.jm_collectionview reloadData];
        
        FNstatisticsTimeModel *oneTimeModel=timeArrM[0];
        selfWeak.dateType=oneTimeModel.type;
        
        FNstatisticsTimeModel *orderModel=cateArrM[0];
        selfWeak.order_type=orderModel.type;
        
        [UIView performWithoutAnimation:^{
            [selfWeak.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:2]];
        }];
        [selfWeak apiRequestReportImg];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - //财务报表筛选条件
- (FNRequestTool *)apiRequestScreening{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=financial_statements&ctrl=screen_2" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"筛选条件:%@",respondsObject);
        NSArray* arr = respondsObject[DataKey];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dictry in arr) {
            //[arrM addObject:[FNreckSetScreenDeModel mj_objectWithKeyValues:dictry]];
            NSMutableArray *itemArr=[NSMutableArray arrayWithCapacity:0];
            FNreckSetScreenDeModel *zonModel=[FNreckSetScreenDeModel mj_objectWithKeyValues:dictry];
            [zonModel.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNreckScreenItemModel *model=[FNreckScreenItemModel mj_objectWithKeyValues:obj];
                model.stateID=200+idx;
                [itemArr addObject:model];
            }];
            zonModel.list=itemArr;
//              zonModel.list=itemArr[0];
            [arrM addObject:zonModel];
        }
        if(selfWeak.screenArray.count>1){
            FNreckScreenItemModel *oneModel=selfWeak.screenArray[0];
            [selfWeak.screenArray removeAllObjects];
            [selfWeak.screenArray addObject:oneModel];
            [selfWeak.screenArray addObjectsFromArray:arrM];
        }else{
            [selfWeak.screenArray addObjectsFromArray:arrM];
        }
        selfWeak.childView.typeDataArr=selfWeak.screenArray;
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

#pragma mark - //财务报表底部数据
- (FNRequestTool *)apiRequestReportImg{
    @WeakObj(self)
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    if([self.type kr_isNotEmpty]){
        params[@"type"]=self.type;
    }
    if([self.dateType kr_isNotEmpty]){
        params[@"time_type"]=self.dateType;
    }
    if([self.order_type kr_isNotEmpty]){
        params[@"order_type"]=self.order_type;
    }
    if([self.dateType kr_isNotEmpty]){
        params[@"screen_type"]=self.screen_type;
    }
    if([self.date_time kr_isNotEmpty]){
        params[@"date_time"]=self.date_time;
    }
    if([self.start_time kr_isNotEmpty]){
        params[@"start_time"]=self.start_time;
    }
    if([self.end_time kr_isNotEmpty]){
        params[@"end_time"]=self.end_time;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=financial_statements&ctrl=report" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"结果:%@",respondsObject);
        NSDictionary *dictry=respondsObject[DataKey];
        FNstatisticsAnReportModel *mode=[FNstatisticsAnReportModel mj_objectWithKeyValues:dictry];
        
        NSMutableArray *syArr=[NSMutableArray arrayWithCapacity:0];
        [mode.sy_data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNstatisticsReportItemModel *itemModel=[FNstatisticsReportItemModel mj_objectWithKeyValues:obj];
            itemModel.place=idx+100;
            [syArr addObject:itemModel];
        }];
        selfWeak.reportTopArr=syArr;
        selfWeak.modeDrawing=mode;
        
        if(syArr.count>0){
            
            [UIView performWithoutAnimation:^{
                [selfWeak.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:3]];
            }];
        }
        NSMutableArray *ratherArr=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dictry  in mode.pic_data) {
            FNstatisticsItemTimeModel *item=[FNstatisticsItemTimeModel mj_objectWithKeyValues:dictry];
            [ratherArr addObject:item];
        }
        if([self.date_time kr_isNotEmpty]){
            
            [ratherArr addObjectsFromArray:selfWeak.picDataArr];
        }
        selfWeak.picDataArr=ratherArr;
        [UIView performWithoutAnimation:^{
            [selfWeak.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:4]];
        }];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - 筛选View
-(void)childViewPortion{
    self.childView=[[FNReckChildDeView alloc]initWithFrame:CGRectMake(0, 70, FNDeviceWidth, FNDeviceHeight) withState:1];
    self.childView.hidden=YES;
    self.childView.delegate=self;
    [self.view addSubview:self.childView];
    self.childView.sd_layout
    .topSpaceToView(self.view, 70).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
}
#pragma mark - FNReckChildDeViewDegate 筛选
// 确定条件
- (void)inConditionConfirmClick:(NSArray*)arr withStart:(NSString*)startdate withOver:(NSString*)overdate{
    [self.jm_collectionview setContentOffset:CGPointMake(0,0) animated:YES];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0  inSection:2];
    FNtypeStatementDeCell* cell = (FNtypeStatementDeCell *)[self.jm_collectionview cellForItemAtIndexPath:indexPath];
    cell.screenBtn.selected=NO;
    
    NSMutableArray *joiArr=[NSMutableArray arrayWithCapacity:0];
    for (FNreckSetScreenDeModel *model in arr) {
        [model.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNreckScreenItemModel *model=[FNreckScreenItemModel mj_objectWithKeyValues:obj];
            if(model.state==1){
                [joiArr addObject:model.screen_type];
            }
        }];
    }
    if(joiArr.count>0){
        [cell.screenBtn setImage:IMAGE(@"FJ_ySJ_topimg") forState:UIControlStateNormal];
        [cell.screenBtn setTitleColor:RGB(255, 61, 61) forState:UIControlStateNormal];
    }else{
        [cell.screenBtn setImage:IMAGE(@"FJ_norsj_img") forState:UIControlStateNormal];
        [cell.screenBtn setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
    }
    
    if(joiArr.count==0 &&![startdate kr_isNotEmpty] &&![overdate kr_isNotEmpty] ){
        return;
    }
    //XYLog(@"开始=:%@结束=:%@",startdate,overdate);
    self.start_time=startdate;
    self.end_time=overdate;
    //XYLog(@"joiArr=:%@",joiArr);
    if(joiArr.count>0){
        self.screen_type= [joiArr componentsJoinedByString:@","];
    }
    self.date_time=@"";
    [self apiRequestReportImg];
}
//刷新类型
-(void)inChildTypeRefresh:(NSString*)type{
    
    
}
#pragma mark - //数组
-(NSMutableArray *)timeArray{
    if (!_timeArray) {
        _timeArray = [NSMutableArray array];
    }
    return _timeArray;
}
-(NSMutableArray *)ordertypeArray{
    if (!_ordertypeArray) {
        _ordertypeArray = [NSMutableArray array];
    }
    return _ordertypeArray;
}
-(NSMutableArray *)screenArray{
    if (!_screenArray) {
        _screenArray = [NSMutableArray array];
    }
    return _screenArray;
}

-(NSMutableArray *)commissionArr{
    if (!_commissionArr) {
        _commissionArr = [NSMutableArray array];
    }
    return _commissionArr;
}

-(NSMutableArray *)reportArr{
    if (!_reportArr) {
        _reportArr = [NSMutableArray array];
    }
    return _reportArr;
}

-(NSMutableArray *)reportTopArr{
    if (!_reportTopArr) {
        _reportTopArr = [NSMutableArray array];
    }
    return _reportTopArr;
}

-(NSMutableArray *)picDataArr{
    if (!_picDataArr) {
        _picDataArr = [NSMutableArray array];
    }
    return _picDataArr;
}

@end
