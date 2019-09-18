//
//  FNBuyProductCell.m
//  LikeKaGou
//
//  Created by jimmy on 16/9/29.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "FNBuyProductCell.h"
#import "FNBuyProductModel.h"

#define BPCMargin 10.0f
#define BPCFont FNFontDefault(FNGlobalFontNormalSize)

@implementation FNBuyProductCell
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
    UIImageView *proImageView = [ UIImageView new];
    [self.contentView addSubview:proImageView];
    _proImageView  = proImageView;
    
    //标题
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = FNFontDefault(FNGlobalFontNormalSize+3);
    
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    //价格相关
    [self setUpPriceView];
    
    //操作按钮
    UIButton *operationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [operationBtn setImage:[UIImage imageNamed:@"buy_bton_beOn"] forState:UIControlStateNormal];
    [operationBtn addTarget:self action:@selector(operationBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [operationBtn sizeToFit];
    [self.contentView addSubview:operationBtn];
    _operationBtn = operationBtn;
    
    
    [self layoutAllViews];
}
- (void)setUpPriceView{
    //price view
    UIView *priceView = [UIView new];
    [self.contentView addSubview:priceView];
    _priceView = priceView;
    
    //领券购
    UILabel *priceTitleLabel = [UILabel new];
    priceTitleLabel.font = FNFontDefault(FNGlobalFontNormalSize-2);
    priceTitleLabel.textColor = FNGlobalTextGrayColor;
    [_priceView addSubview:priceTitleLabel];
    _priceTitleLabel = priceTitleLabel;
    
    //实际价格
    UILabel *realPriceLabel = [UILabel new];
    realPriceLabel.font = BPCFont;
    realPriceLabel.textColor = FNMainGobalTextColor;
    [_priceView addSubview:realPriceLabel];
    _realPriceLabel = realPriceLabel;
    
    //原价
    UILabel *originalPriceLabel = [UILabel new];
    originalPriceLabel.font = BPCFont;
    originalPriceLabel.textColor = FNGlobalTextGrayColor;
    originalPriceLabel.adjustsFontSizeToFitWidth = YES;
    [_priceView addSubview:originalPriceLabel];
    _originalPriceLabel = originalPriceLabel;
    
    //券抵价格
    UILabel *discountPriceLable = [UILabel new];
    discountPriceLable.font = BPCFont;
    discountPriceLable.textColor = FNMainGobalTextColor;
    discountPriceLable.adjustsFontSizeToFitWidth = YES;
    [_priceView addSubview:discountPriceLable];
    _discountPriceLable = discountPriceLable;
    
    UIView *verticalLineView = [UIView new];
    verticalLineView.backgroundColor = FNGlobalTextGrayColor;
    [_priceView addSubview:verticalLineView];
    _verticalLineView = verticalLineView;
    
    JMProgressView *progressView = [JMProgressView new];
    progressView.borderColor = FNMainGobalControlsColor;
    progressView.borderWidth = 1.0;
    progressView.cornerRadius = 5;
    progressView.bgColor =FNWhiteColor;
    progressView.highlightedColor =FNMainGobalControlsColor;
    progressView.maxNum = 100;
    [_priceView addSubview:progressView];
    _progressView = progressView;
    
    
    //领用人数
    UILabel *userCountLabel = [UILabel new];
    userCountLabel.font = BPCFont;
    userCountLabel.textColor = FNGlobalTextGrayColor;
    userCountLabel.adjustsFontSizeToFitWidth = YES;
    [_priceView addSubview:userCountLabel];
    _userCountLabel = userCountLabel;
}
- (void)layoutAllViews
{
    CGFloat proImageW = FNDeviceWidth*0.25;
    
    [_proImageView autoSetDimensionsToSize:CGSizeMake(proImageW, proImageW)];
    [_proImageView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:BPCMargin];
    [_proImageView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:BPCMargin];
    [_titleLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_proImageView withOffset:BPCMargin];
    [_titleLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:_proImageView withOffset:0];
    
    [_operationBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:BPCMargin];
    [_operationBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_operationBtn autoSetDimensionsToSize:_operationBtn.size];
    
    [self layoutPriceView];
    
    [_priceView autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_proImageView withOffset:BPCMargin];
    [_priceView autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:_operationBtn withOffset:-BPCMargin];
    [_priceView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_titleLabel withOffset:BPCMargin*0.5];
    [_priceView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_proImageView];
    
    
}
- (void)layoutPriceView{
    [_priceTitleLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_priceTitleLabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0.5*BPCMargin];
    
    [_realPriceLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_realPriceLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_progressView autoSetDimensionsToSize:CGSizeMake(FNDeviceWidth*0.2, 10)];
    [_progressView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_progressView autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0.5*BPCMargin];
    
    [_userCountLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [_userCountLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:_progressView];
    [_userCountLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_progressView withOffset:BPCMargin];
    
    [_verticalLineView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:BPCMargin*0.5];
    [_verticalLineView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_realPriceLabel withOffset:0];
    [_verticalLineView autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    [_verticalLineView autoSetDimension:(ALDimensionWidth) toSize:1.0f];
    
    [_originalPriceLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:_verticalLineView];
    [_originalPriceLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [_originalPriceLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_verticalLineView withOffset:BPCMargin*0.5];
    
    [_discountPriceLable autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_verticalLineView];
    [_discountPriceLable autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [_discountPriceLable autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_originalPriceLabel];
    
    
}
#pragma mark - button event
- (void)operationBtnOnClicked:(UIButton *)btn
{
    
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNBuyProductCell";
    FNBuyProductCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNBuyProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}

- (void)setModel:(FNBuyProductModel *)model
{
    _model = model;
    if (_model) {
        [_proImageView setUrlImg:_model.goods_img];
        _titleLabel.text =  _model.goods_title;
        _priceTitleLabel.text = @"领券购";
        _realPriceLabel.text = [NSString stringWithFormat:@"￥%@",_model.goods_price];
        _originalPriceLabel.text=  [NSString stringWithFormat:@"支付%@元",_model.goods_price];
        _discountPriceLable.text = [NSString stringWithFormat:@"券抵%@元",_model.yhq_price];
        _userCountLabel.text = [NSString stringWithFormat:@"已有%@人领用",_model.yhq_n];
        [_progressView setPersentNum:_model.jindu.intValue];
        if ([_model.state isEqualToString:@"即将开抢"]) {
            
            [_operationBtn setImage:[UIImage imageNamed:@"buy_bton_beOn"] forState:UIControlStateNormal];
        }else if ([_model.state isEqualToString:@"已抢光"]){
            [_operationBtn setImage:[UIImage imageNamed:@"buy_bton_off"] forState:UIControlStateNormal];
        }else {
            [_operationBtn setImage:[UIImage imageNamed:@"buy_bton_on"] forState:UIControlStateNormal];
        }
    }else {
        NSString *empty = @"0.00";
        [_proImageView setUrlImg:_model.goods_img];
        _titleLabel.text =  _model.goods_title;
        _priceTitleLabel.text = @"领券购";
        _realPriceLabel.text = [NSString stringWithFormat:@"￥%@",empty];
        _originalPriceLabel.text=  [NSString stringWithFormat:@"支付%@元",empty];
        _discountPriceLable.text = [NSString stringWithFormat:@"券抵%@元",empty];
        _userCountLabel.text = [NSString stringWithFormat:@"已有%@人领用",empty];
    }
}
@end
