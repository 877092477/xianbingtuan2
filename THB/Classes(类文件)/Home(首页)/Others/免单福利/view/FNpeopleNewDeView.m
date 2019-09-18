//
//  FNpeopleNewDeView.m
//  THB
//
//  Created by Jimmy on 2018/12/18.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNpeopleNewDeView.h"

@implementation FNpeopleNewDeView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    if (self) {
        [self peoNeViewUI];
    }
    return self;
}

#pragma mark -  单元
-(void)peoNeViewUI{
    
    CGFloat with=JMScreenWidth/3+60;
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing = 10;
    //flowayout.sectionHeadersPinToVisibleBounds = NO;
    //flowayout.sectionFootersPinToVisibleBounds = NO;
    flowayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.goodscollectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 0, FNDeviceWidth-10, 230) collectionViewLayout:flowayout];
    self.goodscollectionview.dataSource = self;
    self.goodscollectionview.delegate = self;
    self.goodscollectionview.backgroundColor=[UIColor whiteColor];
    [self  addSubview: self.goodscollectionview];
    [self.goodscollectionview registerClass:[FNpeopleGoodsItemNeCell class] forCellWithReuseIdentifier:@"GoodsItemNeCell"];
    self.goodscollectionview.showsVerticalScrollIndicator = NO;
    self.goodscollectionview.showsHorizontalScrollIndicator = NO;
    
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNpeopleGoodsItemNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsItemNeCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.cornerRadius=5;
    cell.itemDictry=self.dataArr[indexPath.row];
    cell.indexPath=indexPath;
    //FNBaseProductModel *item=_heatArr[indexPath.row];
    //NSLog(@"name:%@",item.name);
    //cell.model=self.heatArr[indexPath.row];
    cell.delegate=self;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    FNBaseProductModel *item=_heatArr[indexPath.row];
//    
//    if (self.selectHeatCommodityNow) {
//        self.selectHeatCommodityNow(item);
//    }
//    
    if ([self.delegate respondsToSelector:@selector(inSeletedGoodsItemClick:)]) {
        [self.delegate inSeletedGoodsItemClick:self.dataArr[indexPath.row]];
    }
}
#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=JMScreenWidth/3;
    CGSize size = CGSizeMake(with, 230);
    return size;
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr){
        [self.goodscollectionview reloadData];
    }
}

#pragma mark - FNpeopleGoodsItemNeCellDegate <NSObject>

// 点击
- (void)itemGoodsItemClick:(NSDictionary*)dicTry{
    if ([self.delegate respondsToSelector:@selector(inSeletedGoodsItemClick:)]) {
        [self.delegate inSeletedGoodsItemClick:dicTry];
    }
}
@end
