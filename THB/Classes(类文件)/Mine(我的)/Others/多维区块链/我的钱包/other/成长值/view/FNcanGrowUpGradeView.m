//
//  FNcanGrowUpGradeView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcanGrowUpGradeView.h"

@implementation FNcanGrowUpGradeView

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
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 50)  collectionViewLayout:flowayout];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.backgroundColor=[UIColor clearColor];
    [self addSubview: self.collectionview];
    [self.collectionview registerClass:[FNcandiesGradeItemCell class] forCellWithReuseIdentifier:@"FNcandiesGradeItemCellID"];
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
    
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNcandiesGradeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcandiesGradeItemCellID" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    cell.model=self.dataArr[indexPath.row];
    return cell;
}

#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=(FNDeviceWidth-18)/6;
    
    CGSize  size=CGSizeMake(with, 50);
    return size;
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr){
        [self.collectionview reloadData];
    }
}
@end
