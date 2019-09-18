//
//  FNdisOddLaunchStyleView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdisOddLaunchStyleView.h"

@implementation FNdisOddLaunchStyleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setUpAllView{
    self.userInteractionEnabled =YES;
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth-123, 50) collectionViewLayout:flowayout];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.backgroundColor=[UIColor whiteColor];
    [self addSubview: self.collectionview];
    [self.collectionview registerClass:[FNOddStyleLItemCell class] forCellWithReuseIdentifier:@"FNOddStyleLItemCellID"];
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
    self.collectionview.scrollEnabled = NO;
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNOddStyleLItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNOddStyleLItemCellID" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    FNdisOddLaunchMoItemModel *itemModel=self.dataArr[indexPath.row];
    cell.model=itemModel;
    return cell;
}
#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWide= (FNDeviceWidth-123)/2;
    CGSize  size=CGSizeMake(itemWide, 50);
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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNdisOddLaunchMoItemModel *itemModel=self.dataArr[indexPath.row];
    
    for ( FNdisOddLaunchMoItemModel *model in self.dataArr) {
        if(model.stateID==itemModel.stateID){
           model.stateInt=1;
        }else{
           model.stateInt=0;
        }
    }
    [self.collectionview reloadData];
    if ([self.delegate respondsToSelector:@selector(didLaunchStyleAction:)]) {
        [self.delegate didLaunchStyleAction:indexPath];
    }
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr){
        [self.collectionview reloadData];
    }
}

@end
