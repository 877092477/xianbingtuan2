//
//  FNFansCell.m
//  嗨如意
//
//  Created by Fnuo-iOS on 2018/6/7.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNFansCell.h"
#import "FNPromotionalTeamModel.h"
const CGFloat _Fans_cell_height  = 80;

@implementation FNFansCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (UIImageView *)avatarImgview{
    if (_avatarImgview == nil) {
        _avatarImgview = [UIImageView new];
    }
    return _avatarImgview;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.font = kFONT14;
    }
    return _nameLabel;
}
- (UILabel *)dateLabel{
    if (_dateLabel == nil) {
        _dateLabel = [UILabel new];
        _dateLabel.font = kFONT12;
        _dateLabel.textColor = FNGlobalTextGrayColor;
    }
    return _dateLabel;
}
- (UILabel *)valueLabel{
    if (_valueLabel == nil) {
        _valueLabel = [UILabel new];
        _valueLabel.font = kFONT14;
        _valueLabel.textColor = FNGlobalTextGrayColor;
        _valueLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _valueLabel;
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    [self.contentView addSubview:self.avatarImgview];
    [self.avatarImgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(_jmsize_10, 15, _jmsize_10, 0   ))excludingEdge:(ALEdgeRight)];
    [self.avatarImgview autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionHeight) ofView:self.avatarImgview];
    
    UIImageView *starImg=[[UIImageView alloc]initWithImage:IMAGE(@"family_star")];
    [self.contentView addSubview:starImg];
    [starImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImgview.mas_left).offset(-10);
        make.top.equalTo(self.avatarImgview.mas_top).offset(-10);
        make.width.height.equalTo(@20);
    }];
    self.starImg=starImg;
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:self.avatarImgview withOffset:0];
    [self.nameLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.avatarImgview withOffset:_jmsize_10];
    [self.nameLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:self.contentView withMultiplier:0.5 relation:(NSLayoutRelationLessThanOrEqual)];
    
    
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.avatarImgview withOffset:0];
    [self.dateLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.avatarImgview withOffset:_jmsize_10];
    [self.dateLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:self.contentView withMultiplier:0.5 relation:(NSLayoutRelationLessThanOrEqual)];
    
    [self.contentView addSubview:self.valueLabel];
    [self.valueLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15];
    [self.valueLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [self.valueLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:self.contentView withMultiplier:0.2 relation:(NSLayoutRelationLessThanOrEqual)];
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNFansCell";
    FNFansCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNFansCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
- (void)setModel:(PTMfan *)model{
    _model = model;
    if (_model) {
        [self.avatarImgview setUrlImg:self.model.head_img];
        NSString* vname = [NSString isEmpty:self.model.Vname]?@"":[NSString stringWithFormat:@"(%@)",self.model.Vname];
        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",self.model.nickname,vname];
        if (![NSString isEmpty:vname]) {
            [self.nameLabel addSingleAttributed:@{NSFontAttributeName:kFONT12,NSForegroundColorAttributeName:FNGlobalTextGrayColor} ofRange:[self.nameLabel.text rangeOfString:[NSString stringWithFormat:@"%@",vname]]];
        }
        
        self.dateLabel.text = [NSString getTimeStr:self.model.reg_time];
        self.valueLabel.text = [NSString stringWithFormat:@"收益%@",self.model.commission];
        [self.valueLabel addSingleAttributed:@{NSFontAttributeName:kFONT14,NSForegroundColorAttributeName:FNMainGobalControlsColor} ofRange:[self.valueLabel.text rangeOfString:self.model.commission]];
        
        if ([self.model.is_sqdl integerValue]>0) {
            self.starImg.hidden=NO;
        }else{
            self.starImg.hidden=YES;
        }
    }
}
@end
