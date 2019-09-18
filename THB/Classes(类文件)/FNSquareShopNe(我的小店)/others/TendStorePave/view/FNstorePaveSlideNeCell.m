//
//  FNstorePaveSlideNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/11/22.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNstorePaveSlideNeCell.h"

@implementation FNstorePaveSlideNeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.bannerArray = [NSArray new];
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews
{
    //幻灯片模块 FNDeviceWidth*0.52
    _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, XYScreenWidth, 200) imageNamesGroup:self.bannerArray];
    _bannerView.backgroundColor = FNWhiteColor;
    _bannerView.placeholderImage = DEFAULT;
    _bannerView.delegate=self;
    _bannerView.autoScrollTimeInterval = 5;
    _bannerView.pageControlStyle=SDCycleScrollViewPageContolStyleNone;
    _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _bannerView.titleLabelTextFont=kFONT17;
    [self.contentView addSubview:_bannerView];
    
}


- (void)setBannerArray:(NSArray *)bannerArray{
    _bannerArray = bannerArray;
    if (_bannerArray.count> 0) {
        _bannerView.autoScroll = _bannerArray.count >1; 
        NSMutableArray* images = [NSMutableArray new];
        for (NSString *imageString in bannerArray) {
            [images addObject:imageString];
        }
        _bannerView.imageURLStringsGroup = images;
    }
    
}



#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(storePaveSlideClickAction:)]) {
        [self.delegate storePaveSlideClickAction:index];
    }
}
@end
