//
//  FNDistrictCrosswiseView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/30.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNDistrictCrosswiseView.h"

@implementation FNDistrictCrosswiseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setUpAllView{
    
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing = 0;
    flowayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 52) collectionViewLayout:flowayout];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.backgroundColor=[UIColor clearColor];
    [self addSubview: self.collectionview];
    [self.collectionview registerClass:[FNDistrictDealitemCell class] forCellWithReuseIdentifier:@"FNDistrictDealitemCellID"];
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
    
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNDistrictDealitemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNDistrictDealitemCellID" forIndexPath:indexPath];
    //cell.backgroundColor=[UIColor clearColor];
    FNDistrictCoinBtnItemModel *model=[FNDistrictCoinBtnItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]]; 
    cell.model=model;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNDistrictCoinBtnItemModel *model=[FNDistrictCoinBtnItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
    if ([self.delegate respondsToSelector:@selector(didDistrictCrosswiseItemAction:)]) {
        if([model.type kr_isNotEmpty]){
           [self.delegate didDistrictCrosswiseItemAction:model.type];
        } 
    }
}
#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=93; 
    CGSize  size=CGSizeMake(with, 52);
    return size;
}
#pragma mark - <UICollectionViewDelegateFlowLayout>

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat lRspW=15;
    if(self.dataArr.count>0){
       lRspW=(FNDeviceWidth-93*_dataArr.count)/2;
    }
    return UIEdgeInsetsMake(0, lRspW, 0, lRspW);
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr){
        [self.collectionview reloadData];
    }
}

@end
