//
//  FNmarketBillListController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmarketBillListController.h"
#import "FNCustomeNavigationBar.h"
#import "JXCategoryView.h"
#import "FNmarketBillModel.h"
#import "FNmerchentSDateView.h"
#import "FNcalendarPopDeView.h"
#import "NSDate+HXExtension.h"
#import "FNmrketBillItemCell.h"
#import "FNmarketBillHeadView.h"
@interface FNmarketBillListController ()<UICollectionViewDelegate,UICollectionViewDataSource,JXCategoryViewDelegate,FNcalendarPopDeViewDegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *typeArr;
@property (nonatomic, strong)NSMutableArray *dateArr;
@property (nonatomic, strong)NSString *typeString;
@property (nonatomic, strong)NSString *dateString;
@property (nonatomic, strong)NSString *start_timeString;
@property (nonatomic, strong)NSString *end_timeString;
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)JXCategoryTitleView *dateCategoryView;
@property (nonatomic, strong)JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong)FNmarketBillModel *headModel;
@property (nonatomic, strong)FNmerchentSDateView *customView;
@property (nonatomic, assign)NSInteger dateState;
@property (nonatomic, strong)NSString *gainSumStr;
@property (nonatomic, strong)UIButton *rightBtn;
@end

@implementation FNmarketBillListController

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
    self.gainSumStr=@"";
    CGFloat baseGap=0;
    CGFloat topGap=SafeAreaTopHeight+81;
    if(self.understand==YES){
        baseGap=XYTabBarHeight;
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, topGap, FNDeviceWidth, FNDeviceHeight-topGap-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil; 
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNmrketBillItemCell class] forCellWithReuseIdentifier:@"FNmrketBillItemCellID"];
    
    [self.jm_collectionview registerClass:[FNmarketBillHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNmarketBillHeadViewID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView"];
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.leftBtn.size = CGSizeMake(40, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 5).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:16];
    self.navigationView.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.titleLabel.text=@"账单明细";
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=RGB(250, 250, 250);
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
    [self inAddSubTopViews];
    if([UserAccessToken kr_isNotEmpty]){
       [self requestBillHeader];
    }
}
#pragma mark - 排序类型
-(void)inAddSubTopViews{
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+1, FNDeviceWidth, 44)];
    self.categoryView.delegate = self;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.backgroundColor=[UIColor whiteColor];
    //self.categoryView.contentEdgeInsetLeft=15;
    //self.categoryView.contentEdgeInsetRight=15;
    self.categoryView.titleFont=kFONT14;
    self.categoryView.titleSelectedFont=kFONT14;
    //lineView
    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
    //line颜色
    self.lineView.indicatorHeight=2;
    self.categoryView.indicators = @[self.lineView];
    [self.view addSubview:self.categoryView];
    
    self.dateCategoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+46, FNDeviceWidth-80, 34)];
    self.dateCategoryView.delegate = self;
    self.dateCategoryView.titleColorGradientEnabled = YES;
    self.dateCategoryView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.dateCategoryView];
    self.dateCategoryView.titleFont=kFONT13;
    self.dateCategoryView.titleSelectedFont=kFONT13;
    self.dateCategoryView.titleColor=RGB(140, 140, 140);
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.tag=1100;
    [self.rightBtn setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:RGB(255, 96, 9) forState:UIControlStateSelected];
    self.rightBtn.titleLabel.font=kFONT13;
    [self.rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.rightBtn];
    self.rightBtn.backgroundColor=[UIColor whiteColor];
    
    UIView *lineView=[[UIView alloc]init];
    [self.view addSubview:lineView];
    lineView.backgroundColor=RGB(223, 223, 223);
    
    self.rightBtn.sd_layout
    .rightSpaceToView(self.view, 0).heightIs(33).centerYEqualToView(self.dateCategoryView).widthIs(80);
    
    lineView.sd_layout
    .rightSpaceToView(self.rightBtn, 0).heightIs(14).centerYEqualToView(self.dateCategoryView).widthIs(1);
    
    
}
//点击时间排序
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    XYLog(@"%ld",(long)index);
    if(categoryView==self.categoryView){
        FNmarketBillTypeItemModel *itemModel=self.typeArr[index];
        self.typeString=itemModel.type;
        self.jm_page=1;
        self.start_timeString=@"";
        self.end_timeString=@"";
        [self requestSotreList];
    }
    if(categoryView==self.dateCategoryView){
        FNmarketBillTypeItemModel *itemModel=self.dateArr[index];
        self.dateString=itemModel.date;
        self.jm_page=1;
        self.start_timeString=@"";
        self.end_timeString=@"";
        [self requestSotreList];
    }
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{ 
        FNmrketBillItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmrketBillItemCellID" forIndexPath:indexPath];
        cell.model=[FNmarketBillItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
        return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=60;
    CGFloat itemWith=FNDeviceWidth;
    return  CGSizeMake(itemWith, itemHeight);
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        FNmarketBillHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNmarketBillHeadViewID" forIndexPath:indexPath];
        headerView.backgroundColor=RGB(246, 245, 245);
        headerView.titleLB.text=self.gainSumStr;
        return headerView;
    }
    else{
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView" forIndexPath:indexPath];
        footView.backgroundColor=[UIColor clearColor];
        return footView;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=44;
    return CGSizeMake(with,hight);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=0;
    return CGSizeMake(with,hight);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//筛选
-(void)rightBtnAction:(UIButton*)btn{
    btn.selected=!btn.selected;
    if (btn.selected==YES) {
        CGFloat topGap=SafeAreaTopHeight+81;
        self.customView = [[FNmerchentSDateView alloc] initWithFrame:CGRectMake(0, topGap, FNDeviceWidth, FNDeviceHeight-topGap)];
        [self.customView.cancelBtn addTarget:self action:@selector(cancelBtnDiss)];
        [self.customView.confirmBtn addTarget:self action:@selector(confirmBtnClick)];
        [self.customView.startBtn addTarget:self action:@selector(startBtnClick)];
        [self.customView.endBtn addTarget:self action:@selector(endBtnClick)];
        [self.view addSubview:self.customView];
        [self.customView showView: @[]];
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
    UIButton *rightBtn=(UIButton*)[self.view viewWithTag:1100];
    [self rightBtnAction:rightBtn];
    if([self.start_timeString kr_isNotEmpty] && [self.end_timeString kr_isNotEmpty]){
        self.jm_page=1;
        [self requestSotreList];
    }
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
    
    XYLog(@"选择日期=:%@",date);
}
- (void)popSeletedDateStyleClick:(NSDate *)date{
    if(self.dateState==1){
        self.start_timeString=[date dateStringWithFormat:@"yyyy-MM-dd"];
        [self.customView.startBtn setTitle:self.start_timeString forState:UIControlStateNormal];
    }
    if(self.dateState==2){
        self.end_timeString=[date dateStringWithFormat:@"yyyy-MM-dd"];
        [self.customView.endBtn setTitle:self.end_timeString forState:UIControlStateNormal];
    }
    
}
#pragma mark - request
//推手中心-账单明细页面头部
-(FNRequestTool*)requestBillHeader{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=push_hand&ctrl=bill_detail" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary *dictry = respondsObject[DataKey];
        self.headModel=[FNmarketBillModel mj_objectWithKeyValues:dictry];
            NSArray *typeArrM=self.headModel.types;
            if(typeArrM.count>0){
                NSMutableArray *nameArray=[NSMutableArray arrayWithCapacity:0];
                NSMutableArray *tyArray=[NSMutableArray arrayWithCapacity:0];
                [typeArrM enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    FNmarketBillTypeItemModel *model=[FNmarketBillTypeItemModel mj_objectWithKeyValues:obj];
                    [nameArray addObject:model.str];
                    [tyArray addObject:model];
                }];
                self.typeArr=tyArray;
                self.categoryView.titles =nameArray;
                FNmarketBillTypeItemModel *oneModel=self.typeArr[0];
                self.typeString=oneModel.type;
                self.categoryView.titleColor=RGB(140, 140, 140);
                self.categoryView.titleSelectedColor=[UIColor colorWithHexString:self.headModel.types_color];
                self.lineView.indicatorColor=[UIColor colorWithHexString:self.headModel.types_color];
                [self.categoryView reloadData];
            }
        NSArray *dateArrM=self.headModel.dates;
        if(dateArrM.count>0){
            NSMutableArray *titleArray=[NSMutableArray arrayWithCapacity:0];
            NSMutableArray *modelArray=[NSMutableArray arrayWithCapacity:0];
            [dateArrM enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNmarketBillTypeItemModel *model=[FNmarketBillTypeItemModel mj_objectWithKeyValues:obj];
                if(idx<dateArrM.count-1){
                  [titleArray addObject:model.str];
                  [modelArray addObject:model];
                }
            }];
            self.dateArr=modelArray;
            self.dateCategoryView.titles =titleArray;
            FNmarketBillTypeItemModel *oneModel=self.dateArr[0];
            self.dateString=oneModel.date;
            self.dateCategoryView.titleColor=RGB(140, 140, 140);
            self.dateCategoryView.titleSelectedColor=[UIColor colorWithHexString:self.headModel.dates_color];
            [self.dateCategoryView reloadData];
            FNmarketBillTypeItemModel *endModel=[FNmarketBillTypeItemModel mj_objectWithKeyValues:dateArrM[dateArrM.count-1]];
            [self.rightBtn setTitle:endModel.str forState:UIControlStateNormal];
            [self.rightBtn setImage:IMAGE(@"FJ_norsj_img") forState:UIControlStateNormal];
            [self.rightBtn setImage:IMAGE(@"FJ_orsj_img") forState:UIControlStateSelected];
            [self.rightBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
        }
        [self requestSotreList];
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
//推手中心-推荐店铺列表
-(FNRequestTool*)requestSotreList{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];  
    if([self.typeString kr_isNotEmpty]){
       params[@"type"]=self.typeString;
    }
    if([self.dateString kr_isNotEmpty]){
        params[@"date"]=self.dateString;
    }
    if([self.start_timeString kr_isNotEmpty]){
        params[@"start_time"]=self.start_timeString;
    }
    if([self.end_timeString kr_isNotEmpty]){
        params[@"end_time"]=self.end_timeString;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=push_hand&ctrl=bill_list" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary *dataDictry=respondsObject[DataKey];
        NSArray *array =dataDictry[@"list"];
        self.gainSumStr=dataDictry[@"sum_str"];
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
                    [self requestSotreList];
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

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSMutableArray *)typeArr {
    if (!_typeArr) {
        _typeArr = [NSMutableArray array];
    }
    return _typeArr;
}
- (NSMutableArray *)dateArr {
    if (!_dateArr) {
        _dateArr = [NSMutableArray array];
    }
    return _dateArr;
}

@end
