//
//  FNPNormalFilterView.m
//  SuperMode
//
//  Created by jimmy on 2017/6/12.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPNormalFilterView.h"
#import "FNCombinedButton.h"

@interface FNPNormalFilterView ()
@property (nonatomic, strong) NSMutableArray<UIView*>* views;
@end
@implementation FNPNormalFilterView

- (NSMutableArray <UIView*>*)views
{
    if (_views == nil) {
        _views = [NSMutableArray new];
        
    }
    return _views;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    self.currentType = FilterTypeComplex;
    if (self.titles.count == 0) {
        return;
    }
    CGFloat width = FNDeviceWidth/self.titles.count;
    @WeakObj(self);
    [self.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString* image = selfWeak.images[idx];
        if (image.length == 0) {
            UIButton* btn = [UIButton buttonWithTitle:obj titleColor:FNGlobalTextGrayColor font:kFONT14 target:self action:@selector(btnClicked:)];
            btn.tag = idx +100;
            btn.selected = idx == 0;
            [btn setTitleColor:FNMainGobalControlsColor forState:UIControlStateSelected];
            [btn sizeToFit];
            [selfWeak addSubview:btn];
            btn.frame = CGRectMake(width*idx, 0, width, selfWeak.height);
            [self.views addObject:btn];
        }else{
            FNCombinedButton * cBtn = [[FNCombinedButton alloc]initWithImage:IMAGE(image) selectedImage:IMAGE(selfWeak.selectedImage[idx]) title:obj font:kFONT14 titleColor:FNGlobalTextGrayColor selectedTitleColor:FNMainGobalControlsColor target:self action:@selector(btnClicked:)];
            cBtn.tag = idx +100;
            cBtn.frame = CGRectMake(width*idx, 0, width, selfWeak.height);
            [selfWeak addSubview:cBtn];
            [self.views addObject:cBtn];
        }
    }];
}
- (NSArray *)titles{
    if (_titles == nil) {
        _titles = @[@"   综合   ",@"最新",@"销量",@"价格"];
    }
    return  _titles;
}
- (NSArray *)images{
    if (_images == nil) {
        _images = @[@"list_hides_off",@"",@"list_off",@"list_off"];
    }
    return _images;
}
- (NSArray *)selectedImage{
    if (_selectedImage == nil) {
        _selectedImage = @[@"list_hides_on",@"",@"list_down_on",@"list_up_on"];
    }
    return _selectedImage;
}
#pragma mark -  action
- (void)btnClicked:(id)btn{
    NSInteger tag = 0;
    UIView* view = nil;
    if ([btn isKindOfClass:[UIButton class]]) {
        UIButton* button  = (UIButton *)btn;
        tag = button.tag -100;
        view = btn;
    }else{
        UITapGestureRecognizer* tap = btn;
        FNCombinedButton* tmp =(FNCombinedButton *) tap.view;
        tag = tmp.tag - 100;
        view = tap.view;
    }
    
    [self.views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton* button  = (UIButton *)obj;
            button.selected = button == view;
        }
        if([obj isKindOfClass:[FNCombinedButton class]]) {
            FNCombinedButton* cBtn = (FNCombinedButton *)obj;
            cBtn.selected = cBtn == view;
        }
    }];
    
    @WeakObj(self);
    void (^block)(void) = ^{
        if (selfWeak.clickedWithType) {
            selfWeak.clickedWithType(self.currentType);
        }
    };
    switch (tag) {
        case 0:
        {
            self.currentType = FilterTypeComplex;
            block();
            break;
        }
        case 1:{
            if (self.currentType != FilterTypeNew) {
                self.currentType = FilterTypeNew;
                block();
            }
            break;
        }
        case 2:{
            if (self.currentType != FilterTypeSale) {
                self.currentType = FilterTypeSale;
                block();
            }
            break;
        }
        case 3:{
            if (self.currentType != FilterTypePrice) {
                self.currentType = FilterTypePrice;
                block();
            }
            break;
        }
        default:
            break;
    }
}
- (void)changeName:(NSString *)name atIndex:(NSInteger)index{
    if (index == 0) {
        FNCombinedButton* btn =(FNCombinedButton *) self.views[index];
        [btn.titleLabel setTitle:name forState:(UIControlStateNormal)];
    }
}
- (void)selectedAtIndex:(NSInteger)index{
    if (index<=self.views.count-1) {
        id sender = self.views[index];
        [self.views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (sender == obj) {
                if (idx == 1) {
                    UIButton* btn = (UIButton *)obj;
                    btn.selected = YES;
                }else{
                    FNCombinedButton* btn =(FNCombinedButton *) obj;
                    btn.selected = YES;
                }
            }else{
                if (idx == 1) {
                    UIButton* btn = (UIButton *)obj;
                    btn.selected = NO;
                }else{
                    FNCombinedButton* btn =(FNCombinedButton *) obj;
                    btn.selected = NO;
                }
            }
            
        }];
    }
   
}
@end

