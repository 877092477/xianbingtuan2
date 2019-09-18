//
//  FNCommodityActivityItemACell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCommodityActivityItemACell.h"

@implementation FNCommodityActivityItemACell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNCommodityActivityItemACellID";
    FNCommodityActivityItemACell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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
    
    self.bgImgView=[[UIImageView alloc]init];
    self.bgImgView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.bgImgView];
    self.bgImgView.borderWidth=1.5;
    self.bgImgView.borderColor = RGB(250, 242, 242);
    //self.bgImgView.cornerRadius=10;
    self.bgImgView.clipsToBounds = YES;
    
//    self.topImgView=[[UIImageView alloc]init];
//    self.topImgView.backgroundColor=RGB(250, 250, 250);
//    [self.contentView addSubview:self.topImgView];
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0);
//    self.topImgView.sd_layout
//    .leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 5).heightIs(110).rightSpaceToView(self.contentView, 0);
    
    
    self.bgImgView.frame=CGRectMake(15, 0, FNDeviceWidth-15, 240);//340
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bgImgView.bounds byRoundingCorners: UIRectCornerBottomLeft cornerRadii:CGSizeMake(15, 15)];//UIRectCornerTopLeft
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bgImgView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.bgImgView.layer.mask = maskLayer;
    
    //[self.topImgView addTarget:self action:@selector(topImgViewMore)];
    
    self.pagerView = [[TYCyclePagerView alloc]init];
    self.pagerView.isInfiniteLoop = NO;
    self.pagerView.autoScrollInterval = 0;
    self.pagerView.dataSource = self;
    self.pagerView.delegate = self;
    self.pagerView.frame=CGRectMake(25, 15, FNDeviceWidth-25, 200);
    [self.pagerView registerClass:[FNCommActivityItemHACell class] forCellWithReuseIdentifier:@"FNCommActivityItemHACellID"];
    [self.contentView addSubview:self.pagerView];
    
    self.pagerView.sd_layout
    .leftSpaceToView(self.contentView, 25).topSpaceToView(self.contentView, 15).heightIs(200).rightSpaceToView(self.contentView, 0);
    
    [self.pagerView reloadData];
}
-(void)topImgViewMore{
        if ([self.delegate respondsToSelector:@selector(didCommodityActivityItemMoreAction:)]) {
            [self.delegate didCommodityActivityItemMoreAction:self.indexS];
        }
}
#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    
    return self.dataArr.count;
}
- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index { 
    FNBaseProductModel *model=[FNBaseProductModel mj_objectWithKeyValues:self.dataArr[index]];
    FNCommActivityItemHACell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"FNCommActivityItemHACellID" forIndex:index];
    cell.model=model;
    return cell;
} 
- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    //layout.itemSize = CGSizeMake(XYScreenWidth-24, 170);
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(115, 200);
    layout.itemSpacing = 5;//12
    layout.sectionInset=UIEdgeInsetsMake(0, 5, 0, 0);
    return layout;
    
}
- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index{
    XYLog(@"点击:%ld",(long)index);
    FNBaseProductModel *model=[FNBaseProductModel mj_objectWithKeyValues:self.dataArr[index]];
        if ([self.delegate respondsToSelector:@selector(didCommodityActivityItemGoodsAction:)]) {
            [self.delegate didCommodityActivityItemGoodsAction:model];
        }
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr.count>0){
        [self.pagerView reloadData];
    }
}
@end
