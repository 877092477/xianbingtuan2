//
//  MineWithdrawCell.m
//  THB
//
//  Created by jimmy on 2017/3/30.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "MineWithdrawCell.h"

@implementation MineWithdrawCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = kFONT14;
    if (self.contentView.subviews.count>0) {
        [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UILabel class]]) {
                UILabel*    lable = obj;
                lable.font = kFONT14;
            }else if ([obj isKindOfClass:[UIButton class]]){
                UIButton* btn = obj;
                btn.borderColor = FNMainGobalControlsColor;
                [btn setTitleColor:FNMainGobalControlsColor forState:UIControlStateNormal];
            }
        }];
    }
    self.balanceLabel.textColor = FNMainGobalControlsColor;
    
    if ([FNBaseSettingModel settingInstance].txdoing_onoff.boolValue) {
        self.withdrawBtn.hidden = YES;
    }else{
        self.withdrawBtn.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MineWithdrawCell" owner:nil options:nil] lastObject];
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"MineWithdrawCell";
    MineWithdrawCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[MineWithdrawCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
- (IBAction)withdrawAction:(id)sender {
    if (self.withdrawAction) {
        self.withdrawAction();
    }
}
@end
