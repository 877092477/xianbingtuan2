//
//  FNImgTitleCell.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/11/30.
//  Copyright © 2016年 方诺科技. All rights reserved.
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

#import "FNImgTitleCell.h"

@implementation FNImgTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    UIImageView* imgView = [UIImageView new];
    [self.contentView addSubview:imgView];
    _imgView = imgView;
    
    UILabel* titleLabel = [UILabel new];
    titleLabel.font = kFONT14;
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    UILabel* subTitleLabel = [UILabel new];
    subTitleLabel.font = kFONT14;
    [self.contentView addSubview:subTitleLabel];
    _subTitleLabel = subTitleLabel;
    
    [_imgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:15];
    [_imgView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_titleLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_imgView withOffset:10];
    [_titleLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_subTitleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_titleLabel withOffset:10];
    [_subTitleLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:5];
    [_subTitleLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    UIView* line = [UIView new];
    line.backgroundColor = FNHomeBackgroundColor;
    [self addSubview:line];
    [line autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [line autoSetDimension:(ALDimensionHeight) toSize:1.0];
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNImgTitleCell";
    FNImgTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNImgTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
- (void)setImage:(NSString *)img andTitle:(NSString *)title{
    if ([img containsString:@"http"]) {
        [_imgView setUrlImg:img];
    }else{
        _imgView.image = [UIImage imageNamed:img];
    }
    [_imgView sizeToFit];
    if (_imgSize.width == 0) {
        [_imgView autoSetDimensionsToSize:_imgView.size];
    }
    
    _titleLabel.text = title?:@"";
}
- (void)setImgSize:(CGSize)imgSize{
    _imgSize = imgSize;
    [_imgView autoSetDimensionsToSize:_imgSize];
}
@end
