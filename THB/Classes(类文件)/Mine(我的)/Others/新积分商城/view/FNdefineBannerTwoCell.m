//
//  FNdefineBannerTwoCell.m
//  THB
//
//  Created by Jimmy on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//
//轮播图样式2  145
#import "FNdefineBannerTwoCell.h"

@implementation FNdefineBannerTwoCell
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
    //幻灯片模块
    _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 10, XYScreenWidth, 125) imageNamesGroup:self.bannerArray];
    _bannerView.backgroundColor = FNWhiteColor;
    _bannerView.placeholderImage = DEFAULT;
    _bannerView.delegate=self;
    _bannerView.autoScrollTimeInterval = 5;
    _bannerView.pageControlStyle=SDCycleScrollViewPageContolStyleAnimated;
    _bannerView.titleLabelTextFont=kFONT17;
    _bannerView.currentPageDotImage = [UIImage imageNamed:@"FJ_redPage_img"];
    _bannerView.pageDotImage = [UIImage imageNamed:@"FJ_grayPage_img"];
    _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    [self.contentView addSubview:_bannerView];
    
} 

- (void)setBannerArray:(NSArray *)bannerArray{
    _bannerArray = bannerArray;
    if (_bannerArray.count> 0) {
        _bannerView.autoScroll = _bannerArray.count >1;
        FNDefiniteListItemModel *model=[FNDefiniteListItemModel mj_objectWithKeyValues:bannerArray[0]];
        NSString *banner_speed=model.banner_speed;
        NSString *bannerBili=model.banner_bili;
        CGFloat bannerHight;
        if([bannerBili kr_isNotEmpty]){
            bannerHight=[bannerBili floatValue] *FNDeviceWidth;
        }else{
            bannerHight=125;
        }
        _bannerView.frame=CGRectMake(0, 10, XYScreenWidth, bannerHight);
        if([banner_speed kr_isNotEmpty]){
            CGFloat speedInt=[banner_speed floatValue]/1000;
            _bannerView.autoScrollTimeInterval = speedInt;
        }else{
            _bannerView.autoScrollTimeInterval = 5;
        }
        NSMutableArray* images = [NSMutableArray new];
        for (NSDictionary *dict in bannerArray) {
            FNDefiniteListItemModel *huandengpianModel=[FNDefiniteListItemModel mj_objectWithKeyValues:dict];
            [images addObject:huandengpianModel.img];
        }
        _bannerView.imageURLStringsGroup = images;
    }
    
}



#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    FNDefiniteListItemModel *huandengpianModel=[FNDefiniteListItemModel mj_objectWithKeyValues:self.bannerArray[index]]; 
    if ([self.delegate respondsToSelector:@selector(seletedBannerTwoClick:)]) {
        [self.delegate seletedBannerTwoClick:huandengpianModel];
    }
}
@end
