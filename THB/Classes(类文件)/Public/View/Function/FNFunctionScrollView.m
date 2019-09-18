//
//  FNFunctionScrollView.m
//  SuperMode
//
//  Created by jimmy on 2017/6/7.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNFunctionScrollView.h"
#import "FNFunctionBtnView.h"
@interface FNFunctionScrollView ()
@property (nonatomic, strong) NSMutableArray<FNFunctionBtnView *>* views;
@end
@implementation FNFunctionScrollView
#pragma mark - forcasted loading
- (NSMutableArray<FNFunctionBtnView *> *)views
{
    if (_views == nil) {
        _views = [NSMutableArray new];
    }
    return _views;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{

    if (self.views.count>=1) {
        [self.views makeObjectsPerformSelector:@selector( removeFromSuperview)];
        [self.views removeAllObjects];
    }
    CGFloat width =self.width*0.2;
    CGFloat height = self.height;
    
    CGFloat margin = 0;
    CGFloat imgW = width - (self.isScale?FNDeviceWidth*0.13:FNDeviceWidth*0.1);
    CGFloat imgM = (height-imgW-14)/3;
    if (width*_datas.count <FNDeviceWidth) {
        margin = (FNDeviceWidth - width*_datas.count)/(_datas.count+1);
    }else{
        self.contentSize = CGSizeMake(width*_datas.count, self.height);
    }
    
    @WeakObj(self);
    [_datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        _images[idx].size = CGSizeMake(imgW, imgW);
        FNFunctionBtnView* btn = [[FNFunctionBtnView alloc]initWithFrame:CGRectMake(margin*(idx+1)+width*idx, self.height - height+2, width, height) btnImage:_images[idx] andTitle:_datas[idx]];
        if (btn.constraints.count >=1) {
            [btn removeConstraints:btn.constraints];
        }
        if (btn.subviews.count >=1) {
            [btn.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
                if (view.constraints.count >=1) {
                    [view removeConstraints:view.constraints];
                }
            }];
        }
        
        if (self.font) {
            btn.label.font = self.font;
        }
        btn.tag = idx+100;
        [btn addJXTouchWithObject:^(id obj) {
            FNFunctionBtnView* view = obj;
            if (selfWeak.observingClicked) {
                selfWeak.observingClicked(view.tag-100);
            }
        }];
        [self addSubview:btn];
        [btn.button autoSetDimensionsToSize:(CGSizeMake(imgW, imgW))];
        [btn.button autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        [btn.button autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:imgM];
        
        [btn.label autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:imgM];
        [btn.label autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:5];
        [btn.label autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:5];
        [btn layoutIfNeeded];

        
        [self.views addObject:btn];
    }];
    
}
- (void)setDatas:(NSArray *)datas{
    _datas = datas;
    if (_datas.count > 0) {
        [self initializedSubviews];
    }
}

- (void)setFont:(UIFont *)font{
    _font = font;
    if (_views.count>0) {
        [_views enumerateObjectsUsingBlock:^(FNFunctionBtnView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.label.font = _font;
            obj.label.adjustsFontSizeToFitWidth = YES;
        }];
    }
}
@end
