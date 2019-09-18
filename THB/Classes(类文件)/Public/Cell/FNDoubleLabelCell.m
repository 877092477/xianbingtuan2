//
//  FNDoubleLabelCell.m
//  SuperMode
//
//  Created by jimmy on 2017/6/10.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNDoubleLabelCell.h"

@interface FNDoubleLabelCell ()
@property (nonatomic, strong)NSLayoutConstraint* leftConsW;

@end
@implementation FNDoubleLabelCell

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
    _leftlabel = [UILabel new];
    _leftlabel.font = kFONT14;
    [self.contentView addSubview:_leftlabel];
    
    _rightLabel = [UILabel new];
    _rightLabel.font = kFONT14;
    [self.contentView addSubview:_rightLabel];
    
    [_leftlabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
   self.leftCons =  [_leftlabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
    self.leftConsW = [_leftlabel autoSetDimension:(ALDimensionWidth) toSize:6*14];
    
    [_rightLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    [_rightLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.leftlabel withOffset:20];
    [_rightLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNDoubleLabelCell";
    FNDoubleLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNDoubleLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
- (void)setLeftwidth:(CGFloat)leftwidth{
    _leftwidth = leftwidth;
    self.leftConsW.constant = _leftwidth;
}
@end
