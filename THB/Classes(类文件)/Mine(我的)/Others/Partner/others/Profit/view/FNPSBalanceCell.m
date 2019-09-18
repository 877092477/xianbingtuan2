//
//  FNPSBalanceCell.m
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPSBalanceCell.h"
#import "FNCmbDoubleTextButton.h"
@interface FNPSBalanceCell()
@property (nonatomic, strong)UIView* titleview;
@property (nonatomic, strong)UIView* btnview;
@end
@implementation FNPSBalanceCell
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
- (UIButton *)withdrawBtn{
    if (_withdrawBtn == nil) {
        NSString *is_tx=[[NSUserDefaults standardUserDefaults] objectForKey:@"JM_MPM_wallet_is_tx"];
        if ([NSString checkIsSuccess:is_tx andElement:@"1"]) {
            _withdrawBtn = [UIButton buttonWithTitle:@"" titleColor:FNMainGobalControlsColor font:kFONT14 target:self action:@selector(withdrawBtnAction)];
            _withdrawBtn.borderColor = FNMainGobalControlsColor;
        }else{
            NSString *title1=[[NSUserDefaults standardUserDefaults] objectForKey:@"JM_MPM_wallet_title1"];
            _withdrawBtn = [UIButton buttonWithTitle:title1 titleColor:FNGlobalTextGrayColor font:kFONT14 target:self action:nil];
            _withdrawBtn.borderColor = FNGlobalTextGrayColor;
        }
        _withdrawBtn.borderWidth = 1;
        [_withdrawBtn sizeToFit];
        _withdrawBtn.cornerRadius = (_withdrawBtn.height)*0.5;
    }
    return _withdrawBtn;
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
        [self.rightBtn autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.leftBtn withOffset:0];
        [self.rightBtn autoSetDimension:(ALDimensionWidth) toSize:width*0.5];
        [self.rightBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.rightBtn autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionHeight) ofView:_btnview withMultiplier:0.7];
        
        [_btnview addSubview:self.withdrawBtn];
        [self.withdrawBtn autoSetDimensionsToSize:(CGSizeMake(self.withdrawBtn.width+_jmsize_10*2, self.withdrawBtn.height))];
        [self.withdrawBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.withdrawBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15+(width-self.withdrawBtn.width-_jmsize_10*2)*0.5];
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
    //
    [self.contentView addSubview:self.titleview];
    [self.titleview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.titleview autoSetDimension:(ALDimensionHeight) toSize:40];
    
    [self.contentView addSubview:self.btnview];
    [self.btnview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [self.btnview autoSetDimension:(ALDimensionHeight) toSize:80];
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNPSBalanceCell";
    FNPSBalanceCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNPSBalanceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark - action
- (void)withdrawBtnAction{
    if (self.withdrawBlock) {
        self.withdrawBlock();
    }
}
@end
