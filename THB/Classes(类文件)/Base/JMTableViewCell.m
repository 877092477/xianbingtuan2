//
//  JMTableViewCell.m
//  SuperMode
//
//  Created by jimmy on 2017/6/8.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMTableViewCell.h"

@implementation JMTableViewCell

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
        [self jm_setupViews];
        [self jm_bindViewModel];
    }
    return self;
}
- (void)jm_setupViews{
    
}
- (void)jm_bindViewModel{
    
}
@end
