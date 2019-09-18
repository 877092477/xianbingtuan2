//
//  FNHeroRankCell.m
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNHeroRankCell.h"
#import "FNHeroRankModel.h"
const CGFloat _hrc_cell_height = 60+20;
const CGFloat _hrc_avatar_height = 60;
@implementation FNHeroRankCell
- (UIImageView *)rankimgview{
    if (_rankimgview == nil) {
        _rankimgview = [UIImageView new];
        _rankimgview.image = IMAGE(@"hero_one");
        [_rankimgview sizeToFit];
    }
    return _rankimgview;
}
- (UILabel *)rankLabel{
    if (_rankLabel == nil) {
        _rankLabel = [UILabel new];
        _rankLabel.font = [UIFont boldSystemFontOfSize:20];
        _rankLabel.adjustsFontSizeToFitWidth = YES;
        _rankLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _rankLabel;
}
- (UIView *)leftview{
    if (_leftview == nil) {
        _leftview = [UIView new];
        
        [_leftview addSubview:self.rankimgview];
        [self.rankimgview autoSetDimensionsToSize:self.rankimgview.size];
        [self.rankimgview autoCenterInSuperview];
        
        [_leftview addSubview:self.rankLabel];
        [self.rankLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        [self.rankLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [self.rankLabel autoCenterInSuperview];
        
    }
    return _leftview;
}

- (UIImageView *)avatarImgview{
    if (_avatarImgview == nil) {
        _avatarImgview = [UIImageView new];
        _avatarImgview.cornerRadius = _hrc_avatar_height*0.5;
    }
    return _avatarImgview;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.font = kFONT14;
        _nameLabel.textColor  =FNGlobalTextGrayColor;
    }
    return _nameLabel;
}
- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        _moneyLabel = [UILabel new];
        _moneyLabel.font = kFONT14;
        _moneyLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _moneyLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    //
    [self.contentView addSubview:self.leftview];
    [self.leftview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeRight)];
    [self.leftview autoSetDimension:(ALDimensionWidth) toSize:self.rankimgview.width+20];
    
    
    [self.contentView addSubview:self.avatarImgview];
    [self.avatarImgview autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.leftview];
    [self.avatarImgview autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [self.avatarImgview autoSetDimensionsToSize:(CGSizeMake(_hrc_avatar_height, _hrc_avatar_height ))];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.avatarImgview withOffset:_jmsize_10];
    [self.nameLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [self.nameLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:self.contentView withMultiplier:0.4 relation:(NSLayoutRelationLessThanOrEqual)];
    
    [self.contentView addSubview:self.moneyLabel];
    [self.moneyLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    [self.moneyLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [self.moneyLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:self.contentView withMultiplier:0.2 relation:(NSLayoutRelationLessThanOrEqual)];
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNHeroRankCell";
    FNHeroRankCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNHeroRankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}

- (void)setModel:(FNHeroRankModel *)model{
    _model = model;
    if (_model) {
        [self.avatarImgview setUrlImg:self.model.head_img];
        self.nameLabel.text = self.model.nickname;
        
        if (self.model.val.integerValue<=3) {
            [self.rankimgview setUrlImg:self.model.img];
            self.rankLabel.hidden = YES;
            self.rankimgview.hidden = NO;
        }else{
            self.rankLabel.text = self.model.num;
            self.rankLabel.hidden = NO;
            self.rankimgview.hidden = YES;
        }
        
    }
}
@end
