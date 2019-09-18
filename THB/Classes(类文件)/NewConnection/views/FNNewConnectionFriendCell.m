//
//  FNNewConnectionFriendCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/6/5.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNNewConnectionFriendCell.h"

@interface FNNewConnectionFriendCell()

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UIView *vBottom;
@property (nonatomic, strong) UIView *v1;
@property (nonatomic, strong) UIView *v2;
@property (nonatomic, strong) UIView *v3;
@property (nonatomic, strong) UIView *v4;


@property (nonatomic, strong) UIView *vLine1;
@property (nonatomic, strong) UIView *vLine2;
@property (nonatomic, strong) UIView *vLine3;
@property (nonatomic, strong) UIView *vLine4;

@property (nonatomic, strong) UIView *vLine5;

@end

@implementation FNNewConnectionFriendCell

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
    _imgLevel = [[UIImageView alloc] init];
    _lblLevel = [[UILabel alloc] init];
    _imgHeader = [[UIImageView alloc] init];
    _lblName = [[UILabel alloc] init];
    _imgLevel = [[UIImageView alloc] init];
    _lblLevel = [[UILabel alloc] init];
    _lblPhone = [[UILabel alloc] init];
    _lblTime = [[UILabel alloc] init];
    
    _lblTeam = [[UILabel alloc] init];
    _lblOrder = [[UILabel alloc] init];
    
    _vBottom = [[UIView alloc] init];
    _v1 = [[UIView alloc] init];
    _v2 = [[UIView alloc] init];
    _v3 = [[UIView alloc] init];
    _v4 = [[UIView alloc] init];
    _lblTitle1 = [[UILabel alloc] init];
    _lblTitle2 = [[UILabel alloc] init];
    _lblTitle3 = [[UILabel alloc] init];
    _lblTitle4 = [[UILabel alloc] init];
    _lblValue1 = [[UILabel alloc] init];
    _lblValue2 = [[UILabel alloc] init];
    _lblValue3 = [[UILabel alloc] init];
    _lblValue4 = [[UILabel alloc] init];
    _vLine1 = [[UIView alloc] init];
    _vLine2 = [[UIView alloc] init];
    _vLine3 = [[UIView alloc] init];
    _vLine4 = [[UIView alloc] init];
    _vLine5 = [[UIView alloc] init];
    
    [self.contentView addSubview:_vBackground];
    
    [_vBackground addSubview:_vLine5];
    
    [_vBackground addSubview:_imgBackground];
    [_vBackground addSubview:_lblTitle];
    [_vBackground addSubview:_btnChat];
    [_vBackground addSubview:_vLine];
    [_vBackground addSubview:_imgHeader];
    [_vBackground addSubview:_lblName];
    [_vBackground addSubview:_imgLevel];
    [_vBackground addSubview:_lblLevel];
    [_vBackground addSubview:_lblPhone];
    [_vBackground addSubview:_lblTime];
    
    [_vBackground addSubview:_lblTeam];
    [_vBackground addSubview:_lblOrder];
    
    [_vBackground addSubview:_vBottom];
    [_vBottom addSubview:_v1];
    [_vBottom addSubview:_v2];
    [_vBottom addSubview:_v3];
    [_vBottom addSubview:_v4];
    [_v1 addSubview:_lblTitle1];
    [_v2 addSubview:_lblTitle2];
    [_v3 addSubview:_lblTitle3];
    [_v4 addSubview:_lblTitle4];
    [_v1 addSubview:_lblValue1];
    [_v2 addSubview:_lblValue2];
    [_v3 addSubview:_lblValue3];
    [_v4 addSubview:_lblValue4];
    [_vBackground addSubview:_vLine1];
    [_vBackground addSubview:_vLine2];
    [_vBackground addSubview:_vLine3];
    [_vBackground addSubview:_vLine4];
    
    [_vBackground mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_equalTo(160);
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
        make.top.equalTo(self.vLine.mas_bottom).offset(11);
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
        make.right.lessThanOrEqualTo(self.vLine5).offset(-10);
    }];
    [_lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(22);
        make.top.equalTo(self.lblPhone.mas_bottom).offset(8);
        make.right.lessThanOrEqualTo(self.vLine5).offset(-10);
    }];
    
    [_vBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
//        make.height.mas_equalTo(60);
        make.top.equalTo(self.imgHeader.mas_bottom).offset(16);
    }];
    [_v1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.bottom.equalTo(@0);
    }];
    [_v2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.v1.mas_right);
        make.width.equalTo(self.v1);
        make.top.bottom.equalTo(@0);
    }];
    [_v3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.v2.mas_right);
        make.width.equalTo(self.v1);
        make.top.bottom.equalTo(@0);
    }];
    [_v4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.v3.mas_right);
        make.width.equalTo(self.v1);
        make.top.bottom.equalTo(@0);
        make.right.equalTo(@0);
    }];
    [_lblTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.top.equalTo(@11);
        make.centerX.equalTo(@0);
    }];
    [_lblTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.top.equalTo(@11);
        make.centerX.equalTo(@0);
    }];
    [_lblTitle3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.top.equalTo(@11);
        make.centerX.equalTo(@0);
    }];
    [_lblTitle4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.top.equalTo(@11);
        make.centerX.equalTo(@0);
    }];
    [_lblValue1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.top.equalTo(@33);
        make.centerX.equalTo(@0);
    }];
    [_lblValue2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.top.equalTo(@33);
        make.centerX.equalTo(@0);
    }];
    [_lblValue3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.top.equalTo(@33);
        make.centerX.equalTo(@0);
    }];
    [_lblValue4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.top.equalTo(@33);
        make.centerX.equalTo(@0);
    }];
    [_vLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.vBottom);
        make.height.mas_equalTo(1);
    }];
    [_vLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.v1.mas_right);
        make.top.equalTo(self.vLine1.mas_bottom).offset(12);
        make.bottom.equalTo(@-7);
        make.width.equalTo(@1);
    }];
    [_vLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.v2.mas_right);
        make.top.equalTo(self.vLine1.mas_bottom).offset(12);
        make.bottom.equalTo(@-7);
        make.width.equalTo(@1);
    }];
    [_vLine4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.v3.mas_right);
        make.top.equalTo(self.vLine1.mas_bottom).offset(12);
        make.bottom.equalTo(@-7);
        make.width.equalTo(@1);
    }];
    
    [_vLine5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-120);
        make.top.equalTo(self.vLine.mas_bottom).offset(20);
        make.bottom.equalTo(self.vLine1.mas_top).offset(-12);
        make.width.mas_equalTo(1);
    }];
    
    [_lblOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.lessThanOrEqualTo(@-10);
        make.top.equalTo(self.vLine5);
        make.left.equalTo(self.vLine5).offset(10);
    }];
    
    [_lblTeam mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.lessThanOrEqualTo(@-10);
        make.top.equalTo(self.lblOrder.mas_bottom).offset(10);
        make.left.equalTo(self.vLine5).offset(10);
    }];
    
    self.backgroundColor = UIColor.clearColor;
    
//    self.vBackground.backgroundColor = UIColor.whiteColor;
    
    _vLine.backgroundColor = RGB(240, 240, 240);
    
    _lblLevel.font = kFONT10;
    
//    _lblTitle.text = @"所属团队：方诺科技";
    _lblTitle.font = kFONT11;
    _lblTitle.textColor = RGB(102, 102, 102);
    _lblTitle.textAlignment = NSTextAlignmentCenter;
    
//    [_btnChat setTitle:@"聊天" forState:UIControlStateNormal];
    [_btnChat setTitleColor:RGB(98, 231, 255) forState:UIControlStateNormal];
    _btnChat.titleLabel.font = kFONT11;
    [_btnChat addTarget:self action:@selector(clickChat) forControlEvents:UIControlEventTouchUpInside];
    
    _imgHeader.cornerRadius = 22;
    
    _lblTeam.font = kFONT11;
    _lblTeam.textColor = RGB(102, 102, 102);
    
    _lblOrder.font = kFONT11;
    _lblOrder.textColor = RGB(102, 102, 102);
    
    _lblName.font = kFONT14;
    _lblName.textColor = RGB(51, 51, 51);
//    _lblName.text = @"毛毛虫";
    
    _lblPhone.font = kFONT11;
    _lblPhone.textColor = RGB(102, 102, 102);
//    _lblPhone.text = @"手机号：12354678910";
    
    _lblTime.font = kFONT11;
    _lblTime.textColor = RGB(102, 102, 102);
//    _lblTime.text = @"2019-06-28 12:04 加入";
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
//    _v1.backgroundColor = UIColor.redColor;
//    _v2.backgroundColor = UIColor.blueColor;
//    _v3.backgroundColor = UIColor.greenColor;
//    _v4.backgroundColor = UIColor.yellowColor;
//    _imgHeader.backgroundColor = UIColor.grayColor;
    
    
//    _lblTitle1.text = @"总佣金(元)";
    _lblTitle1.textColor = RGB(51, 51, 51);
    _lblTitle1.font = kFONT11;

//    _lblValue1.text = @"3258";
    _lblValue1.textColor = RGB(98, 231, 255);
    _lblValue1.font = kFONT15;
    
//    _lblTitle2.text = @"总佣金(元)";
    _lblTitle2.textColor = RGB(51, 51, 51);
    _lblTitle2.font = kFONT11;
    
//    _lblValue2.text = @"3258";
    _lblValue2.textColor = RGB(98, 231, 255);
    _lblValue2.font = kFONT15;
    
//    _lblTitle3.text = @"总佣金(元)";
    _lblTitle3.textColor = RGB(51, 51, 51);
    _lblTitle3.font = kFONT11;
    
//    _lblValue3.text = @"3258";
    _lblValue3.textColor = RGB(98, 231, 255);
    _lblValue3.font = kFONT15;
    
//    _lblTitle4.text = @"总佣金(元)";
    _lblTitle4.textColor = RGB(51, 51, 51);
    _lblTitle4.font = kFONT11;
    
//    _lblValue4.text = @"3258";
    _lblValue4.textColor = RGB(98, 231, 255);
    _lblValue4.font = kFONT15;
    
    _vLine1.backgroundColor = RGB(240, 240, 240);
    _vLine2.backgroundColor = RGB(240, 240, 240);
    _vLine3.backgroundColor = RGB(240, 240, 240);
    _vLine4.backgroundColor = RGB(240, 240, 240);
    _vLine5.backgroundColor = RGB(240, 240, 240);
}

- (void) setPadding: (CGFloat)padding {
    [_vBackground mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(padding, padding, 0, padding));
    }];
}

- (void)clickChat {
    if ([_delegate respondsToSelector:@selector(cellDidChatClick:)]) {
        [_delegate cellDidChatClick:self];
    }
}

@end
