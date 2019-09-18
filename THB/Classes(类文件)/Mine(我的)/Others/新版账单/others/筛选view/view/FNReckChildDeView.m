//
//  FNReckChildDeView.m
//  THB
//
//  Created by Jimmy on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNReckChildDeView.h"
#import "FNchildItemSeCell.h"
#import "FNchildDeHeaderView.h"
#import "FNCollectionHeaderNeLayout.h"
#import "FNSiftViewController.h"
#pragma mark 自定义layout
@interface FNHSCollectionViewFlowLayoutL : UICollectionViewFlowLayout
@property (nonatomic, strong) NSMutableArray *attrsArray;
@end
@implementation FNHSCollectionViewFlowLayoutL
//override
- (NSArray *)layoutAttributesForElementsInRect:(CGRect )rect
{
    NSArray *attributesInRect = [super layoutAttributesForElementsInRect:rect];
    
    for (NSInteger i = 0; i<attributesInRect.count; i++) {
        if (i > 0 ) {
            UICollectionViewLayoutAttributes *atts = attributesInRect[i];
            
            if ([atts.representedElementKind isEqualToString:UICollectionElementKindSectionFooter] || [atts.representedElementKind  isEqualToString:UICollectionElementKindSectionHeader]) {
                break;
            }
            if (atts.frame.origin.x != self.sectionInset.left && i+1 != attributesInRect.count) {
                [self modifiedAttributess:attributesInRect[i] andLastAtts:attributesInRect[i-1]];
            }
        }
    }
    return attributesInRect;
}
//modified attributes
- (void)modifiedAttributess:(UICollectionViewLayoutAttributes *)atts andLastAtts:(UICollectionViewLayoutAttributes *)previousLayoutAttribute;
{
    CGRect frame = atts.frame;
    frame.origin.x   = CGRectGetMaxX(previousLayoutAttribute.frame)+10;
    atts.frame = frame;
}

@end
@interface FNReckChildDeView()<UICollectionViewDelegate,UICollectionViewDataSource,FNCollectionHeaderNeLayoutDelegate,FNcalendarPopDeViewDegate>

@end

@implementation FNReckChildDeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame withState:(NSInteger)popstate{
    if (self = [super initWithFrame:frame]) {
        self.popState=popstate;
        [self setUpAllView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
}
-(void)setUpAllView{
    CGFloat placeY=0;
    if(self.popState==1){
        placeY=FNDeviceHeight;
    }
    self.startDate=@"";
    self.overDate=@"";
    self.bgView=[[UIView alloc]init];
    self.bgView.backgroundColor=[UIColor whiteColor];
    self.bgView.frame=CGRectMake(0, placeY, FNDeviceWidth, 0);
    [self addSubview:self.bgView];
    
    //UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideViewAction)];
    //[self addGestureRecognizer:tap];
    
    CGFloat tableHeight=0;
    CGFloat topInterval=46;
 
    FNHSCollectionViewFlowLayoutL *flowLayout = [FNHSCollectionViewFlowLayoutL new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.headerReferenceSize = CGSizeMake(FNDeviceWidth, 30);
    flowLayout.footerReferenceSize = CGSizeMake(FNDeviceWidth, 0.1);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    
    self.conditionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, topInterval, FNDeviceWidth, tableHeight) collectionViewLayout:flowLayout];
    
    self.conditionView.backgroundColor=[UIColor whiteColor];
    self.conditionView.dataSource = self;
    self.conditionView.delegate = self;
    self.conditionView.showsVerticalScrollIndicator=NO;
    self.conditionView.showsHorizontalScrollIndicator=NO;
    
    [self.bgView addSubview:self.conditionView];
    
    [self.conditionView registerClass:[FNchildItemSeCell class] forCellWithReuseIdentifier:@"FNchildItemSeCellId"];
    [self.conditionView registerClass:[FNchildDeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNchildDeHeaderViewID"];
    [self.conditionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footNoViewID"];
 
    self.startBtn=[[UIButton alloc]init];
    self.startBtn.hidden=YES;
    self.startBtn.tag=1;
    [self.startBtn setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
    [self.startBtn setTitle:@"开始时间" forState:UIControlStateNormal];
    self.startBtn.titleLabel.font=kFONT12;
    [self.startBtn setImage:IMAGE(@"FJ_redCalendar") forState:UIControlStateNormal];
    [self.startBtn addTarget:self action:@selector(startDateClick)];
    [self.bgView addSubview:self.startBtn];
    
    self.lineTwo=[[UIView alloc]init];
    self.lineTwo.hidden=YES;
    self.lineTwo.backgroundColor= RGB(140, 140, 140);
    [self.bgView addSubview:self.lineTwo];
    
    self.overBtn=[[UIButton alloc]init];
    self.overBtn.hidden=YES;
    self.overBtn.tag=2;
    [self.overBtn setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
    [self.overBtn setTitle:@"结束时间" forState:UIControlStateNormal];
    self.overBtn.titleLabel.font=kFONT12;
    [self.overBtn setImage:IMAGE(@"FJ_redCalendar") forState:UIControlStateNormal];
    [self.overBtn addTarget:self action:@selector(overDateClick)];
    [self.bgView addSubview:self.overBtn];
    
    
    self.resetBtn=[[UIButton alloc]init];
    self.resetBtn.hidden=YES;
    [self.resetBtn setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
    [self.resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    self.resetBtn.titleLabel.font=kFONT16;
    self.resetBtn.borderWidth=0.5;
    self.resetBtn.borderColor = RGB(240, 240, 240);
    self.resetBtn.clipsToBounds = YES;
    [self.resetBtn addTarget:self action:@selector(resetBtnClick)];
    [self.bgView addSubview:self.resetBtn];
    
    self.confirmBtn=[[UIButton alloc]init];
    self.confirmBtn.hidden=YES;
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.confirmBtn.titleLabel.font=kFONT16;
    self.confirmBtn.backgroundColor= RGB(255, 85, 85);
    [self.confirmBtn addTarget:self action:@selector(confirmBtnClick)];
    [self.bgView addSubview:self.confirmBtn];
    
    self.resetBtn.sd_layout
    .topSpaceToView(self.conditionView, 0).leftSpaceToView(self.bgView, 0).widthIs(FNDeviceWidth/2).heightIs(45);
    self.confirmBtn.sd_layout
    .topSpaceToView(self.conditionView, 0).leftSpaceToView(self.resetBtn, 0).widthIs(FNDeviceWidth/2).heightIs(45);
    
    self.startBtn.sd_layout
    .topSpaceToView(self.bgView, 0).leftSpaceToView(self.bgView, 10).heightIs(45).widthIs(95);
    //[self.startBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:45];
    [self.startBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:6];
    
    self.lineTwo.sd_layout
    .leftSpaceToView(self.startBtn, 7).heightIs(1).widthIs(7).centerYEqualToView(self.startBtn);
    
    self.overBtn.sd_layout
    .topSpaceToView(self.bgView, 0).leftSpaceToView(self.lineTwo, 7).heightIs(45).widthIs(95);
    //[self.overBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:45];
    [self.overBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:6];
    
    self.line=[[UIView alloc]init];
    self.line.hidden=YES;
    self.line.backgroundColor= RGB(245, 245, 245);
    [self.bgView addSubview:self.line];
    self.line.sd_layout
    .topSpaceToView(self.bgView, 0).leftSpaceToView(self.bgView, 0).widthIs(FNDeviceWidth).heightIs(1);
    
    
}
#pragma mark - //选择开始时间
-(void)startDateClick{
    self.dateState=1;
    [self showcalendarView];
}
#pragma mark - //选择结束时间
-(void)overDateClick{
    self.dateState=2;
    [self showcalendarView];
}
#pragma mark - //显示日历
-(void)showcalendarView{
    FNcalendarPopDeView *calendarView = [[FNcalendarPopDeView alloc]init];
    calendarView.delegate=self;
    [[UIApplication sharedApplication].delegate.window addSubview:calendarView];
}
#pragma mark - FNcalendarPopDeViewDegate // 选择日期
- (void)popSeletedDateClick:(NSString *)date{
    XYLog(@"选择日期=:%@",date);
    if(self.dateState==1){
        self.startDate=date;
        [self.startBtn setTitle:date forState:UIControlStateNormal];
    }
    if(self.dateState==2){
        self.overDate=date;
        [self.overBtn setTitle:date forState:UIControlStateNormal];
    }
}
//重置
-(void)resetBtnClick{
    
    if(self.typeInt==1){
        if ([self.delegate respondsToSelector:@selector(inChildCancelRefresh)]) {
            [self.delegate inChildCancelRefresh];
        }
       [self hideViewAction];
       return;
    }
    
    if(self.OneSingSeleted==YES){
        for (FNreckSetScreenDeModel *model in self.typeDataArr) {
            NSMutableArray *listArr=[NSMutableArray arrayWithCapacity:0];
            [model.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNreckScreenItemModel *model=obj;
                model.state=0;
                [listArr addObject:model];
            }];
            model.list=listArr;
        }
        for (int i = 0; i < [self.typeDataArr count]; i++){
            if(i>0){
                [self.typeDataArr removeObjectAtIndex:i];
            }
        }
        if(self.typeDataArr.count==1){
            [self.delegate inChildTypeRefresh:@""];
            [self.conditionView reloadData];
        }
    }else{
        for (FNreckSetScreenDeModel *model in self.typeDataArr) {
            NSMutableArray *listArr=[NSMutableArray arrayWithCapacity:0];
            [model.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNreckScreenItemModel *model=obj;
                model.state=0;
                [listArr addObject:model];
            }];
            model.list=listArr;
        }
        [self.conditionView reloadData];
    }
    
}
//确定
-(void)confirmBtnClick{
    if ([self.delegate respondsToSelector:@selector(inConditionConfirmClick:withStart:withOver:)]) {
        [self.delegate inConditionConfirmClick:self.typeDataArr withStart:self.startDate withOver:self.overDate];
    }
    [self hideViewAction];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.typeDataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FNreckSetScreenDeModel *model=self.typeDataArr[section];
    if ([model.name isEqualToString:@"报表类型"]) {//后续自己改动
        return 1;
    }
    return model.list.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNchildItemSeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNchildItemSeCellId" forIndexPath:indexPath];
    //cell.backgroundColor=[UIColor redColor];
    FNreckSetScreenDeModel *model=self.typeDataArr[indexPath.section];
    FNreckScreenItemModel *itemModel=model.list[indexPath.row];//[FNreckScreenItemModel mj_objectWithKeyValues:model.list[indexPath.row]];
    cell.model=itemModel;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNreckSetScreenDeModel *model=self.typeDataArr[indexPath.section];
    FNreckScreenItemModel *itemModel=model.list[indexPath.row];//[FNreckScreenItemModel mj_objectWithKeyValues:model.list[indexPath.row]];
    NSString *textString=itemModel.name;//@"合作商城";
    CGFloat with=90;
    with=13*textString.length+20;
    CGSize size = CGSizeMake(with, 30);
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNreckSetScreenDeModel *model=self.typeDataArr[indexPath.section];
    FNreckScreenItemModel *itemModel=model.list[indexPath.row];
    
    if(self.OneSingSeleted==YES){
        if(indexPath.section==0){
            //单选
            for (FNreckScreenItemModel *Model in model.list) {
                if(Model.stateID==itemModel.stateID){
                    Model.state=1;
                }else{
                    Model.state=0;
                }
            }
            if ([self.delegate respondsToSelector:@selector(inChildTypeRefresh:)]) {
                [self.delegate inChildTypeRefresh:itemModel.screen_type];
            }
        }
        else{
            //多选
            for (FNreckScreenItemModel *Model in model.list) {
                if(Model.stateID==itemModel.stateID){
                    if(Model.state==1){
                        Model.state=0;
                    }else{
                        Model.state=1;
                    }
                }
            }
        }
    }else{
        //多选
        for (FNreckScreenItemModel *Model in model.list) {
            if(Model.stateID==itemModel.stateID){
                if(Model.state==1){
                    Model.state=0;
                }else{
                    Model.state=1;
                }
            }
        }
    }
    
    [self.conditionView reloadData];
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
      if ( [kind isEqual: UICollectionElementKindSectionHeader] ) {
        FNchildDeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNchildDeHeaderViewID" forIndexPath:indexPath];
        //headerView.backgroundColor=RGB(245, 245, 245);
        FNreckSetScreenDeModel *model=self.typeDataArr[indexPath.section];
        headerView.titleLB.text=model.name;
        return headerView;
      }else{
          UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footNoViewID" forIndexPath:indexPath];
          return footView;
      }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    return CGSizeMake(with,30);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=0;
    return CGSizeMake(with,hight);
}
-(void)setTypeDataArr:(NSMutableArray *)typeDataArr{
    _typeDataArr=typeDataArr;
    if(typeDataArr){
        [self.conditionView reloadData];
    }
}
#pragma mark - 隐藏当前视图
-(void)hideViewAction{
    CGFloat placeY=0;
    CGFloat topInterval=46;
    CGFloat leftGap=0;
    CGFloat listWidh=FNDeviceWidth;
    if(self.popState==1){
        placeY=FNDeviceHeight;
    }
    if(self.typeInt==1){
        topInterval=50;
        leftGap=27;
        listWidh=FNDeviceWidth-54;
    }
    //self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.startBtn.hidden=YES;
        self.lineTwo.hidden=YES;
        self.overBtn.hidden=YES;
        self.resetBtn.hidden=YES;
        self.confirmBtn.hidden=YES;
        self.lineTwo.hidden=YES;
        self.line.hidden=YES;
        self.conditionView.hidden=YES;
        self.bgView.frame = CGRectMake(0, placeY, FNDeviceWidth, 0);
        self.conditionView.frame = CGRectMake(leftGap, topInterval, listWidh, 0);
        self.hidden = YES;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        self.bgView.hidden = YES;
        for (UIView *view in self.subviews) {
            view.hidden = YES;
        }
    }];
}
#pragma mark - OneView
-(void)showOneView{
    CGFloat placeY=0;
    if(self.popState==1){
        placeY=FNDeviceHeight;
    }
    self.bgView.hidden = NO;
    CGFloat tableHeight=400-SafeAreaTopHeight-46-45;
    CGFloat topInterval=46;
    CGFloat bgViewHeight=400-SafeAreaTopHeight;
    CGFloat leftGap=0;
    CGFloat listWidh=FNDeviceWidth;
    if(self.typeInt==1){
       [self reloadTypeListViews];
       bgViewHeight=190;
       tableHeight=93;
       topInterval=50;
       leftGap=27;
       listWidh=FNDeviceWidth-54;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.frame = CGRectMake(0, 0, FNDeviceWidth, bgViewHeight);
        self.conditionView.frame = CGRectMake(leftGap, topInterval, listWidh, tableHeight);
        self.backgroundColor = [UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.3];
    } completion:^(BOOL finished) {
        self.startBtn.hidden=NO;
        self.lineTwo.hidden=NO;
        self.overBtn.hidden=NO;
        self.resetBtn.hidden=NO;
        self.confirmBtn.hidden=NO;
        self.lineTwo.hidden=NO;
        self.line.hidden=NO;
        self.conditionView.hidden=NO;
    }];
}

-(void)reloadTypeListViews{
    self.startBtn.sd_layout
    .topSpaceToView(self.bgView, 0).leftSpaceToView(self.bgView, 27).heightIs(50).widthIs(95);
    [self.startBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:6];
    
    self.lineTwo.sd_layout
    .leftSpaceToView(self.startBtn, 7).heightIs(1).widthIs(7).centerYEqualToView(self.startBtn);
    
    self.overBtn.sd_layout
    .topSpaceToView(self.bgView, 0).leftSpaceToView(self.lineTwo, 7).heightIs(50).widthIs(95);
    [self.overBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:6];
    
    self.conditionView.frame = CGRectMake(27, 50, FNDeviceWidth-54, 0);
    self.resetBtn.sd_layout
    .bottomSpaceToView(self.bgView, 0).leftSpaceToView(self.bgView, 0).widthIs(FNDeviceWidth/2).heightIs(45);
    self.confirmBtn.sd_layout
    .bottomSpaceToView(self.bgView, 0).leftSpaceToView(self.resetBtn, 0).widthIs(FNDeviceWidth/2).heightIs(45);
}
@end


