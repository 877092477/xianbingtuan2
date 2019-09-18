//
//  FNmerReviewPrintsView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/10.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerReviewPrintsView.h"

@implementation FNmerReviewPrintsView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setUpAllView{
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing = 0;
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 41) collectionViewLayout:flowayout];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.backgroundColor=[UIColor clearColor];
    [self addSubview: self.collectionview];
    [self.collectionview registerClass:[FNmerReviewImgCell class] forCellWithReuseIdentifier:@"FNmerReviewImgCellID"];
    
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
    
    self.collectionview.sd_layout
    .leftSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0);
    
    self.collectionview.scrollEnabled = NO;
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{ 
    
    FNmerReviewImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerReviewImgCellID" forIndexPath:indexPath];
    cell.backgroundColor=RGB(246, 245, 245);
    [cell.ImgView setUrlImg:self.dataArr[indexPath.row]];
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(inmerReviewPrintsAction:isIndex:)]) {
        [self.delegate inmerReviewPrintsAction:self.dataArr isIndex:indexPath.row];
    }
    
}
#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWith=96;//(FNDeviceWidth-30)/3;
    CGFloat itemHeight=96;//itemWith;
    CGSize size=CGSizeMake(itemWith, itemHeight);
    return size;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 3;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 3;
    
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=57;
    CGFloat bottomGap=0;
    CGFloat rightGap=FNDeviceWidth-215-57;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr){
        self.collectionview.sd_layout
        .leftSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0);
       [self.collectionview reloadData];
    }
}




@end
