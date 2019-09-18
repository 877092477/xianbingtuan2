//
//  FNBannerViewCell.m
//  THB
//
//  Created by zhongxueyu on 2018/8/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNBannerViewCell.h"

@implementation FNBannerViewCell
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
    _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, XYScreenWidth, FNDeviceWidth*0.52) imageNamesGroup:self.bannerArray];
    _bannerView.backgroundColor = FNWhiteColor;
    _bannerView.placeholderImage = DEFAULT;
    _bannerView.delegate=self;
    _bannerView.autoScrollTimeInterval = 5;
    _bannerView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _bannerView.titleLabelTextFont=kFONT17;
    [self.contentView addSubview:_bannerView];
    
    self.bannerView.sd_layout
    .leftEqualToView(self.contentView).bottomEqualToView(self.contentView).rightEqualToView(self.contentView).topEqualToView(self.contentView);
}


- (void)setBannerArray:(NSArray *)bannerArray{
    _bannerArray = bannerArray;
    if (_bannerArray.count> 0) {
        _bannerView.autoScroll = _bannerArray.count >1;
        NSString *banner_speed=[bannerArray[0] valueForKey:@"banner_speed"];
        NSString *bannerBili=[bannerArray[0] valueForKey:@"banner_bili"];
        CGFloat bannerHight;
        if([bannerBili kr_isNotEmpty]){
           bannerHight=[bannerBili floatValue] *FNDeviceWidth;
        }else{
           bannerHight=0.52 *FNDeviceWidth;
        } 
        _bannerView.frame=CGRectMake(0, 0, XYScreenWidth, bannerHight);
        self.bannerView.sd_layout
        .leftEqualToView(self.contentView).bottomEqualToView(self.contentView).rightEqualToView(self.contentView).topEqualToView(self.contentView);
        if([banner_speed kr_isNotEmpty]){
            CGFloat speedInt=[banner_speed floatValue]/1000;
            _bannerView.autoScrollTimeInterval = speedInt;
        }else{
            _bannerView.autoScrollTimeInterval = 5;
        }
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
