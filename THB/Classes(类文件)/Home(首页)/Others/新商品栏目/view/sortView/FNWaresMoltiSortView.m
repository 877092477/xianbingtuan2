//
//  FNWaresMoltiSortView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNWaresMoltiSortView.h"

@implementation FNWaresMoltiSortView

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
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth-60, 35) collectionViewLayout:flowayout];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.backgroundColor=[UIColor clearColor];
    [self addSubview: self.collectionview];
    [self.collectionview registerClass:[FNWaresSortItemACell class] forCellWithReuseIdentifier:@"FNWaresSortItemACell"];
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
    
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNWaresSortItemACell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNWaresSortItemACell" forIndexPath:indexPath];
    cell.model=self.dataArr[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNWaresSortAModel  *model=self.dataArr[indexPath.row];
    for (FNWaresSortAModel  *itemModel in self.dataArr) {
        if (itemModel.sortid==model.sortid) {
            itemModel.state=1;
        }else{
            itemModel.state=0;
        }
    }
    [self.collectionview reloadData];
    if ([self.delegate respondsToSelector:@selector(diWaresMoltiSortViewAction:)]) {
        [self.delegate diWaresMoltiSortViewAction:indexPath.row];
    }
}
#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=(FNDeviceWidth-60)/3; 
    CGSize  size=CGSizeMake(with, 35);
    return size;
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr){
        [self.collectionview reloadData];
    }
}

@end
