//
//  FNMCAOrderDetailCell.m
//  THB
//
//  Created by jimmy on 2017/7/27.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNMCAOrderDetailCell.h"
#import "FNMCAOrderDetailModel.h"
const CGFloat _aodc_cell_height = 40*2+120;
const CGFloat _aodc_mid_height = 120;
const CGFloat _aodc_top_height = 40;
@interface FNMCAOrderDetailCell ()
@property (nonatomic, strong) UIView* topview;
@property (nonatomic, strong) UILabel* orderLabel;
@property (nonatomic, strong) UILabel* statusLabel;

@property (nonatomic, strong) UIView* midview;
@property (nonatomic, strong) UIImageView* proimgView;
@property (nonatomic, strong) UILabel* deslabel;
@property (nonatomic, strong) UILabel* paymentLabel;
@property (nonatomic, strong) UILabel* comissionLabel;

@property (nonatomic, strong) UIView* btmview;
@property (nonatomic, strong) UILabel* dateLabel;
@end
@implementation FNMCAOrderDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self jm_setupViews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    CGFloat margin = _jm_leftMargin;
    //
    _topview = [UIView new];
    [self.contentView addSubview:_topview];
    [_topview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [_topview autoSetDimension:(ALDimensionHeight) toSize:_aodc_top_height];
    
    _orderLabel = [UILabel new];
    _orderLabel.font = kFONT14;
    _orderLabel.textColor = FNGlobalTextGrayColor;
    [_topview addSubview:_orderLabel];
    [_orderLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:margin];
    [_orderLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    _statusLabel = [UILabel new];
    _statusLabel.font = kFONT14;
    _statusLabel.textColor = FNMainGobalControlsColor;
    [_topview addSubview:_statusLabel];
    [_statusLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:margin];
    [_statusLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    //
    
    _midview = [UIView new];
    _midview.borderColor = FNHomeBackgroundColor;
    _midview.borderWidth = 1.0;
    [self.contentView addSubview:_midview];
    [_midview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [_midview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_midview autoSetDimension:(ALDimensionHeight) toSize:_aodc_mid_height];
    [_midview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_topview];
    
    _proimgView = [UIImageView new];
    _proimgView.contentMode = UIViewContentModeScaleAspectFit;
    _proimgView.image=DEFAULT;
    [_midview addSubview:_proimgView];
    [_proimgView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(5, margin, 5, 0)) excludingEdge:(ALEdgeRight)];
    [_proimgView autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionHeight) ofView:_proimgView];
    
    _deslabel = [UILabel new];
    _deslabel.font = kFONT14;
    _deslabel.numberOfLines = 2;
    [_midview addSubview:_deslabel];
    [_deslabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:10];
    [_deslabel autoSetDimension:(ALDimensionHeight) toSize:40];
    [_deslabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:margin];
    [_deslabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_proimgView withOffset:10];
    
    _comissionLabel = [UILabel new];
    _comissionLabel.font = kFONT14;
    _comissionLabel.textColor = FNMainGobalControlsColor;
    [_midview addSubview:_comissionLabel];
    [_comissionLabel autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:10];
    [_comissionLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:margin];
    [_comissionLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_proimgView withOffset:10];
    
    _paymentLabel = [UILabel new];
    _paymentLabel.font = kFONT14;
    _paymentLabel.textColor = FNGlobalTextGrayColor;
    [_midview addSubview:_paymentLabel];
    [_paymentLabel autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:_comissionLabel withOffset:-8];
    [_paymentLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:margin];
    [_paymentLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_proimgView withOffset:10];

    //
    _btmview = [UIView new];
    [self.contentView addSubview:_btmview];
    [_btmview autoSetDimension:(ALDimensionHeight) toSize:_aodc_top_height];
    [_btmview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    
    _dateLabel = [UILabel new];
    _dateLabel.font = kFONT14;
    _dateLabel.textColor = FNGlobalTextGrayColor;
    [_btmview addSubview:_dateLabel];
    [_dateLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:margin];
    [_dateLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNMCAOrderDetailCell";
    FNMCAOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNMCAOrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
- (void)setModel:(FNMCAOrderDetailModel *)model{
    _model =model;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_proimgView setUrlImg:_model.goods_img];
    });
    _orderLabel.text = [NSString stringWithFormat:@"订单号：%@",_model.orderId];
    _statusLabel.text = _model.status;
    _deslabel.text = _model.goods_title;
    
    _paymentLabel.text = [NSString stringWithFormat:@"付款金额：¥%.2f",[_model.payment floatValue]];
    _comissionLabel.text = [NSString stringWithFormat:@"佣金：%.2f元",[_model.commission floatValue]];
    
    _dateLabel.text = [NSString stringWithFormat:@"下单时间：%@",[NSString getTimeStr:_model.createDate]];
}
@end
