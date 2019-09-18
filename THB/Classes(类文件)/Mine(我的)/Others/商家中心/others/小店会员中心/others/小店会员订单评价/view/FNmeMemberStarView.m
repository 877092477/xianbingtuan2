//
//  FNmeMemberStarView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmeMemberStarView.h"

@implementation FNmeMemberStarView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setUpAllView{
    NSArray *arrM=@[
                    @{@"imgSeleted":@"FN_meMemberStarSeleted",@"imgNor":@"FN_meMemberStarNor",@"state":@"0",@"moId":@"0"}, @{@"imgSeleted":@"FN_meMemberStarSeleted",@"imgNor":@"FN_meMemberStarNor",@"state":@"0",@"moId":@"1"}, @{@"imgSeleted":@"FN_meMemberStarSeleted",@"imgNor":@"FN_meMemberStarNor",@"state":@"0",@"moId":@"2"}, @{@"imgSeleted":@"FN_meMemberStarSeleted",@"imgNor":@"FN_meMemberStarNor",@"state":@"0",@"moId":@"3"},@{@"imgSeleted":@"FN_meMemberStarSeleted",@"imgNor":@"FN_meMemberStarNor",@"state":@"0",@"moId":@"4"}];
    self.imgArr=[NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dictry in arrM) {
        FNmeMemberStarsModel *model=[FNmeMemberStarsModel mj_objectWithKeyValues:dictry];
        [self.imgArr addObject:model];
    }
    
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing = 0;
    flowayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth-20, 30) collectionViewLayout:flowayout];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.backgroundColor=[UIColor clearColor];
    [self addSubview: self.collectionview];
    [self.collectionview registerClass:[FNmeMemberStarItemsCell class] forCellWithReuseIdentifier:@"FNmeMemberStarItemsCellID"];
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    return self.imgArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNmeMemberStarItemsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmeMemberStarItemsCellID" forIndexPath:indexPath];
    cell.model=self.imgArr[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWith=30;
    CGFloat itemHeight=30;
    CGSize size=CGSizeMake(itemWith, itemHeight);
    return size;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 28;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNmeMemberStarsModel *model=self.imgArr[indexPath.row];
    NSInteger levale=0;
    NSInteger stateBo=0;
            if([model.state integerValue]==1){
                stateBo=0;
                levale=0;
            }else{
                stateBo=1;
                levale=indexPath.row+1;
            }
    [self.imgArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FNmeMemberStarsModel *itemModel=obj;
        if(idx<indexPath.row ||idx==indexPath.row){
            if(stateBo==1){
              itemModel.state=@"1";
            }
            if(stateBo==0){
                itemModel.state=@"0";
            }
        }else{
           itemModel.state=@"0";
        }
    }];
    
    [self.collectionview reloadData]; 
    
    if ([self.delegate respondsToSelector:@selector(didMeMemberStarViewLevel:)]) {
        [self.delegate didMeMemberStarViewLevel:levale];
    } 
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat spaceLR=(FNDeviceWidth-282)/2;
    CGFloat topGap=0;
    CGFloat leftGap=spaceLR;
    CGFloat bottomGap=0;
    CGFloat rightGap=spaceLR;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
-(void)setStarStr:(NSString *)starStr{
    _starStr=starStr;
    if([starStr kr_isNotEmpty]){
        NSInteger starInt=[starStr integerValue];
        [self.imgArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNmeMemberStarsModel *model=obj;
            if(idx<starInt){
                model.state=@"1";
            }else{
                model.state=@"0";
            }
        }];
        [self.collectionview reloadData];
    }
}
@end
