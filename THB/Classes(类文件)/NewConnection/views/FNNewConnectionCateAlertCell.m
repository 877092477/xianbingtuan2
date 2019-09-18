//
//  FNNewConnectionCateAlertCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewConnectionCateAlertCell.h"

@interface FNNewConnectionCateAlertCell()

@property (nonatomic, strong) UIImageView *imgCheck;
@property (nonatomic, strong) UIView *vLine;

@end

@implementation FNNewConnectionCateAlertCell

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
    _imgCheck = [[UIImageView alloc] init];
    _vLine = [[UIView alloc] init];
    
    [self.contentView addSubview: _lblTitle];
    [self.contentView addSubview: _imgCheck];
    [self.contentView addSubview: _vLine];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(self.imgCheck.mas_left).offset(-10);
    }];
    
    [_imgCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.centerY.equalTo(@0);
    }];
    
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@25);
        make.right.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = kFONT12;
    
//    _vLine.backgroundColor = RGB(240, 240, 240);
    
    _imgCheck.image = IMAGE(@"connection_cate_alert_check");
    _imgCheck.hidden = YES;
}

- (void)setCheck: (BOOL)check {
    _lblTitle.font = check ? [UIFont boldSystemFontOfSize:12] : kFONT12;
    _imgCheck.hidden = !check;
}

@end
