//
//  FNcardheDayTeView.m
//  THB
//
//  Created by 李显 on 2019/2/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcardheDayTeView.h"

@implementation FNcardheDayTeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setUpAllView{ 
    
    CGFloat itemW=FNDeviceWidth/5;
    CGFloat itemH=60;
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc] init];
    //设置水平滚动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置每个cell的尺寸
    layout.itemSize = CGSizeMake(itemW, itemH);
    //cell之间的水平间距  行间距
    layout.minimumLineSpacing = 0;
    //cell之间的垂直间距 cell间距
    layout.minimumInteritemSpacing = 0;
    //设置四周边距
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.dayCollectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 60) collectionViewLayout:layout];
    self.dayCollectionview.backgroundColor=[UIColor clearColor];
    self.dayCollectionview.dataSource = self;
    self.dayCollectionview.delegate = self;
    self.dayCollectionview.showsVerticalScrollIndicator=NO;
    self.dayCollectionview.showsHorizontalScrollIndicator=NO;
    [self addSubview:self.dayCollectionview];
    [self.dayCollectionview registerClass:[FNcardDayItemTeCell class] forCellWithReuseIdentifier:@"FNcardDayItemTeCellID"];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNcardDayItemTeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcardDayItemTeCellID" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    cell.model=[FNDayCardZoModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=FNDeviceWidth/4;
    CGFloat height=60;
    CGSize size = CGSizeMake(with, height);
    return size;
} 
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr){
      [self.dayCollectionview  reloadData];
    }
}
@end
