//
//  JMShopRebateCell.m
//  THB
//
//  Created by jimmy on 2017/4/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMShopRebateCell.h"
#import "ShopListModel.h"
@interface JMShopRebateCell ()
@property (nonatomic, strong) UIImageView*  logoImgView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* desLabel;
@property (nonatomic, strong) UILabel* rebateLabel;

@property (nonatomic, strong)UIButton* shoppingBtn;
@end
@implementation JMShopRebateCell

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
    CGFloat imgSize = 80;
    _logoImgView = [UIImageView new];
//    _logoImgView.cornerRadius = imgSize*0.5;
    _logoImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_logoImgView];
    [_logoImgView autoSetDimensionsToSize:(CGSizeMake(imgSize, imgSize))];
    [_logoImgView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_logoImgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = kFONT16;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_logoImgView withOffset:_jm_leftMargin];
    [_titleLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:_logoImgView withOffset:0];
    
    UIButton* shoppingBtn = [UIButton  buttonWithType:(UIButtonTypeCustom)];
    shoppingBtn.userInteractionEnabled = NO;
    [shoppingBtn setTitle:@" 去购物 " forState:UIControlStateNormal];
    [shoppingBtn sizeToFit];
    shoppingBtn.borderColor = FNMainGobalControlsColor;
    shoppingBtn.borderWidth = 1.0;
    [shoppingBtn setTitleColor:FNMainGobalControlsColor forState:(UIControlStateNormal)];
    shoppingBtn.titleLabel.font = kFONT14;
    [self.contentView addSubview:shoppingBtn];
    _shoppingBtn = shoppingBtn;
    [_shoppingBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin];
    [_shoppingBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_shoppingBtn autoSetDimensionsToSize:(CGSizeMake(_shoppingBtn.width, 34))];
    
    _desLabel = [UILabel new];
    _desLabel.font = kFONT14;
    _desLabel.textColor = FNGlobalTextGrayColor;
    [self.contentView addSubview:_desLabel];
    
    [_desLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_desLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_titleLabel];
    [_desLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:_shoppingBtn withOffset: -_jm_margin10];
    
    _rebateLabel = [UILabel new];
    _rebateLabel.font = kFONT14;
    _rebateLabel.textColor = RED;
    [self.contentView addSubview:_rebateLabel];
    [_rebateLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_titleLabel];
    [_rebateLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:_shoppingBtn withOffset:-_jm_margin10];
    [_rebateLabel autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_logoImgView];
    
    
    
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"JMShopRebateCell";
    JMShopRebateCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[JMShopRebateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
- (void)setModel:(ShopListModel *)model{
    _model = model;
    if (_model) {
        [_logoImgView setUrlImg:_model.scdg_logo];
        _titleLabel.text = _model.shop_name;
        _desLabel.text = _model.scdg_intr;
        _rebateLabel.text = [NSString stringWithFormat:@"最高返%@",_model.scdg_bili];
    }
}
@end
