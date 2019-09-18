//
//  FNConnectionSettingExitCell.m
//  THB
//
//  Created by Weller Zhao on 2019/3/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionSettingExitCell.h"

@interface FNConnectionSettingExitCell()


@end

@implementation FNConnectionSettingExitCell

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
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.edges.equalTo(@0);
    }];
    
    _lblTitle.textColor = RED;
    _lblTitle.font = kFONT14;
    _lblTitle.textAlignment = NSTextAlignmentCenter;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


@end
