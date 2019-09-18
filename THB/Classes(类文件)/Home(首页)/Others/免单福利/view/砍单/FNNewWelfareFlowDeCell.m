//
//  FNNewWelfareFlowDeCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNNewWelfareFlowDeCell.h"
#import "SDCycleScrollView/SDCycleScrollView.h"

@interface FNNewWelfareFlowDeCell()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIView *vBanner;
@property (nonatomic, strong) SDCycleScrollView *bannerView;

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIImageView *vContent;

@property (nonatomic, strong) UIView *vHeader2;
@property (nonatomic, strong) UIImageView *imgHeader2;
@property (nonatomic, strong) UIView *line2;

@end

@implementation FNNewWelfareFlowDeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vBanner = [[UIView alloc] init];
    _vBackground = [[UIView alloc] init];
    _imgHeader = [[UIImageView alloc] init];
    _line = [[UIView alloc] init];
    _vContent = [[UIImageView alloc] init];
    
    _vHeader2 = [[UIView alloc] init];
    _imgHeader2 = [[UIImageView alloc] init];
    _line2 = [[UIView alloc] init];
    
    [self.contentView addSubview:_vBanner];
    [self.contentView addSubview: _vBackground];
    [_vBackground addSubview: _imgHeader];
    [_vBackground addSubview: _line];
    [_vBackground addSubview: _vContent];
    
    [self.contentView addSubview:_vHeader2];
    [_vHeader2 addSubview: _imgHeader2];
    [_vHeader2 addSubview: _line2];
    
    [_vBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.width.mas_equalTo(XYScreenWidth);
        make.height.mas_equalTo(0);
    }];
    
    [_vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vBanner.mas_bottom).offset(10);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.bottom.equalTo(self.vHeader2.mas_top).offset(-10);
    }];
    
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@10);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(24);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(self.imgHeader.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.right.equalTo(@-17);
        make.top.equalTo(self.line.mas_bottom).offset(10);
        make.bottom.equalTo(@-10);
    }];
    
    [_vHeader2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(44);
    }];
    [_imgHeader2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@10);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(24);
    }];
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.bottom.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    
    _vBackground.backgroundColor = UIColor.whiteColor;
    _vBackground.cornerRadius = 5;
    _vHeader2.backgroundColor = UIColor.whiteColor;
    
    _line.backgroundColor = RGB(243, 243, 243);
    _line2.backgroundColor = RGB(243, 243, 243);
    
    _imgHeader.contentMode = UIViewContentModeScaleAspectFit;
    _vContent.contentMode = UIViewContentModeScaleAspectFit;
    _imgHeader2.contentMode = UIViewContentModeScaleAspectFit;
}


- (void)setTitle: (NSString*)titleUrl andImage: (NSString*)flowImage title2: (NSString*)titleUrl2 {
    [_imgHeader sd_setImageWithURL:URL(titleUrl)];
    [_vContent sd_setImageWithURL:URL(flowImage)];
    [_imgHeader2 sd_setImageWithURL:URL(titleUrl2)];
}

- (void)setBanners: (NSArray<UIImage*>*)images {
    if (images.count > 0) {
        CGFloat height = (XYScreenWidth / images[0].size.width * images[0].size.height);
        [_vBanner mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
        
        if (_bannerView) {
            [_bannerView removeFromSuperview];
        }
        //幻灯片模块
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, XYScreenWidth, height) imageNamesGroup:images];
        _bannerView.backgroundColor = FNWhiteColor;
        _bannerView.placeholderImage = DEFAULT;
        _bannerView.delegate=self;
        _bannerView.autoScrollTimeInterval = 10;
        _bannerView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
        _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _bannerView.titleLabelTextFont=kFONT17;
        [_vBanner addSubview:_bannerView];
    }
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if ([_delegate respondsToSelector:@selector(didItemSelectedAt:)]) {
        [_delegate didItemSelectedAt:index];
    }
}

@end
