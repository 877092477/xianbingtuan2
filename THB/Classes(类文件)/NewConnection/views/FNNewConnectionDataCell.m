//
//  FNNewConnectionDataCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/6/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNNewConnectionDataCell.h"

@interface FNNewConnectionDataCell()

@property (nonatomic, strong) UIView *vBackground;

@property (nonatomic, strong) UIView *vTopLeft;
@property (nonatomic, strong) UIView *vTopRight;

@property (nonatomic, strong) UIView *vBottomLeft;
@property (nonatomic, strong) UIView *vBottomCenter;
@property (nonatomic, strong) UIView *vBottomRight;

@property (nonatomic, strong) UIView *vLine1;
@property (nonatomic, strong) UIView *vLine2;
@property (nonatomic, strong) UIView *vLine3;

@end

@implementation FNNewConnectionDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vBackground = [[UIView alloc] init];
    _imgBackground = [[UIImageView alloc] init];
    _vTopLeft = [[UIView alloc] init];
    _vTopRight = [[UIView alloc] init];
    _vBottomLeft = [[UIView alloc] init];
    _vBottomCenter = [[UIView alloc] init];
    _vBottomRight = [[UIView alloc] init];
    _lblLeftTopTitle = [[UILabel alloc] init];
    _imgLeftTopTitle = [[UIImageView alloc] init];
    _lblLeftTopValue = [[UILabel alloc] init];
    _imgLeftTopValue = [[UIImageView alloc] init];
    _lblRightTopTitle = [[UILabel alloc] init];
    _imgRightTopTitle = [[UIImageView alloc] init];
    _lblRightTopValue = [[UILabel alloc] init];
    _imgRightTopValue = [[UIImageView alloc] init];
    _lblLeftBottomTitle = [[UILabel alloc] init];
    _lblLeftBottomValue = [[UILabel alloc] init];
    _lblCenterBottomTitle = [[UILabel alloc] init];
    _lblCenterBottomValue = [[UILabel alloc] init];
    _lblRightBottomTitle = [[UILabel alloc] init];
    _lblRightBottomValue = [[UILabel alloc] init];
    _vLine1 = [[UIView alloc] init];
    _vLine2 = [[UIView alloc] init];
    _vLine3 = [[UIView alloc] init];
    
    [self.contentView addSubview: _vBackground];
    [_vBackground addSubview: _imgBackground];
    [_vBackground addSubview: _vTopLeft];
    [_vBackground addSubview: _vTopRight];
    [_vBackground addSubview: _vBottomLeft];
    [_vBackground addSubview: _vBottomCenter];
    [_vBackground addSubview: _vBottomRight];
    
    [_vTopLeft addSubview: _lblLeftTopTitle];
    [_vTopLeft addSubview: _imgLeftTopTitle];
    [_vTopLeft addSubview: _lblLeftTopValue];
    [_vTopLeft addSubview: _imgLeftTopValue];
    [_vTopRight addSubview: _lblRightTopTitle];
    [_vTopRight addSubview: _imgRightTopTitle];
    [_vTopRight addSubview: _lblRightTopValue];
    [_vTopRight addSubview: _imgRightTopValue];
    [_vBottomLeft addSubview: _lblLeftBottomTitle];
    [_vBottomLeft addSubview: _lblLeftBottomValue];
    [_vBottomCenter addSubview: _lblCenterBottomTitle];
    [_vBottomCenter addSubview: _lblCenterBottomValue];
    [_vBottomRight addSubview: _lblRightBottomTitle];
    [_vBottomRight addSubview: _lblRightBottomValue];
    
    [_vBackground addSubview: _vLine1];
    [_vBackground addSubview: _vLine2];
    [_vBackground addSubview: _vLine3];
    
    [_vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_equalTo(150);
    }];
    [_imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_vTopLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0);
        make.right.equalTo(self.vBackground.mas_centerX);
        make.height.mas_equalTo(90);
    }];
    [_vTopRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(@0);
        make.left.equalTo(self.vBackground.mas_centerX);
        make.height.mas_equalTo(90);
    }];
    [_vBottomLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(@0);
        make.top.equalTo(self.vTopLeft.mas_bottom);
    }];
    [_vBottomCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.width.equalTo(self.vBottomLeft);
        make.left.equalTo(self.vBottomLeft.mas_right);
    }];
    [_vBottomRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.width.equalTo(self.vBottomLeft);
        make.left.equalTo(self.vBottomCenter.mas_right);
        make.right.equalTo(@0);
    }];
    [_lblLeftTopTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@20);
        make.top.equalTo(@18);
        make.right.lessThanOrEqualTo(@-10);
        make.height.mas_equalTo(@14);
    }];
    [_imgLeftTopTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lblLeftTopTitle.mas_left).offset(0);
        make.centerY.equalTo(self.lblLeftTopTitle);
        make.left.greaterThanOrEqualTo(@10);
        make.width.height.mas_equalTo(20);
    }];
    [_lblLeftTopValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@50);
        make.left.greaterThanOrEqualTo(@10);
        make.height.mas_equalTo(@14);
    }];
    [_imgLeftTopValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblLeftTopValue.mas_right).offset(2);
        make.centerY.equalTo(self.lblLeftTopValue);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_lblRightTopTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@20);
        make.top.equalTo(@18);
        make.right.lessThanOrEqualTo(@-10);
        make.height.mas_equalTo(@14);
    }];
    [_imgRightTopTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lblRightTopTitle.mas_left).offset(0);
        make.centerY.equalTo(self.lblRightTopTitle);
        make.left.greaterThanOrEqualTo(@10);
        make.width.height.mas_equalTo(20);
    }];
    [_lblRightTopValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@50);
        make.left.greaterThanOrEqualTo(@10);
        make.height.mas_equalTo(@14);
    }];
    [_imgRightTopValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblRightTopValue.mas_right).offset(2);
        make.centerY.equalTo(self.lblRightTopValue);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_lblLeftBottomTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@10);
        make.left.greaterThanOrEqualTo(@10);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_lblLeftBottomValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.bottom.equalTo(@-15);
        make.left.greaterThanOrEqualTo(@10);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_lblCenterBottomTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@10);
        make.left.greaterThanOrEqualTo(@10);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_lblCenterBottomValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.bottom.equalTo(@-15);
        make.left.greaterThanOrEqualTo(@10);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_lblRightBottomTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@10);
        make.left.greaterThanOrEqualTo(@10);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_lblRightBottomValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.bottom.equalTo(@-15);
        make.left.greaterThanOrEqualTo(@10);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_vLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vTopLeft.mas_bottom);
        make.left.right.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    [_vLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.vBottomLeft.mas_right);
        make.top.equalTo(self.vBottomLeft.mas_top).offset(10);
        make.bottom.equalTo(self.vBottomLeft.mas_bottom).offset(-10);
        make.width.mas_equalTo(1);
    }];
    [_vLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.vBottomCenter.mas_right);
        make.top.equalTo(self.vBottomCenter.mas_top).offset(10);
        make.bottom.equalTo(self.vBottomCenter.mas_bottom).offset(-10);
        make.width.mas_equalTo(1);
    }];
    
    self.backgroundColor = UIColor.clearColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _lblLeftTopTitle.textColor = RGB(51, 51, 51);
    _lblLeftTopValue.textColor = RGB(51, 51, 51);
    _lblRightTopTitle.textColor = RGB(51, 51, 51);
    _lblRightTopValue.textColor = RGB(51, 51, 51);
    _lblLeftBottomTitle.textColor = RGB(51, 51, 51);
    _lblLeftBottomValue.textColor = RGB(51, 51, 51);
    _lblCenterBottomTitle.textColor = RGB(51, 51, 51);
    _lblCenterBottomValue.textColor = RGB(51, 51, 51);
    _lblRightBottomTitle.textColor = RGB(51, 51, 51);
    _lblRightBottomValue.textColor = RGB(51, 51, 51);
    
    _lblLeftTopTitle.font = kFONT14;
    _lblLeftTopValue.font = kFONT14;
    _lblRightTopTitle.font = kFONT14;
    _lblRightTopValue.font = kFONT14;
    _lblLeftBottomTitle.font = kFONT11;
    _lblLeftBottomValue.font = kFONT14;
    _lblCenterBottomTitle.font = kFONT11;
    _lblCenterBottomValue.font = kFONT14;
    _lblRightBottomTitle.font = kFONT11;
    _lblRightBottomValue.font = kFONT14;
    
    _lblLeftTopTitle.textAlignment = NSTextAlignmentCenter;
    _lblLeftTopValue.textAlignment = NSTextAlignmentCenter;
    _lblRightTopTitle.textAlignment = NSTextAlignmentCenter;
    _lblRightTopValue.textAlignment = NSTextAlignmentCenter;
    _lblLeftBottomTitle.textAlignment = NSTextAlignmentCenter;
    _lblLeftBottomValue.textAlignment = NSTextAlignmentCenter;
    _lblCenterBottomTitle.textAlignment = NSTextAlignmentCenter;
    _lblCenterBottomValue.textAlignment = NSTextAlignmentCenter;
    _lblRightBottomTitle.textAlignment = NSTextAlignmentCenter;
    _lblRightBottomValue.textAlignment = NSTextAlignmentCenter;
    
    _vLine1.backgroundColor = RGB(240, 240, 240);
    _vLine2.backgroundColor = RGB(240, 240, 240);
    _vLine3.backgroundColor = RGB(240, 240, 240);
    
    @weakify(self)
    [_vTopLeft addJXTouch:^{
        @strongify(self);
        if ([_delegate respondsToSelector:@selector(onLeftTopClick:)]) {
            [_delegate onLeftTopClick:self];
        }
    }];
    [_vTopRight addJXTouch:^{
        @strongify(self);
        if ([_delegate respondsToSelector:@selector(onRightTopClick:)]) {
            [_delegate onRightTopClick:self];
        }
    }];
    [_vBottomLeft addJXTouch:^{
        @strongify(self);
        if ([_delegate respondsToSelector:@selector(onLeftBottomClick:)]) {
            [_delegate onLeftBottomClick:self];
        }
    }];
    [_vBottomCenter addJXTouch:^{
        @strongify(self);
        if ([_delegate respondsToSelector:@selector(onCenterBottomClick:)]) {
            [_delegate onCenterBottomClick:self];
        }
    }];
    [_vBottomRight addJXTouch:^{
        @strongify(self);
        if ([_delegate respondsToSelector:@selector(onRightBottomClick:)]) {
            [_delegate onRightBottomClick:self];
        }
    }];

    
}

- (void) setPadding: (CGFloat)padding {
    [_vBackground mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(padding, padding, 0, padding));
    }];
}


@end
