//
//  FNMinePromoteCateView.m
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNMinePromoteCateView.h"

const CGFloat _mpcv_height = 60;
@implementation FNMinePromoteCateView
- (UIScrollView *)scorllview{
    if (_scorllview == nil) {
        _scorllview = [UIScrollView new];
        _scorllview.showsHorizontalScrollIndicator = NO;
        
        [_scorllview addSubview:self.indicatorView];
    }
    return _scorllview;
}
- (UIView *)indicatorView{
    if (_indicatorView == nil) {
        _indicatorView = [[UIView alloc]initWithFrame:(CGRectMake(0, _mpcv_height-2, (JMScreenWidth-2)/3, 2))];
        _indicatorView.backgroundColor = FNMainGobalControlsColor;
    }
    return _indicatorView;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    [self addSubview:self.scorllview];
    [self.scorllview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    self.height = _mpcv_height;
}

- (NSMutableArray<FNCmbDoubleTextButton *> *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray new];
    }
    return _btns;
}
- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    if (self.titles.count>=1) {
        [self setupBtns];
    }
}
- (void)setupBtns{
    if (self.btns.count>=1) {
        [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.btns removeAllObjects];
    }
    CGFloat width  = (JMScreenWidth-2)/3;
    CGFloat margin = 1;
    [self.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FNCmbDoubleTextButton* btn = [[FNCmbDoubleTextButton alloc]initWithFrame:(CGRectMake(idx*(margin+width), 0, width, _mpcv_height))];
        [btn.topLable setTitleColor:FNMainGobalControlsColor forState:(UIControlStateSelected)];
        [btn.topLable setTitleColor:FNGlobalTextGrayColor forState:(UIControlStateNormal)];
        [btn.topLable setTitle:obj forState:(UIControlStateNormal)];
        if (idx == self.index) {
            btn.selected = YES;
        }
        [btn.bottomLabel setTitleColor:FNMainGobalControlsColor forState:(UIControlStateSelected)];
        [btn.bottomLabel setTitleColor:FNGlobalTextGrayColor forState:(UIControlStateNormal)];
        [btn.bottomLabel setTitle:@"0" forState:(UIControlStateNormal)];
        
        btn.tag = idx+1000;
        [btn addJXTouchWithObject:^(FNCmbDoubleTextButton* obj) {
            NSInteger index = obj.tag - 1000;
            
            if (self.clickedBlock) {
                self.clickedBlock(index);
            }
            [self.btns enumerateObjectsUsingBlock:^(FNCmbDoubleTextButton * _Nonnull objs, NSUInteger idx, BOOL * _Nonnull stop) {
                objs.selected = objs == obj;
            }];
            [UIView animateWithDuration:0.3 animations:^{
                self.indicatorView.x = index*((JMScreenWidth-2)/3);
            }];
        }];
        [self.scorllview addSubview:btn];
        if (idx < self.titles.count-1) {
            UIView* line = [[UIView alloc]initWithFrame:(CGRectMake(CGRectGetMaxX(btn.frame), 15, 1, 15*2))];
            line.backgroundColor = FNHomeBackgroundColor;
            [self.scorllview addSubview:line];
            
        }
        [self.btns addObject:btn];
    }];
    if (CGRectGetMaxX([self.btns lastObject].frame) >= JMScreenWidth) {
        [self.scorllview setContentSize:(CGSizeMake(CGRectGetMaxX([self.btns lastObject].frame), _mpcv_height))];
    }
    [self.scorllview bringSubviewToFront:self.indicatorView];
}

- (void)setContents:(NSArray *)contents{
    _contents = contents;
    if (_contents.count>=1) {
        [self.btns enumerateObjectsUsingBlock:^(FNCmbDoubleTextButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx <= self.contents.count) {
                [obj.bottomLabel setTitle:_contents[idx] forState:(UIControlStateNormal)];
            }
        }];
    }
}
@end
