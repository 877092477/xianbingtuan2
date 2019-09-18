//
//  FNHSecKillTBDCell.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/8/5.
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

#import "FNHSecKillTBDCell.h"
#import "FNHSecKillProudctModel.h"
@interface FNHSecKillTBDCell ()
@property (nonatomic, weak) UILabel *tbdTimeLabel;
@property (nonatomic, weak)UILabel *remindCountLabel;
@end
@implementation FNHSecKillTBDCell

#pragma mark - override super's initializedSubviews
- (void)initializedSubviews
{
    [super initializedSubviews];
    CGFloat horizonalMargin = 10;
    CGFloat verticalMargin = 10;
    //
    UILabel *tbdTimeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    tbdTimeLabel.textColor = FNMainTextNormalColor;
    tbdTimeLabel.font = FNFontDefault(FNGlobalFontNormalSize-3);
    [self.contentView addSubview:tbdTimeLabel];
    _tbdTimeLabel = tbdTimeLabel;
    
    //
    UILabel *remindCountLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    remindCountLabel.textColor = FNMainTextNormalColor;
    remindCountLabel.font = FNFontDefault(FNGlobalFontNormalSize-3);
    [self.contentView addSubview:remindCountLabel];
    _remindCountLabel = remindCountLabel;
    
    //layout views
    [_tbdTimeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.realPriceLabel ];
    [_tbdTimeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.realPriceLabel withOffset:2*verticalMargin];
    
    [_remindCountLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_tbdTimeLabel ];
    [_remindCountLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:horizonalMargin];
    
    [self setupAutoHeightWithBottomView:_tbdTimeLabel bottomMargin:verticalMargin];
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNHSecKillTBDCell";
    FNHSecKillTBDCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNHSecKillTBDCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
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
        
        self.realPriceLabel.text = [NSString stringWithFormat:@"¥%@",_model.goods_price];
        
        self.originalPriceLabel.text = [NSString stringWithFormat:@"¥%@",_model.goods_cost_price];
        
        self.stateButton.selected = _model.state;
        
        self.tbdTimeLabel.text =[NSString stringWithFormat:@"%@",_model.str2?_model.str2 :_model.str];
        
        NSString *tmp = @"0";
        self.remindCountLabel.text  = [NSString stringWithFormat:@"已有%@人设置提醒", _model.tixing==nil || _model.tixing.length==0?_model.tixing:tmp];
        
        [self setRemindImage:_model.isRemind];
        
    }
}
- (void)setRemindImage:(BOOL)isRemind
{
    if (isRemind) {
        [self.stateButton setImage:[UIImage imageNamed:@"home_seckill_cancelReminder"] forState:UIControlStateNormal];

    }
}
@end
