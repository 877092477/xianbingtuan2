//
//  FNMCouponGoodsView.m
//  THB
//
//  Created by jimmy on 2017/10/30.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNMCouponGoodsView.h"
#import "FNMCTopGoodsModel.h"
@interface FNMCouponGoodsSubView:UIView
@property (nonatomic, strong)UIView* labelView;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UILabel* desLabel;
@property (nonatomic, strong)UILabel* couponLabel;
@property (nonatomic, strong)UIImageView* imgView;
@end
@implementation FNMCouponGoodsSubView
- (UIView *)labelView{
    if (_labelView == nil) {
        _labelView = [UIView new];
        [_labelView addSubview:self.titleLabel];
        [self.titleLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(_jm_margin10, _jm_margin10, _jm_margin10, _jm_margin10 )) excludingEdge:(ALEdgeBottom)];
        
        [_labelView addSubview:self.desLabel];
        [self.desLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.titleLabel withOffset:5];
        [self.desLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.titleLabel];
        [self.desLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.titleLabel];
    
        
        
        
        [_labelView addSubview:self.couponLabel];
        [self.couponLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.titleLabel];
        [self.couponLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.desLabel withOffset:5];
        [self.couponLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_labelView withMultiplier:0.9 relation:(NSLayoutRelationLessThanOrEqual)];
        [self.couponLabel autoSetDimension:(ALDimensionHeight) toSize:18];
        
        [self addSubview:self.labelView];
    }
    return _labelView;
}
- (UILabel *)titleLabel{
    if(_titleLabel == nil){
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = FNMainGobalControlsColor;
        _titleLabel.adjustsFontSizeToFitWidth= YES;
    }
    return _titleLabel;
}
- (UILabel *)desLabel{
    if(_desLabel == nil){
        _desLabel = [UILabel new];
        _desLabel.font = [UIFont systemFontOfSize:12];
        _desLabel.textColor = FNGlobalTextGrayColor;
        
    }
    return _desLabel;
}
- (UILabel *)couponLabel{
    if(_couponLabel == nil){
        _couponLabel = [UILabel new];
        _couponLabel.font = [UIFont systemFontOfSize:14];
        _couponLabel.textColor = FNWhiteColor;
        _couponLabel.backgroundColor = FNMainGobalControlsColor;
        _couponLabel.cornerRadius = 3;
        
    }
    return _couponLabel;
}
- (UIImageView *)imgView{
    if(_imgView == nil){
        _imgView = [UIImageView new];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imgView];
    }
    return _imgView;
}

@end

@interface FNMCouponGoodsView()
@property(nonatomic, strong)FNMCouponGoodsSubView* leftView;
@property(nonatomic, strong)FNMCouponGoodsSubView* rightTopView;
@property(nonatomic, strong)FNMCouponGoodsSubView* rightBtmView;
@property (nonatomic, strong)NSMutableArray<FNMCouponGoodsSubView *>* views;

@end
@implementation FNMCouponGoodsView
- (NSMutableArray <FNMCouponGoodsSubView *>*)views{
    if (_views == nil) {
        _views = [NSMutableArray new];
    }
    return _views;
}
- (FNMCouponGoodsSubView *)leftView{
    if (_leftView == nil) {
        _leftView = [FNMCouponGoodsSubView new];
        _leftView.backgroundColor = FNWhiteColor;
        @WeakObj(self);
        [_leftView addJXTouch:^{
            if (selfWeak.viewclicked && selfWeak.datas.count>=1) {
                selfWeak.viewclicked(selfWeak.datas[0]);
            }
        }];
        [_leftView.labelView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
        [_leftView.labelView autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionHeight) ofView:_leftView withMultiplier:0.45];
        
        [_leftView.imgView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, _jm_margin10, 5, _jm_margin10)) excludingEdge:(ALEdgeTop)];
        [_leftView.imgView autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionHeight) ofView:_leftView withMultiplier:0.45];
        
    }
    return _leftView;
}
- (FNMCouponGoodsSubView *)rightTopView{
    if (_rightTopView == nil) {
        _rightTopView = [FNMCouponGoodsSubView new];
       _rightTopView.backgroundColor = FNWhiteColor;
        @WeakObj(self);
        [_rightTopView addJXTouch:^{
            if (selfWeak.viewclicked && selfWeak.datas.count>=1) {
                selfWeak.viewclicked(selfWeak.datas[1]);
            }
        }];
        [_rightTopView.labelView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeRight)];
        [_rightTopView.labelView autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_rightTopView withMultiplier:0.55];
        
        [_rightTopView.imgView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeLeft)];
        [_rightTopView.imgView autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_rightTopView withMultiplier:0.40];
        
        
    }
    return _rightTopView;
}
- (FNMCouponGoodsSubView *)rightBtmView{
    if (_rightBtmView == nil) {
        _rightBtmView = [FNMCouponGoodsSubView new];
        @WeakObj(self);
        [_rightBtmView addJXTouch:^{
            if (selfWeak.viewclicked && selfWeak.datas.count>=1) {
                selfWeak.viewclicked([selfWeak.datas lastObject]);
            }
        }];
        _rightBtmView.backgroundColor = FNWhiteColor;
        [_rightBtmView.labelView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeRight)];
        [_rightBtmView.labelView autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_rightBtmView withMultiplier:0.55];
        
        [_rightBtmView.imgView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeLeft)];
        [_rightBtmView.imgView autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_rightBtmView withMultiplier:0.4];
    }
    return _rightBtmView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jm_setupViews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    self.backgroundColor = FNHomeBackgroundColor;

    if (self.views.count>=1) {
        [self.views makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.views removeAllObjects];
    }
    [self addSubview:self.leftView];
    CGFloat margin = 2;
    [self.leftView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(margin, 0, margin, 0)) excludingEdge:(ALEdgeRight)];
    [self.leftView autoSetDimension:(ALDimensionWidth) toSize:FNDeviceWidth*0.4-margin];
    [self.views addObject:self.leftView];
    
    
    UIView* midline = [UIView new];
    [self insertSubview:midline atIndex:0];
    [midline autoSetDimension:(ALDimensionHeight) toSize:margin];
    [midline autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [midline autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [midline autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [self addSubview:self.rightTopView];
    [self.views addObject:self.rightTopView];
    [self.rightTopView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:margin];
    [self.rightTopView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [self.rightTopView autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:self withMultiplier:0.6];
//    [self.rightTopView autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionHeight) ofView:self withMultiplier:0.485];
    [self.rightTopView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:midline];
    
    [self addSubview:self.rightBtmView];
    [self.views addObject:self.rightBtmView];
    [self.rightBtmView autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:margin];
    [self.rightBtmView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [self.rightBtmView autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:self withMultiplier:0.6];
//    [self.rightBtmView autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionHeight) ofView:self withMultiplier:0.485];
    [self.rightBtmView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:midline];
    
    
}
- (void)setDatas:(NSArray *)datas{
    _datas = datas;
    if (_datas.count>=1) {

        [self.views enumerateObjectsUsingBlock:^(FNMCouponGoodsSubView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx<=self.datas.count-1) {
                obj.titleLabel.text = self.datas[idx].title;
                obj.desLabel.text = self.datas[idx].des;
                if (![NSString isEmpty:self.datas[idx].price_span]) {
                    obj.couponLabel.text = [NSString stringWithFormat:@"  %@  ",self.datas[idx].price_span];
                }
                
                [obj.imgView setUrlImg:self.datas[idx].image];
            }
            
        }];
        
        
    }
}
@end
