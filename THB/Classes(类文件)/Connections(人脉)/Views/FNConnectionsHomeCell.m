//
//  FNConnectionsHomeCell.m
//  THB
//
//  Created by Weller Zhao on 2019/1/14.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsHomeCell.h"

@interface FNConnectionsHomeCell()

@property (nonatomic, strong) UIImageView *imgCheck;
@property (nonatomic, strong) UIView *vContent;

@end

@implementation FNConnectionsHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.vContent = [[UIView alloc] init];
    self.imgHeader = [[UIImageView alloc] init];
    self.lblTitle = [[UILabel alloc] init];
    self.lblDesc = [[UILabel alloc] init];
    self.lblPhone = [[UILabel alloc] init];
    self.lblType = [[UILabel alloc] init];
    self.imgCheck = [[UIImageView alloc] init];
    
    [self.contentView addSubview:self.vContent];
    [self.vContent addSubview:self.imgHeader];
    [self.vContent addSubview:self.lblTitle];
    [self.vContent addSubview:self.lblDesc];
    [self.vContent addSubview:self.lblPhone];
    [self.vContent addSubview:self.lblType];
    [self.contentView addSubview:self.imgCheck];
    @weakify(self)
    [self.vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
        make.right.equalTo(@0);
    }];
    [self.imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@8);
        make.width.height.mas_equalTo(40);
    }];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@8);
        make.left.equalTo(self_weak_.imgHeader.mas_right).offset(10);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [self.lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self_weak_.lblTitle.mas_bottom).offset(4);
        make.left.equalTo(self_weak_.imgHeader.mas_right).offset(10);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [self.lblPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self_weak_.lblDesc.mas_bottom).offset(4);
        make.left.equalTo(self_weak_.imgHeader.mas_right).offset(10);
        make.right.lessThanOrEqualTo(@-20);
        make.bottom.lessThanOrEqualTo(@-8);
    }];
    [self.lblType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self_weak_.imgHeader);
        make.top.equalTo(self_weak_.imgHeader.mas_bottom).offset(4);
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(self.imgHeader.mas_right).offset(8);
        make.bottom.lessThanOrEqualTo(@-8);
    }];
    [self.imgCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.centerY.equalTo(@0);
        make.right.equalTo(@-30);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.imgHeader.cornerRadius = 20;
    
    self.lblTitle.textColor = RGB(38, 38, 38);
    self.lblTitle.font = kFONT13;
    
    self.lblDesc.textColor = RGB(150, 150, 150);
    self.lblDesc.font = kFONT11;
    
    self.lblPhone.textColor = RGB(150, 150, 150);
    self.lblPhone.font = kFONT11;
    
    self.lblType.textColor = RGB(150, 150, 150);
    self.lblType.font = [UIFont systemFontOfSize:9];
    
    UIView *vLine = [[UIView alloc] init];
    [self.contentView addSubview: vLine];
    [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    vLine.backgroundColor = FNHomeBackgroundColor;
    
    self.imgCheck.image = IMAGE(@"connections_check_normal");
    [self setIsShowCheck:NO];
}

- (void)setIsCheck: (BOOL)isCheck {
    self.imgCheck.image = isCheck ? IMAGE(@"connections_check_selected") : IMAGE(@"connections_check_normal");
}

- (void)setIsShowCheck: (BOOL)isShow {
    [self.imgCheck setHidden:!isShow];
    [self.vContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(isShow ? @-50 : @0);
    }];
}

@end
