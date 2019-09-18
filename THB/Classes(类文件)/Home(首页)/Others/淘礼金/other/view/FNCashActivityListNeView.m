//
//  FNCashActivityListNeView.m
//  THB
//
//  Created by Jimmy on 2018/10/23.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNCashActivityListNeView.h"
#import "FNCashAcCommodityNeCell.h"
@implementation FNCashActivityListNeView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    if (self) {
        [self ActivityListUI];
    }
    return self;
}

#pragma mark -  单元
-(void)ActivityListUI{
    
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing = 5;
    flowayout.minimumInteritemSpacing=5;
    //flowayout.sectionHeadersPinToVisibleBounds = NO;
    //flowayout.sectionFootersPinToVisibleBounds = NO;
    //flowayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat ActivityWide=FNDeviceWidth-10-20-10-10-10;
    self.ActivityCollectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 0, ActivityWide, 200) collectionViewLayout:flowayout];
    self.ActivityCollectionview.dataSource = self;
    self.ActivityCollectionview.delegate = self;
    self.ActivityCollectionview.backgroundColor=[UIColor whiteColor];
    [self  addSubview: self.ActivityCollectionview];
    [self.ActivityCollectionview registerClass:[FNCashAcCommodityNeCell class] forCellWithReuseIdentifier:@"ActivityCell"];
    self.ActivityCollectionview.showsVerticalScrollIndicator = NO;
    self.ActivityCollectionview.showsHorizontalScrollIndicator = NO;
    self.ActivityCollectionview.sd_layout
    .topSpaceToView(self, 0).bottomSpaceToView(self, 0).leftSpaceToView(self, 5).rightSpaceToView(self, 5);
    
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNCashAcCommodityNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ActivityCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    //cell.indexPath=indexPath;
    //FNBaseProductModel *item=_heatArr[indexPath.row];
    //NSLog(@"name:%@",item.name);
    //cell.model=self.heatArr[indexPath.row];
    cell.borderWidth=0.5;
    cell.borderColor = FNGlobalTextGrayColor;
    cell.clipsToBounds = YES;
    cell.itemDic=self.dataArr[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *itemDic=self.dataArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(caActivityListAction:)]) {
        [self.delegate caActivityListAction:itemDic];
    }
}
#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=(FNDeviceWidth-25-10-5-20)/2;
    
    CGSize size = CGSizeMake(with, with+90);
    return size;
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr.count>0){
      [self.ActivityCollectionview reloadData];
    }
}
@end
