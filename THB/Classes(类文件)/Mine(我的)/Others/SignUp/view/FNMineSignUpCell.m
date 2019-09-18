//
//  FNMineSignUpCell.m
//  THB
//
//  Created by Jimmy on 2018/1/17.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNMineSignUpCell.h"
#import "FNMineSignUpRecordModel.h"
@interface FNMineSignUpCell()
@property (nonatomic, strong)UILabel* desLabel;
@property (nonatomic, strong)UILabel* dateLabel;
@property (nonatomic, strong)UILabel* valueLabel;
@end
@implementation FNMineSignUpCell
- (UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [UILabel new];
        _desLabel.font = kFONT14;
    }
    return _desLabel;
}
- (UILabel *)dateLabel{
    if (_dateLabel == nil) {
        _dateLabel = [UILabel new];
        _dateLabel.font = kFONT12;
        _dateLabel.textColor = FNGlobalTextGrayColor;
    }
    return _dateLabel;
}
- (UILabel *)valueLabel{
    if (_valueLabel == nil) {
        _valueLabel = [UILabel new];
        _valueLabel.font = kFONT14;
        _valueLabel.textColor = FNMainGobalControlsColor;
    }
    return _valueLabel;
}

#pragma mark - set up view
- (void)jm_setupViews{
    [self.contentView addSubview:self.desLabel];
    [self.desLabel autoConstrainAttribute:ALEdgeBottom toAttribute:ALAxisHorizontal ofView:self.contentView withOffset:-5];
    [self.desLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
    
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel autoConstrainAttribute:ALEdgeTop toAttribute:ALAxisHorizontal ofView:self.contentView withOffset:5];
    [self.dateLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
    
    [self.contentView addSubview:self.valueLabel];
    [self.valueLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
    [self.valueLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    static NSString *reuseIdentifier = @"FNMineSignUpCell";
    FNMineSignUpCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNMineSignUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
- (void)setModel:(FNMineSignUpRecordModel *)model{
    _model = model;
    if (_model) {
        self.desLabel.text = _model.detail;
        self.dateLabel.text = [NSString getTimeStr:_model.time];
        self.valueLabel.text = _model.interal;
    }
}
@end
