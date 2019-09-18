//
//  FNProfitStatisticsCell.m
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNProfitStatisticsCell.h"
const CGFloat _psc_cell_height= 120;
const CGFloat _psc_top_height = 40;
const CGFloat _psc_btn_height = 80;
@interface FNProfitStatisticsCell()
@property (nonatomic, strong)UIView* titleview;

@property (nonatomic, strong)UIView* btnview;
@end
@implementation FNProfitStatisticsCell

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = kFONT14;
        _titleLabel.textColor = FNGlobalTextGrayColor;
    }
    return _titleLabel;
}
- (UIView *)titleview{
    if (_titleview == nil) {
        _titleview = [UIView new];
        
        [_titleview addSubview:self.titleLabel];
        [self.titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:15];
        [self.titleLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    }
    return _titleview;
}


- (FNCmbDoubleTextButton *)leftBtn{
    if (_leftBtn == nil) {
        _leftBtn = [[FNCmbDoubleTextButton alloc]init];
        [_leftBtn.bottomLabel setTitleColor:FNGlobalTextGrayColor forState:(UIControlStateNormal)];
        _leftBtn.bottomLabel.titleLabel.font = kFONT12;
        [_leftBtn.topLable setTitleColor:FNBlackColor forState:(UIControlStateNormal)];
        _leftBtn.topLable.titleLabel.font = kFONT12;
    }
    return _leftBtn;
}
- (FNCmbDoubleTextButton *)rightBtn{
    if (_rightBtn == nil) {
        _rightBtn = [[FNCmbDoubleTextButton alloc]init];
        [_rightBtn.bottomLabel setTitleColor:FNGlobalTextGrayColor forState:(UIControlStateNormal)];
        _rightBtn.bottomLabel.titleLabel.font = kFONT12;
        [_rightBtn.topLable setTitleColor:FNBlackColor forState:(UIControlStateNormal)];
        _rightBtn.topLable.titleLabel.font = kFONT12;
    }
    return _rightBtn;
}
- (UIView *)btnview{
    if (_btnview == nil) {
        _btnview = [UIView new];
        
        CGFloat width = (JMScreenWidth-15*2)*0.5;
        [_btnview addSubview:self.leftBtn];
        [self.leftBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:15];
        [self.leftBtn autoSetDimension:(ALDimensionWidth) toSize:width*0.5];
        [self.leftBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.leftBtn autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionHeight) ofView:_btnview withMultiplier:0.7];
        
        [_btnview addSubview:self.rightBtn];
        [self.rightBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:15+width];
        [self.rightBtn autoSetDimension:(ALDimensionWidth) toSize:width*0.5];
        [self.rightBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.rightBtn autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionHeight) ofView:_btnview withMultiplier:0.7];
        
    }
    return _btnview;
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
    [self.contentView addSubview:self.titleview];
    [self.titleview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.titleview autoSetDimension:(ALDimensionHeight) toSize:_psc_top_height];
    
    [self.contentView addSubview:self.btnview];
    [self.btnview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [self.btnview autoSetDimension:(ALDimensionHeight) toSize:_psc_btn_height];
    
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNProfitStatisticsCell";
    FNProfitStatisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNProfitStatisticsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
@end
