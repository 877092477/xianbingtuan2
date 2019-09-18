//
//  JMMineBillListCell.m
//  THB
//
//  Created by jimmy on 2017/3/30.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMMineBillListCell.h"
#import "JMMineBillModel.h"
@interface JMMineBillListCell ()
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;

@end
@implementation JMMineBillListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"JMMineBillListCell" owner:nil options:nil] lastObject];
        [self initializedSubviews];
        
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.valueLabel.adjustsFontSizeToFitWidth = YES;
    self.desLabel.font = kFONT14;
    self.dateLabel.font = kFONT14;
    self.valueLabel.textAlignment = NSTextAlignmentRight;
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"JMMineBillListCell";
    JMMineBillListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[JMMineBillListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark - setter && getter
- (void)setModel:(JMMineBillModel *)model{
    _model = model;
    if (_model) {
        self.desLabel.text = _model.detail;
        self.valueLabel.text = _model.interal;
        if ([_model.interal containsString:@"+"]) {
            self.valueLabel.textColor = RED;
        }else{
            self.valueLabel.textColor = FNBlackColor;
        }
        self.dateLabel.text = [NSString getTimeStr:_model.time];
        self.feeLabel.text = _model.sxf;
    }
}
@end
