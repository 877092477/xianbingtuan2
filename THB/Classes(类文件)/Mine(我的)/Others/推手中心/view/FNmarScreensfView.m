//
//  FNmarScreensfView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/14.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmarScreensfView.h"

@implementation FNmarScreensfView

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
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 36) collectionViewLayout:flowayout];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.backgroundColor=[UIColor clearColor];
    [self addSubview: self.collectionview];
    [self.collectionview registerClass:[FNmarketScreenItemCell class] forCellWithReuseIdentifier:@"FNmarketScreenItemCellID"];
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
    self.collectionview.scrollEnabled = NO;
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNmarketScreenItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmarketScreenItemCellID" forIndexPath:indexPath];
    cell.model=self.dataArr[indexPath.row];
    return cell;
} 

#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=FNDeviceWidth/4;
    CGSize  size=CGSizeMake(with, 36);
    return size;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNMarketCentreSelectItemModel *model=self.dataArr[indexPath.row];
    NSString *typeStr=model.type;
        for (FNMarketCentreSelectItemModel *itemModel in self.dataArr) {
            if([itemModel.type isEqualToString:model.type]){
                if(itemModel.seletedInt==1){
                   itemModel.seletedInt=2;
                   typeStr=model.type1;
                }else{
                   itemModel.seletedInt=1;
                   typeStr=model.type;
                }
            }else{
                itemModel.seletedInt=0;
            }
        }
     [self.collectionview reloadData]; 
    if ([self.delegate respondsToSelector:@selector(inMarketScreensfSeletedType:)]) {
        [self.delegate inMarketScreensfSeletedType:typeStr];
    }
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr.count>0){
        [self.collectionview reloadData];
    }
}

@end
