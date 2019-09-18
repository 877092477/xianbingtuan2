//
//  COFSelectlectivityCell.m
//  THB
//
//  Created by Jimmy on 2018/8/29.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "COFSelectlectivityCell.h"

@interface COFSelectlectivityCell()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *selectIV;
@end

@implementation COFSelectlectivityCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 14, self.contentView.frame.size.width-100, 20)];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLabel];
    
    self.selectIV = [[UIImageView alloc]initWithFrame:CGRectMake(JMScreenWidth-30, 17, 15, 15)];
    [self.selectIV setImage:[UIImage imageNamed:@""]];
    [self.contentView addSubview:self.selectIV];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
