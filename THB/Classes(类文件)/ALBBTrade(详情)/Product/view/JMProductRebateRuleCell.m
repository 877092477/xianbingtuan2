//
//  JMProductRebateRuleCell.m
//  THB
//
//  Created by jimmy on 2017/4/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMProductRebateRuleCell.h"

@implementation JMProductRebateRuleCell

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
        [self addLineOnDirection:(LineDirectionBottom) withLineSzie:CGSizeMake(FNDeviceWidth, 1.0)];
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    _questionIcon  = [UIImageView new];
    _questionIcon.image =IMAGE(@"good_detail_q");
    [_questionIcon sizeToFit];
    [self.contentView addSubview:_questionIcon];
    
    _questionLabel = [UILabel new];
    _questionLabel.font = kFONT14;
    [self.contentView addSubview:_questionLabel];
    
    _answerLabel = [UILabel new];
    _answerLabel.font = kFONT14;
    _answerLabel.textColor = FNGlobalTextGrayColor;
    _answerLabel.numberOfLines = 0;
    [self.contentView addSubview:_answerLabel];
    
    [_questionIcon autoSetDimensionsToSize:_questionIcon.size];
    [_questionIcon autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
    [_questionIcon autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jm_margin10];
    
    [_questionLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin];
    [_questionLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:_questionIcon];
    [_questionLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_questionIcon withOffset:_jm_margin10*0.5];
    
    [_answerLabel autoPinEdge:ALEdgeRight toEdge:(ALEdgeRight) ofView:_questionLabel];
    [_answerLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_questionLabel];
    [_answerLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_questionLabel withOffset:_jm_margin10];
    
    
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"JMProductRebateRuleCell";
    JMProductRebateRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[JMProductRebateRuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}

 
@end
