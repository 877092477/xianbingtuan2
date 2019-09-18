//
//  FNPromotePublicCell.m
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPromotePublicCell.h"
#import "FNPromotePublicModel.h"
const CGFloat _ppc_cell_height = 180+2;
const CGFloat _ppc_top_height = 40;
const CGFloat _ppc_info_height = 100;
@interface FNPromotePublicCell()
@property (nonatomic, strong) UIView * topview;
@property (nonatomic, strong)UILabel* orderLabel;
@property (nonatomic, strong)UILabel*  statusLabel;

@property (nonatomic, strong)UIView* infoview;
@property (nonatomic, strong)UIImageView* proimageview;
@property (nonatomic, strong)UILabel* desLabel;
@property (nonatomic, strong)UILabel* promoteLabel;
@property (nonatomic, strong)UILabel* priceLabel;
@property (nonatomic, strong)UILabel* commissionLabel;

@property (nonatomic, strong)UIView* btmview;
@property (nonatomic, strong)UILabel* orderedDateLabel;
@end
@implementation FNPromotePublicCell
- (UILabel *)orderLabel{
    if (_orderLabel ==nil) {
        _orderLabel = [UILabel new];
        _orderLabel.textColor = FNGlobalTextGrayColor;
        _orderLabel.adjustsFontSizeToFitWidth = YES;
        _orderLabel.font = kFONT14;
    }
    return _orderLabel;
}
- (UILabel *)statusLabel{
    if (_statusLabel ==nil) {
        _statusLabel = [UILabel new];
        _statusLabel.textColor = FNMainGobalControlsColor;
        _statusLabel.adjustsFontSizeToFitWidth = YES;
        _statusLabel.font = kFONT14;
    }
    return _statusLabel;
}
- (UIView *)topview{
    if (_topview ==nil) {
        _topview = [UIView new];
        _topview.backgroundColor = FNWhiteColor;
        [_topview addSubview:self.orderLabel];
        [self.orderLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        [self.orderLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.orderLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_topview withMultiplier:0.7 relation:(NSLayoutRelationLessThanOrEqual)];
        
        
        [_topview addSubview:self.statusLabel];
        [self.statusLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [self.statusLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.statusLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_topview withMultiplier:0.25 relation:(NSLayoutRelationLessThanOrEqual)];
        
    }
    return _topview;
}

//info view
- (UIImageView *)proimageview{
    if (_proimageview == nil) {
        _proimageview = [UIImageView new];
        _proimageview.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _proimageview;
}
- (UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [UILabel new];
        _desLabel.numberOfLines = 2;
        _desLabel.font = kFONT13;
    }
    return _desLabel;
}
- (UILabel *)promoteLabel{
    if (_promoteLabel == nil) {
        _promoteLabel = [UILabel new];
        _promoteLabel.textColor = FNGlobalTextGrayColor;
        _promoteLabel.font = kFONT14;
    }
    return _promoteLabel;
}
- (UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [UILabel new];
        _priceLabel.textColor = FNGlobalTextGrayColor;
        _priceLabel.font = kFONT13;
    }
    return _priceLabel;
}
- (UILabel *)commissionLabel{
    if (_commissionLabel == nil) {
        _commissionLabel = [UILabel new];
        _commissionLabel.textColor = FNMainGobalControlsColor;
        _commissionLabel.font = kFONT14;
    }
    return _commissionLabel;
}
- (UIView *)infoview{
    if (_infoview == nil) {
        _infoview = [UIView new];
        _infoview.backgroundColor = FNWhiteColor;
        
        [_infoview addSubview:self.proimageview];
        [self.proimageview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(_jmsize_10, _jmsize_10, _jmsize_10, _jmsize_10)) excludingEdge:(ALEdgeRight)];
        [self.proimageview autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionHeight) ofView:self.proimageview];
        
        [_infoview addSubview:self.desLabel];
        [self.desLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [self.desLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.proimageview withOffset:_jmsize_10];
        [self.desLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:self.proimageview];
        [self.desLabel autoSetDimension:(ALDimensionHeight) toSize:40];
        
        [_infoview addSubview:self.promoteLabel];
        [self.promoteLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [self.promoteLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.proimageview withOffset:_jmsize_10];
//        [self.promoteLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.promoteLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.desLabel withOffset:0];
        
        [_infoview addSubview:self.priceLabel];
        [self.priceLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.proimageview withOffset:_jmsize_10];
        [self.priceLabel autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.proimageview];
        [self.priceLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_infoview withMultiplier:0.4 relation:(NSLayoutRelationLessThanOrEqual)];
        
        [_infoview addSubview:self.commissionLabel];
        [self.commissionLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        
        [self.commissionLabel autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.proimageview];
        [self.commissionLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_infoview withMultiplier:0.3 relation:(NSLayoutRelationLessThanOrEqual)];
        
        
        
        
    }
    return _infoview;
}

//bottom view
- (UILabel *)orderedDateLabel{
    if (_orderedDateLabel ==nil) {
        _orderedDateLabel = [UILabel new];
        _orderedDateLabel.textColor = FNGlobalTextGrayColor;
        _orderedDateLabel.adjustsFontSizeToFitWidth = YES;
        _orderedDateLabel.font = kFONT14;
    }
    return _orderedDateLabel;
}

- (UIView *)btmview{
    if (_btmview == nil) {
        _btmview = [UIView new];
        _btmview.backgroundColor = FNWhiteColor;
        [_btmview addSubview:self.orderedDateLabel];
        [self.orderedDateLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        [self.orderedDateLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [self.orderedDateLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    }
    return _btmview;
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
    self.backgroundColor = FNHomeBackgroundColor;
    //
    [self.contentView addSubview:self.topview];
    [self.topview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.topview autoSetDimension:(ALDimensionHeight) toSize:_ppc_top_height];
    
    [self.contentView addSubview:self.infoview];
    [self.infoview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.topview withOffset:1];
    [self.infoview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.infoview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [self.infoview autoSetDimension:(ALDimensionHeight) toSize:_ppc_info_height];
    
    [self.contentView addSubview:self.btmview];
    [self.btmview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [self.btmview autoSetDimension:(ALDimensionHeight) toSize:_ppc_top_height];
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    static NSString *reuseIdentifier = @"FNPromotePublicCell";
    FNPromotePublicCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNPromotePublicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
- (void)setModel:(PPMorder *)model{
    _model  =model;
    if (_model) {
        //NSLog(@"goods_img:%@",self.model.goods_img);
        self.orderLabel.text = [NSString stringWithFormat:@"订单号：%@",self.model.orderId];
        self.statusLabel.text = self.model.status;
        if([self.model.goods_img kr_isNotEmpty]){
            [self.proimageview setUrlImg:self.model.goods_img];
        }else{
            self.proimageview.image=DEFAULT;
        }
        self.desLabel.text = self.model.goodsInfo;
        self.orderedDateLabel.text = [NSString stringWithFormat:@"下单时间：%@",[NSString getTimeStr:self.model.createDate]];
        
        NSString* price = [NSString stringWithFormat:@"¥%.2lf",self.model.payment.floatValue];
        NSString* commission = self.model.commission;
        if (self.isMine) {
            self.promoteLabel.text = [NSString stringWithFormat:@"付款金额：%@",price];
            self.priceLabel.text = [NSString stringWithFormat:@"%@：%@%@",[FNBaseSettingModel settingInstance].YJCustomUnit,commission,[FNBaseSettingModel settingInstance].CustomUnit];
        }else{
            self.promoteLabel.text = [NSString stringWithFormat:@"推广人：%@",self.model.tgNickname];
            self.priceLabel.text = [NSString stringWithFormat:@"付款金额：%@",price];
            self.commissionLabel.text = [NSString stringWithFormat:@"%@：%@%@",[FNBaseSettingModel settingInstance].YJCustomUnit,commission,[FNBaseSettingModel settingInstance].CustomUnit];
        }
    }
}
@end
