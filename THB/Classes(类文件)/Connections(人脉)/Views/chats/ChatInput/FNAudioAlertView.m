//
//  FNAudioAlertView.m
//  THB
//
//  Created by Weller Zhao on 2019/2/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNAudioAlertView.h"

@interface FNAudioAlertView()

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UIView *vTitle;
@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation FNAudioAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vBackground = [[UIView alloc] init];
    _imgIcon = [[UIImageView alloc] init];
    _vTitle = [[UIView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    
    [self addSubview:_vBackground];
    [_vBackground addSubview:_imgIcon];
    [_vBackground addSubview:_vTitle];
    [_vTitle addSubview:_lblTitle];
    
    [_vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.height.mas_equalTo(150);
    }];
    [_imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@20);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@20);
        
    }];
    [_vTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-10);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(24);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@8);
        make.right.lessThanOrEqualTo(@8);
        make.center.equalTo(@0);
    }];
    
    _vBackground.backgroundColor = RGBA(0, 0, 0, 0.5);
    _vBackground.cornerRadius = 4;
    
    
    _imgIcon.contentMode = UIViewContentModeScaleAspectFit;
    
    _vTitle.cornerRadius = 4;
    
    _lblTitle.font = kFONT12;
    _lblTitle.textColor = UIColor.whiteColor;
    _lblTitle.textAlignment = NSTextAlignmentCenter;
}

- (void)setVoiceWithLevel: (int)level {
    level = level > 6 ? 6 : level;
    level = level < 1 ? 1 : level;
    _imgIcon.image = [UIImage imageNamed:[NSString stringWithFormat: @"connection_voice_alert_%d", level]];
    _lblTitle.text = @"手指上滑，取消发送";
    _vTitle.backgroundColor = UIColor.clearColor;
}

- (void)setRelease {
    _imgIcon.image = IMAGE(@"connection_voice_alert_release");
    _vTitle.backgroundColor = RGB(131, 61, 54);
    _lblTitle.text = @"松开手指，取消发送";
}

@end
