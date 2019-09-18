//
//  FNmerMoneyOffController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerMoneyOffController.h"
#import "FNCustomeNavigationBar.h"
#import "FNmerIssueEditOCell.h"
#import "FNmerIssueDateSCell.h"
#import "FNmoneyOffItemCell.h"
#import "FNmerIssueocModel.h"
#import "FNcalendarPopDeView.h"
#import "NSDate+HXExtension.h"
#import "PGDatePickManager.h"
#import "FNDeliveryDatepView.h"
#import "FNStoreGoodsSelectManagerController.h"
@interface FNmerMoneyOffController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNmerIssueEditOCellDelegate,FNcalendarPopDeViewDegate,PGDatePickerDelegate,FNmoneyOffItemCellDelegate, FNStoreGoodsSelectManagerControllerDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)NSMutableArray *dataArr;//3:section
@property (nonatomic, strong)NSMutableArray *extraArr;//2:section
@property (nonatomic, strong)NSMutableArray *topOneArr;//0:section
@property (nonatomic, strong)NSMutableArray *topTwoArr;//1:section
@property (nonatomic, strong)NSString* type;
@property (nonatomic, strong)NSString* condition1;//满减条件
@property (nonatomic, strong)NSString* price1;//满减金额
@property (nonatomic, strong)NSString* condition2;//满减条件
@property (nonatomic, strong)NSString* price2;//满减金额    例：满20减5的
@property (nonatomic, strong)NSString* condition3;//满减条件
@property (nonatomic, strong)NSString* price3;//满减金额
@property (nonatomic, strong)NSString* allow_cates;//参加满减的商品分类
@property (nonatomic, strong)NSString* allow_goods;//参加满减的具体商品    1,2
@property (nonatomic, strong)NSString* on_line;//买单方式->线上
@property (nonatomic, strong)NSString* on_shop;//买单方式->门店
@property (nonatomic, strong)NSString* with_red_packet;//是否可与红包叠加
@property (nonatomic, strong)NSString* with_yhq;//是否可以与优惠券叠加
@property (nonatomic, strong)NSString* start_time;//        开始时间    年月日
@property (nonatomic, strong)NSString* end_time;//          结束时间    年月日
@property (nonatomic, strong)NSString* start_Hour;//        开始时间    年月日 + 时分秒
@property (nonatomic, strong)NSString* end_Hour;//          结束时间    年月日 + 时分秒
@property (nonatomic, assign)NSInteger dateStar;

@property (nonatomic, strong)NSString* MoneyOffid;//满减活动id  修改满减时传

@property (nonatomic, strong)NSDate *sTime;
@property (nonatomic, strong)NSDate *eTime;
@property (nonatomic, strong)NSString* distanceCount;//距离天数
@property (nonatomic, strong)NSString* validity;//有效期

@property (nonatomic, strong)FNmoneyOffFullMinusModel* minuteModel;//修改信息model
@end

@implementation FNmerMoneyOffController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
#pragma mark - set up views
- (void)jm_setupViews{
    self.on_line=@"0";
    self.on_shop=@"0";
    self.distanceCount=@"0天";
    self.validity=@"0天";
    self.with_red_packet=@"0";//是否可与红包叠加
    self.with_yhq=@"0";//是否可以与优惠券叠加
    self.allow_cates=@"";
    self.allow_goods=@"";
    [self addTopOneModel];
    [self addTopTwoModel];
    [self addDataArrMsg];
    
    CGFloat baseGap=SafeAreaTopHeight+15;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, baseGap, FNDeviceWidth, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    self.jm_collectionview.backgroundColor=RGB(246, 245, 245);
    [self.view addSubview:self.jm_collectionview];
    
    [self.jm_collectionview registerClass:[FNmerIssueEditOCell class] forCellWithReuseIdentifier:@"FNmerIssueEditOCellID"];
    
    [self.jm_collectionview registerClass:[FNmerIssueDateSCell class] forCellWithReuseIdentifier:@"FNmerIssueDateSCellID"];
    
    [self.jm_collectionview registerClass:[FNmoneyOffItemCell class] forCellWithReuseIdentifier:@"FNmoneyOffItemCellID"];
    
    [self.jm_collectionview registerClass:[FNmoneyOffItemCell class] forCellWithReuseIdentifier:@"FNmoneyOffItemCell2ID"];
    
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 10).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    
    self.view.backgroundColor=RGB(246, 245, 245);
   
    self.navigationView.titleLabel.text=@"创建满减";
    
    
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
        return self.topOneArr.count;
    }
    else if(section==1){
        return self.topTwoArr.count;
    }
//    else if(section==2){
//        //不使用
//        return self.extraArr.count;
//    }
    else if(section==2){
        return self.dataArr.count;
    }
    else{
        return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNmerIssueocModel *itemModel=self.topOneArr[indexPath.row];
        FNmerIssueEditOCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerIssueEditOCellID" forIndexPath:indexPath];
        //FNmerIssueEditOCell *cell = [FNmerIssueEditOCell cellWithCollectionView:collectionView atIndexPath:indexPath withStyle:itemModel.isStyle];
        cell.model=itemModel;
        cell.delegate=self;
        cell.index=indexPath;
        return cell;
    }
    else if(indexPath.section==1){
        FNmoneyOffItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmoneyOffItemCellID" forIndexPath:indexPath];
        cell.model=self.topTwoArr[indexPath.row];
        cell.delegate=self;
        cell.index=indexPath;
        return cell;
    }
//    else if(indexPath.section==2){
//        //不使用
//        FNmoneyOffItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmoneyOffItemCell2ID" forIndexPath:indexPath];
//        //cell.model=self.extraArr[indexPath.row];
//        //cell.delegate=self;
//        //cell.index=indexPath;
//        return cell;
//    }
    else if(indexPath.section==2){
        //FNmerIssueocModel *itemModel=self.dataArr[indexPath.row];
        FNmerIssueEditOCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerIssueEditOCellID" forIndexPath:indexPath];
        //FNmerIssueEditOCell *cell = [FNmerIssueEditOCell cellWithCollectionView:collectionView atIndexPath:indexPath withStyle:itemModel.isStyle];
        cell.model=self.dataArr[indexPath.row];
        cell.delegate=self;
        cell.index=indexPath;
        //cell.compileField.tag=indexPath.row;
        return cell;
    }
    else{
        FNmerIssueDateSCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerIssueDateSCellID" forIndexPath:indexPath];
      
        
        if(![self.activityID kr_isNotEmpty]){
            [cell.issueBtn setTitle:@"创建满减" forState:UIControlStateNormal]; 
        }else{
            [cell.issueBtn setTitle:@"确认修改" forState:UIControlStateNormal];
        }
        [cell.issueBtn setBackgroundImage:IMAGE(@"FN_cxNorGreenbgimg") forState:UIControlStateNormal];
        
        [cell.startBtn addTarget:self action:@selector(startBtnClick)];
        [cell.endBtn addTarget:self action:@selector(endBtnClick)];
        [cell.issueBtn addTarget:self action:@selector(issueBtnClick)];
        if([self.start_Hour kr_isNotEmpty]){
            [cell.startBtn setTitle:self.start_Hour forState:UIControlStateNormal];
        }
        if([self.end_Hour kr_isNotEmpty]){
            [cell.endBtn setTitle:self.end_Hour forState:UIControlStateNormal];;
        }
        cell.hintLB.text=[NSString stringWithFormat:@"满减活动将于 %@ 后开始，有效期  %@",self.distanceCount,self.validity];
        [cell.hintLB fn_changeColorWithTextColor:RGB(255, 102, 0) changeTexts:@[self.distanceCount,self.validity]];
        
        cell.typeStr=self.typeStyle;
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=0;
    CGFloat itemWith=FNDeviceWidth;
    if(indexPath.section==0){
        itemHeight=53;
    }
    else if(indexPath.section==1){
        FNmoneyOffOItemModel *itemModel=self.topTwoArr[indexPath.row];
        itemHeight=itemModel.rowheight;
    }
//    else if(indexPath.section==2){
//        FNmoneyOffOItemModel *itemModel=self.extraArr[indexPath.row];
//        itemHeight=itemModel.rowheight;
//    }
    else if(indexPath.section==2){
        itemHeight=53;
    }
    else{
        itemHeight=190;
    }
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
    return 0;
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=0;
    CGFloat bottomGap=0;
    CGFloat rightGap=0;
    if(section==3){
       bottomGap=40;
    }
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - //FNmerIssueEditOCellDelegate 编辑
// 编辑
- (void)didMerIssueEditOC:(NSIndexPath*)index withContent:(NSString*)content{

}
// 修改 红包 状态
- (void)didMerIssueLuckIndex:(NSIndexPath*)index withLuck:(NSString*)luck{
//        @weakify(self);
//        [UIView performWithoutAnimation:^{
//                @strongify(self);
//                [self.jm_collectionview reloadItemsAtIndexPaths:@[index]];
//        }];
    
}
// 点击右边按钮
- (void)didMerIssueCouponUseIndex:(NSIndexPath*)index withView:(UICollectionViewCell*)cell{
    
    [self upCellBtnBGimg];
    
    if (index.section == 2 && index.row == 0) {
        FNStoreGoodsSelectManagerController *vc = [[FNStoreGoodsSelectManagerController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

// 开关
- (void)didMerIssueEditSwitch:(NSIndexPath*)index withView:(UICollectionViewCell*)cell{
   
    //[self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:0]];
    
}

//开始时间  日历
-(void)startBtnClick{
    self.dateStar=1;
    NSDate *today = [NSDate dateWithTimeIntervalSinceNow: 0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dayTo=[formatter stringFromDate:today];
    FNcalendarPopDeView *calendarView = [[FNcalendarPopDeView alloc]initWithFrame:self.view.frame withMinimumDate:dayTo];
    calendarView.delegate=self;
    [[UIApplication sharedApplication].delegate.window addSubview:calendarView];
}
//结束时间  日历
-(void)endBtnClick{
    self.dateStar=2;
    NSDate *today = [NSDate dateWithTimeIntervalSinceNow: 0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dayTo=[formatter stringFromDate:today];
    FNcalendarPopDeView *calendarView = [[FNcalendarPopDeView alloc]initWithFrame:self.view.frame withMinimumDate:dayTo];
    calendarView.delegate=self;
    [[UIApplication sharedApplication].delegate.window addSubview:calendarView];
}

//发布
-(void)issueBtnClick{
    
//    self.condition1;//满减条件
//    self.price1;//满减金额
//    self.condition2;//满减条件
//    self.price2;//满减金额    例：满20减5的
//    self.condition3;//满减条件
//   self.price3;//满减金额
//    self.allow_cates;//参加满减的商品分类
//    self.allow_goods;//参加满减的具体商品    1,2
//    self.on_line;//买单方式->线上
//    self.on_shop;//买单方式->门店
//    self.with_red_packet;//是否可与红包叠加
//    self.with_yhq;//是否可以与优惠券叠加
//    self.start_time;//        开始时间    年月日
//    self.end_time;//          结束时间    年月日
//    self.start_Hour;//        开始时间    年月日 + 时分秒
//    self.end_Hour;//          结束时间    年月日 + 时分秒
//    self.MoneyOffid;//满减活动id  修改满减时传
    
    if(![self.condition1 kr_isNotEmpty]){
        [FNTipsView showTips:@"请编辑满减条件"];
        return;
    }
    if(![self.price1 kr_isNotEmpty]){
        [FNTipsView showTips:@"请编辑满减金额"];
        return;
    }
    if(![self.start_Hour kr_isNotEmpty]){
        [FNTipsView showTips:@"请选择开始时间"];
        return;
    }
    else if(![self.end_Hour kr_isNotEmpty]){
        [FNTipsView showTips:@"请选择结束时间"];
        return;
    }
    [self requestAdd_red_packet];
}
#pragma mark - FNcalendarPopDeViewDegate // 选择日期(yyyy-MM-dd) 关闭日历后 打开 选择时间时分
- (void)popSeletedDateClick:(NSString *)date{
    XYLog(@"选择日期=:%@",date);
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    PGDatePicker *datePicker = datePickManager.datePicker;
    //    datePicker.isOnlyHourFlag = YES;
    datePicker.delegate = self;
    datePicker.datePickerMode = PGDatePickerModeTimeAndSecond;
    [self presentViewController:datePickManager animated:YES completion:nil];
}
- (void)popSeletedDateStyleClick:(NSDate *)date{
    if(self.dateStar==1){
        self.start_time=[date dateStringWithFormat:@"yyyy-MM-dd"];
        self.sTime=date;
        //NSDate *today = [NSDate dateWithTimeIntervalSinceNow: 0];
        //NSInteger count=[self numberOfDaysWithFromDate:today toDate:date];
        //XYLog(@"距离Count:%ld",(long)count);
    }
    if(self.dateStar==2){
        self.end_time=[date dateStringWithFormat:@"yyyy-MM-dd"];
        self.eTime=date;
        //NSInteger count=[self numberOfDaysWithFromDate:self.sTime toDate:self.eTime];
        //XYLog(@"dayCount:%ld",(long)count);
    }
//    @weakify(self);
//    [UIView performWithoutAnimation:^{
//        @strongify(self);
//        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:3]];
//    }];
}
//计算时间
//-(NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    
//    NSDateComponents  * comp = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:NSCalendarWrapComponents];
//    XYLog(@" -- >>  comp : %@  << --",comp);
//    return comp.day;
//}
#pragma mark - PGDatePickerDelegate  选择时间  (时分HH:mm:ss)
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    XYLog(@"dateComponents = %@", dateComponents);
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * date = [calendar dateFromComponents:dateComponents];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"hh:mm:ss";
    NSString * str = [formatter stringFromDate:date];
    //NSString *joint=[NSString stringWithFormat:@"%@ %@",self.start_time,str];
    //NSDate*dateJoint=[self StringToDate:joint inPattern:@"yyyy-MM-dd HH:mm:ss"];
    //[self stringDateWithString:joint pattern:@"yyyy-mm-dd hh:mm:ss"];
    //NSLog(@"时间=%@",str);
    if(self.dateStar==1){
        self.start_Hour=[NSString stringWithFormat:@"%@ %@",self.start_time,str];
        NSString *joint=[NSString stringWithFormat:@"%@ %@",self.start_time,str];
        self.sTime=[self StringToDate:joint inPattern:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *today = [self inGainCurrentTimeAddTimeZone];
        CGFloat timeCha=[self inGainTimeDifferenceWithAtPresent:today toSeleted:self.sTime];
        if(timeCha/24<1){
            self.distanceCount=[NSString stringWithFormat:@"%.0f 小时",timeCha];
        }else{
            self.distanceCount=[NSString stringWithFormat:@"%.1f 天",timeCha/24];
        }
    }
    if(self.dateStar==2){
        self.end_Hour=[NSString stringWithFormat:@"%@ %@",self.end_time,str];
        NSString *joint=[NSString stringWithFormat:@"%@ %@",self.end_time,str];
        self.eTime=[self StringToDate:joint inPattern:@"yyyy-MM-dd HH:mm:ss"];
        CGFloat timeYouX=[self inGainTimeDifferenceWithAtPresent:self.sTime toSeleted:self.eTime];
        if(timeYouX/24<1){
            self.validity=[NSString stringWithFormat:@"%.0f 小时",timeYouX];
        }else{
            self.validity=[NSString stringWithFormat:@"%.1f 天",timeYouX/24];
        }
    }
    @weakify(self);
    [UIView performWithoutAnimation:^{
        @strongify(self);
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:3]];
    }];
    [self upCellBtnBGimg];
}
-(NSDate *)stringDateWithString:(NSString *)strDate pattern:(NSString *)pattern{
    NSDateFormatter *poformatter = [[NSDateFormatter alloc]init];
    //formatter.dateFormat = pattern;
    [poformatter setDateFormat:pattern];
    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    return  [poformatter dateFromString:strDate];
}
-(NSDate*)StringToDate:(NSString*)curdate inPattern:(NSString*)pattern{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    
    NSString *inputDate = curdate;//[NSString stringWithFormat:@"%@ %@",curdate,curtime];
    
    [inputFormatter setDateFormat:pattern];  //@"yyyy-MM-dd HH:mm:ss"   //注意格式符的大小写。HH为24小时的小时数据格式
    
    NSDate *date = [inputFormatter dateFromString:inputDate];
    
    //  默认的 NSDate Date的显示的是格林威治标准时间GMT，在中国存在时差，所以要转换为中国时区+8。
    
    NSTimeInterval timeZoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMT];
    
    date = [date dateByAddingTimeInterval: timeZoneOffset];
    
    return date;
    
}
//刷新保存背景图片状态
-(void)upCellBtnBGimg{
    //    self.condition1;//满减条件
    //    self.price1;//满减金额
    //    self.condition2;//满减条件
    //    self.price2;//满减金额    例：满20减5的
    //    self.condition3;//满减条件
    //   self.price3;//满减金额
    //    self.allow_cates;//参加满减的商品分类
    //    self.allow_goods;//参加满减的具体商品    1,2
    //    self.on_line;//买单方式->线上
    //    self.on_shop;//买单方式->门店
    //    self.with_red_packet;//是否可与红包叠加
    //    self.with_yhq;//是否可以与优惠券叠加
    //    self.start_time;//        开始时间    年月日
    //    self.end_time;//          结束时间    年月日
    //    self.start_Hour;//        开始时间    年月日 + 时分秒
    //    self.end_Hour;//          结束时间    年月日 + 时分秒
    //    self.MoneyOffid;//满减活动id  修改满减时传
    NSIndexPath *indexReload = [NSIndexPath indexPathForRow:0 inSection:3];
    FNmerIssueDateSCell *itemCell=(FNmerIssueDateSCell *)[self.jm_collectionview cellForItemAtIndexPath:indexReload];
    
    if([self.end_Hour kr_isNotEmpty]&&[self.start_Hour kr_isNotEmpty]){
       
        [itemCell.issueBtn setBackgroundImage:IMAGE(@"FN_cxYGreenbgimg") forState:UIControlStateNormal];
        
    }else{
       
        [itemCell.issueBtn setBackgroundImage:IMAGE(@"FN_cxNorGreenbgimg") forState:UIControlStateNormal];
       
    }
}
#pragma mark - FNmoneyOffItemCellDelegate //满减编辑
// 编辑
- (void)didMerMoneyOffEditOneView:(NSIndexPath*)index withContent:(NSString*)content{
    if (index.section==1) {
        FNmoneyOffOItemModel *itemModel=self.topTwoArr[index.row];
        itemModel.condition=content;
        if(index.row==0){
          self.condition1=content;
        }
        if(index.row==1){
            self.condition2=content;
        }
        if(index.row==2){
            self.condition3=content;
        }
        [self reloadModelHintWith:index];
    }
//    if (index.section==2) {
//        FNmoneyOffOItemModel *itemModel=self.extraArr[index.row];
//        itemModel.condition=content;
//        if(index.row==0){
//           self.condition2=content;
//        }
//        if(index.row==1){
//            self.condition3=content;
//        }
//
//    }
    
}
- (void)didMerMoneyOffEditTwoView:(NSIndexPath*)index withContent:(NSString*)content{
    if (index.section==1) {
        FNmoneyOffOItemModel *itemModel=self.topTwoArr[index.row];
        itemModel.price=content;
        if(index.row==0){
            self.price1=content;
        }
        if(index.row==1){
            self.price2=content;
        }
        if(index.row==2){
            self.price3=content;
        }
        [self reloadModelHintWith:index];
    }
//    if (index.section==2) {
//        FNmoneyOffOItemModel *itemModel=self.extraArr[index.row];
//        itemModel.price=content;
//        if(index.row==0){
//            self.price2=content;
//        }
//        if(index.row==1){
//            self.price3=content;
//        }
//    }
    
}
#pragma mark - 添加数据
// LeftBtnClick
- (void)didMerMoneyOffLeftIndex:(NSIndexPath*)index{
    if (index.section==1) {
        FNmoneyOffOItemModel *itemModel=self.topTwoArr[index.row];
        if (itemModel.leftBtnState==1) {
            //加
            [self addThreeModel];
        }else{
            //减
            [self disDeletedModelWithIndex:index.row];
        }
   
        
    }
//    if (index.section==2) {
//        FNmoneyOffOItemModel *itemModel=self.extraArr[index.row];
//        if (itemModel.leftBtnState==1) {
//            [self addThreeModel];
//        }else{
//            [self disDeletedModelWithIndex:index.row];
//        }
//    }
}
// RightBtnClick
- (void)didMerMoneyOffRightIndex:(NSIndexPath*)index{
    if (index.section==1) {
        FNmoneyOffOItemModel *itemModel=self.topTwoArr[index.row];
        if (itemModel.rightBtnState==1) {
            [self addThreeModel];
        }else{
            [self disDeletedModelWithIndex:index.row];
        }
    }
//    if (index.section==2) {
//        FNmoneyOffOItemModel *itemModel=self.extraArr[index.row];
//        if (itemModel.rightBtnState==1) {
//            [self addThreeModel];
//        }else{
//            [self disDeletedModelWithIndex:index.row];
//        }
//    }
}
#pragma mark - 创建限时折扣使用 选择买单方式 线上 线下
// 线上
- (void)didMerIssueEditPaymentMethod:(NSIndexPath*)index withOnLine:(NSString*)onLineStyle{
    if(index.section==0){
        self.on_line=onLineStyle;
    }
    if(index.section==2){
        self.with_yhq=onLineStyle;
    }
}
// 线下
- (void)didMerIssueEditPaymentMethod:(NSIndexPath*)index withOnShop:(NSString*)onShopStyle{
    if(index.section==2){
        self.on_shop=onShopStyle;
    }
    if(index.section==3){
        self.with_red_packet=onShopStyle;
    }
}
#pragma mark - 页面数据
// 2:section数据
-(void)addDataArrMsg{
    //      title;左边标题
    //      value;值
    //      valueHint;右边提示
    //      unit;单位
    //      bottomHint;底部提示
    //      startDate;开始时间
    //      endDate;结束时间
    //      value1Orange;
    //      value2Orange;
    //      rowheight;高度
    //      isCompile;//是否可以编辑 YES不可以编辑
    //      editType;//编辑键盘类型
    //      isStyle;右边样式 1:只编辑 2:只显示文字 3:编辑+单位  4:不能编辑显示选择文字 5:不能编辑 只选择开关 6:线上线下按钮
    //isBoth ;//1:修改单个颜色  2:修改两个颜色;
    //self.typeStyle
    
    FNmerIssueocModel *item1Model=[[FNmerIssueocModel alloc]init];
    item1Model.title=@"*适用范围";
    item1Model.bottomHint=@"";
    item1Model.valueHint=@"请选择适用商品";
    item1Model.type=self.typeStyle;
    item1Model.rowheight=57;
    item1Model.isStyle=4;
    
    FNmerIssueocModel *item2Model=[[FNmerIssueocModel alloc]init];
    item2Model.title=@"*可与其叠加使用";
    item2Model.type=self.typeStyle;
    item2Model.rowheight=57;
    item2Model.editType=@"defu";
    item2Model.isStyle=6;
    item2Model.online=@"优惠券";
    item2Model.offline=@"红包";
    
    
    
    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
    [arrM addObject:item1Model];
    [arrM addObject:item2Model];
    self.dataArr=arrM;
    
    
}
//第一区条数据
-(void)addTopOneModel{
    FNmerIssueocModel *item1Model=[[FNmerIssueocModel alloc]init];
    item1Model.title=@"*支持买单方式";
    item1Model.type=self.typeStyle;
    item1Model.rowheight=57;
    item1Model.editType=@"defu";
    item1Model.isStyle=6;
    item1Model.online=@"线上";
    item1Model.offline=@"线下";
    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
    [arrM addObject:item1Model];
    self.topOneArr=arrM;
}
//第二区条数据
-(void)addTopTwoModel{
    FNmoneyOffOItemModel *item1Model=[[FNmoneyOffOItemModel alloc]init];
    item1Model.title1Str=@"*单次消费满";
    item1Model.title2Str=@"*立减";
    item1Model.unit1Str=@"元";
    item1Model.unit2Str=@"元";
    item1Model.valueHint1Str=@"0";
    item1Model.valueHint2Str=@"0";
    item1Model.leftBtnStr=@"添加满减条件";
    item1Model.leftBtnimg=@"FN_cxMJAddGImg";//FN_cxMJMinusGImg
    item1Model.leftBtnState=1;//1添加  2删除
    item1Model.hintStr=@"";
    item1Model.rowheight=145;
    item1Model.isHint=YES;
    item1Model.isThree=NO;
    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
    [arrM addObject:item1Model];
    self.topTwoArr=arrM;
    if([self.activityID kr_isNotEmpty]){
       [self requestactivityMinuteMsg];
    }
}
//第三区条数据  添加数据
-(void)addThreeModel{
    
    FNmoneyOffOItemModel *itemSectionOneModel=self.topTwoArr[0];
    itemSectionOneModel.rowheight=97;
    itemSectionOneModel.isHint=YES;
    itemSectionOneModel.isThree=YES;
    
    FNmoneyOffOItemModel *itemModel=[[FNmoneyOffOItemModel alloc]init];
    itemModel.title1Str=@"*单次消费满";
    itemModel.title2Str=@"*立减";
    itemModel.unit1Str=@"元";
    itemModel.unit2Str=@"元";
    itemModel.valueHint1Str=@"0";
    itemModel.valueHint2Str=@"0";
    itemModel.leftBtnStr=@"删除满减条件";
    itemModel.leftBtnimg=@"FN_cxMJMinusGImg";//FN_cxMJMinusGImg//FN_cxMJAddGImg
    itemModel.leftBtnState=2;//1添加  2删除
    itemModel.rightBtnStr=@"添加满减条件";
    itemModel.rightBtnimg=@"FN_cxMJAddGImg";
    itemModel.rightBtnState=1;//1添加  2删除
    itemModel.hintStr=@"";
    itemModel.rowheight=145;
    itemModel.isThree=NO;
    itemModel.isHint=YES;
    itemModel.price=@"";
    itemModel.condition=@"";
    NSMutableArray *arrM=[NSMutableArray array];
    [arrM addObject:itemModel];
    
//    if(self.extraArr.count==0){
//       self.extraArr=arrM;
//    }else{
        [self.topTwoArr addObjectsFromArray:arrM];
        if(self.topTwoArr.count==3){
            [self.topTwoArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if(idx>0){
                    FNmoneyOffOItemModel *itemEnModel=obj;
                    itemEnModel.leftBtnStr=@"删除满减条件";
                    itemEnModel.leftBtnimg=@"FN_cxMJMinusGImg";
                    itemEnModel.leftBtnState=2;
                    itemEnModel.rightBtnStr=@"";
                    itemEnModel.rightBtnimg=@"";
                    itemEnModel.rightBtnState=0;
                }
            }];
        }
   // }
    //NSIndexPath *indexReload = [NSIndexPath indexPathForRow:1 inSection:0];
    @weakify(self);
    [UIView performWithoutAnimation:^{
        @strongify(self);
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
        //[self.jm_collectionview reloadItemsAtIndexPaths:@[indexReload]];
    }];
    //[self performSelector:@selector(delayMethodReload) withObject:nil afterDelay:0.1];
}
//减model
-(void)disDeletedModelWithIndex:(NSInteger)index{
    if(self.topTwoArr.count>0){
        [self.topTwoArr removeObjectAtIndex:index];
        if(self.topTwoArr.count==1){
                FNmoneyOffOItemModel *itemModel=self.topTwoArr[0];
                itemModel.leftBtnStr=@"添加满减条件";
                itemModel.leftBtnimg=@"FN_cxMJAddGImg";//FN_cxMJMinusGImg
                itemModel.leftBtnState=1; //1添加  2删除
                //itemModel.rightBtnStr=@"添加满减条件";
                //itemModel.rightBtnimg=@"FN_cxMJAddGImg";
                //itemModel.rightBtnState=1;
                itemModel.rowheight=145;
                itemModel.isHint=YES;
                itemModel.isThree=NO;
        }
        if(self.topTwoArr.count==2){
               FNmoneyOffOItemModel *itemModel=self.topTwoArr[1];
            itemModel.leftBtnStr=@"删除满减条件";
            itemModel.leftBtnimg=@"FN_cxMJMinusGImg";
            itemModel.leftBtnState=2; //1添加  2删除
            itemModel.rightBtnStr=@"添加满减条件";
            itemModel.rightBtnimg=@"FN_cxMJAddGImg";
            itemModel.rightBtnState=1;
            itemModel.rowheight=145;
            itemModel.isHint=YES;
            itemModel.isThree=NO;
        }
        @weakify(self);
        [UIView performWithoutAnimation:^{
            @strongify(self);
            [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
        }];
        
       
    }
    
}
-(void)reloadModelHintWith:(NSIndexPath*)index{
//    if(self.extraArr.count>0){
//        FNmoneyOffOItemModel *itemModel=self.extraArr[self.extraArr.count-1];
//        if([itemModel.condition kr_isNotEmpty] &&[itemModel.price kr_isNotEmpty]){
//            itemModel.rowheight=168;
//            itemModel.isHint=NO;
//            itemModel.hintStr=@"*立减额度不得超过单次消费满额度";
//
//        }
//        if(![itemModel.condition kr_isNotEmpty] && ![itemModel.price kr_isNotEmpty]){
//            itemModel.rowheight=145;
//            itemModel.isHint=YES;
//            itemModel.hintStr=@"";
//
//        }
////        @weakify(self);
////        [UIView performWithoutAnimation:^{
////            @strongify(self);
////            [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:2]];
////        }];
//    }else{
            FNmoneyOffOItemModel *itemModel=self.topTwoArr[index.row];
    if(self.topTwoArr.count>1){
        if([itemModel.condition kr_isNotEmpty]&&[itemModel.price kr_isNotEmpty]){
            itemModel.rowheight=168;
            itemModel.isHint=NO;
            itemModel.hintStr=@"*立减额度不得超过单次消费满额度";
            //[self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
        }
        if(![itemModel.condition kr_isNotEmpty] && ![itemModel.price kr_isNotEmpty]){
            itemModel.rowheight=145;
            itemModel.isHint=YES;
            itemModel.hintStr=@"";
            //[self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
        }
        FNmoneyOffOItemModel *itemOneModel=self.topTwoArr[0];
        itemOneModel.rowheight=97;
        itemOneModel.isHint=YES;
        itemOneModel.hintStr=@"";
        if(index.row>0){
            @weakify(self);
            [UIView performWithoutAnimation:^{
                @strongify(self);
                //[self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
                [self.jm_collectionview reloadItemsAtIndexPaths:@[index]];
            }];
        }
        
    }
    
    
        
//    }
}
#pragma mark - request
//商家中心-发布满减
-(void)requestAdd_red_packet{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    //    self.condition1;//满减条件
    //    self.price1;//满减金额
    //    self.condition2;//满减条件
    //    self.price2;//满减金额    例：满20减5的
    //    self.condition3;//满减条件
    //    self.price3;//满减金额
    //    self.allow_cates;//参加满减的商品分类
    //    self.allow_goods;//参加满减的具体商品    1,2
    //    self.on_line;//买单方式->线上
    //    self.on_shop;//买单方式->门店
    //    self.with_red_packet;//是否可与红包叠加
    //    self.with_yhq;//是否可以与优惠券叠加
    //    self.start_time;//        开始时间    年月日
    //    self.end_time;//          结束时间    年月日
    //    self.start_Hour;//        开始时间    年月日 + 时分秒
    //    self.end_Hour;//          结束时间    年月日 + 时分秒
    //    self.MoneyOffid;//满减活动id  修改满减时传
    
    if([self.condition1 kr_isNotEmpty]){
       params[@"condition1"]=self.condition1;
    }
    if([self.price1 kr_isNotEmpty]){
        params[@"price1"]=self.price1;
        if([self.price1 floatValue]>[self.condition1 floatValue]){
            [FNTipsView showTips:@"立减金额不能超过单次消费消费满额度"];
            return;
        }
    }
    if([self.condition2 kr_isNotEmpty]){
        params[@"condition2"]=self.condition2;
    }
    if([self.price2 kr_isNotEmpty]){
        params[@"price2"]=self.price2;
        if([self.price2 floatValue]>[self.condition2 floatValue]){
            [FNTipsView showTips:@"立减金额不能超过单次消费消费满额度"];
            return;
        }
    }
    if([self.condition3 kr_isNotEmpty]){
        params[@"condition3"]=self.condition3;
    }
    if([self.price3 kr_isNotEmpty]){
        params[@"price3"]=self.price3;
        if([self.price3 floatValue]>[self.condition3 floatValue]){
            [FNTipsView showTips:@"立减金额不能超过单次消费消费满额度"];
            return;
        }
    }
    params[@"allow_cates"]=self.allow_cates;
    params[@"allow_goods"]=self.allow_goods;
    if([self.on_line kr_isNotEmpty]){
        params[@"on_line"]=self.on_line;
    }
    if([self.on_shop kr_isNotEmpty]){
        params[@"on_shop"]=self.on_shop;
    }
    if([self.with_red_packet kr_isNotEmpty]){
        params[@"with_red_packet"]=self.with_red_packet;
    }
    if([self.with_yhq kr_isNotEmpty]){
        params[@"with_yhq"]=self.with_yhq;
    }
    if([self.MoneyOffid kr_isNotEmpty]){
        params[@"id"]=self.MoneyOffid;
    }
    params[@"start_time"]=self.start_Hour;
    params[@"end_time"]=self.end_Hour;
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_store_activity&ctrl=add_full_reduction" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        NSString *msgStr=respondsObject[MsgKey];
        [FNTipsView showTips:msgStr];
        if(state==1){
            if (self.inMerMoneyOffData) {
                self.inMerMoneyOffData();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}

//促销工具-满减详细
-(void)requestactivityMinuteMsg{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.activityID kr_isNotEmpty]){
        params[@"id"]=self.activityID;
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_store_activity&ctrl=reduction_detail" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary *dictry=respondsObject[DataKey];
        self.minuteModel=[FNmoneyOffFullMinusModel mj_objectWithKeyValues:dictry];
        self.start_Hour=self.minuteModel.start_time;
        self.end_Hour=self.minuteModel.end_time;
        self.on_line=self.minuteModel.on_line;
        self.on_shop=self.minuteModel.on_shop;
        self.with_red_packet=self.minuteModel.with_red_packet;//是否可与红包叠加
        self.with_yhq=self.minuteModel.with_yhq;//是否可以与优惠券叠加
        self.allow_cates=self.minuteModel.allow_cates;
        self.allow_goods=self.minuteModel.allow_goods;
            FNmerIssueocModel *item2Model=self.dataArr[1];
            item2Model.onlineState=self.minuteModel.with_yhq;
            item2Model.offlineState=self.minuteModel.with_red_packet;
       
        
            FNmerIssueocModel *item0Model=self.topOneArr[0];
            item0Model.onlineState=self.minuteModel.on_line;
            item0Model.offlineState=self.minuteModel.on_shop;
        if([self.minuteModel.start_time kr_isNotEmpty]&&[self.minuteModel.end_time kr_isNotEmpty]){
            //self.distanceCount
            NSDate *startTi=[self StringToDate:self.minuteModel.start_time inPattern:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *endTi=[self StringToDate:self.minuteModel.end_time inPattern:@"yyyy-MM-dd HH:mm:ss"];
            
            NSDate *today = [self inGainCurrentTimeAddTimeZone];
            CGFloat timeCha=[self inGainTimeDifferenceWithAtPresent:today toSeleted:startTi];
            if(timeCha/24<1){
                self.distanceCount=[NSString stringWithFormat:@"%.0f 小时",timeCha*24];
            }else{
                CGFloat downFloat=floorf(timeCha/24);
                CGFloat hourFloat=(timeCha/24-downFloat)*24;
                self.distanceCount=[NSString stringWithFormat:@"%.0f 天",timeCha/24];
                if(hourFloat>0){
                    self.distanceCount=[NSString stringWithFormat:@"%.0f 天 %.0f 小时",downFloat,hourFloat];
                }
            }
            if(timeCha/24<0){
                self.distanceCount=@"0天";
            }
            CGFloat timeYouX=[self inGainTimeDifferenceWithAtPresent:startTi toSeleted:endTi];
            if(timeYouX/24<1){
                self.validity=[NSString stringWithFormat:@"%.0f 小时",timeYouX*24];
            }else{
                CGFloat downFloat=floorf(timeYouX/24);
                CGFloat hourFloat=(timeYouX/24-downFloat)*24;
                self.validity=[NSString stringWithFormat:@"%.0f 天",timeYouX/24];
                if(hourFloat>0){
                   self.validity=[NSString stringWithFormat:@"%.0f 天 %.0f 小时",downFloat,hourFloat];
                }
            }
        }
        
        NSArray *listArr=self.minuteModel.condition_data;
        if(listArr.count==1){
            FNmoneyOffFullMinusItemModel *msgModel=[FNmoneyOffFullMinusItemModel mj_objectWithKeyValues:listArr[0]];
            FNmoneyOffOItemModel *itemModel=self.topTwoArr[0];
            itemModel.price=msgModel.price;
            itemModel.condition=msgModel.condition;
        }
        if(listArr.count>1){
            NSMutableArray *arrM=[NSMutableArray array];
            [listArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNmoneyOffFullMinusItemModel *msgModel=[FNmoneyOffFullMinusItemModel mj_objectWithKeyValues:obj];
                FNmoneyOffOItemModel *itemModel=[[FNmoneyOffOItemModel alloc]init];
                itemModel.title1Str=@"*单次消费满";
                itemModel.title2Str=@"*立减";
                itemModel.unit1Str=@"元";
                itemModel.unit2Str=@"元";
                itemModel.valueHint1Str=@"0";
                itemModel.valueHint2Str=@"0";
                itemModel.leftBtnStr=@"删除满减条件";
                itemModel.leftBtnimg=@"FN_cxMJMinusGImg";//FN_cxMJMinusGImg//FN_cxMJAddGImg
                itemModel.leftBtnState=2;//1添加  2删除
                itemModel.rightBtnStr=@"添加满减条件";
                itemModel.rightBtnimg=@"FN_cxMJAddGImg";
                itemModel.rightBtnState=1;//1添加  2删除
                itemModel.hintStr=@"";
                itemModel.rowheight=145;
                itemModel.isThree=NO;
                itemModel.isHint=YES;
                itemModel.price=msgModel.price;
                itemModel.condition=msgModel.condition;
                if(idx==0){
                    itemModel.rowheight=97;
                    itemModel.isHint=YES;
                    itemModel.isThree=YES;
                    itemModel.title1Str=@"*单次消费满";
                    itemModel.title2Str=@"*立减";
                    itemModel.unit1Str=@"元";
                    itemModel.unit2Str=@"元";
                    itemModel.valueHint1Str=@"0";
                    itemModel.valueHint2Str=@"0";
                    itemModel.leftBtnStr=@"添加满减条件";
                    itemModel.leftBtnimg=@"FN_cxMJAddGImg";//FN_cxMJMinusGImg
                    itemModel.leftBtnState=1;//1添加  2删除
                    itemModel.hintStr=@"";
                    itemModel.rowheight=145;
                    itemModel.isHint=YES;
                    itemModel.isThree=NO;
                }
                [arrM addObject:itemModel];
            }];
            self.topTwoArr=arrM;
            if(self.topTwoArr.count==3){
                [self.topTwoArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if(idx>0){
                        FNmoneyOffOItemModel *itemEnModel=obj;
                        itemEnModel.leftBtnStr=@"删除满减条件";
                        itemEnModel.leftBtnimg=@"FN_cxMJMinusGImg";
                        itemEnModel.leftBtnState=2;
                        itemEnModel.rightBtnStr=@"";
                        itemEnModel.rightBtnimg=@"";
                        itemEnModel.rightBtnState=0;
                    }
                }];
            }
        }
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadData];
        }];
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
//不使用
- (NSMutableArray *)extraArr{
    if (!_extraArr) {
        _extraArr = [NSMutableArray array];
    }
    return _extraArr;
}
- (NSMutableArray *)topOneArr{
    if (!_topOneArr) {
        _topOneArr = [NSMutableArray array];
    }
    return _topOneArr;
}
- (NSMutableArray *)topTwoArr{
    if (!_topTwoArr) {
        _topTwoArr = [NSMutableArray array];
    }
    return _topTwoArr;
}

//获取本时区时间
-(NSDate *)inGainCurrentTimeAddTimeZone{
    NSDate *nowDate = [NSDate date];
    // 设置系统时区为本地时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 计算本地时区与 GMT 时区的时间差
    NSInteger interval = [zone secondsFromGMT];
    // 在 GMT 时间基础上追加时间差值，得到本地时间
    nowDate = [nowDate dateByAddingTimeInterval:interval];
    NSLog(@"现在时间: nowDate=%@",nowDate);
    return nowDate;
    //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSString *nowDateString = [dateFormatter stringFromDate:nowDate];
}
//计算时间差2 时间一  时间二
-(CGFloat)inGainTimeDifferenceWithAtPresent:(NSDate *)presentDate toSeleted:(NSDate*)seletedDate{
    NSTimeInterval timeInterval = [seletedDate timeIntervalSinceDate:presentDate];
    CGFloat badFloat=timeInterval/3600.00;
    return badFloat;
}

#pragma mark - FNStoreGoodsSelectManagerControllerDelegate


/**
 适用范围选择回调
 
 @param vc 当前viewcontroller
 @param cates 商品列表
 @param isAll 是否全场通用
 */
- (void)goodsSelectController: (FNStoreGoodsSelectManagerController*)vc cates: (NSArray<FNStoreManagerCateModel*> *)cates isAll: (BOOL)isAll {
    NSLog (@"count: %ld   isAll: %d", cates.count, isAll);
    
    NSMutableString *cateString = [[NSMutableString alloc] init];
    NSMutableString *goodsString = [[NSMutableString alloc] init];
    if (cates.count == 0) {
        _allow_cates = @"";
        _allow_goods = @"";
    } else {
        BOOL isFirst = YES;
        BOOL isFirstCate = YES;
        for (FNStoreManagerCateModel *cate in cates) {
            if (isFirstCate)
                [cateString appendString:cate.id];
            else
                [cateString appendString:[NSString stringWithFormat:@",%@", cate.id]];
            isFirstCate = NO;
            for (FNStoreManagerGoodsModel *goods in cate.goods) {
                if (isFirst)
                    [goodsString appendString:goods.id];
                else
                    [goodsString appendString:[NSString stringWithFormat:@",%@", goods.id]];
                isFirst = NO;
            }
        }
        
        _allow_cates = cateString;
        _allow_goods = goodsString;
        
        NSLog (@"_allow_cates %@", cateString);
        NSLog (@"_allow_cates %@", goodsString);
        NSString *goodsState=@"";
        if(isAll){
            goodsState=@"全场通用";
        }else{
            goodsState=@"仅限指定商品使用";
        }
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:2];
        FNmerIssueEditOCell *itemCell=(FNmerIssueEditOCell *)[self.jm_collectionview cellForItemAtIndexPath:index];
        [itemCell.rightBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [itemCell.rightBtn setTitle:goodsState forState:UIControlStateNormal];
    }
}

@end
