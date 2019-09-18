//
//  FNmakeHeadListView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmakeHeadListView.h"

@implementation FNmakeHeadListView

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
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 60) collectionViewLayout:flowayout];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.backgroundColor=[UIColor clearColor];
    [self addSubview: self.collectionview];
    [self.collectionview registerClass:[FNmakeHeadItemCell class] forCellWithReuseIdentifier:@"FNmakeHeadItemCellID"];
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
    
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNmakeHeadItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmakeHeadItemCellID" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    FNMakeJFTmodel *model=[FNMakeJFTmodel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
    if ([self.textColor kr_isNotEmpty]) {
        cell.titleLB.textColor=[UIColor colorWithHexString:self.textColor];
        cell.numberLB.textColor=[UIColor colorWithHexString:self.textColor];
    }
    cell.model=model;
    return cell;
}
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if ([self.delegate respondsToSelector:@selector(inHeadrColumnAction:)]) {
//        [self.delegate inHeadrColumnAction:indexPath];
//    }
//}
#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=FNDeviceWidth/3;
    if(self.dataArr.count>4){
        with=FNDeviceWidth/4;
    }
    else {
        with=FNDeviceWidth/self.dataArr.count;
    }
    CGSize  size=CGSizeMake(with, 60);
    return size;
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr){
       [self.collectionview reloadData];
    }
}
-(void)setTextColor:(NSString *)textColor{
    _textColor=textColor;
    if ([textColor kr_isNotEmpty]) {
        [self.collectionview reloadData];
    }
}
@end
