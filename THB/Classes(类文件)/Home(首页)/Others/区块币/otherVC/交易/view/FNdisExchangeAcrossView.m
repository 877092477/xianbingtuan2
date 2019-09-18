//
//  FNdisExchangeAcrossView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdisExchangeAcrossView.h"

@implementation FNdisExchangeAcrossView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setUpAllView{
    self.userInteractionEnabled =YES;
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    //flowayout.minimumLineSpacing = 0;
    flowayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth-30, 40) collectionViewLayout:flowayout];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.backgroundColor=[UIColor whiteColor];
    [self addSubview: self.collectionview];
    [self.collectionview registerClass:[FNdisExChangeStyleTwoCell class] forCellWithReuseIdentifier:@"FNdisExChangeStyleTwoCellID"];
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
    self.collectionview.scrollEnabled = NO;
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNdisExChangeStyleTwoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNdisExChangeStyleTwoCellID" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    //cell.model=model;
    FNdisExchangeAcrossItemModel *model=self.dataArr[indexPath.row];
    if(model.showInt==0){
       cell.line.hidden=NO;
    }else{
       cell.line.hidden=YES;
    }
    cell.sumLB.text=model.number;//@"8.00";
    cell.msgLB.text=model.tips;//@"未成交金额(元)";
    return cell;
}
 
#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat with=(self.frame.size.width-2)/3; 
    
    CGSize  size=CGSizeMake(with, 40);
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
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(didExchangeAcrossAction)]) {
        [self.delegate didExchangeAcrossAction];
    }
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr){
        [self.collectionview reloadData];
    }
}


@end
