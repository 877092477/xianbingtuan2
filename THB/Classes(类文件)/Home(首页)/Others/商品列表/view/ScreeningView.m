//
//  ScreeningView.m
//  如意贝
//
//  Created by Fnuo-iOS on 2018/4/27.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "ScreeningView.h"

@implementation ScreeningView

- (NSMutableArray <UIView*>*)views
{
    if (_views == nil) {
        _views = [NSMutableArray new];
        
    }
    return _views;
}

-(void)setTitles:(NSMutableArray *)titles images:(NSMutableArray *)images selectedImage:(NSMutableArray *)selectedImage types:(NSMutableArray *)types{
    if (self.views.count>=1) {
        [self.views makeObjectsPerformSelector:@selector( removeFromSuperview)];
        [self.views removeAllObjects];
    }
    if (titles.count == 0) {
        return;
    }
    self.types=types;
    CGFloat width = self.frame.size.width/titles.count;
    @WeakObj(self);
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton* btn = [UIButton buttonWithTitle:obj titleColor:FNGlobalTextGrayColor font:kFONT14 target:self action:@selector(btnClicked:)];
        btn.tag = idx +1000;
        btn.selected = idx == 0;
        [btn setTitleColor:FNMainGobalControlsColor forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:images[idx]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:selectedImage[idx]] forState:UIControlStateSelected];
        [btn sizeToFit];
        [selfWeak addSubview:btn];
        btn.frame = CGRectMake(width*idx, 0, width, selfWeak.height);
        [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5.0f];
        [self.views addObject:btn];
    }];
}
#pragma mark -  action
- (void)btnClicked:(id)btn{
    NSInteger tag = 0;
    UIView* view = nil;
    UIButton* button  = (UIButton *)btn;
    tag = button.tag -1000;
    view = btn;
    if([self.genreString isEqualToString:@"record"]){
       [self.views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           UIButton* button  = (UIButton *)obj;
           button.selected = button == view;
        
       }];
    }
    
    
    else{
             if (tag!=self.types.count-1) {
                  [self.views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                      UIButton* button  = (UIButton *)obj;
                      button.selected = button == view;
        
                  }];
              }else{
                  button.selected=!button.selected;
              }
    }
   

   
    
    if (self.clickedWithType) {
        self.clickedWithType(self.types[tag]);
    }
    if(self.clickedWithSiteType){
       self.clickedWithSiteType(self.types[tag],tag);
    }
}
#pragma mark - public method
- (void)setButtonAtIndex:(NSInteger)index
{
    if (self.views&& self.views.count == 0) {
        return;
    }
    UIButton *btn = (UIButton *)[self viewWithTag:index+1000];
    NSInteger tag = 0;
    UIView* view = nil;
    UIButton* button  = (UIButton *)btn;
    tag = button.tag-1000;
    
    view = btn;
    if([self.genreString isEqualToString:@"record"]){
        [self.views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton* button  = (UIButton *)obj;
            button.selected = button == view;
            
        }];
    }
    
    else{
        if (tag!=self.types.count-1) {
            [self.views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIButton* button  = (UIButton *)obj;
                button.selected = button == view;
                
            }];
        }else{
            button.selected=!button.selected;
        }
    }
    //[self btnClicked:btn];
}
@end

