//
//  JMMemberUpgradePayCell.m
//  THB
//
//  Created by jimmy on 2017/4/1.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMMemberUpgradePayCell.h"

@implementation JMMemberUpgradePayCell

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
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    _imgView = [UIImageView new];
    [self.contentView addSubview:_imgView];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = kFONT14;
    [self.contentView addSubview:_titleLabel];
    
    _seletedImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"vip_choose_off"] highlightedImage:[UIImage imageNamed:@"vip_choose_on"]];
    [_seletedImgView sizeToFit];
    [self.contentView addSubview:_seletedImgView];
    
    CGFloat imgW = 23;
    
    [_imgView autoSetDimensionsToSize:(CGSizeMake(imgW, imgW))];
    [_imgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:LeftSpace];
    [_imgView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_titleLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_imgView withOffset:10];
    [_titleLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_seletedImgView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:10];
    [_seletedImgView autoSetDimensionsToSize:_seletedImgView.size];
    [_seletedImgView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"JMMemberUpgradePayCell";
    JMMemberUpgradePayCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[JMMemberUpgradePayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
@end
