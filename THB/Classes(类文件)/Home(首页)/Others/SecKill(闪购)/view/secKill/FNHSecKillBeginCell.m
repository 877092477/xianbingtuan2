//
//  FNHSecKillBeginCell.m
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

#import "FNHSecKillBeginCell.h"
#import "FNHSecKillProudctModel.h"
#import "JMProgressView.h"
@interface FNHSecKillBeginCell ()
@property (nonatomic, weak) UILabel *rebateLabel;
@property (nonatomic, weak)JMProgressView *progressView;
@property (nonatomic, weak)UILabel *soldCountLabel;
@end
@implementation FNHSecKillBeginCell
- (void)initializedSubviews
{
    [super initializedSubviews];
    CGFloat horizonalMargin = 10;
    CGFloat verticalMargin = 10;
    self.realPriceLabel.font = kFONT15;
    self.realPriceLabel.textColor= FNBlackColor;
    //
    UILabel *rebateLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    rebateLabel.textColor = RED;
    rebateLabel.font = kFONT15;
    rebateLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:rebateLabel];
    _rebateLabel = rebateLabel;
    
    //
    JMProgressView *progressView = [[JMProgressView alloc]initWithFrame:CGRectZero];
    progressView.borderColor = FNHomeBackgroundColor;
    progressView.borderWidth = 1.0;
    progressView.cornerRadius = 10;
    progressView.bgColor =FNColor(246, 160, 190);
    progressView.highlightedColor =RED;
    progressView.maxNum = 100;
    [self.contentView addSubview:progressView];
    _progressView = progressView;
    
    //
    UILabel *soldCountLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    soldCountLabel.textColor = FNWhiteColor;
    soldCountLabel.font = kFONT12;
    soldCountLabel.adjustsFontSizeToFitWidth = YES;
    soldCountLabel.textAlignment= NSTextAlignmentCenter;
    [self.contentView addSubview:soldCountLabel];
    _soldCountLabel = soldCountLabel;
    
    //layout views
    [_rebateLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.originalPriceLabel withOffset:10];
    [_rebateLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.realPriceLabel];
    [_rebateLabel autoSetDimension:(ALDimensionWidth) toSize:self.stateButton.width relation:(NSLayoutRelationLessThanOrEqual)];
    
    [_progressView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.proImageView withOffset:horizonalMargin];
    [_progressView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.stateButton];
    
    [_progressView autoSetDimension:(ALDimensionHeight) toSize:20];
    [_progressView autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:self.stateButton withOffset:-20];
    
    
    
    [_soldCountLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_progressView];
    [_soldCountLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:_progressView];
    [_soldCountLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:_progressView];
    
    UIView *line = [UIView new];
    line.backgroundColor = FNHomeBackgroundColor;
    [self.contentView addSubview:line];
    [line autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [line autoSetDimension:(ALDimensionHeight) toSize:1.0];
    
    [self setupAutoHeightWithBottomView:self.proImageView bottomMargin:verticalMargin];
}

#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNHSecKillBeginCell";
    FNHSecKillBeginCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNHSecKillBeginCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
- (void)setModel:(FNHSecKillProudctModel *)model
{
    _model = model;
    
    //set datas
    if (_model) {
        [self.proImageView setUrlImg:_model.goods_img];
        
        self.proDescriptionLabel.text = _model.goods_title;
        
        self.realPriceLabel.text =[NSString stringWithFormat:@"¥%@",_model.goods_price];
        
        self.originalPriceLabel.text = [NSString stringWithFormat:@"¥%@",_model.goods_cost_price];
        
        [self.stateButton setTitle:_model.str forState:UIControlStateNormal];
        self.stateButton.selected = YES;
        if ([_model.str isEqualToString:@"己抢光"]) {
            self.stateButton.backgroundColor = FNHomeBackgroundColor;
        }else{
            self.stateButton.backgroundColor = RED;
        }
        
        self.rebateLabel.text =[NSString stringWithFormat:@"再返%@",_model.fcommission];
        
        self.soldCountLabel.text  = [NSString stringWithFormat:@"已抢%@件", _model.goods_sales];
        [_progressView setPersentNum:_model.jindu.intValue];

        
    }
}
@end
