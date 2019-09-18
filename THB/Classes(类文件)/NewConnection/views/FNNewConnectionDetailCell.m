//
//  FNNewConnectionDetailCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/3.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewConnectionDetailCell.h"

@interface FNNewConnectionDetailCell()

@property (nonatomic, strong) UIView *vBackground;

@property (nonatomic, strong) UIView *vLine;

@end

@implementation FNNewConnectionDetailCell

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
    _lblTitle = [[UILabel alloc] init];
    _btnChat = [[UIButton alloc] init];
    _vLine = [[UIView alloc] init];
    _imgHeader = [[UIImageView alloc] init];
    _lblName = [[UILabel alloc] init];
    _imgLevel = [[UIImageView alloc] init];
    _lblLevel = [[UILabel alloc] init];
    _lblPhone = [[UILabel alloc] init];
    _lblCode = [[UILabel alloc] init];
    _lblWechat = [[UILabel alloc] init];
    
    [self.contentView addSubview:_vBackground];
    [_vBackground addSubview:_imgBackground];
    [_vBackground addSubview:_lblTitle];
    [_vBackground addSubview:_btnChat];
    [_vBackground addSubview:_vLine];
    [_vBackground addSubview:_imgHeader];
    [_vBackground addSubview:_lblName];
    [_vBackground addSubview:_imgLevel];
    [_vBackground addSubview:_lblLevel];
    [_vBackground addSubview:_lblPhone];
    [_vBackground addSubview:_lblCode];
    [_vBackground addSubview:_lblWechat];
    
    [_vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_equalTo(0);
    }];
    [_imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@10);
        make.right.lessThanOrEqualTo(self.btnChat.mas_left).offset(-10);
        make.height.mas_equalTo(28);
    }];
    [_btnChat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.centerY.equalTo(self.lblTitle);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@28);
        make.left.right.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(44);
        make.left.equalTo(@14);
        make.top.equalTo(self.vLine.mas_bottom).offset(16);
    }];
    [_lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(22);
        make.top.equalTo(self.vLine.mas_bottom).offset(11);
        make.height.mas_equalTo(12);
    }];
    [_imgLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblName.mas_right).offset(10);
        make.centerY.equalTo(self.lblName);
        make.right.lessThanOrEqualTo(@-20);
        make.height.mas_equalTo(14);
    }];
    [_lblLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgLevel).offset(8);
        make.right.equalTo(self.imgLevel).offset(-8);
        make.centerY.equalTo(self.imgLevel);
    }];
    [_lblPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(22);
        make.top.equalTo(self.lblName.mas_bottom).offset(8);
    }];
    [_lblCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblPhone.mas_right).offset(22);
        make.centerY.equalTo(self.lblPhone);
    }];
    [_lblWechat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(22);
        make.top.equalTo(self.lblPhone.mas_bottom).offset(8);
    }];
    
    self.backgroundColor = UIColor.clearColor;
    
//    self.vBackground.backgroundColor = UIColor.whiteColor;
    
    _vLine.backgroundColor = RGB(240, 240, 240);
    
    _lblLevel.font = kFONT10;
    
//    _lblTitle.text = @"我的推荐人";
    _lblTitle.font = kFONT11;
    _lblTitle.textColor = RGB(102, 102, 102);
    _lblTitle.textAlignment = NSTextAlignmentCenter;
    
//    [_btnChat setTitle:@"聊天" forState:UIControlStateNormal];
    [_btnChat setTitleColor:RGB(98, 231, 255) forState:UIControlStateNormal];
    _btnChat.titleLabel.font = kFONT11;
    
    _imgHeader.cornerRadius = 22;
    
    _lblName.font = kFONT14;
    _lblName.textColor = RGB(51, 51, 51);
//    _lblName.text = @"毛毛虫";
    
    _lblPhone.font = kFONT11;
    _lblPhone.textColor = RGB(102, 102, 102);
//    _lblPhone.text = @"手机号：12354678910";
    
    _lblCode.font = kFONT11;
    _lblCode.textColor = RGB(102, 102, 102);
//    _lblCode.text = @"邀请码：123456";
    
    _lblWechat.font = kFONT11;
    _lblWechat.textColor = RGB(102, 102, 102);
//    _lblWechat.text = @"微信号：123546";
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.hidden = YES;
}

- (void) updateHeight {
    [_vBackground mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(116);
    }];
    self.contentView.hidden = NO;
}

- (void) setPadding: (CGFloat)padding {
    [_vBackground mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(padding, padding, 0, padding));
    }];
}

@end
