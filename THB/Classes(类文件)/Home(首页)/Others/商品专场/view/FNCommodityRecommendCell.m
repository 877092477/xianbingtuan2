//
//  FNCommodityRecommendCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCommodityRecommendCell.h"


@implementation FNCommodityRecommendCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNCommodityRecommendCellID";
    FNCommodityRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews{
 
    self.titleLB=[[UILabel alloc]init];
    [self.contentView addSubview:self.titleLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:18];
    self.titleLB.textColor=[UIColor whiteColor];
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.contentView, 12).rightSpaceToView(self.contentView, 12).heightIs(47).topSpaceToView(self.contentView, 0);
    
    self.pagerView = [[TYCyclePagerView alloc]init];
    self.pagerView.isInfiniteLoop = YES;
    self.pagerView.autoScrollInterval = 5;
    self.pagerView.dataSource = self;
    self.pagerView.delegate = self;
    self.pagerView.frame=CGRectMake(0, 47, FNDeviceWidth, 175);
    [self.pagerView registerClass:[FNCommodityLRslideItemCell class] forCellWithReuseIdentifier:@"FNCommodityLRslideItemCellID"];
    [self.contentView addSubview:self.pagerView];
    
    [self.pagerView reloadData]; 
}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    
    return self.dataArr.count;
}
- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    
    FNBaseProductModel *model=[FNBaseProductModel mj_objectWithKeyValues:self.dataArr[index]];
    FNCommodityLRslideItemCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"FNCommodityLRslideItemCellID" forIndex:index];
    cell.cornerRadius=0;
    cell.model=model;
    cell.sharerightNow = ^(FNBaseProductModel *mod) {
        if ([self.delegate respondsToSelector:@selector(didCommodityRecommendShareGoodsAction:)]) {
            [self.delegate didCommodityRecommendShareGoodsAction:mod];
        } 
    };
    return cell; 
}
- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    //layout.itemSize = CGSizeMake(XYScreenWidth-24, 170);
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(FNDeviceWidth-24, 175);
    layout.itemSpacing = 12;//12
    return layout; 
}
- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index{
    XYLog(@"点击:%ld",(long)index);
    FNBaseProductModel *model=[FNBaseProductModel mj_objectWithKeyValues:self.dataArr[index]];
    if ([self.delegate respondsToSelector:@selector(didCommodityRecommendItemAction:)]) {
        [self.delegate didCommodityRecommendItemAction:model];
    }
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr.count>0){
       [self.pagerView reloadData];
    }
}
@end
