//
//  JMPProductTVCell.m
//  THB
//
//  Created by jimmy on 2017/5/24.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMPProductTVCell.h"

@implementation JMPProductTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.proImgView = [UIImageView new];
    [self.contentView addSubview:self.proImgView];
    
    self.desLabel = [UILabel new];
    self.desLabel.font = kFONT14;
    [self.contentView addSubview:self.desLabel];
    
    self.priceLabel = [UILabel new];
    self.priceLabel.font = kFONT14;
    [self.contentView addSubview:self.priceLabel];
    
    self.rebateLabel = [UILabel new];
    self.rebateLabel.font = kFONT14;
    [self.contentView addSubview:self.rebateLabel];
    
}
@end
