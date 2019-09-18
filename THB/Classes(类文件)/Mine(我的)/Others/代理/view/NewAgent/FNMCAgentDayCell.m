//
//  FNMCAgentDayCell.m
//  THB
//
//  Created by jimmy on 2017/7/27.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNMCAgentDayCell.h"
#import "FNCmbDoubleTextButton.h"
const CGFloat _adc_cell_height = 50+64+50;
const CGFloat _adc_date_height = 50;
const CGFloat _adc_info_heigt = 64+50;
const CGFloat _adc_label_height = 50;
const CGFloat _adc_value_height = 64;
@interface FNMCAgentDayCell ()
@property (nonatomic, strong) UIView* dateView;

@property (nonatomic, strong) UIView* infoView;
@property (nonatomic, strong) UILabel* settlementLabel;
@property (nonatomic, strong)UIView* valueView;
@property (nonatomic, strong) NSMutableArray<FNCmbDoubleTextButton *>* btns;
@end
@implementation FNMCAgentDayCell
- (NSMutableArray<FNCmbDoubleTextButton *> *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray new];
    }
    return _btns;
}
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
    _dateView  = [UIView new];
    [self.contentView addSubview:_dateView];
    [_dateView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [_dateView autoSetDimension:(ALDimensionHeight) toSize:_adc_date_height];
    
    UIButton* today = [UIButton buttonWithTitle:@"今日" titleColor:FNBlackColor font:kFONT14 target:self action:@selector(changeDateAction:) ];
    today.selected = YES;
    [today setTitleColor:FNMainGobalControlsColor forState:UIControlStateSelected];
    [_dateView addSubview:today];
    [today autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeRight)] ;
    [today autoSetDimension:(ALDimensionWidth) toSize:FNDeviceWidth*0.5];
    _todaybtn = today;
    
    UIButton* yesterday = [UIButton buttonWithTitle:@"昨日" titleColor:FNBlackColor font:kFONT14 target:self action:@selector(changeDateAction:) ];
    [yesterday setTitleColor:FNMainGobalControlsColor forState:UIControlStateSelected];
    [_dateView addSubview:yesterday];
    [yesterday autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeLeft)] ;
    [yesterday autoSetDimension:(ALDimensionWidth) toSize:FNDeviceWidth*0.5];
    _yesterdaybtn = yesterday;
    
    UIView *dateline = [ UIView new];
    dateline.backgroundColor = FNHomeBackgroundColor;
    [self.dateView addSubview:dateline];
    [dateline autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:margin];
    [dateline autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:margin];
    [dateline autoSetDimension:(ALDimensionWidth) toSize:1.0];
    [dateline autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    
    //
    _infoView = [UIView new];
    [self.contentView addSubview:_infoView];
    [_infoView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeTop)];
    [_infoView autoSetDimension:(ALDimensionHeight) toSize:_adc_info_heigt];
    
    UIView * labelView = [UIView new];
    [self.infoView addSubview:labelView];
    [labelView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [labelView autoSetDimension:(ALDimensionHeight) toSize:_adc_label_height];
    
    
    _settlementLabel = [UILabel new];
    _settlementLabel.font =kFONT14;
    _settlementLabel.text= @"结算预估收入：¥0.00";
    [labelView addSubview:_settlementLabel];
    [_settlementLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:margin];
    [_settlementLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    _valueView = [UIView new];
    [_infoView addSubview:_valueView];
    [_valueView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [_valueView autoSetDimension:(ALDimensionHeight) toSize:_adc_value_height];
     
    NSArray* titles = @[@"付款笔数(笔)",@"效果预估(笔)"];
    CGFloat width = FNDeviceWidth*0.5;
    
    if (self.btns.count>=1) {
        [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //
        FNCmbDoubleTextButton* btn = [[FNCmbDoubleTextButton alloc]initWithFrame:(CGRectMake(0, 0, width, _adc_value_height))];
        [btn.topLable setTitleColor:FNBlackColor forState:UIControlStateNormal];
        [btn.topLable setTitle:obj forState:UIControlStateNormal];
        [btn.bottomLabel setTitle:@"0" forState:(UIControlStateNormal)];
        [btn.bottomLabel setTitleColor:FNMainGobalControlsColor forState:UIControlStateNormal];
        [self.valueView addSubview:btn];
        [btn autoSetDimensionsToSize:(CGSizeMake(width, _adc_value_height))];
        [btn autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
        [btn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:idx*width];
        [self.btns addObject:btn];
    }];
    
    UIView *line = [ UIView new];
    line.backgroundColor = FNHomeBackgroundColor;
    [self.valueView addSubview:line];
    [line autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:margin];
    [line autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:margin];
    [line autoSetDimension:(ALDimensionWidth) toSize:1.0];
    [line autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    
    UIView* midLine = [UIView new];
    midLine.backgroundColor = FNHomeBackgroundColor;
    [self.contentView addSubview:midLine];
    [midLine autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [midLine autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [midLine autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_dateView];
    [midLine autoSetDimension:(ALDimensionHeight) toSize:1.0];
}
- (void)changeDateAction:(UIButton *)btn{
    if (btn == _todaybtn    ) {
        _todaybtn.selected = YES;
        _yesterdaybtn.selected = NO;
    }else{
        _todaybtn.selected = NO;
        _yesterdaybtn.selected = YES;
    }
    if (self.changeDateBlock) {
        self.changeDateBlock(btn == _todaybtn);
    }
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNMCAgentDayCell";
    FNMCAgentDayCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNMCAgentDayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
- (void)setToday:(NSString *)today{
    _today = today;
    if (_today&& self.btns.count>=1) {
        
        [self.btns[0].bottomLabel setTitle:_today forState:(UIControlStateNormal)];
    }
}
- (void)setYesterday:(NSString *)yesterday{
    _yesterday = yesterday;
    if (_yesterday&& self.btns.count==2) {
        
        [self.btns[1].bottomLabel setTitle:_yesterday forState:(UIControlStateNormal)];
    }
}
- (void)setMoney:(NSString *)money{
    _money = money;
    if (_money) {
        _settlementLabel.text= [NSString stringWithFormat:@"结算预估收入： %.2f",[_money floatValue]];
        [_settlementLabel HttpLabelLeftImage:[FNBaseSettingModel settingInstance].mon_icon label:_settlementLabel imageX:0 imageY:-1.5 imageH:13 atIndex:7];
    }
    
}
@end
