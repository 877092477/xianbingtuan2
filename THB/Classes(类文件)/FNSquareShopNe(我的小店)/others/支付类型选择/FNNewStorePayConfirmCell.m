//
//  FNNewStorePayConfirmCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/1.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStorePayConfirmCell.h"


@interface FNNewStorePayConfirmCell()

@property (nonatomic, strong) UIView *vLine;

@end


@implementation FNNewStorePayConfirmCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _vLine = [[UIView alloc] init];
    
    [self.contentView addSubview: _lblTitle];
    [self.contentView addSubview: _lblDesc];
    [self.contentView addSubview: _vLine];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(self.lblDesc.mas_left).offset(-20);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-15);
        make.centerY.equalTo(@0);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.bottom.equalTo(@0);
        make.height.mas_equalTo(@1);
    }];
    
    _lblTitle.textColor = RGB(120, 120, 120);
    _lblTitle.font = kFONT16;
    
    _lblDesc.textColor = RGB(29, 29, 29);
    _lblDesc.font = [UIFont boldSystemFontOfSize:15];
    
    _vLine.backgroundColor = RGB(232, 232, 232);
}

@end
