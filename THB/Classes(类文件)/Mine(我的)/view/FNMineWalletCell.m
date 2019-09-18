//
//  FNMineWalletCell.m
//  THB
//
//  Created by Jimmy on 2018/1/16.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNMineWalletCell.h"
#import "FNCmbDoubleTextButton.h"
#import "MenuModel.h"
@interface FNMineWalletCell()
@property (nonatomic, strong)NSMutableArray<FNCmbDoubleTextButton *>* buttons;
@end
@implementation FNMineWalletCell
- (NSMutableArray<FNCmbDoubleTextButton *> *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray new];
    }
    return _buttons;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - set up view
- (void)jm_setupViews{
    self.contentView.backgroundColor = FNWhiteColor;
}
- (void)setupBtnview{
    if (self.buttons.count>=1) {
        [self.buttons makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.buttons removeAllObjects];
    }
    CGFloat btnw = JMScreenWidth/self.datas.count;
    CGFloat btnh = 64;
    [self.datas enumerateObjectsUsingBlock:^(MenuModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FNCmbDoubleTextButton* btn = [[FNCmbDoubleTextButton alloc]initWithFrame:(CGRectMake(idx*btnw, 0, btnw, btnh))];
        [btn.topLable setTitleColor:FNMainGobalControlsColor forState:(UIControlStateNormal)];
        [btn.bottomLabel setTitleColor:FNGlobalTextGrayColor forState:(UIControlStateNormal)];
        btn.bottomLabel.titleLabel.font = kFONT12;
        btn.topLable.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn.topLable.titleLabel.font = kFONT13;
        XYLog(@"obj.val is %@",obj.val);
        [btn.topLable setTitle:obj.val forState:(UIControlStateNormal)];
        [btn.bottomLabel setTitle:obj.name forState:(UIControlStateNormal)];
        [self.contentView addSubview:btn];
        [self.buttons addObject:btn];
    
    }];
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    static NSString *reuseIdentifier = @"FNMineWalletCell";
    FNMineWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNMineWalletCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
- (void)setDatas:(NSArray<MenuModel *> *)datas{
    _datas = datas;
    if (_datas.count>=1) {
        [self setupBtnview];
    }
}
@end
