//
//  FNIntegralMallOrderTextCell.m
//  THB
//
//  Created by Weller Zhao on 2019/1/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNIntegralMallOrderTextCell.h"

@interface FNIntegralMallOrderTextCell()

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;

@end

@implementation FNIntegralMallOrderTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.lblTitle = [[UILabel alloc] init];
    self.lblDesc = [[UILabel alloc] init];
    
    [self.contentView addSubview: self.lblTitle];
    [self.contentView addSubview: self.lblDesc];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(@10);
        make.height.mas_equalTo(44);
        make.right.lessThanOrEqualTo(self.lblDesc.mas_left).offset(-10);
    }];
    
    [self.lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.centerY.equalTo(@0);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.lblTitle.textColor = RGB(24, 24, 24);
    self.lblTitle.font = kFONT14;
    
    self.lblDesc.textColor = RGB(60, 60, 60);
    self.lblDesc.font = kFONT13;
}

- (void)setTitle: (NSString*) title withDesc: (NSString*)desc {
    self.lblTitle.text = title;
    self.lblDesc.text = desc;
}

@end
