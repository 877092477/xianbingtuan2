//
//  FNUpgradeGoodsNView.m
//  THB
//
//  Created by Jimmy on 2018/9/25.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
//今日推荐商品升级
#import "FNUpgradeGoodsNView.h"
#import "FNheatProductNCell.h"
#import "FNBaseProductModel.h"
#import "FNUpRecommendNCell.h"

@implementation FNUpgradeGoodsNView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    if (self) {
        [self goodsViewUI];
    }
    return self;
}

#pragma mark -  单元
-(void)goodsViewUI{
    
    CGFloat with=200;
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing = 10; 
    flowayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.goodscollectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, with) collectionViewLayout:flowayout];
    self.goodscollectionview.dataSource = self;
    self.goodscollectionview.delegate = self;
    self.goodscollectionview.layer.masksToBounds = NO;
    self.goodscollectionview.backgroundColor=[UIColor whiteColor];
    [self  addSubview: self.goodscollectionview];
    [self.goodscollectionview registerClass:[FNUpRecommendNCell class] forCellWithReuseIdentifier:@"RecommendCell"];
    self.goodscollectionview.showsVerticalScrollIndicator = NO;
    self.goodscollectionview.showsHorizontalScrollIndicator = NO;
    
}


#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.productArr.count;;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNUpRecommendNCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.indexPath=indexPath;
    FNRecommendNMode *itemmodel=[FNRecommendNMode mj_objectWithKeyValues:self.productArr[indexPath.row]];
    cell.model=itemmodel;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNBaseProductModel *item=_productArr[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(selectRecommendAction:)]) {
        [self.delegate selectRecommendAction:item];
    }
}
#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat with=JMScreenWidth/3;
    CGFloat with=135;
    CGSize size = CGSizeMake(with, with+80);
    return size;
}


-(void)setProductArr:(NSMutableArray *)productArr{
    NSLog(@"productArr:%@",productArr);
    _productArr=productArr;
    [self.goodscollectionview reloadData];
    
}


@end
