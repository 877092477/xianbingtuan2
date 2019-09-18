//
//  FNPredictDeliveryTimeVC.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNPredictDeliveryTimeVC.h"
#import "FNCustomeNavigationBar.h"
#import "FNpredictTimesCell.h"
#import "FNpredictSpecialTimeItemCell.h"
#import "FNpredictTimeBaseView.h"
#import "FNpredictDeliveryTimeModel.h"
#import "FNDeliveryDatepView.h"
#import "DSHPopupContainer.h"
#import "FNpredictDurationListView.h"
@interface FNPredictDeliveryTimeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNpredictTimesCellDelegate,FNpredictSpecialTimeItemCellDelegate,FNDeliveryDatepViewDelegate,FNpredictDurationListViewDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UIButton *switchRightBtn;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *specialTimeArr;
@property (nonatomic, strong)NSMutableArray *startTimeArr;
@property (nonatomic, strong)NSMutableArray *endTimeArr;
@property (nonatomic, strong)NSMutableArray *deliveryArr;
@property (nonatomic, strong)NSIndexPath *timeFrameIndex;
@property (nonatomic, strong)DSHPopupContainer *container;
@property (nonatomic, strong)FNDeliveryDatepView *customDateView;

@property (nonatomic, strong)DSHPopupContainer *durationContainer;
@property (nonatomic, strong)FNpredictDurationListView *durationCustomView;

@property (nonatomic, strong)NSString *compute_duration;
@property (nonatomic, strong)NSString *ps_duration;
@property (nonatomic, strong)NSString *one_km_inc;
@end

@implementation FNPredictDeliveryTimeVC

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
    //[self reloadModels:@[]];
    self.compute_duration=@"close"; //open  close
    self.ps_duration=@"";
    self.one_km_inc=@"";
    self.startTimeArr=[NSMutableArray arrayWithCapacity:0];
    self.endTimeArr=[NSMutableArray arrayWithCapacity:0];
    self.deliveryArr=[NSMutableArray arrayWithCapacity:0];
    
    self.specialTimeArr=[NSMutableArray arrayWithCapacity:0];
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.leftBtn.size = CGSizeMake(40, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.size = CGSizeMake(54, 27);
    self.navigationView.rightButton = self.rightBtn;
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    //[self.rightBtn setBackgroundImage:IMAGE(@"FN_me_orBCimg") forState:UIControlStateNormal];
    [self.rightBtn setBackgroundImage:IMAGE(@"FN_me_orBCnorImg") forState:UIControlStateNormal];
    
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 5).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:16];
    self.navigationView.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).leftSpaceToView(self.leftBtn, 1).heightIs(20);
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.titleLabel.text=@"配送设置";
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=RGB(250, 250, 250);
    [self inAddHeadSubViews];
    
    CGFloat baseGap=SafeAreaTopHeight+85;
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
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
    [self.jm_collectionview registerClass:[FNpredictTimesCell class] forCellWithReuseIdentifier:@"FNpredictTimesCellID"];
    [self.jm_collectionview registerClass:[FNpredictSpecialTimeItemCell class] forCellWithReuseIdentifier:@"FNpredictSpecialTimeItemCellID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewID"];
    [self.jm_collectionview registerClass:[FNpredictTimeBaseView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FNpredictTimeBaseViewID"];
     [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterID"];
    
    
    if([self.setingModel.compute_duration kr_isNotEmpty]){
        self.compute_duration=self.setingModel.compute_duration;
        if([self.setingModel.compute_duration isEqualToString:@"close"]){
            self.switchRightBtn.selected=NO;
        }else{
            self.switchRightBtn.selected=YES;
        }
    }
    if([self.setingModel.ps_duration kr_isNotEmpty]){
        self.ps_duration=self.setingModel.ps_duration;
    }
    if([self.setingModel.one_km_inc kr_isNotEmpty]){
        self.one_km_inc=self.setingModel.one_km_inc;
    }
    NSArray *arrList=self.setingModel.special_duration;
    if(arrList.count>0){
        [arrList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNpredictSpecialTimeModel *model=[FNpredictSpecialTimeModel mj_objectWithKeyValues:obj];
            model.title=@"特殊时段";
            model.startDateHint=@"00:00";
            model.endDateHint=@"00:00";
            model.durationPlaceholder=@"配送时长";
            model.durationHint=@"分钟";
            [self.specialTimeArr addObject:model];
            [self.startTimeArr addObject:model.start_time];
            [self.endTimeArr addObject:model.end_time];
            [self.deliveryArr addObject:model.time];
        }];
        if([self.ps_duration kr_isNotEmpty]&&[self.one_km_inc kr_isNotEmpty]){
            [self.rightBtn setBackgroundImage:IMAGE(@"FN_me_orBCimg") forState:UIControlStateNormal];
        }
    }
    [self reloadModels:self.specialTimeArr];
    [self.jm_collectionview reloadData];
    
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FNpredictDeliveryTimeModel *model=self.dataArr[section];
    if([model.type isEqualToString:@"duration"]||[model.type isEqualToString:@"durationOuter"]){
       return 1;
    }else{
       return self.specialTimeArr.count;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNpredictDeliveryTimeModel *model=self.dataArr[indexPath.section];
    if([model.type isEqualToString:@"duration"]){
        FNpredictTimesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNpredictTimesCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=model;
        cell.delegate=self;
        cell.index=indexPath;
        return cell;
    }
    else if([model.type isEqualToString:@"timeFrame"]){
        FNpredictSpecialTimeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNpredictSpecialTimeItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=self.specialTimeArr[indexPath.row];
        cell.delegate=self;
        cell.index=indexPath;
        return cell;
    }
    else if([model.type isEqualToString:@"durationOuter"]){
        FNpredictTimesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNpredictTimesCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=model;
        cell.delegate=self;
        cell.index=indexPath;
        return cell;
    } else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=0;
    CGFloat itemWith=FNDeviceWidth-20;
    if(indexPath.section==0 || indexPath.section==2){
       itemHeight=95;
    }else{
       itemHeight=65;
    }
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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=10;
    CGFloat bottomGap=0;
    CGFloat rightGap=10;
    if(section==2){
       topGap=10;
    }
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableViewID" forIndexPath:indexPath];
        return view;
    }else{
        if(indexPath.section==1){
            FNpredictTimeBaseView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FNpredictTimeBaseViewID" forIndexPath:indexPath];
            view.backgroundColor=[UIColor clearColor];
            [view.addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
            return view;
        }else{
            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FooterID" forIndexPath:indexPath];
            return view;
        }
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(FNDeviceWidth-20, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if(section==1){
       return CGSizeMake(FNDeviceWidth-20, 37);
    }else{
       return CGSizeMake(FNDeviceWidth-20, 0);
    }
}
#pragma mark - FNpredictTimesCellDelegate  常规时段 || 3公里以外 选择时长
// 选择时长
- (void)didpredictTimesItemAction:(NSIndexPath*)index{
    self.durationCustomView = [[FNpredictDurationListView alloc] init];
    self.durationCustomView.index=index;
    self.durationCustomView.delegate=self;
    [self.durationCustomView.leftBtn addTarget:self action:@selector(disappearDpredictTimesClick)];
    self.durationContainer = [[DSHPopupContainer alloc] initWithCustomPopupView:self.durationCustomView];
    self.durationContainer.autoDismissWhenClickedBackground=YES;
    self.durationContainer.maskColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    [self.durationContainer show];
}
-(void)disappearDpredictTimesClick{
    [self.durationContainer dismiss];
}
#pragma mark - FNpredictSpecialTimeItemCellDelegate <NSObject>
// 编辑时长
- (void)didpredictSpecialTimeAction:(NSIndexPath*)index withContent:(NSString*)content{
   [self.deliveryArr addObject:content];
    FNpredictSpecialTimeModel *model=self.specialTimeArr[index.row];
    model.time=content;
}
// 选择时间 开始 ~ 结束
- (void)didpredictSpecialTimeSeletedSDateAction:(NSIndexPath*)index{
    self.timeFrameIndex=index;
        self.customDateView = [[FNDeliveryDatepView alloc] init];
        self.customDateView.delegate=self;
        [self.customDateView.leftBtn addTarget:self action:@selector(inDateCancelClick)];
        self.container = [[DSHPopupContainer alloc] initWithCustomPopupView:self.customDateView];
        self.container.autoDismissWhenClickedBackground=YES;
        self.container.maskColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
        [self.container show];
}
//时间取消
-(void)inDateCancelClick{
    [self.container dismiss];
}
// 删除
- (void)didpredictSpecialTimeDeleteAction:(NSIndexPath*)index{
    [self.specialTimeArr removeObjectAtIndex:index.row];
    @weakify(self);
    [UIView performWithoutAnimation:^{
        @strongify(self);
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
    }];
    [self.startTimeArr removeObjectAtIndex:index.row];
    [self.endTimeArr removeObjectAtIndex:index.row];
    [self.deliveryArr removeObjectAtIndex:index.row];
}
#pragma mark -  //时间确定 FNDeliveryDatepViewDelegate
- (void)inDateConfirmActionWithContent:(NSString*)start withContent:(NSString*)end{
    [self.container dismiss];
    XYLog(@"开始时间 = %@  结束时间 = %@", start,end);
    [self.startTimeArr addObject:start];
    [self.endTimeArr addObject:end];
    FNpredictSpecialTimeModel *model=self.specialTimeArr[self.timeFrameIndex.row];
    model.start_time=start;
    model.end_time=end;
    @weakify(self);
    [UIView performWithoutAnimation:^{
        @strongify(self);
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
    }];
}
#pragma mark -  FNpredictDurationListViewDelegate // 选择时长
- (void)didpredictPredictDurationListAction:(NSIndexPath*)index withContent:(NSString*)content{
    FNpredictDeliveryTimeModel *model=self.dataArr[index.section];
    model.rightValue=content;
    if(index.section==0){
        self.ps_duration=content;
    }
    if(index.section==2){
        self.one_km_inc=content;
    }
    @weakify(self);
    [UIView performWithoutAnimation:^{
        @strongify(self);
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:index.section]];
    }];
    [self.durationContainer dismiss];
    
    if([self.ps_duration kr_isNotEmpty]&&[self.one_km_inc kr_isNotEmpty]){
        [self.rightBtn setBackgroundImage:IMAGE(@"FN_me_orBCimg") forState:UIControlStateNormal];
    }else{
        [self.rightBtn setBackgroundImage:IMAGE(@"FN_me_orBCnorImg") forState:UIControlStateNormal];
    }
}
#pragma mark - 开启部分View
-(void)inAddHeadSubViews{
    UIView *headView=[[UIView alloc]init];
    [self.view addSubview:headView];
    
    UILabel *leftTitleLB=[[UILabel alloc]init];
    [headView addSubview:leftTitleLB];
    
    self.switchRightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [headView addSubview:self.switchRightBtn];
    
    UILabel *hintTitleLB=[[UILabel alloc]init];
    [self.view addSubview:hintTitleLB];
    
    headView.backgroundColor=[UIColor whiteColor];
    
    leftTitleLB.font=[UIFont systemFontOfSize:14];
    leftTitleLB.textColor=RGB(51, 51, 51);
    leftTitleLB.textAlignment=NSTextAlignmentLeft;
    
    hintTitleLB.font=[UIFont systemFontOfSize:11];
    hintTitleLB.textColor=RGB(153, 153, 153);
    hintTitleLB.textAlignment=NSTextAlignmentLeft;
    
    leftTitleLB.text=@"自助设置预计配送时长";
    hintTitleLB.text=@"建议参考近七天的起送情况，您设置的时长将用来计算预计到达时间";
    [self.switchRightBtn setBackgroundImage:IMAGE(@"FN_xdSJ_gbimg") forState:UIControlStateNormal];
    [self.switchRightBtn setBackgroundImage:IMAGE(@"FN_xdSJ_kqim") forState:UIControlStateSelected];
    [self.switchRightBtn addTarget:self action:@selector(switchRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat baseGap=SafeAreaTopHeight+12;
    
    headView.sd_layout
    .leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).topSpaceToView(self.view, baseGap).heightIs(44);
    
    leftTitleLB.sd_layout
    .leftSpaceToView(headView, 15).heightIs(20).centerYEqualToView(headView).rightSpaceToView(headView, 55);
    
    hintTitleLB.sd_layout
    .leftSpaceToView(self.view, 25).rightSpaceToView(self.view, 25).topSpaceToView(headView, 0).heightIs(30);
    
    self.switchRightBtn.sd_layout
    .rightSpaceToView(headView, 15).centerYEqualToView(leftTitleLB).widthIs(34).heightIs(22);
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存
-(void)rightBtnAction{
    if(![self.ps_duration kr_isNotEmpty]){
        [FNTipsView showTips:@"请选择常规配送时长"];
        return;
    }
    else if(![self.one_km_inc kr_isNotEmpty]){
        [FNTipsView showTips:@"请选择超出配送时长"];
        return;
    } 
    
    [self requestSaveHeader];
}
//开关
-(void)switchRightBtnAction:(UIButton*)btn{
    btn.selected=!btn.selected;
    if(btn.selected==YES){
        //[self reloadModels:@[]];
        [self reloadModels:self.specialTimeArr];
        self.compute_duration=@"open";
    }else{
        [self.dataArr removeAllObjects];
        self.compute_duration=@"close";
    }
    [self.jm_collectionview reloadData];
}
//添加
-(void)addBtnAction{
    FNpredictSpecialTimeModel *model=[[FNpredictSpecialTimeModel alloc]init];
    model.title=@"特殊时段";
    model.startDate=@"";
    model.endDate=@"";
    model.startDateHint=@"00:00";
    model.endDateHint=@"00:00";
    model.duration=@"";
    model.durationPlaceholder=@"配送时长";
    model.durationHint=@"分钟";
    [self.specialTimeArr addObject:model];
    @weakify(self);
    [UIView performWithoutAnimation:^{
        @strongify(self);
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
    }];
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSMutableArray *)specialTimeArr{
    if (!_specialTimeArr) {
        _specialTimeArr = [NSMutableArray array];
    }
    return _specialTimeArr;
}
-(void)reloadModels:(NSArray*)arr{
    
    //self.ps_duration=@"";
    //self.one_km_inc=@"";
    NSArray *arrM=@[@{@"title":@"三公里内",@"dateTitle":@"常规时段",@"leftHint":@"营业时间内，非特殊时段",@"rightHint":@"配送时长",@"islLeftHint":@"1",@"rightValue":self.ps_duration,@"list":@[],@"type":@"duration"}, @{@"title":@"",@"dateTitle":@"",@"leftHint":@"",@"rightHint":@"",@"islLeftHint":@"",@"rightValue":@"",@"list":arr,@"type":@"timeFrame"},
        @{@"title":@"三公里外",@"dateTitle":@"每增加一公里，要增加的时长",@"leftHint":@"",@"rightHint":@"去设置",@"islLeftHint":@"0",@"rightValue":self.one_km_inc,@"list":@[@""],@"type":@"durationOuter"}];
    self.dataArr=[NSMutableArray arrayWithCapacity:0];
    [arrM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FNpredictDeliveryTimeModel *model=[FNpredictDeliveryTimeModel mj_objectWithKeyValues:obj];
        [self.dataArr addObject:model];
    }];
    [UIView performWithoutAnimation:^{
        [self.jm_collectionview reloadData];
    }];
}

#pragma mark - request
//修改配送时长接口
-(FNRequestTool*)requestSaveHeader{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    params[@"compute_duration"]=self.compute_duration;
    params[@"ps_duration"]=self.ps_duration;
    params[@"one_km_inc"]=self.one_km_inc;
    //NSMutableDictionary *startTimeParams=[NSMutableDictionary dictionaryWithDictionary:@{}];
    //NSMutableDictionary *endTimeParams=[NSMutableDictionary dictionaryWithDictionary:@{}];
    //NSMutableDictionary *deliveryParams=[NSMutableDictionary dictionaryWithDictionary:@{}];
    if(self.startTimeArr.count>0){
        [self.startTimeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *dateKey=[NSString stringWithFormat:@"start_time%lu",(unsigned long)idx+1];
            params[dateKey]=obj;
        }];
    }
    if(self.endTimeArr.count>0){
        [self.endTimeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *dateKey=[NSString stringWithFormat:@"end_time%lu",(unsigned long)idx+1];
            params[dateKey]=obj;
        }];
    }
    if(self.deliveryArr.count>0){
        [self.deliveryArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *dateKey=[NSString stringWithFormat:@"time%lu",(unsigned long)idx+1];
            params[dateKey]=obj;
        }];
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=ps_time" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        NSString *msgStr=respondsObject[MsgKey];
        [FNTipsView showTips:msgStr];
        if(state==1){
//            if (self.inMerMoneyOffData) {
//                self.inMerMoneyOffData();
//            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
@end
