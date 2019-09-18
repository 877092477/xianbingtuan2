//
//  FNCommSortHFView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCommSortHFView.h"

@implementation FNCommSortHFView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setUpAllView{
    
    self.pagerView = [[TYCyclePagerView alloc]init];
    self.pagerView.isInfiniteLoop = NO;
    self.pagerView.autoScrollInterval = 0;
    self.pagerView.dataSource = self;
    self.pagerView.delegate = self;
    self.pagerView.frame=CGRectMake(0, 0, FNDeviceWidth, 105);
    [self.pagerView registerClass:[FNCommSortHFitemCell class] forCellWithReuseIdentifier:@"FNCommSortHFitemCellID"];
    [self addSubview:self.pagerView];
    
    [self.pagerView reloadData];
    
}
#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    
    return self.dataArr.count;
}
- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    
    FNCommoditySortItemModel *model=self.dataArr[index];
    FNCommSortHFitemCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"FNCommSortHFitemCellID" forIndex:index];
    cell.model=model;
    return cell;
    
}
- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
     
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(120, 105);
    layout.itemSpacing = 7;//12
    layout.sectionInset=UIEdgeInsetsMake(0, 15, 0, 0);
    return layout;
    
}
- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index{
    XYLog(@"点击:%ld",(long)index);
    FNCommoditySortItemModel *model=self.dataArr[index];
    for (FNCommoditySortItemModel *itemModel in self.dataArr) {
        if(itemModel.sortid== model.sortid){
           itemModel.state=1;
        }else{
           itemModel.state=0;
        }
    }
    [self.pagerView reloadData];
    if ([self.delegate respondsToSelector:@selector(didCommSortHFViewDelegateItemAction:)]) {
        [self.delegate didCommSortHFViewDelegateItemAction:index];
    }
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr){
        [self.pagerView reloadData];
    }
}


@end
