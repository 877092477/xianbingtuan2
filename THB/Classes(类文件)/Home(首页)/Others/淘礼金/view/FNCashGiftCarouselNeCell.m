//
//  FNCashGiftCarouselNeCell.m
//  THB
//
//  Created by 李显 on 2018/10/15.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNCashGiftCarouselNeCell.h"

@implementation FNCashGiftCarouselNeCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"CashGiftCarouselCellId";
    FNCashGiftCarouselNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    return cell;
}
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, XYScreenWidth, 200) imageNamesGroup:self.bannerArray];
    _bannerView.backgroundColor = FNWhiteColor;
    _bannerView.placeholderImage = DEFAULT;
    _bannerView.delegate=self;
    _bannerView.autoScrollTimeInterval = 5;
    _bannerView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _bannerView.titleLabelTextFont=kFONT17;
    [self.contentView addSubview:_bannerView];
}
- (void)setBannerArray:(NSArray *)bannerArray{
    _bannerArray = bannerArray;
    if (_bannerArray.count> 0) {
        _bannerView.autoScroll = _bannerArray.count >1;
        NSMutableArray* images = [NSMutableArray new];
        for (NSDictionary *dictry in bannerArray) {
            FNGiftSeekHeNeModel *huandengpianModel=[FNGiftSeekHeNeModel mj_objectWithKeyValues:dictry];
            [images addObject:huandengpianModel.img];
        }
        _bannerView.imageURLStringsGroup = images;
    }
}
#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{ 
    if ([self.delegate respondsToSelector:@selector(CashGiftCarouselClickAction:)]) {
        [self.delegate CashGiftCarouselClickAction:index];
    }
}
@end
