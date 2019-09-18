//
//  FNhandConditionsView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNhandConditionsView.h"

@implementation FNhandConditionsView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setUpAllView{
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing = 0;
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth-94, 50) collectionViewLayout:flowayout];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.backgroundColor=[UIColor clearColor];
    [self addSubview: self.collectionview];
    [self.collectionview registerClass:[FNhandConditionItemCell class] forCellWithReuseIdentifier:@"FNhandConditionItemCellID"];
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
    self.collectionview.scrollEnabled = NO;
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNhandConditionItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNhandConditionItemCellID" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    FNHandConditionItemModel *model=[FNHandConditionItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
    cell.titleLB.text=model.str;
    [cell.stateImgView setUrlImg:model.icon];
    return cell;
}


#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=FNDeviceWidth-94;
    CGSize  size=CGSizeMake(with, 49);
    return size;
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr.count>0){
        self.collectionview.sd_layout
        .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
        [self.collectionview reloadData];
    }
}
@end
