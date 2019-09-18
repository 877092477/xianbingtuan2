//
//  FNRMAccountManagementCell.m
//  嗨如意
//
//  Created by Jimmy on 2018/1/16.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNRMAccountManagementCell.h"
#import "FNRMAccountManagementModel.h"
@interface FNRMAccountManagementCell()
@property (nonatomic, strong)UILabel* leftTitleLabel;
@property (nonatomic, strong)UILabel* rightTitleLabel;
@property (nonatomic, strong)UIImageView* bgImgView;
@property (nonatomic, strong)UIImageView* iconImageView;
@property (nonatomic, strong)UILabel* typeLabel;
@property (nonatomic, strong)UILabel* nameLabel;
@property (nonatomic, strong)UILabel* accountLabel;

@end
@implementation FNRMAccountManagementCell
- (UILabel *)leftTitleLabel{
    if (_leftTitleLabel == nil) {
        _leftTitleLabel = [UILabel new];
        _leftTitleLabel.font = kFONT16;
    }
    return _leftTitleLabel;
}
- (UILabel *)rightTitleLabel{
    if (_rightTitleLabel == nil) {
        _rightTitleLabel = [UILabel new];
        _rightTitleLabel.font = kFONT16;
        _rightTitleLabel.text = @"管理";
    }
    return _rightTitleLabel;
}
- (UIImageView *)bgImgView{
    if (_bgImgView == nil) {
        _bgImgView = [[UIImageView alloc]init];
        
        [_bgImgView addSubview:self.iconImageView];
        [self.iconImageView autoSetDimensionsToSize:self.iconImageView.size];
        [self.iconImageView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        [self.iconImageView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jmsize_10];
        
        [_bgImgView addSubview:self.typeLabel];
        [self.typeLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.iconImageView];
        [self.typeLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.iconImageView withOffset:_jmsize_10];
        
        [_bgImgView addSubview:self.nameLabel];
        [self.nameLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.iconImageView];
        [self.nameLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        
        [_bgImgView addSubview:self.accountLabel];
        [self.accountLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [self.accountLabel autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:_jmsize_10];
        [self.accountLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
    }
    return _bgImgView;
}
- iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [UIImageView new];
        _iconImageView.size = IMAGE(@"pay_alipay").size;
    }
    return _iconImageView;
}
- (UILabel *)typeLabel{
    if (_typeLabel == nil) {
        _typeLabel = [UILabel new];
        _typeLabel.font = kFONT14;
        _typeLabel.textColor = FNWhiteColor;
    }
    return _typeLabel;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.font = kFONT14;
        _nameLabel.textColor = FNWhiteColor;
    }
    return _nameLabel;
}
- (UILabel *)accountLabel{
    if (_accountLabel == nil) {
        _accountLabel = [UILabel new];
        _accountLabel.textColor = FNWhiteColor;
        _accountLabel.font = [UIFont boldSystemFontOfSize:16];
        _accountLabel.textAlignment = NSTextAlignmentRight;
    }
    return _accountLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - set up view
- (void)jm_setupViews{
    [self.contentView addSubview:self.leftTitleLabel];
    self.contentView.backgroundColor = FNWhiteColor;
    self.backgroundColor = [UIColor clearColor];
    [self.leftTitleLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
    [self.leftTitleLabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jmsize_10];
    
    [self.contentView addSubview:self.rightTitleLabel];
    [self.rightTitleLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    [self.rightTitleLabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jmsize_10];
    
    [self.contentView addSubview:self.bgImgView];
    [self.bgImgView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.leftTitleLabel withOffset:_jmsize_10];
    [self.bgImgView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    [self.bgImgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
    [self.bgImgView autoSetDimension:(ALDimensionHeight) toSize:(JMScreenWidth-30)*0.32];
    
    [self.contentView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(5, 5, 5, 5))];
    self.contentView.cornerRadius = 5;
    [self setupAutoHeightWithBottomView:self.bgImgView bottomMargin:_jmsize_10*2];
    
    
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    static NSString *reuseIdentifier = @"FNRMAccountManagementCell";
    FNRMAccountManagementCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNRMAccountManagementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}

- (void)setModel:(FNRMAccountManagementModel *)model{
    _model = model;
    if (_model) {
        [self.bgImgView setUrlImg:self.model.bj_img];
        [self.iconImageView setUrlImg:self.model.img];
        self.typeLabel.text = self.model.str;
        self.leftTitleLabel.text = self.model.str;
        self.nameLabel.text = self.model.realname;
        self.accountLabel.text = self.model.alipay;
    }
}
@end
