//
//  FNAlterIssueItemContr.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/14.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNAlterIssueItemContr.h"
#import "FNCustomeNavigationBar.h"
#import "FNmerIssueEditOCell.h"
#import "FNmerIssueDateSCell.h"
#import "FNmerIssueocModel.h"
#import "FNcalendarPopDeView.h"
#import "NSDate+HXExtension.h"
#import "PGDatePickManager.h"
@interface FNAlterIssueItemContr ()
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNmerIssueEditOCellDelegate,UITextFieldDelegate,FNcalendarPopDeViewDegate,PGDatePickerDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSString* now_price;//      剩余金额
@property (nonatomic, strong)NSString* now_counts;//     now_counts
@property (nonatomic, strong)NSString* start_time;//     开始时间    年月日
@property (nonatomic, strong)NSString* end_time;//       结束时间    年月日
@property (nonatomic, strong)NSString* start_Hour;//     开始时间    年月日 + 时分秒
@property (nonatomic, strong)NSString* end_Hour;//       结束时间    年月日 + 时分秒
@property (nonatomic, assign)NSInteger dateStar;

@end

@implementation FNAlterIssueItemContr

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
    
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
    
    [self.jm_collectionview registerClass:[FNmerIssueDateSCell class] forCellWithReuseIdentifier:@"FNmerIssueDateSCellID"];
    
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
    self.navigationView.titleLabel.text=@"修改";
    [self requestPagmsg];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
        return self.dataArr.count;
    }
    else{
        return 1;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNmerIssueEditOCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerIssueEditOCellID" forIndexPath:indexPath];
        cell.model=self.dataArr[indexPath.row];
        cell.delegate=self;
        cell.index=indexPath;
        cell.compileField.tag=indexPath.row;
        cell.compileField.delegate=self;
        return cell;
    }
    else{
        FNmerIssueDateSCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerIssueDateSCellID" forIndexPath:indexPath];
        if([self.typeStyle isEqualToString:@"pub_red_packet_list"]||[self.typeStyle isEqualToString:@"red_packet"]){
            [cell.issueBtn setTitle:@"确认修改" forState:UIControlStateNormal];
            [cell.issueBtn setBackgroundImage:IMAGE(@"FN_yhqANhbNobg") forState:UIControlStateNormal];
        }else if([self.typeStyle isEqualToString:@"pub_yhq_list"]||[self.typeStyle isEqualToString:@"yhq"]){
            [cell.issueBtn setTitle:@"确认修改" forState:UIControlStateNormal];
            [cell.issueBtn setBackgroundImage:IMAGE(@"FN_yhqANhbNobg") forState:UIControlStateNormal];
        }
        [cell.startBtn addTarget:self action:@selector(startBtnClick)];
        [cell.endBtn addTarget:self action:@selector(endBtnClick)];
        [cell.issueBtn addTarget:self action:@selector(issueBtnClick)];
        if([self.start_Hour kr_isNotEmpty]){
            [cell.startBtn setTitle:self.start_Hour forState:UIControlStateNormal];
        }
        if([self.end_Hour kr_isNotEmpty]){
            [cell.endBtn setTitle:self.end_Hour forState:UIControlStateNormal];;
        }
        cell.hintLB.text=@"";
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=70;
    CGFloat itemWith=FNDeviceWidth;
    if(indexPath.section==0){
        itemHeight=75;
    }else{
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
    CGFloat topGap=10;
    CGFloat leftGap=0;
    CGFloat bottomGap=0;
    CGFloat rightGap=0;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//FNmerIssueEditOCellDelegate
// 编辑
- (void)didMerIssueEditOC:(NSIndexPath*)index withContent:(NSString*)content{
    if(index.row==0){
       self.now_price=content;
    }
    if(index.row==1){
       self.now_counts=content;
    }
}
// 修改 红包 状态  该页面未曾使用
- (void)didMerIssueLuckIndex:(NSIndexPath*)index withLuck:(NSString*)luck{
}
// 添加条件 门槛   该页面未曾使用
- (void)didMerIssueCouponUseIndex:(NSIndexPath*)index withView:(UICollectionViewCell*)cell{
    
}
//开始时间
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
//结束时间
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
    if(![self.now_price kr_isNotEmpty]){
       [FNTipsView showTips:@"请输入金额"];
       return;
    }
    else if(![self.now_counts kr_isNotEmpty]){
       [FNTipsView showTips:@"请输入个数"];
       return;
    }
    else if(![self.start_Hour kr_isNotEmpty]){
       [FNTipsView showTips:@"请选择开始时间"];
       return;
    }
    else if(![self.end_Hour kr_isNotEmpty]){
       [FNTipsView showTips:@"请选择结束时间"];
       return;
    }
    [self requestRevampPag];
}
#pragma mark - FNcalendarPopDeViewDegate // 选择日期
- (void)popSeletedDateClick:(NSString *)date{
    XYLog(@"选择日期=:%@",date);
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePicker.delegate = self;
    datePicker.datePickerMode = PGDatePickerModeTimeAndSecond;
    [self presentViewController:datePickManager animated:YES completion:nil];
}
- (void)popSeletedDateStyleClick:(NSDate *)date{
    if(self.dateStar==1){
        self.start_time=[date dateStringWithFormat:@"yyyy-MM-dd"];
    }
    if(self.dateStar==2){
        self.end_time=[date dateStringWithFormat:@"yyyy-MM-dd"];
    }
    @weakify(self);
    [UIView performWithoutAnimation:^{
        @strongify(self);
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
    }];
}
#pragma mark - PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    XYLog(@"dateComponents = %@", dateComponents);
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * date = [calendar dateFromComponents:dateComponents];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm:ss";
    NSString * str = [formatter stringFromDate:date]; 
    if(self.dateStar==1){
       self.start_Hour=[NSString stringWithFormat:@"%@ %@",self.start_time,str];
    }
    if(self.dateStar==2){
       self.end_Hour=[NSString stringWithFormat:@"%@ %@",self.end_time,str];
    }
    XYLog(@"时间=%@",str);
    @weakify(self);
    [UIView performWithoutAnimation:^{
        @strongify(self);
        [self.jm_collectionview reloadData];
    }];
}
#pragma mark - 页面数据
-(void)addDataArrMsg{
    FNmerIssueocModel *item1Model=[[FNmerIssueocModel alloc]init];
    item1Model.title=@"剩余金额";
    item1Model.valueHint=@"";
    item1Model.rightunit=NO;
    item1Model.unit=@"元";
    item1Model.rightCondition=YES;
    item1Model.bottomHint=@"剩余余额只可增加";
    item1Model.type=self.typeStyle;
    item1Model.isStyle=3;
    FNmerIssueocModel *item2Model=[[FNmerIssueocModel alloc]init];
    item2Model.title=@"剩余红包";
    item2Model.valueHint=@"";
    item2Model.unit=@"个";
    item2Model.rightunit=NO;
    item2Model.rightCondition=YES;
    item2Model.bottomHint=@"红包个数只可增加";
    item2Model.value1Orange=@"";
    item2Model.type=self.typeStyle;
    item2Model.isCommon=@"0";
    item2Model.isStyle=3;
    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
    [arrM addObject:item1Model];
    [arrM addObject:item2Model];
    self.dataArr=arrM;
}
#pragma mark - request
//商家中心-修改红包界面
-(FNRequestTool*)requestPagmsg{
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    params[@"id"]=self.pagId;
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=red_packet_detail" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dictry = respondsObject[DataKey];
        FNmerIssueocAlterModel *model=[FNmerIssueocAlterModel mj_objectWithKeyValues:dictry];
        @strongify(self);
        FNmerIssueocModel *oneModel=self.dataArr[0];
        FNmerIssueocModel *twoModel=self.dataArr[1];
        oneModel.value=model.now_price;
        twoModel.value=model.now_counts;
        self.now_price=model.now_price;
        self.now_counts=model.now_counts;
        self.start_Hour=model.start_time;
        self.end_Hour=model.end_time;
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        
    } isHideTips:NO isCache:NO];
}
//商家中心-修改红包
-(FNRequestTool*)requestRevampPag{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    params[@"id"]=self.pagId;
    params[@"now_price"]=self.now_price;
    params[@"now_counts"]=self.now_counts;
    params[@"start_time"]=self.start_Hour;
    params[@"end_time"]=self.end_Hour;
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=edit_red_packet" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        NSString *msgStr=respondsObject[MsgKey];
        [FNTipsView showTips:msgStr];
        if(state==1){
           if ([self.delegate respondsToSelector:@selector(didMerAlterIssueRevampMsg)]) {
               [self.delegate didMerAlterIssueRevampMsg];
           }
           [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSString *error) {
        
    } isHideTips:NO isCache:NO];
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField.tag==0||textField.tag==1){
        //限制只能输入数字
        BOOL isHaveDian = YES;
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian = NO;
        }
        if ([string length] > 0) {
            unichar single = [string characterAtIndex:0];//当前输入的字符
            if(textField.tag==1){
                if (single == '.') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            if ((single >= '0' && single <= '9') || single == '.') {
                //数据格式正确
                if([textField.text length] == 0){
                    if(single == '.') {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                //输入的字符是否是小数点
                if (single == '.') {
                    if(!isHaveDian) {
                        //text中还没有小数点
                        isHaveDian = YES;
                        return YES;
                    }else{
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{
                    //存在小数点
                    if (isHaveDian) {
                        //判断小数点的位数
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 2) {
                            return YES;
                        }else{
                            return NO;
                        }
                    }else{
                        return YES;
                    }
                }
            }else{
                //输入的数据格式不正确
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;
        }
    } 
    return YES;
}

@end
