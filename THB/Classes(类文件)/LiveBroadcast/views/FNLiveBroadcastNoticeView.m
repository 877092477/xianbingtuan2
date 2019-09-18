//
//  FNLiveBroadcastNoticeView.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveBroadcastNoticeView.h"

@interface FNLiveBroadcastNoticeView()

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIImageView *imgLeft;

@end

@implementation FNLiveBroadcastNoticeView

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
    _imgLeft = [[UIImageView alloc] init];
    _lblLeft = [[UILabel alloc] init];
    _lblRight = [[UILabel alloc] init];
    
    [self addSubview:_vBackground];
    [self addSubview:_imgLeft];
    [self addSubview:_lblLeft];
    [self addSubview:_lblRight];
    
    [_vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.height.mas_equalTo(24);
    }];
    [_imgLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.bottom.equalTo(@0);
    }];
    [_lblLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgLeft).offset(13);
        make.right.equalTo(self.imgLeft).offset(-11);
        make.centerY.equalTo(self.imgLeft);
    }];
    [_lblRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgLeft.mas_right).offset(4);
        make.right.equalTo(self.vBackground.mas_right).offset(-18);
        make.centerY.equalTo(@0);
    }];
    
//    UIView *view = [[UIView alloc] init];
//    view.frame = CGRectMake(43,84,50,25);
//    view.backgroundColor = [UIColor colorWithRed:254/255.0 green:53/255.0 blue:33/255.0 alpha:1.0];
//
//    CAGradientLayer *gl = [CAGradientLayer layer];
//    gl.frame = CGRectMake(43,84,50,25);
//    gl.startPoint = CGPointMake(0, 0);
//    gl.endPoint = CGPointMake(1, 1);
//    gl.colors = @[(__bridge id)[UIColor colorWithRed:253/255.0 green:37/255.0 blue:15/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:255/255.0 green:108/255.0 blue:43/255.0 alpha:1.0].CGColor];
//    gl.locations = @[@(0.0),@(1.0)];
//
//    [_imgLeft.layer addSublayer:gl];
//    view.layer.cornerRadius = 12.5;
    
    _imgLeft.image = IMAGE(@"live_broadcast_notice_image_left");
    
    _lblLeft.text = @"公告";
    _lblLeft.font = kFONT14;
    _lblLeft.textColor = UIColor.whiteColor;
    
    _lblRight.text = @"";
    _lblRight.font = kFONT12;
    _lblRight.textColor = UIColor.whiteColor;
    
    _vBackground.backgroundColor = RGBA(51, 51, 51, 0.4);
    _vBackground.cornerRadius = 12;
}

@end
