//
//  FNMCAgentMonthCell.m
//  THB
//
//  Created by jimmy on 2017/7/27.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNMCAgentMonthCell.h"
#import "FNCmbDoubleTextButton.h"
const CGFloat _amc_cell_h = 84+64;
const CGFloat _amc_balance_h = 84;
const CGFloat _amc_month_h = 64;
@interface FNMCAgentMonthCell ()
@property (nonatomic, strong)UIView* balanceView;
@property (nonatomic, strong) UILabel* balanceLabel;

@property (nonatomic, strong) UIView* monthValueView;
@property (nonatomic, strong) NSMutableArray<FNCmbDoubleTextButton *>* btns;

@end
@implementation FNMCAgentMonthCell
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
    //
    CGFloat margin = _jm_leftMargin;
    
    _balanceView = [ UIView new];
    [self.contentView addSubview:_balanceView];
    [_balanceView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [_balanceView autoSetDimension:(ALDimensionHeight) toSize:_amc_balance_h];
    
    UILabel* balanceTitlelabel = [UILabel new];
    balanceTitlelabel.font = kFONT14;
    balanceTitlelabel.text = @"账户余额";
    [_balanceView addSubview:balanceTitlelabel];
    [balanceTitlelabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:margin];
    [balanceTitlelabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:margin];
    
    
    _balanceLabel = [UILabel new];
    _balanceLabel.font = kFONT14;
    _balanceLabel.text = @"----";
    _balanceLabel.textColor = FNMainGobalControlsColor;
    [_balanceView addSubview:_balanceLabel];
    [_balanceLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:margin];
    [_balanceLabel autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:margin];
    
    NSString *is_tx=[[NSUserDefaults standardUserDefaults] objectForKey:@"JM_MPM_wallet_is_tx"];
    NSString *img=[[NSUserDefaults standardUserDefaults] objectForKey:@"JM_MPM_wallet_img"];
    NSString *title1=[[NSUserDefaults standardUserDefaults] objectForKey:@"JM_MPM_wallet_title1"];
    if ([NSString checkIsSuccess:is_tx andElement:@"1"]) {
        UIImageView* withdrawimgview = [[UIImageView alloc]initWithImage:IMAGE(@"my_wallet_withdraw")];
        @weakify(self);
        [withdrawimgview addJXTouch:^{
            @strongify(self);
            if (self.widthdrawAction) {
                self.widthdrawAction();
            }
        }];
        [_balanceView addSubview:withdrawimgview];
        [withdrawimgview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:margin];
        [withdrawimgview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_balanceLabel];
        [withdrawimgview autoSetDimensionsToSize:withdrawimgview.size];
        
        [withdrawimgview setNoPlaceholderUrlImg:img];
    }else{
        NSString* string = title1;
        if (![NSString isEmpty:string]) {
            UIButton* withdrawBtn = [UIButton buttonWithTitle:string titleColor:FNGlobalTextGrayColor font:kFONT12 target:self action:nil];
            [withdrawBtn sizeToFit];
            withdrawBtn.size = CGSizeMake(withdrawBtn.width+_jmsize_10*2, 20);
            withdrawBtn.cornerRadius  = 20*0.5;
            withdrawBtn.borderColor = FNGlobalTextGrayColor;
            withdrawBtn.borderWidth = 1;
            [_balanceView addSubview:withdrawBtn];
            [withdrawBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:margin];
            [withdrawBtn autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_balanceLabel];
            [withdrawBtn autoSetDimensionsToSize:withdrawBtn.size];
        }
    }
    
    _monthValueView = [UIView new];
    [self.contentView addSubview:_monthValueView];
    [_monthValueView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [_monthValueView autoSetDimension:(ALDimensionHeight) toSize:_amc_month_h];
    
    NSArray* titles = @[[NSString stringWithFormat:@"本月结算预估收入(%@)",[FNBaseSettingModel settingInstance].CustomUnit],[NSString stringWithFormat:@"上月结算预估收入(%@)",[FNBaseSettingModel settingInstance].CustomUnit]];
    CGFloat width = FNDeviceWidth*0.5;
    
    if (self.btns.count>=1) {
        [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //
        FNCmbDoubleTextButton* btn = [[FNCmbDoubleTextButton alloc]initWithFrame:(CGRectMake(0, 0, width, _amc_month_h))];
        [btn.topLable setTitleColor:FNBlackColor forState:UIControlStateNormal];
        [btn.topLable setTitle:obj forState:UIControlStateNormal];
        [btn.bottomLabel setTitle:@"0.00" forState:(UIControlStateNormal)];
        [btn.bottomLabel setTitleColor:FNMainGobalControlsColor forState:UIControlStateNormal];
        [self.monthValueView addSubview:btn];
        [btn autoSetDimensionsToSize:(CGSizeMake(width, _amc_month_h))];
        [btn autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
        [btn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:idx*width];
        
        [self.btns addObject:btn];
    }];
    
    UIView *line = [ UIView new];
    line.backgroundColor = FNHomeBackgroundColor;
    [self.monthValueView addSubview:line];
    [line autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:margin];
    [line autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:margin];
    [line autoSetDimension:(ALDimensionWidth) toSize:1.0];
    [line autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    
    UIView* midLine = [UIView new];
    midLine.backgroundColor = FNHomeBackgroundColor;
    [self.contentView addSubview:midLine];
    [midLine autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [midLine autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [midLine autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_balanceView];
    [midLine autoSetDimension:(ALDimensionHeight) toSize:1.0];
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNMCAgentMonthCell";
    FNMCAgentMonthCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNMCAgentMonthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
- (void)setLastMonth:(NSString *)lastMonth{
    _lastMonth = lastMonth;
    if (_lastMonth && self.btns.count==2) {
        //
        [self.btns[1].bottomLabel setTitle:_lastMonth forState:(UIControlStateNormal)];
    }
}
- (void)setThisMonth:(NSString *)thisMonth{
    _thisMonth = thisMonth;
    if (_thisMonth&& self.btns.count>=1) {
        
        [self.btns[0].bottomLabel setTitle:_thisMonth forState:(UIControlStateNormal)];
    }
}
- (void)setBalance:(NSString *)balance{
    _balance = balance;
    if (_balance) {
        self.balanceLabel.text = [NSString stringWithFormat:@" %.2f",[_balance floatValue]];
        [self.balanceLabel HttpLabelLeftImage:[FNBaseSettingModel settingInstance].mon_icon label:self.balanceLabel imageX:0 imageY:-1.5 imageH:13 atIndex:0];
    }
}
@end
