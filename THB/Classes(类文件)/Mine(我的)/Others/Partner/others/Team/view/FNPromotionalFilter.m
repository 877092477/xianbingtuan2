//
//  FNPromotionalFilter.m
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPromotionalFilter.h"
#import "FNCmbDoubleTextButton.h"
const CGFloat _pf_cate_height = 60;
const CGFloat _pf_filter_height = 40;
@implementation FNPromotionalFilter
- (UIView *)cateView{
    if (_cateView == nil) {
        _cateView = [UIView new];
        
        [_cateView addSubview:self.indicatorview];
        
    }
    return _cateView;
}
- (UIView *)indicatorview{
    if (_indicatorview == nil) {
        _indicatorview = [[UIView alloc]initWithFrame:(CGRectMake(0, 58, (JMScreenWidth-1)*0.5, 2))];
        _indicatorview.backgroundColor = FNMainGobalControlsColor;
    }
    return _indicatorview;
}


- (FNPCFilterView *)filterView{
    if (_filterView == nil) {
        _filterView = [FNPCFilterView new];
    }
    return _filterView;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    self.backgroundColor = FNHomeBackgroundColor;
    //
    [self addSubview:self.cateView];
    [self.cateView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.cateView autoSetDimension:(ALDimensionHeight) toSize:_pf_cate_height];
    
    [self addSubview:self.filterView];
    [self.filterView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [self.filterView autoSetDimension:(ALDimensionHeight) toSize:_pf_filter_height];
    
    self.height =_pf_filter_height+10+_pf_cate_height;
    
}

#pragma mark - aciton

- (void)setCates:(NSArray *)cates{
    _cates = cates;
    if (_cates.count>=1) {
        [self setupbtnsview];
    }
}
- (void)setupbtnsview{
    if (self.btns.count>=1) {
        [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.btns removeAllObjects];
    }
    CGFloat width = (JMScreenWidth-1)*0.5;
    [self.cates enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FNCmbDoubleTextButton* btn = [[FNCmbDoubleTextButton alloc]initWithFrame:(CGRectMake(idx*(1+width), 0, width, _pf_cate_height))];
        btn.backgroundColor = FNWhiteColor;
        btn.tag = 1000+idx;
        [btn addJXTouchWithObject:^(FNCmbDoubleTextButton* obj) {
            if (obj.tag == 1000) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.indicatorview.x = 0;
                }];
                if (self.catesBlock) {
                    self.catesBlock(YES);
                }
            }else{
                [UIView animateWithDuration:0.3 animations:^{
                    self.indicatorview.x = self.indicatorview.width+1;
                }];
                if (self.catesBlock) {
                    self.catesBlock(NO);
                }
            }
            
        }];
        [btn.topLable setTitle:obj forState:(UIControlStateNormal)];
        [btn.topLable setTitleColor:FNBlackColor forState:(UIControlStateNormal)];
        [btn.bottomLabel setTitle:@"0人" forState:UIControlStateNormal];
        [btn.bottomLabel setTitleColor:FNMainGobalControlsColor forState:(UIControlStateNormal)];
        [self.cateView addSubview:btn];
        [self.btns addObject:btn];
    }];
    [self.cateView bringSubviewToFront:self.indicatorview];
}
- (NSMutableArray *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray new];
    }
    return _btns;
}
- (void)setMpcount:(NSString *)mpcount{
    _mpcount = mpcount;
    if (self.btns.count>=1) {
        FNCmbDoubleTextButton* btn = self.btns[0];
        [btn.bottomLabel setTitle:[NSString stringWithFormat:@"%@人",_mpcount] forState:(UIControlStateNormal)];
    }
}
- (void)setTcount:(NSString *)tcount{
    _tcount = tcount;
    if (self.btns.count>=1) {
        FNCmbDoubleTextButton* btn = self.btns[1];
        [btn.bottomLabel setTitle:[NSString stringWithFormat:@"%@人",_tcount] forState:(UIControlStateNormal)];
    }
}
@end
