//
//  FNmeStoreIncomeView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmeStoreIncomeView.h"

@implementation FNmeStoreIncomeView

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
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth-20, 41) collectionViewLayout:flowayout];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.backgroundColor=[UIColor clearColor];
    [self addSubview: self.collectionview];
    [self.collectionview registerClass:[FNmeStoreInTextItemCell class] forCellWithReuseIdentifier:@"FNmeStoreInTextItemCellID"];
    //[self.collectionview registerClass:[FNmerchantIconItemCell class] forCellWithReuseIdentifier:@"FNmerchantIconItemCellID"];
    [self.collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellnil"];
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelArr.count;;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNMerchantItemMeModel *itemModel=self.modelArr[indexPath.row];
    if([self.model.type isEqualToString:@"store_income"]){
        FNmeStoreInTextItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmeStoreInTextItemCellID" forIndexPath:indexPath];
        cell.daModel=itemModel;
        return cell;
    }
    //else if([self.model.type isEqualToString:@"member_mem_ico"]){
    //    FNmerchantIconItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerchantIconItemCellID" forIndexPath:indexPath];
    //    cell.daModel=itemModel;
    //    return cell;
    //}
    else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellnil" forIndexPath:indexPath];
        return cell;
    }
} 
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNMerchantItemMeModel *itemModel=self.modelArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(inMeStoreIncomeAction:isType:)]) {
        [self.delegate inMeStoreIncomeAction:itemModel isType:self.model.type];
    }
}
#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWith=(FNDeviceWidth-20)/3;
    CGFloat itemHeight=0;
    if([self.model.type isEqualToString:@"store_income"]){
        itemHeight=41;
    }
    //else if([self.model.type isEqualToString:@"member_mem_ico"]){
    //    itemHeight=89;
    //}
    CGSize  size=CGSizeMake(itemWith, itemHeight);
    return size;
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
            if([model.type isEqualToString:@"store_income"]){
               self.collectionview.frame=CGRectMake(0, 15, FNDeviceWidth-20, 40);
            }
            //else if([model.type isEqualToString:@"member_mem_ico"]){
            //   self.collectionview.frame=CGRectMake(0, 0, FNDeviceWidth-20, 89);
            //}
            NSArray *listArr=model.list;
            NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
            [listArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNMerchantItemMeModel *itemModel=[FNMerchantItemMeModel mj_objectWithKeyValues:obj];
                    if(idx==listArr.count-1){
                       itemModel.lineState=YES;
                    }else{
                       itemModel.lineState=NO;
                    }
                [arrM addObject:itemModel];
            }];
            self.modelArr=arrM;
            [self.collectionview reloadData];
    }
}
@end
