//
//  FNMineOrderCell.m
//  THB
//
//  Created by Jimmy on 2018/1/16.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNMineOrderCell.h"
#import "MenuModel.h"
#import "FNHomeFunctionBtn.h"
#import "FNMineButton.h"
@interface FNMineOrderCell()
@property (nonatomic, strong)NSMutableArray<FNMineButton *>* buttons;
@end
@implementation FNMineOrderCell
- (NSMutableArray<FNMineButton *> *)buttons{
    if (_buttons == nil) {
        _buttons  = [NSMutableArray new];
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
- (void)setupBtnviews{
    if (self.buttons.count>=1) {
        [self.buttons makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.buttons removeAllObjects];
    }
    CGFloat btnw = (JMScreenWidth-_jmsize_10)/self.datas.count;
    CGFloat btnh = JMScreenHeight*0.15;
    
    @weakify(self);
    [self.datas enumerateObjectsUsingBlock:^(MenuModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        CGRect frame = CGRectMake(btnw*idx, 0, btnw, btnh);
        
        CGFloat margin1 = (btnh - 25 - 15 -15)*0.5;
        FNMineButton *btn = [[FNMineButton alloc]initWithFrame:frame image:nil andTitle:obj.name];
        btn.tag = 100+idx;
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btn.titleLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, 2, margin1, 2)) excludingEdge:(ALEdgeTop)];
//        [UIImage imageWithData:[NSData dataWithContentsOfURL:URL(obj.img)]]
        [btn.imageView setUrlImg:obj.img];
        [btn.imageView autoSetDimensionsToSize:(CGSizeMake(25, 25))];
        [btn.imageView autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        [btn.imageView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:margin1];
        btn.buttonClicked = ^(UIView *view){
            [self buttonClicked:view];
        };
        if (![NSString isEmpty:obj.val] && [btn.titleLabel.text containsString:obj.val]) {
            [btn.titleLabel addSingleAttributed:@{NSForegroundColorAttributeName:FNMainGobalControlsColor} ofRange:[btn.titleLabel.text rangeOfString:obj.val]];
        }
        [self.contentView addSubview:btn];
        [self.buttons addObject:btn];
        
    }];
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    static NSString *reuseIdentifier = @"FNMineOrderCell";
    FNMineOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNMineOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
- (void)setDatas:(NSArray<MenuModel *> *)datas{
    _datas = datas;
    if (_datas.count>=1) {
        [self setupBtnviews];
    }
}
- (void)buttonClicked:(UIView *)view
{
    NSInteger tag = view.tag-100;
    if (self.btnClicked) {
        self.btnClicked(tag, self.datas[tag],self.indexPath);
    }
//    if (self.clickedCellAtIndex) {
//        self.clickedCellAtIndex(self.functions[tag].type.integerValue,self.functions[tag].name,tag);
//    }
}
@end
