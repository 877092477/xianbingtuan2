//
//  FNdeliveryDateItemView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdeliveryDateItemView.h"

@implementation FNdeliveryDateItemView

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        [self initializedSubviews];
    } return self;
}
// 准备弹出(初始化弹层位置)
- (void)willPopupContainer:(DSHPopupContainer *)container; {
    CGRect frame = self.frame;
    frame.size = CGSizeMake(FNDeviceWidth-50, 188);
    frame.origin.x = 25;
    frame.origin.y = container.frame.size.height/2-144;
    self.frame = frame;
}

// 已弹出(做弹出动画)
- (void)didPopupContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.6f;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.layer addAnimation:animation forKey:nil];
}

// 将要移除(做移除动画)
- (void)willDismissContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    
    
    [UIView animateWithDuration:0.6f animations:^{
        self.transform = (CGAffineTransformMakeScale(0.1, 0.1));
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
}

- (void)initializedSubviews{
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:18];
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    self.titleLB.text=@"自定义";
     
    UIView *centerXLine=[[UIView alloc]init];
    [self addSubview:centerXLine];
    
    self.leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.leftBtn];
    
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightBtn];
    
    self.leftBtn.titleLabel.font=kFONT17;
    [self.leftBtn setTitleColor:RGB(255, 120, 37) forState:UIControlStateNormal];
    [self.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    self.rightBtn.titleLabel.font=kFONT17;
    [self.rightBtn setTitleColor:RGB(255, 120, 37) forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.rightBtn addTarget:self action:@selector(rightBtnClick)];
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 27).rightSpaceToView(self, 27).heightIs(21).topSpaceToView(self, 24);
    
    centerXLine.sd_layout
    .centerXEqualToView(self).widthIs(1).heightIs(73).bottomSpaceToView(self, 0);
    
    self.leftBtn.sd_layout
    .rightSpaceToView(centerXLine, 0).widthIs(115).heightIs(73).bottomSpaceToView(self, 0);
    
    self.rightBtn.sd_layout
    .leftSpaceToView(centerXLine, 0).widthIs(115).heightIs(73).bottomSpaceToView(self, 0);
    
    NSArray *arrM=@[@{@"img":@"FN_sj_day1",@"seletedImg":@"FN_sj_day1red",@"value":@"1",@"dayVal":@"星期一"}, @{@"img":@"FN_sj_day2",@"seletedImg":@"FN_sj_day2red",@"value":@"2",@"dayVal":@"星期二"}, @{@"img":@"FN_sj_day3",@"seletedImg":@"FN_sj_day3red",@"value":@"3",@"dayVal":@"星期三"},
                    @{@"img":@"FN_sj_day4",@"seletedImg":@"FN_sj_day4red",@"value":@"4",@"dayVal":@"星期四"},
                    @{@"img":@"FN_sj_day5",@"seletedImg":@"FN_sj_day5red",@"value":@"5",@"dayVal":@"星期五"},
                    @{@"img":@"FN_sj_day6",@"seletedImg":@"FN_sj_day6red",@"value":@"6",@"dayVal":@"星期六"},
                    @{@"img":@"FN_sj_day7",@"seletedImg":@"FN_sj_day7red",@"value":@"7",@"dayVal":@"星期日"}];
    self.dataArr=[NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in arrM) {
        FNdeliveryDayModel *model=[FNdeliveryDayModel mj_objectWithKeyValues:dic];
        [self.dataArr addObject:model];
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    //flowlayout.minimumLineSpacing = 0;
    //flowlayout.minimumInteritemSpacing = 0;
    //flowlayout.sectionInset = UIEdgeInsetsZero;
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 27, 269, 35) collectionViewLayout:flowlayout];
    self.collectionview.backgroundColor=[UIColor whiteColor];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.showsVerticalScrollIndicator=NO;
    self.collectionview.showsHorizontalScrollIndicator=NO;
    [self.collectionview registerClass:[FNdeliveryDayItemCell class] forCellWithReuseIdentifier:@"FNdeliveryDayItemCellID"];
    [self addSubview:self.collectionview]; 
    self.collectionview.sd_layout
    .topSpaceToView(self.titleLB, 40).centerXEqualToView(self).widthIs(269).heightIs(35);
    
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{ 
    FNdeliveryDayModel *model=self.dataArr[indexPath.row];
    FNdeliveryDayItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNdeliveryDayItemCellID" forIndexPath:indexPath];
    cell.model=model;
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake(35, 35);
    return size;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNdeliveryDayModel *model=self.dataArr[indexPath.row];
    if (model.state==YES) {
        model.state=NO;
    }else{
        model.state=YES;
    }
    @weakify(self);
    [UIView performWithoutAnimation:^{
        @strongify(self);
        [self.collectionview reloadData];
    }];

}
-(void)rightBtnClick{
    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
    NSMutableArray *arrTM=[NSMutableArray arrayWithCapacity:0];
    NSString *jointString=@"";
    NSString *jointTwo=@"";
    [self.dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FNdeliveryDayModel *model=obj;
        if(model.state==YES){
           [arrM addObject:model.value];
           [arrTM addObject:model.dayVal];
        }
    }];
    if(arrM.count>0){
        jointString=[arrM componentsJoinedByString:@","];
        XYLog(@"选择%@",jointString);
    }
    if(arrTM.count>0){
        jointTwo=[arrTM componentsJoinedByString:@","];
        XYLog(@"选择%@",jointTwo);
    }
    if ([self.delegate respondsToSelector:@selector(inDeliveryDateItemWithDate:withJoint:)]) {
        [self.delegate inDeliveryDateItemWithDate:jointString withJoint:jointTwo];
    }
}
@end
