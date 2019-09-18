//
//  FNshopTendSlideNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/11/21.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNshopTendSlideNeCell.h"

@implementation FNshopTendSlideNeCell
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
    self.backgroundColor = UIColor.whiteColor;
    
    //幻灯片模块 FNDeviceWidth*0.52
    _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 0, XYScreenWidth-20, 157) imageNamesGroup:self.bannerArray];
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
        NSString *banner_speed=[bannerArray[0] valueForKey:@"banner_speed"];
        NSString *bannerBili=[bannerArray[0] valueForKey:@"banner_bili"];
        CGFloat bannerHight;
        if([bannerBili kr_isNotEmpty]){
            bannerHight=[bannerBili floatValue] *FNDeviceWidth;
        }else{
            bannerHight=0.52 *FNDeviceWidth;
        }
        bannerHight=157;
        _bannerView.frame=CGRectMake(10, 0, XYScreenWidth-20, bannerHight);
        if([banner_speed kr_isNotEmpty]){
            CGFloat speedInt=[banner_speed floatValue]/1000;
            _bannerView.autoScrollTimeInterval = speedInt;
        }else{
            _bannerView.autoScrollTimeInterval = 5;
        }
        NSMutableArray* images = [NSMutableArray new];
        for (NSDictionary *dict in bannerArray) {
            //Index_huandengpian_01Model *huandengpianModel=[Index_huandengpian_01Model mj_objectWithKeyValues:dict];
            //[images addObject:huandengpianModel.img];
            [images addObject:dict[@"img"]];
        }
        _bannerView.imageURLStringsGroup = images;
    }
    
}



#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(tendSlideClickAction:)]) {
        [self.delegate tendSlideClickAction:index];
    }
}
@end
