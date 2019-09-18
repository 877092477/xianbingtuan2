//
//  FNConnectionsSwitchCell.m
//  THB
//
//  Created by Weller Zhao on 2019/3/5.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsSwitchCell.h"

@interface FNConnectionsSwitchCell()


@end

@implementation FNConnectionsSwitchCell

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
    [self.contentView addSubview:_lblTitle];
    _swt = [[UISwitch alloc] init];
    [self.contentView addSubview:_swt];
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(44);
//    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.bottom.equalTo(@0);
        make.height.mas_equalTo(44);
//        make.right.lessThanOrEqualTo(self.swt.mas_left).offset(-10);
    }];
    [_swt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.centerY.equalTo(@0);
//        make.width.mas_equalTo(80);
//        make.height.mas_equalTo(40);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _lblTitle.textAlignment = NSTextAlignmentLeft;
    _lblTitle.text = @"置顶群聊";
    _lblTitle.textColor = UIColor.grayColor;
    _lblTitle.font = kFONT14;
    
    [_swt addTarget:self action:@selector(switchStateChange) forControlEvents:UIControlEventValueChanged];
}

- (void)switchStateChange {
    if ([_delegate respondsToSelector:@selector(switchCell:didChange:)]) {
        [_delegate switchCell:self didChange:_swt.isOn];
    }
}

@end
