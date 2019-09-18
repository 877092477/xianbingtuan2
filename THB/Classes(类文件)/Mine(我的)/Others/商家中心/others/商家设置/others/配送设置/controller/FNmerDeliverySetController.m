//
//  FNmerDeliverySetController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerDeliverySetController.h"
#import "FNAstrictDeliverysController.h"
#import "FNPredictDeliveryTimeVC.h"
#import "FNCustomeNavigationBar.h"
#import "FNmerDeliverySwitchCell.h"
#import "FNmerDeliveryEditorCell.h"
#import "FNmerDeliveryCostCell.h"
#import "FNmerDeliveryHeadTextView.h"
#import "FNdeliverySetsModel.h"
@interface FNmerDeliverySetController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNmerDeliveryEditorCellDelegate,FNmerDeliveryCostCellDelegate,FNAstrictDeliverysControllerDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, assign)NSInteger switchState;

@property (nonatomic, strong)NSString* phone;
@property (nonatomic, strong)NSString* site;

@property (nonatomic, strong)NSString* postage;//         配送费
@property (nonatomic, strong)NSString* postage_km;//      超出千米数
@property (nonatomic, strong)NSString* postage_eachkm;//  每x千米
@property (nonatomic, strong)NSString* postage_add;//     增加x元配送费
@property (nonatomic, strong)NSString* ps_open;//         是否开启配送 0 否 1 是
@property (nonatomic, strong)NSString* max_km;//          最大配送范围
@property (nonatomic, strong)NSString* end_time;//        配送结束时间
@property (nonatomic, strong)NSString* start_time;//      配送开始时间
@property (nonatomic, strong)NSString* start_postage;//   起送费
@property (nonatomic, strong)NSString* compute_duration;//   起送费
@end

@implementation FNmerDeliverySetController

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
    self.postage=@"";
    self.postage_km=@"";
    self.postage_eachkm=@"";
    self.postage_add=@"";
    self.ps_open=@"0";
    self.max_km=@"";
    self.end_time=@"";
    self.start_time=@"";
    self.start_postage=@"";
    self.compute_duration=@"";
    self.switchState=0;
    [self addSectionModel];
    CGFloat baseGap=SafeAreaTopHeight;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(10, baseGap, FNDeviceWidth-20, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    [self.view addSubview:self.jm_collectionview]; 
    
    [self.jm_collectionview registerClass:[FNmerDeliverySwitchCell class] forCellWithReuseIdentifier:@"FNmerDeliverySwitchCellID"];
    [self.jm_collectionview registerClass:[FNmerDeliveryEditorCell class] forCellWithReuseIdentifier:@"FNmerDeliveryEditorCellID"];
    [self.jm_collectionview registerClass:[FNmerDeliveryCostCell class] forCellWithReuseIdentifier:@"FNmerDeliveryCostCellID"];
    [self.jm_collectionview registerClass:[FNmerDeliveryHeadTextView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNmerDeliveryHeadTextViewID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableViewFootID"];
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.leftBtn.size = CGSizeMake(40, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.hidden=YES;
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
    
    self.ps_open=self.dataModel.ps_open;
    self.switchState=[self.dataModel.ps_open integerValue];
    self.phone=self.dataModel.phone;
    self.site=self.dataModel.address;
    FNmerSetingsPostageModel *postageModel=[FNmerSetingsPostageModel mj_objectWithKeyValues:self.dataModel.postage_data];
    self.postage=postageModel.postage;
    self.postage_km=postageModel.postage_km;
    self.postage_eachkm=postageModel.postage_eachkm;
    self.postage_add=postageModel.postage_add;
    self.max_km=postageModel.max_km;
    self.end_time=postageModel.end_time;
    self.start_time=postageModel.start_time;
    self.start_postage=postageModel.start_postage;
    FNmerSetingsPsTimeItemModel *psTimeModel=[FNmerSetingsPsTimeItemModel mj_objectWithKeyValues:self.dataModel.ps_time]; 
    self.compute_duration=psTimeModel.compute_duration;
    if([self.dataModel.ps_open integerValue]==1){
        [self addSwitchBackModel];
        self.rightBtn.hidden=NO;
    }else{
        self.rightBtn.hidden=YES;
    }
    [UIView performWithoutAnimation:^{
        [self.jm_collectionview reloadData];
    }];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
 
    FNdeliverySetSectionModel *model=self.dataArr[section];
    return model.list.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNdeliverySetSectionModel *model=self.dataArr[indexPath.section];
    FNdeliverySetsModel *rowModel=model.list[indexPath.row];
    if([model.type isEqualToString:@"Switch"]){
        FNmerDeliverySwitchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerDeliverySwitchCellID" forIndexPath:indexPath];
        [cell.rightBtn addTarget:self action:@selector(switchClick:)];
        cell.backgroundColor=[UIColor whiteColor];
        cell.leftTitleLB.text=rowModel.title;
        if(self.switchState==0){
            [cell.rightBtn setBackgroundImage:IMAGE(@"FN_xdSJ_gbimg") forState:UIControlStateNormal];
        }else{
            [cell.rightBtn setBackgroundImage:IMAGE(@"FN_xdSJ_kqim") forState:UIControlStateNormal];
        }
        return cell;
    }
    else if ([model.type isEqualToString:@"Editor"]){
        FNmerDeliveryEditorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerDeliveryEditorCellID" forIndexPath:indexPath]; 
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=rowModel;
        cell.index=indexPath;
        cell.delegate=self;
        return cell;
    }else{
        //Editor2
        FNmerDeliveryCostCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerDeliveryCostCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.titleLB.text=rowModel.title;
        cell.compileField.placeholder=rowModel.hint;
        cell.compileField.text=rowModel.value;
        cell.index=indexPath;
        cell.delegate=self;
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=0;
    CGFloat itemWith=FNDeviceWidth-20;
 
    FNdeliverySetSectionModel *model=self.dataArr[indexPath.section];
    FNdeliverySetsModel *rowModel=model.list[indexPath.row];
    if ([model.type isEqualToString:@"Editor2"]) {
        itemWith=(FNDeviceWidth-20)/3;
    }
    itemHeight=rowModel.rowHeight;
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
    if(indexPath.section==3 && indexPath.row==0){
       
    }
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=0;
    CGFloat bottomGap=10;
    CGFloat rightGap=0;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        FNdeliverySetSectionModel *model=self.dataArr[indexPath.section];
        FNmerDeliveryHeadTextView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FNmerDeliveryHeadTextViewID" forIndexPath:indexPath];
        view.titleLB.text=model.title;//@"长距离配送设置";
        if(model.rowHeight==10 || model.rowHeight==33){
           view.backgroundColor = RGB(250, 250, 250);
        }
        else if (model.rowHeight==44){
          view.backgroundColor = UIColor.whiteColor;
        }
        return view;
    }else{
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableViewFootID" forIndexPath:indexPath];
        return view;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    FNdeliverySetSectionModel *model=self.dataArr[section];
    return CGSizeMake(FNDeviceWidth-20, model.rowHeight);
 
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(FNDeviceWidth-20, 0);
}

#pragma mark - 点击
//返回
-(void)leftBtnAction{
    if ([self.delegate respondsToSelector:@selector(inDidMerDeliverySetRefreshAction)]) {
        [self.delegate inDidMerDeliverySetRefreshAction];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
//保存
-(void)rightBtnAction{
    
    if(![self.postage kr_isNotEmpty]){
        //[FNTipsView showTips:@"请输入名称"];
        return;
    }
    else if(![self.postage_km kr_isNotEmpty]){
        
        return;
    }
    else if(![self.postage_eachkm kr_isNotEmpty]){
        
        return;
    }
    else if(![self.postage_add kr_isNotEmpty]){
        
        return;
    }
    else if(![self.ps_open kr_isNotEmpty]){
        
        return;
    }
    else if(![self.max_km kr_isNotEmpty]){
        
        return;
    }
    else if(![self.end_time kr_isNotEmpty]){
        
        return;
    }
    else if(![self.start_time kr_isNotEmpty]){
        
        return;
    }
    else if(![self.start_postage kr_isNotEmpty]){
        
        return;
    }
    
    //[self requestRevise_psf];
    
    [self requestshezhiBendi];
}
//开关
-(void)switchClick:(UIButton*)btn{ 
    if(self.switchState==0){
       self.switchState=1;
       self.ps_open=@"1";
       self.rightBtn.hidden=NO;
        XYLog(@"开");
       [self addSwitchBackModel];
    }else{
        XYLog(@"关");
        self.switchState=0;
        self.rightBtn.hidden=YES;
        self.ps_open=@"0";
        [self.dataArr removeAllObjects];
        [self addSectionModel];
    }
    FNdeliverySetSectionModel *model=self.dataArr[0];
    FNdeliverySetsModel *itemModel=model.list[0];
    itemModel.isSwitch=self.switchState;
    @weakify(self);
    [UIView performWithoutAnimation:^{
        @strongify(self);
        [self.jm_collectionview reloadData];
    }];
    
    //[self requestRevise_psf];
    //[self requestshezhiBendi];
}

#pragma mark - FNmerDeliveryEditorCellDelegate 编辑1
// 编辑 电话 地址
- (void)didmerDeliveryEditorAction:(NSIndexPath*)index withContent:(NSString*)content{
    
    //self.end_time=@"";
    //self.start_time=@"";
    
    if(index.section==1){
        if(index.row==0){
           self.phone=content;
        }
        if(index.row==1){
           self.site=content;
        }
    }
    [self reloadRightBtnState];
}
// 右边点击按钮 更多配送设置 配送时间  范围内配送
- (void)didmerDeliveryRightAction:(NSIndexPath*)index{
   
    FNdeliverySetSectionModel *model=self.dataArr[index.section];
    FNdeliverySetsModel *rowModel=model.list[index.row];
    if([rowModel.rightType isEqualToString:@"预计配送时长"]){
        FNmerSetingsPsTimeItemModel *psTimeModel=[FNmerSetingsPsTimeItemModel mj_objectWithKeyValues:self.dataModel.ps_time];
        FNPredictDeliveryTimeVC *vc=[[FNPredictDeliveryTimeVC alloc]init];
        vc.setingModel=psTimeModel;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        FNAstrictDeliverysController *vc=[[FNAstrictDeliverysController alloc]init];
        vc.keyWord=rowModel.rightType;
        vc.backIndex=index;
        vc.delegate=self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - FNmerDeliveryCostCellDelegate 长距离配送设置
// 编辑 长距离配送设置:  0 超出千米数  1 每x千米  2 增加x元配送费
- (void)didmerCostEditorAction:(NSIndexPath*)index withContent:(NSString*)content{
    if(index.row==0){
       self.postage_km=content;
    }
    if(index.row==1){
       self.postage_eachkm=content;
    }
    if(index.row==2){
       self.postage_add=content;
    }
    [self reloadRightBtnState];
}
// 编辑
- (void)didmerDeliverysAction:(NSIndexPath*)index withContent:(NSString*)content withType:(NSString*)keyType{
    FNmerDeliveryEditorCell* cell = (FNmerDeliveryEditorCell *)[self.jm_collectionview cellForItemAtIndexPath:index];
    cell.compileField.text=content; 
    if([keyType isEqualToString:@"起送费"]){
        self.start_postage=content;
    }
    if([keyType isEqualToString:@"配送费"]){
        self.postage=content;
    }
    if([keyType isEqualToString:@"配送范围"]){
        self.max_km=content;
    }
    [self reloadRightBtnState];
}
// 不限制
- (void)didmerDeliverysNoLimitAction:(NSIndexPath*)index withContent:(NSString*)content withType:(NSString*)keyType{
    FNmerDeliveryEditorCell* cell = (FNmerDeliveryEditorCell *)[self.jm_collectionview cellForItemAtIndexPath:index];
    cell.compileField.text=content;
    if([keyType isEqualToString:@"起送费"]){
        self.start_postage=content;
    }
    if([keyType isEqualToString:@"配送费"]){
        self.postage=content;
    }
    if([keyType isEqualToString:@"配送范围"]){
        self.max_km=content;
    }
    [self reloadRightBtnState];
}
//配送时间
- (void)didmerDeliverysDateAction:(NSIndexPath*)index withStartTime:(NSString*)startTime withEndTime:(NSString*)endTime{
    self.end_time=endTime;
    self.start_time=startTime;
    //NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0  inSection:3];
    FNmerDeliveryEditorCell* cell = (FNmerDeliveryEditorCell *)[self.jm_collectionview cellForItemAtIndexPath:index];
    //[cell.rightBtn setTitle:[NSString stringWithFormat:@"%@-%@",self.start_time,self.end_time] forState:UIControlStateNormal];
    cell.compileField.text=[NSString stringWithFormat:@"%@-%@",self.start_time,self.end_time];
    if([self.start_time isEqualToString:@"不限制"]){
        cell.compileField.text=@"不限制";
    }
    [self reloadRightBtnState];
}
-(void)reloadRightBtnState{
    if([self.postage kr_isNotEmpty] && [self.postage_km kr_isNotEmpty] && [self.postage_eachkm kr_isNotEmpty] &&[self.postage_add kr_isNotEmpty] && [self.max_km kr_isNotEmpty] && [self.end_time kr_isNotEmpty] && [self.start_time kr_isNotEmpty] && [self.start_postage kr_isNotEmpty] && [self.phone kr_isNotEmpty] && [self.site kr_isNotEmpty]){
        [self.rightBtn setBackgroundImage:IMAGE(@"FN_me_orBCimg") forState:UIControlStateNormal];
    }else{
        [self.rightBtn setBackgroundImage:IMAGE(@"FN_me_orBCnorImg") forState:UIControlStateNormal];
    }
}
#pragma mark - 添加数据
//一区
-(void)addSectionModel{
    self.dataArr=[NSMutableArray arrayWithCapacity:0];
    FNdeliverySetSectionModel *model=[[FNdeliverySetSectionModel alloc]init];
    model.title=@"";
    model.type=@"Switch";
    model.rowHeight=10;
    FNdeliverySetsModel *itemModel=[[FNdeliverySetsModel alloc]init];
    itemModel.title=@"开启配送服务";
    itemModel.rowHeight=44;
    itemModel.isSwitch=0;
    model.list=@[itemModel];
    [self.dataArr addObject:model];
    
}
//其他数据
-(void)addSwitchBackModel{
    
    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
    FNdeliverySetSectionModel *model1=[[FNdeliverySetSectionModel alloc]init];
    model1.title=@"基础信息";
    model1.type=@"Editor";
    model1.rowHeight=33;
    FNdeliverySetsModel *item1Model=[[FNdeliverySetsModel alloc]init];
    item1Model.title=@"配送电话";
    item1Model.rowHeight=44;
    item1Model.isHsj=YES;
    item1Model.isLocation=NO;
    item1Model.hint=@"请输入电话号码";
    item1Model.value=self.phone;
    item1Model.edType=@"numInt";
    FNdeliverySetsModel *item2Model=[[FNdeliverySetsModel alloc]init];
    item2Model.title=@"发货地址";
    item2Model.isLocation=YES;
    item2Model.rowHeight=68;
    item2Model.isHsj=YES;
    item2Model.isLocation=YES;
    item2Model.hint=@"请输入地址";
    item2Model.value=self.site;
    item2Model.edType=@"Text";
    model1.list=@[item1Model,item2Model];
    
    FNdeliverySetSectionModel *model2=[[FNdeliverySetSectionModel alloc]init];
    model2.title=@"更多配送设置";
    model2.type=@"Editor";
    model2.rowHeight=33;
    FNdeliverySetsModel *itemT1Model=[[FNdeliverySetsModel alloc]init];
    itemT1Model.title=@"起送费(元)";
    itemT1Model.rowHeight=44;
    itemT1Model.isHsj=NO;
    itemT1Model.isLocation=NO;
    itemT1Model.hint=@"请设置店铺起送费用";
    itemT1Model.value=self.start_postage;
    if([self.start_postage isEqualToString:@"0"]){
       itemT1Model.value=@"不限制";
    }
    itemT1Model.edType=@"num";
    itemT1Model.isBearEd=YES;
    itemT1Model.rightType=@"起送费";
    FNdeliverySetsModel *itemT2Model=[[FNdeliverySetsModel alloc]init];
    itemT2Model.title=@"配送费(元)";
    itemT2Model.rowHeight=44;
    itemT2Model.isHsj=NO;
    itemT2Model.isLocation=NO;
    itemT2Model.hint=@"请设置商铺配送费用";
    itemT2Model.value=self.postage;
    if([self.postage isEqualToString:@"0"]){
        itemT2Model.value=@"不限制";
    }
    itemT2Model.edType=@"num";
    itemT2Model.isBearEd=YES;
    itemT2Model.rightType=@"配送费";
    model2.list=@[itemT1Model,itemT2Model];
    
    FNdeliverySetSectionModel *model3=[[FNdeliverySetSectionModel alloc]init];
    model3.title=@"";
    model3.type=@"Editor";
    model3.rowHeight=0;
    FNdeliverySetsModel *itemTh1Model=[[FNdeliverySetsModel alloc]init];
    itemTh1Model.title=@"配送时间";
    itemTh1Model.rowHeight=44;
    itemTh1Model.isHsj=NO;
    itemTh1Model.isLocation=NO;
    itemTh1Model.isBearEd=YES;
    itemTh1Model.hint=@"请设置配送时间";
    itemTh1Model.value=@"";
    if([self.end_time kr_isNotEmpty]&&[self.start_time kr_isNotEmpty]){
        itemTh1Model.value=[NSString stringWithFormat:@"%@-%@",self.start_time,self.end_time];
    }
    if([self.end_time isEqualToString:@"0"]){
        itemTh1Model.value=@"不限制";
    }
    itemTh1Model.edType=@"Text";
    itemTh1Model.rightType=@"配送时间";
    
    FNdeliverySetsModel *itemThPstimeModel=[[FNdeliverySetsModel alloc]init];
    itemThPstimeModel.title=@"预计配送时长";
    itemThPstimeModel.rowHeight=44;
    itemThPstimeModel.isHsj=NO;
    itemThPstimeModel.isLocation=NO;
    itemThPstimeModel.hint=@"未设置";
    itemThPstimeModel.value=@"";
    itemThPstimeModel.edType=@"Text";
    itemThPstimeModel.isBearEd=YES;
    itemThPstimeModel.rightType=@"预计配送时长";
    if([self.compute_duration isEqualToString:@"open"]){
       itemThPstimeModel.value=@"已设置";
    }else{
       itemThPstimeModel.value=@"未设置";
    }
    FNdeliverySetsModel *itemTh2Model=[[FNdeliverySetsModel alloc]init];
    itemTh2Model.title=@"范围内配送(公里)";
    itemTh2Model.rowHeight=44;
    itemTh2Model.isHsj=NO;
    itemTh2Model.isLocation=NO;
    itemTh2Model.hint=@"请设置配送范围";
    itemTh2Model.value=self.max_km;
    if([self.max_km isEqualToString:@"0"]){
        itemTh2Model.value=@"不限制";
    }
    itemTh2Model.edType=@"num";
    itemTh2Model.isBearEd=YES;
    itemTh2Model.rightType=@"配送范围";
    model3.list=@[itemTh1Model,itemThPstimeModel,itemTh2Model];
    
    FNdeliverySetSectionModel *model4=[[FNdeliverySetSectionModel alloc]init];
    model4.title=@"长距离配送设置";
    model4.type=@"Editor2";
    model4.rowHeight=44;
    FNdeliverySetsModel *itemF1Model=[[FNdeliverySetsModel alloc]init];
    itemF1Model.title=@"超出(km)后";
    itemF1Model.rowHeight=99;
    itemF1Model.isHsj=NO;
    itemF1Model.isLocation=NO;
    itemF1Model.hint=@"0";
    itemF1Model.value=self.postage_km;
    itemF1Model.edType=@"num";
    FNdeliverySetsModel *itemF2Model=[[FNdeliverySetsModel alloc]init];
    itemF2Model.title=@"每超出(km)";
    itemF2Model.rowHeight=99;
    itemF2Model.isHsj=NO;
    itemF2Model.isLocation=NO;
    itemF2Model.hint=@"0";
    itemF2Model.value=self.postage_eachkm;
    itemF2Model.edType=@"num";
    FNdeliverySetsModel *itemF3Model=[[FNdeliverySetsModel alloc]init];
    itemF3Model.title=@"加收配送费(元)";
    itemF3Model.rowHeight=99;
    itemF3Model.isHsj=NO;
    itemF3Model.isLocation=NO;
    itemF3Model.hint=@"0";
    itemF3Model.value=self.postage_add;
    itemF3Model.edType=@"num";
    model4.list=@[itemF1Model,itemF2Model,itemF3Model];
    
    [arrM addObject:model1];
    [arrM addObject:model2];
    [arrM addObject:model3];
    [arrM addObject:model4];
    
    [self.dataArr addObjectsFromArray:arrM];
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
#pragma mark - request  保存
-(void)requestRevise_psf{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    
    params[@"postage_km"]=self.postage_km;
    params[@"postage_eachkm"]=self.postage_eachkm;
    params[@"postage_add"]=self.postage_add;
    params[@"ps_open"]=self.ps_open;
    
    if([self.max_km isEqualToString:@"不限制"]){
        params[@"max_km"]=@"0";
    }else{
        params[@"max_km"]=self.max_km;
    }
    if([self.start_time isEqualToString:@"不限制"]){
        params[@"end_time"]=@"0";
        params[@"start_time"]=@"0";
    }else{
        params[@"end_time"]=self.end_time;
        params[@"start_time"]=self.start_time;
    }
    if([self.postage isEqualToString:@"不限制"]){
        params[@"postage"]=@"0";
    }else{
        params[@"postage"]=self.postage;
    }
    if([self.start_postage isEqualToString:@"不限制"]){
        params[@"start_postage"]=@"0";
    }else{
        params[@"start_postage"]=self.start_postage;
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=revise_psf" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        NSString *msgStr=respondsObject[MsgKey];
        [FNTipsView showTips:msgStr];
        if(state==1){
            if ([self.delegate respondsToSelector:@selector(inDidMerDeliverySetRefreshAction)]) {
                [self.delegate inDidMerDeliverySetRefreshAction];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}

#pragma mark -  本地数据
-(void)requestshezhiBendi{
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    @weakify(self);
    //params[@"postage"]=self.postage;
    params[@"postage_km"]=self.postage_km;
    params[@"postage_eachkm"]=self.postage_eachkm;
    params[@"postage_add"]=self.postage_add;
    params[@"ps_open"]=self.ps_open;
//    params[@"max_km"]=self.max_km;
//    params[@"end_time"]=self.end_time;
//    params[@"start_time"]=self.start_time;
//    params[@"start_postage"]=self.start_postage;
    if([self.max_km isEqualToString:@"不限制"]){
        params[@"max_km"]=@"0";
    }else{
        params[@"max_km"]=self.max_km;
    }
    if([self.start_time isEqualToString:@"不限制"]){
        params[@"end_time"]=@"0";
        params[@"start_time"]=@"0";
    }else{
        params[@"end_time"]=self.end_time;
        params[@"start_time"]=self.start_time;
    }
    if([self.postage isEqualToString:@"不限制"]){
        params[@"postage"]=@"0";
    }else{
        params[@"postage"]=self.postage;
    }
    if([self.start_postage isEqualToString:@"不限制"]){
        params[@"start_postage"]=@"0";
    }else{
        params[@"start_postage"]=self.start_postage;
    }
    
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=small_store&ctrl=revise_psf" successBlock:^(id responseBody) {
        XYLog(@"responseBody=%@",responseBody);
        @strongify(self);
        NSInteger state=[responseBody[SuccessKey] integerValue];
        NSString *msgStr=responseBody[MsgKey];
        [FNTipsView showTips:msgStr];
        if(state==1){
            //if ([self.delegate respondsToSelector:@selector(inDidMerDeliverySetRefreshAction)]) {
            //    [self.delegate inDidMerDeliverySetRefreshAction];
            //}
            //[self.navigationController popViewControllerAnimated:YES];
        }
        
    } failureBlock:^(NSString *error) {
    }];
}
@end
