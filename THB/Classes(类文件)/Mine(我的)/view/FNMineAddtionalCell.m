
//
//  FNMineAddtionalCell.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/7/30.
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

#import "FNMineAddtionalCell.h"
#import "FNMineButton.h"
#import "FNMineFunctionModel.h"

@interface FNMineAddtionalCell ()
@property (nonatomic, strong) NSMutableArray<FNMineButton *>*  views;
@end
@implementation FNMineAddtionalCell
- (NSMutableArray<FNMineButton *> *)views
{
    if (_views == nil) {
        _views = [NSMutableArray new];
    }
    return _views;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = FNHomeBackgroundColor;
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    if (self.views.count) {
        [self.views makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    CGFloat cellH = FNDeviceHeight*0.15;
    CGFloat margin = 1;
    CGFloat btnW = ((self.max_width>=1 ?self.max_width:FNDeviceWidth)-margin*3)/4;
    CGFloat btnH = cellH;
    int count = ceilf(self.functions.count/4.0);
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, cellH*count)];
    [self.contentView addSubview:contentView];
    [contentView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [contentView autoSetDimension:(ALDimensionHeight) toSize:contentView.height];
 
    @WeakObj(self);
    for (NSInteger i = 0; i < _functions.count; i++) {
        CGRect frame = CGRectZero;
        if (i>= 4) {
            frame = CGRectMake((i%4)*(btnW+margin), floorf(i/4)*(btnH+margin), btnW, btnH);
        }else{
            frame = CGRectMake(i*(btnW+margin), 0, btnW, btnH);
        }
        CGFloat margin1 = (btnH - 25 - 15 -15)*0.5;
         FNMineButton *btn = [[FNMineButton alloc]initWithFrame:frame image:nil andTitle:_functions[i].name];
        btn.tag = 100+i;
        [btn.titleLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, 2, margin1, 2)) excludingEdge:(ALEdgeTop)];
        [btn.imageView setUrlImg:_functions[i].img];
        [btn.imageView autoSetDimensionsToSize:(CGSizeMake(25, 25))];
        [btn.imageView autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        [btn.imageView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:margin1];
        btn.buttonClicked = ^(UIView *view){
            [selfWeak buttonClicked:view];
        };
        [contentView addSubview:btn];
        [selfWeak.views addObject:btn];
    }
    
}
+ (instancetype)cellWithTabelView:(UITableView *)tableView
{
    static NSString *reuseIdentifier = @"FNMineAddtionalCell";
    FNMineAddtionalCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNMineAddtionalCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}
- (void)buttonClicked:(UIView *)view
{
    NSInteger tag = view.tag-100;
    if (self.clickedCellAtIndex) {
        self.clickedCellAtIndex(self.functions[tag].type.integerValue,self.functions[tag].name,tag);
    }
}

- (void)setFunctions:(NSArray<FNMineFunctionModel *> *)functions{
    _functions  = functions;
    if (_functions.count>0 && _functions.count != self.views.count) {
        [self initializedSubviews];
    }else{
//        if (self.views.count) {
//            [self.views makeObjectsPerformSelector:@selector(removeFromSuperview)];
//        }
    }
}
@end
