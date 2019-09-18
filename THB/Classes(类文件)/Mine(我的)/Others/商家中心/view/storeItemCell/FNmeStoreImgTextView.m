//
//  FNmeStoreImgTextView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmeStoreImgTextView.h"

@implementation FNmeStoreImgTextView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setUpAllView{
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth-20, 41) collectionViewLayout:flowayout];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.backgroundColor=[UIColor clearColor];
    [self addSubview: self.collectionview];
    [self.collectionview registerClass:[FNmerchantIconItemCell class] forCellWithReuseIdentifier:@"FNmerchantIconItemCellID"];
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelArr.count;;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   FNMerchantItemMeModel *itemModel=self.modelArr[indexPath.row];
    FNmerchantIconItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerchantIconItemCellID" forIndexPath:indexPath];
    cell.daModel=itemModel;
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNMerchantItemMeModel *itemModel=self.modelArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(inMeStoreImgTextAction:)]) {
        [self.delegate inMeStoreImgTextAction:itemModel];
    }
}
#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWith=(FNDeviceWidth-20)/4;
    CGFloat itemHeight=89;
    CGSize  size=CGSizeMake(itemWith, itemHeight);
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
    return 0;
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=0;
    CGFloat bottomGap=0;
    CGFloat rightGap=0;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
-(NSMutableArray *)modelArr{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

-(void)setModel:(FNMerchantMeModel *)model{
    _model=model;
    if(model){
        self.collectionview.sd_layout
        .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
        NSArray *listArr=model.list;
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        [listArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNMerchantItemMeModel *itemModel=[FNMerchantItemMeModel mj_objectWithKeyValues:obj];
            [arrM addObject:itemModel];
        }];
        self.modelArr=arrM;
        [self.collectionview reloadData];
    }
}

@end
