//
//  FNclockInAriseView.m
//  THB
//
//  Created by Jimmy on 2019/2/27.
//  Copyright © 2019 方诺科技. All rights reserved.
//
//打卡使用
#import "FNclockInAriseView.h"

@implementation FNclockInAriseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}

-(void)setUpAllView{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3/1.0];
    self.bgView = [[UIView alloc]init];
    self.bgView.frame = CGRectMake(0, FNDeviceHeight, FNDeviceWidth, 0);
    [self addSubview:self.bgView];
    self.bgView.backgroundColor=[UIColor whiteColor];
    [self punchCardCollectionview];
}
#pragma mark - 打卡UI
-(void)punchCardCollectionview{
    
    CGFloat tableHeight=440;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.cardCollectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, tableHeight) collectionViewLayout:flowlayout];
    self.cardCollectionview.backgroundColor=[UIColor whiteColor];
    self.cardCollectionview.dataSource = self;
    self.cardCollectionview.delegate = self;
    self.cardCollectionview.showsVerticalScrollIndicator=NO;
    self.cardCollectionview.showsHorizontalScrollIndicator=NO;
    [self.bgView addSubview:self.cardCollectionview];
    [self.cardCollectionview registerClass:[FNclockInTeCell class] forCellWithReuseIdentifier:@"FNclockInTeCellID"];
    [self.cardCollectionview registerClass:[FNclockInPayCell class] forCellWithReuseIdentifier:@"FNclockInPayCellID"];
    
    
    [self.cardCollectionview registerClass:[FNclockInTeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNclockInTeHeaderViewID"];
    
    [self.cardCollectionview registerClass:[FNclockInPayHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNclockInPayHeaderViewID"];
    
    [self.cardCollectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableViewID"];
    
    
    
    self.cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.titleLabel.font=kFONT16;
    self.cancelBtn.backgroundColor=RGB(246, 245, 245);
    [self.cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.cancelBtn];
    
    
    self.confirmBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmBtn.titleLabel.font=kFONT16;
    [self.confirmBtn setBackgroundImage:IMAGE(@"FN_dK_QDimg") forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.confirmBtn];
    
    CGFloat baseH=0;
    if(XYTabBarHeight>49){
       baseH=XYTabBarHeight-40;
    }
    self.cancelBtn.sd_layout
    .leftSpaceToView(self.bgView, 0).bottomSpaceToView(self.bgView, baseH).widthIs(FNDeviceWidth/2).heightIs(49);
    self.confirmBtn.sd_layout
    .rightSpaceToView(self.bgView, 0).bottomSpaceToView(self.bgView, baseH).widthIs(FNDeviceWidth/2).heightIs(49);
}
-(void)cancelBtnAction{
    [self dismiss];
}
-(void)confirmBtnAction{
    if(![self.countID kr_isNotEmpty]){
        [FNTipsView showTips:@"请选择方式!"];
        return;
    }
    if(![self.payTypeID kr_isNotEmpty]){
        [FNTipsView showTips:@"请选择支付方式!"];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(ariseClockInChoiceCount:withType:)]){
        [self.delegate ariseClockInChoiceCount:self.countID withType:self.payTypeID];
    }
    [self dismiss];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
      return self.typeArr.count;
    }else{
      return self.payArr.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
       FNclockInTeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNclockInTeCellID" forIndexPath:indexPath];
       cell.model=self.typeArr[indexPath.row];
       return cell;
    }else{
        FNclockInPayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNclockInPayCellID" forIndexPath:indexPath];
        cell.model=self.payArr[indexPath.row];
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=0;
    CGFloat height=0;
    if(indexPath.section==0){
        height=100;
        with=FNDeviceWidth/2;
    }else{
        height=50;
        with=FNDeviceWidth;
    }
    CGSize size = CGSizeMake(with, height);
    return size;
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
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ( [kind isEqual: UICollectionElementKindSectionHeader] ) {
        if(indexPath.section==0){
            FNclockInTeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNclockInTeHeaderViewID" forIndexPath:indexPath];
            headerView.model=self.dataModel;
            return headerView;
        }else{
            FNclockInPayHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNclockInPayHeaderViewID" forIndexPath:indexPath];
            headerView.backgroundColor=[UIColor whiteColor];
            headerView.model=self.dataModel;
            return headerView;
        } 
    }else{
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableViewID" forIndexPath:indexPath];
        headerView.backgroundColor=[UIColor whiteColor];
        return headerView;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=0;
    if(section==0){
        hight=70;
    }else{
        hight=60;
    }
    return CGSizeMake(with,hight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=0;
   
    return CGSizeMake(with,hight);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
       FNclockInpayItemModel *model=self.typeArr[indexPath.row];
       self.countID=model.id;
       for (FNclockInpayItemModel *itemmodel in self.typeArr) {
           if(model.identifying ==itemmodel.identifying){
               itemmodel.state=1;
           }else{
               itemmodel.state=0;
           }
       }
       [self.cardCollectionview reloadSections:[NSIndexSet indexSetWithIndex:0]];
    }
    if(indexPath.section==1){
        FNclockInTypeItemModel *model=self.payArr[indexPath.row];
        self.payTypeID=model.type;
        for (FNclockInTypeItemModel *itemmodel in self.payArr) {
            if(model.identifying ==itemmodel.identifying){
                itemmodel.state=1;
            }else{
                itemmodel.state=0;
            }
        }
        [self.cardCollectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
    }
}
- (void)showView
{
    CGFloat tableHeight=440+XYTabBarHeight;
    [UIView animateWithDuration:0.5 delay:0.2 usingSpringWithDamping:0.7f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
        CGRect frame = CGRectMake(0, FNDeviceHeight-tableHeight, FNDeviceWidth,tableHeight);
        self.bgView.frame = frame;
            
    } completion:nil];
    
}

- (void)dismiss
{
    self.cancelBtn.hidden=YES;
    self.confirmBtn.hidden=YES;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgView.frame =  CGRectMake(0, FNDeviceHeight, FNDeviceWidth,0);
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)setDataModel:(FNclockInZoModel *)dataModel{
    _dataModel=dataModel;
    if(dataModel){
        
       NSArray *arr=dataModel.pay;
       NSArray *arrZ=dataModel.paytype;
       NSMutableArray *typeArr=[NSMutableArray arrayWithCapacity:0];
       for(int i=0;i<arr.count;i++){
           NSDictionary *dictry=arr[i];
           FNclockInpayItemModel *model=[FNclockInpayItemModel mj_objectWithKeyValues:dictry];
           if(i==0){
               model.state=1;
               self.countID=model.id;
           }else{
               model.state=0;
           }
           model.identifying=i;
           [typeArr addObject:model];
       }
       self.typeArr=typeArr;
       NSMutableArray *pay=[NSMutableArray arrayWithCapacity:0];
      
       for(int i=0;i<arrZ.count;i++){
            NSDictionary *dictry=arrZ[i];
            FNclockInTypeItemModel *model=[FNclockInTypeItemModel mj_objectWithKeyValues:dictry];
            if(i==0){
              model.state=1;
              self.payTypeID=model.type;
            }else{
              model.state=0;
            }
            model.identifying=i;
            [pay addObject:model];
       }
       self.payArr=pay;
       [self.cardCollectionview reloadData];
    }
}

-(NSMutableArray *)typeArr{
    if (!_typeArr) {
        _typeArr = [NSMutableArray array];
    }
    return _typeArr;
}
-(NSMutableArray *)payArr{
    if (!_payArr) {
        _payArr = [NSMutableArray array];
    }
    return _payArr;
}

@end
