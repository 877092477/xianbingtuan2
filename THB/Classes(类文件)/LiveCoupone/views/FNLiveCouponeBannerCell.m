//
//  FNLiveCouponeBannerCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveCouponeBannerCell.h"

@interface FNLiveCouponeBannerCell()<SDCycleScrollViewDelegate>

#pragma mark- Array
@property (nonatomic, strong)NSArray* bannerArray;

@end

@implementation FNLiveCouponeBannerCell
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
    //    //幻灯片模块
    //    _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, XYScreenWidth, FNDeviceWidth*0.52) imageNamesGroup:self.bannerArray];
    //    _bannerView.backgroundColor = FNWhiteColor;
    //    _bannerView.placeholderImage = DEFAULT;
    //    _bannerView.delegate=self;
    //    _bannerView.autoScrollTimeInterval = 5;
    //    _bannerView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    //    _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    //    _bannerView.titleLabelTextFont=kFONT17;
    //    [self.contentView addSubview:_bannerView];
    self.contentView.layer.masksToBounds = YES;
}

- (void)setBannerArray:(NSArray *)bannerArray withHeight: (CGFloat)height speed: (CGFloat)speed{
    
    if (_bannerView) {
        [_bannerView removeFromSuperview];
    }
    
    //幻灯片模块
    _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, XYScreenWidth, height) imageNamesGroup:self.bannerArray];
    _bannerView.backgroundColor = FNWhiteColor;
//    _bannerView.placeholderImage = DEFAULT;
    _bannerView.delegate=self;
    _bannerView.autoScrollTimeInterval = 5;
    _bannerView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _bannerView.titleLabelTextFont=kFONT17;
    [self.contentView addSubview:_bannerView];
    
    _bannerArray = bannerArray;
    if (_bannerArray.count> 0) {
        _bannerView.autoScroll = _bannerArray.count >1;
        
        _bannerView.frame=CGRectMake(0, 0, XYScreenWidth, height);

        _bannerView.autoScrollTimeInterval = speed/1000;
        
        NSMutableArray* images = [NSMutableArray new];
        for (NSDictionary *dict in bannerArray) {
            Index_huandengpian_01Model *huandengpianModel=[Index_huandengpian_01Model mj_objectWithKeyValues:dict];
            [images addObject:huandengpianModel.img];
        }
        _bannerView.imageURLStringsGroup = images;
    }
    
}

-(void)setModel:(Index_huandengpian_01Model *)model{
    
}

#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (self.BannerClickedBlock) {
        self.BannerClickedBlock(index);
    }
}

@end
