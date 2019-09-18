//
//  FNPartnerApplyCell.m
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPartnerApplyCell.h"
#import "FNPartnerApplyModel.h"
#import "FNPartnerApplyTitleView.h"

@interface FNPartnerApplyCell()
@property (nonatomic, strong)FNPartnerApplyTitleView* titleView;
@property (nonatomic, strong)UILabel* contentLabel;
@end
@implementation FNPartnerApplyCell
- (FNPartnerApplyTitleView *)titleView{
    if (_titleView == nil) {
        _titleView = [FNPartnerApplyTitleView new];
        
    }
    return _titleView;
}
- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [UILabel new];
        _contentLabel.font = kFONT12;
        _contentLabel.textColor = FNGlobalTextGrayColor;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
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
        [self jm_setupViews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    //
    [self.contentView addSubview:self.titleView];
    [self.titleView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.titleView autoSetDimension:(ALDimensionHeight) toSize:30];
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.titleView withOffset:5] ;
    [self.contentLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10*2];
    [self.contentLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10*2];
    
    [self setupAutoHeightWithBottomView:self.contentLabel bottomMargin:5];
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNPartnerApplyCell";
    FNPartnerApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNPartnerApplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
- (void)setModel:(FAMintroduce *)model{
    _model = model;
    if (_model ) {
        self.titleView.titleLabel.text = _model.title;
        self.contentLabel.text = _model.content;
    }
}
@end
