//
//  FNmerchantOrderListView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerchantOrderListView.h"

@implementation FNmerchantOrderListView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setUpAllView{
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing = 0; 
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth-20, 10) collectionViewLayout:flowayout];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.backgroundColor=[UIColor clearColor];
    [self addSubview: self.collectionview];
    [self.collectionview registerClass:[FNmerchantOrderItemCell class] forCellWithReuseIdentifier:@"FNmerchantOrderItemCellID"];
    [self.collectionview registerClass:[FNmerchantYjkbItemCell class] forCellWithReuseIdentifier:@"FNmerchantYjkbItemCellID"];
    [self.collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellWu"];
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelArr.count;;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    FNMerchantItemMeModel *itemModel=self.modelArr[indexPath.row];
    if([self.model.type isEqualToString:@"store_order"]){
        FNmerchantOrderItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerchantOrderItemCellID" forIndexPath:indexPath];
        //cell.backgroundColor=[UIColor whiteColor];
        cell.daModel=itemModel;
        return cell;
    }else if([self.model.type isEqualToString:@"store_yjkb"]){
        FNmerchantYjkbItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerchantYjkbItemCellID" forIndexPath:indexPath];
        //cell.backgroundColor=[UIColor whiteColor];
        cell.daModel=itemModel;
        return cell;
    }else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellWu" forIndexPath:indexPath];
        return cell;
    }
}

#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWith=(FNDeviceWidth-20)/2;
    CGFloat itemHeight=0;
    if([self.model.type isEqualToString:@"store_order"]){
        itemWith=FNDeviceWidth-20;
        itemHeight=60;
    }else if([self.model.type isEqualToString:@"store_yjkb"]){
        itemWith=(FNDeviceWidth-20)/2-5;
        itemHeight=100;
    }
    CGSize  size=CGSizeMake(itemWith, itemHeight);
    return  size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNMerchantItemMeModel *itemModel=self.modelArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(inMerchantOrderListAction:isType:)]) { 
        [self.delegate inMerchantOrderListAction:itemModel isType:self.model.type];
    }
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
        NSArray *listArr=model.list;
        CGFloat listItemHeight=0;
        CGFloat listHeight=0;
        if([model.type isEqualToString:@"store_order"]){
            listItemHeight=60;
            listHeight=listItemHeight*listArr.count;
        }else if([model.type isEqualToString:@"store_yjkb"]){
            listItemHeight=100;
            CGFloat row=listArr.count;
            CGFloat coFloat=row/2;
            CGFloat secInt=ceil(coFloat);
            listHeight=listItemHeight*secInt;
        }
        self.collectionview.frame=CGRectMake(0, 0, FNDeviceWidth-20, listHeight);
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
