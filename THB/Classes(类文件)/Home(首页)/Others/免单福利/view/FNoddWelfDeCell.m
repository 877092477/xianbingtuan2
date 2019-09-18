//
//  FNoddWelfDeCell.m
//  THB
//
//  Created by Jimmy on 2018/12/18.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//幻灯片 0.52
#import "FNoddWelfDeCell.h"

@implementation FNoddWelfDeCell
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
    _bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_bannerView];
    
}


- (void)setBannerArray:(NSArray *)bannerArray{
    _bannerArray = bannerArray;
    if (_bannerArray.count> 0) {
        _bannerView.autoScroll = _bannerArray.count >1;
        FNwelfDeListItemModel *model=[FNwelfDeListItemModel mj_objectWithKeyValues:bannerArray[0]];
        NSString *banner_speed=model.banner_speed;
        NSString *bannerBili=model.banner_bili;
        CGFloat bannerHight;
        if([bannerBili kr_isNotEmpty]){
            bannerHight=[bannerBili floatValue] *FNDeviceWidth;
        }else{
            bannerHight=0.52 *FNDeviceWidth;
        }
        _bannerView.frame=CGRectMake(0, 0, XYScreenWidth, bannerHight);
        if([banner_speed kr_isNotEmpty]){
            CGFloat speedInt=[banner_speed floatValue]/1000;
            _bannerView.autoScrollTimeInterval = speedInt;
        }else{
            _bannerView.autoScrollTimeInterval = 5;
        }
        NSMutableArray* images = [NSMutableArray new];
        for (NSDictionary *dict in bannerArray) {
            FNwelfDeListItemModel *huandengpianModel=[FNwelfDeListItemModel mj_objectWithKeyValues:dict];
            [images addObject:huandengpianModel.img];
        }
        _bannerView.imageURLStringsGroup = images;
    }
    [_bannerView setHidden: bannerArray.count == 0];
}

 

#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    FNwelfDeListItemModel *huandengpianModel=[FNwelfDeListItemModel mj_objectWithKeyValues:self.bannerArray[index]];  
    
    if ([self.delegate respondsToSelector:@selector(oddWelfBannerClick:)]) {
        [self.delegate oddWelfBannerClick:huandengpianModel];
    }
}
@end
