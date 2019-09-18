//
//  FNConnectionsMessageCell.m
//  THB
//
//  Created by Weller Zhao on 2019/2/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsMessageCell.h"

@interface FNConnectionsMessageCell()


@end

@implementation FNConnectionsMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _imgHeader = [[UIImageView alloc] init];
    _lblName = [[UILabel alloc] init];
    _lblTime = [[UILabel alloc] init];
    _vCount = [[UIView alloc] init];
    _lblCount = [[UILabel alloc] init];
    
    [self.contentView addSubview:_imgHeader];
    [self.contentView addSubview:_lblName];
    [self.contentView addSubview:_lblTime];
    [self.contentView addSubview:_vCount];
    [_vCount addSubview:_lblCount];
    
    @weakify(self)
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.width.height.mas_equalTo(40);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    [_lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@60);
        make.top.equalTo(@12);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@60);
        make.bottom.equalTo(@-12);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_vCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self_weak_.imgHeader.mas_right);
        make.centerY.equalTo(self_weak_.imgHeader.mas_top);
        make.height.mas_equalTo(12);
        make.width.mas_greaterThanOrEqualTo(12);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@4);
        make.right.lessThanOrEqualTo(@-4);
        make.center.equalTo(self_weak_.vCount);
    }];
    
    _imgHeader.cornerRadius = 20;
    
    _lblName.font = kFONT14;
    
    _lblTime.font = kFONT12;
    _lblTime.textColor = UIColor.lightGrayColor;
    
    _vCount.backgroundColor = UIColor.redColor;
    _vCount.cornerRadius = 6;
    
    _lblCount.font = kFONT10;
    _lblCount.textColor = UIColor.whiteColor;
    
    UIView *line = [[UIView alloc] init];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@60);
        make.bottom.equalTo(@0);
        make.right.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    line.backgroundColor = FNHomeBackgroundColor;
}


@end
