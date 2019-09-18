//
//  FNHSecKillPublicCell.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/8/4.
//  Copyright © 2016年 jimmy. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "FNHSecKillPublicCell.h"

@interface FNHSecKillPublicCell ()
@end
@implementation FNHSecKillPublicCell
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
    //product image
    UIImageView *proImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:proImageView];
    _proImageView = proImageView;
    
    //the descriotion
    UILabel *desLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    desLabel.textColor = [UIColor blackColor];
    desLabel.numberOfLines = 2;
    desLabel.font = FNFontDefault(FNGlobalFontNormalSize);
    [self.contentView addSubview:desLabel];
    _proDescriptionLabel  = desLabel;
    
    //the real price of product
    UILabel *realPriceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    realPriceLabel.textColor = FNMainGobalControlsColor;
    realPriceLabel.font = FNFontDefault(FNGlobalFontNormalSize+1);
    [self.contentView addSubview:realPriceLabel];
    _realPriceLabel  = realPriceLabel;
    
    //the original price of product
    DiscountLabel*orginalPrice = [[DiscountLabel alloc]initWithFrame:CGRectMake(0, 0, 100, 0 )];
    orginalPrice.textColor = FNMainTextNormalColor;
    orginalPrice.lineColor = FNMainTextNormalColor;
    orginalPrice.lineWidth = 2.0;
    orginalPrice.font = FNFontDefault(FNGlobalFontNormalSize-3);
    [self.contentView addSubview:orginalPrice];
    _originalPriceLabel = orginalPrice;
    
    // the salling state of product
    UIButton *stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [stateBtn setTitle:@"马上抢" forState:UIControlStateNormal];
    
    stateBtn.backgroundColor = RED;
    stateBtn.cornerRadius = 15;
    [stateBtn sizeToFit];
    stateBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [stateBtn addTarget:self action:@selector(observingStateButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:stateBtn];
    _stateButton = stateBtn;
    [self layoutAllViews];
}
- (void)layoutAllViews
{
    CGFloat verticalMargin = 10;
    CGFloat horizonalMargin = 10;
    
    // the layout for product image ,lack of layout for size
    [_proImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:horizonalMargin];
    [_proImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:verticalMargin];
    [_proImageView autoSetDimensionsToSize:CGSizeMake(100, 100)];
    [_proImageView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
 
    //the layout for description of product
    [_proDescriptionLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_proImageView withOffset:horizonalMargin];
    [_proDescriptionLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:horizonalMargin];
    [_proDescriptionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_proImageView];
    
    //the layout for real price of product
    [_realPriceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_proImageView withOffset:horizonalMargin];
    [_realPriceLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_proDescriptionLabel withOffset:2*horizonalMargin];
    
    //the layout for original price of product
    [_originalPriceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_realPriceLabel withOffset:horizonalMargin];
    [_originalPriceLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_realPriceLabel ];
    
    //layout for state button
    [_stateButton autoSetDimensionsToSize:CGSizeMake(_stateButton.width+10, 30)];
    [_stateButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:horizonalMargin];
    [_stateButton autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_proImageView];
    
}

#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNHSecKillPublicCell";
    FNHSecKillPublicCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNHSecKillPublicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
#pragma mark - observing state button
- (void)observingStateButton:(UIButton *)btn
{
    if (self.buttonClickBlock) {
        self.buttonClickBlock(_indexPath,!btn.selected);
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
