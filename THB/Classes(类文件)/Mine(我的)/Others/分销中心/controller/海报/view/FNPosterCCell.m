//
//  FNPosterCCell.m
//  THB
//
//  Created by jimmy on 2017/8/28.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPosterCCell.h"

@implementation FNPosterCCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
- (UIImageView *)posterimgview{
    if (_posterimgview == nil) {
        _posterimgview = [UIImageView new];
    }
    return _posterimgview;
}
- (UIButton *)chooseBtn{
    if (_chooseBtn == nil) {
        _chooseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_chooseBtn setImage:IMAGE(@"poster_choose_off") forState:UIControlStateNormal];
        [_chooseBtn setImage:IMAGE(@"poster_choose_on") forState:UIControlStateSelected];
        [_chooseBtn addTarget:self action:@selector(chooseClick)];
        [_chooseBtn sizeToFit];
    }
    return _chooseBtn;
}
- (UIView *)btmview{
    if (_btmview == nil) {
        _btmview = [UIView new];
        _btmview.backgroundColor = FNWhiteColor;
        
        [_btmview addSubview:self.chooseBtn];
        [self.chooseBtn autoCenterInSuperview];
        [self.chooseBtn autoSetDimensionsToSize:self.chooseBtn.size];
    }
    return _btmview;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    [self.contentView addSubview:self.btmview];
    [self.btmview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [self.btmview autoSetDimension:(ALDimensionHeight) toSize:44];
    
    [self.contentView addSubview:self.posterimgview];
    [self.posterimgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.posterimgview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:self.btmview];
    
}
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNPosterCCell";
    FNPosterCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

-(void)chooseClick{
    if ([self.delegate respondsToSelector:@selector(posterChooseAction:)]) {
        [self.delegate posterChooseAction:self.indxpath];
    }
}
@end
