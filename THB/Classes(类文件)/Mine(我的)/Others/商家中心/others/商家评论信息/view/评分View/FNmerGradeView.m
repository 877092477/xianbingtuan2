//
//  FNmerGradeView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerGradeView.h"

@implementation FNmerGradeView

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
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 70, 15) collectionViewLayout:flowayout];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.backgroundColor=[UIColor clearColor];
    [self addSubview: self.collectionview];
    [self.collectionview registerClass:[FNmerGradeItemCell class] forCellWithReuseIdentifier:@"FNmerGradeItemCellID"];
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //NSInteger countInt=[self.model.star integerValue]; //[self.gradeCount integerValue];
    //return countInt;
    return self.imgArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNmerGradeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerGradeItemCellID" forIndexPath:indexPath];
    //cell.imgView.image=IMAGE(@"family_star");
    //[cell.imgView setUrlImg:self.model.good_star];
    [cell.imgView setUrlImg:self.imgArr[indexPath.row]];
    if(self.isBead==YES){
       cell.imgView.cornerRadius=15/2;
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWith=15;
    CGFloat itemHeight=15;
    CGSize size=CGSizeMake(itemWith, itemHeight);
    return size;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.itemGap;
} 

-(void)setModel:(FNmerchentReviewModel *)model{
    _model=model;
    if(model){
       [self.collectionview reloadData];
    }
}
-(void)setImgArr:(NSArray *)imgArr{
    _imgArr=imgArr;
    if(imgArr.count>0){ 
        self.collectionview.sd_resetLayout
        .leftSpaceToView(self, 0).heightIs(15).topSpaceToView(self, 0).rightSpaceToView(self, 0);
        [self.collectionview reloadData];
    }
}
-(void)setItemGap:(NSInteger)itemGap{
    _itemGap=itemGap;
    if(itemGap){
       [self.collectionview reloadData];
    }
}
@end
