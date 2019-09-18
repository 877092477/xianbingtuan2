//
//  FNPartnerGoodsFilter.m
//  SuperMode
//
//  Created by jimmy on 2017/10/19.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPartnerGoodsFilter.h"
const CGFloat _pgf_search_height = 60;
const CGFloat _pgf_filter_height = 50;
@interface FNPartnerGoodsFilter()
@property (nonatomic, strong)UIView* searchview;


@property (nonatomic, strong)UIView* filterview;
@end
@implementation FNPartnerGoodsFilter
- (UISearchBar *)searchbar{
    if (_searchbar == nil) {
        _searchbar  =[[UISearchBar alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 40))];
        _searchbar.placeholder = @"请输入商品标题";
        _searchbar.backgroundImage = [UIImage createImageWithColor:FNWhiteColor];
        _searchbar.barTintColor = FNGlobalTextGrayColor;
        [_searchbar setSearchFieldBackgroundImage:IMAGE(@"partner_search_bj") forState:(UIControlStateNormal)];
        _searchbar.tintColor = FNGlobalTextGrayColor;
        [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setFont:kFONT14];
    }
    return _searchbar;
}
- (UIView *)searchview{
    if (_searchview == nil) {
        _searchview = [UIView new];
        _searchview.backgroundColor = FNWhiteColor;
        
        [_searchview addSubview:self.searchbar];
        [self.searchbar autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
        [self.searchbar autoSetDimensionsToSize:self.searchbar.size];
    }
    return _searchview;
}
- (UIView *)filterview{
    if (_filterview == nil) {
        _filterview = [UIView new];
        
    }
    return _filterview;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    //
    [self addSubview:self.searchview];
    [self.searchview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.searchview autoSetDimension:(ALDimensionHeight) toSize:_pgf_search_height];
    
    [self addSubview:self.filterview];
    [self.filterview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeTop)];
    [self.filterview autoSetDimension:(ALDimensionHeight) toSize:_pgf_filter_height];
    
    self.height = _pgf_filter_height+_pgf_search_height;
    
}
-(void)setupbtns{
    if (self.btns.count>=1) {
        [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.btns removeAllObjects];
    }
    CGFloat width = (JMScreenWidth-2)/3;
    [self.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FNCombinedButton* btn = [[FNCombinedButton alloc]initWithImage:IMAGE(@"partner_down") selectedImage:IMAGE(@"partner_up") title:obj font:kFONT14 titleColor:FNGlobalTextGrayColor selectedTitleColor:FNMainGobalControlsColor target:self action:@selector(btnClicked:)];
        btn.frame = CGRectMake(idx*(1+width), 0, width, _pgf_filter_height);
        [self.filterview addSubview:btn];
        if (idx <self.titles.count) {
            UIView * line = [[UIView alloc]initWithFrame:(CGRectMake(CGRectGetMaxX(btn.frame), (_pgf_filter_height-20)*0.5, 1, 20))];
            line.backgroundColor = FNHomeBackgroundColor;
            [self.filterview addSubview:line];
        }
        [self.btns addObject:btn];
    }];
}
- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    if (_titles.count >= 1) {
        [self setupbtns];
    }
}
- (NSMutableArray<FNCombinedButton *> *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray new];
    }
    return _btns;
}
#pragma mark - action
- (void)btnClicked:(UITapGestureRecognizer *)sender{
    PGFFilterType type = PGFFilterTypeCategory;
    if (sender.view == self.btns[0]) {
        type = PGFFilterTypeCategory;
    }else if (sender.view == self.btns[1]){
        type = PGFFilterTypeRecommend;
    }else{
        type = PGFFilterTypeFilter;
    }
    [self.btns enumerateObjectsUsingBlock:^(FNCombinedButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = idx == type;
    }];
    [self.btns[type].titleLabel setImage:IMAGE(@"partner_up") forState:(UIControlStateSelected)];
    if (self.filterClicked) {
        self.filterClicked(type,self.btns[type]);
    }
}
@end
