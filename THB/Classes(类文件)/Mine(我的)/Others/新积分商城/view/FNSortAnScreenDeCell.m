//
//  FNSortAnScreenDeCell.m
//  THB
//
//  Created by Jimmy on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//
//70
#import "FNSortAnScreenDeCell.h"

@implementation FNSortAnScreenDeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.btns = [NSMutableArray new];
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.filterview = [[UIView alloc]initWithFrame:(CGRectMake(0, 36, FNDeviceWidth, 34))];
    self.filterview.backgroundColor = FNWhiteColor;
    [self addSubview:self.filterview];
    
    UIView *lineView = [[UIView alloc]initWithFrame:(CGRectMake(0, 69, FNDeviceWidth, 1))];
    lineView.backgroundColor = RGB(245, 245, 245);
    [self addSubview:lineView];
    
    [self cateTopView];
   
}
#pragma mark - 类型
-(void)cateTopView{
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0,0, FNDeviceWidth, 35)];
    self.categoryView.delegate = self;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.backgroundColor=[UIColor whiteColor];
    //lineView
    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
    //line颜色
    self.lineView.indicatorColor=RGB(251, 155, 31);
    self.lineView.indicatorHeight=2;
    self.categoryView.indicators = @[self.lineView];
    [self addSubview:self.categoryView];
    
    self.categoryView.titleFont=kFONT14;
    self.categoryView.titleSelectedFont=kFONT14;
    self.categoryView.titleColor=RGB(153, 153, 153);
    self.categoryView.titleSelectedColor=RGB(255, 131, 20);
    self.lineView.indicatorColor=RGB(255, 131, 20);
    
}
#pragma mark - 点击兑换类型
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    XYLog(@"选择%ld",(long)index);
    if ([self.delegate respondsToSelector:@selector(choiceClassifyIntegralClick:withPlace:)]) {
        FNDefiniteListItemModel *model=[FNDefiniteListItemModel mj_objectWithKeyValues:self.sortArray[index]];
        [self.delegate choiceClassifyIntegralClick:model.id withPlace:index];
    }
}
-(void)setSortArray:(NSArray *)sortArray{
    _sortArray=sortArray;
    if(sortArray.count>0){
        NSMutableArray *titleArr=[NSMutableArray arrayWithCapacity:0];
        for(NSDictionary *dictry in sortArray){
            FNDefiniteListItemModel *model=[FNDefiniteListItemModel mj_objectWithKeyValues:dictry];
            [titleArr addObject:model.name];
        }
        //self.titleView.titleArray=titleArr;
//        if (titleArr.count>=1) {
//            [self.titleTwoView removeFromSuperview];
//        }
//        self.titleTwoView = [[QJSlideButtonView alloc] initWithTitleArr:titleArr withRoll:1 withTextColor:RGB(255, 131, 20)];
//        @WeakObj(self);
//        self.titleTwoView.sbBlock = ^(NSInteger index){
//            if ([selfWeak.delegate respondsToSelector:@selector(choiceClassifyIntegralClick:withPlace:)]) {
//                FNDefiniteListItemModel *model=[FNDefiniteListItemModel mj_objectWithKeyValues:sortArray[index]];
//                [selfWeak.delegate choiceClassifyIntegralClick:model.id withPlace:index];
//            }
//        };
//        self.titleTwoView.frame=CGRectMake(0,0, FNDeviceWidth, 35);
//        [self addSubview:self.titleTwoView];
        
        self.categoryView.titles =titleArr;
        [self.categoryView reloadData];
    }
}
-(void)setCatePlace:(NSInteger)catePlace{
    _catePlace=catePlace;
    if(catePlace){
        [self.titleTwoView seScrollViewPitchOn:catePlace];
    }
}
-(void)setScreeningArray:(NSArray *)screeningArray{
    _screeningArray=screeningArray;
    if(screeningArray.count>0){
        NSMutableArray *name=[[NSMutableArray alloc]init];
        if (screeningArray.count>0) {
            [screeningArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNDefiniteScreenModel *model=[FNDefiniteScreenModel mj_objectWithKeyValues:obj];
                [name addObject:model.name];
            }];
        }
        if (self.btns.count>=1) {
            [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self.btns removeAllObjects];
        } 
        CGFloat width = FNDeviceWidth*0.25;
        [name enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNCombinedButton* tmpview = nil;
            tmpview.userInteractionEnabled=YES;
            if (idx<1) {
                FNCombinedButton* btn = [[FNCombinedButton alloc]initWithImage:IMAGE(@"") selectedImage:IMAGE(@"") title:obj font:kFONT13 titleColor:RGB(140, 140, 140) selectedTitleColor:RGB(255, 131, 20) target:self action:nil];
                [self.filterview addSubview:btn];
                tmpview  = btn;
            }else{
                FNCombinedButton* btn = [[FNCombinedButton alloc]initWithImage:IMAGE(@"FJ_gray_sj") selectedImage:IMAGE(@"FJ_orSH_SJ") title:obj font:kFONT13 titleColor:RGB(140, 140, 140) selectedTitleColor:RGB(255, 131, 20) target:self action:nil];
                btn.tag = idx+100;
                [self.filterview addSubview:btn];
                tmpview  = btn;
            }
            [tmpview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, width*idx, 0, 0)) excludingEdge:(ALEdgeRight)];
            [tmpview autoSetDimension:(ALDimensionWidth) toSize:width];
            tmpview.tag = idx+100;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
            [tmpview addGestureRecognizer:tap];
            [self.btns addObject:tmpview]; 
        }];
        
    }
}
#pragma mark - JMTitleScrollViewDelegate
- (void)clickedTitleView:(JMTitleScrollView *)titleView atIndex:(NSInteger)index{
    
    if (titleView) {
        
    }
}
#pragma mark - action
-(void)tapClick:(id)sender{
    [self updateAtIndex: sender isClick: YES];
}

- (void)updateAtIndex: (id)sender isClick: (BOOL)isClick {
    UITapGestureRecognizer * singleTap = (UITapGestureRecognizer *)sender;
    
    UIView *tmp =nil;
    
    UIView *view = (UIView *)singleTap.view;
    
    NSInteger index = view.tag;
    
    NSInteger tag = index-100;
    
    if (tag==0) {
        FNCombinedButton* btn = self.btns[tag];
        tmp= btn;
        if ([self.delegate respondsToSelector:@selector(choiceRankIntegralClickWithPlace:WithState:)] && isClick) {
            [self.delegate choiceRankIntegralClickWithPlace:tag WithState:1];
        }
    }else{
        FNCombinedButton* btn = self.btns[tag];
        btn.titleLabel.selected=!btn.titleLabel.selected;
        [btn.titleLabel setImage:IMAGE(@"FJ_orX_SJ") forState:UIControlStateNormal];
        [btn.titleLabel setImage:IMAGE(@"FJ_orSH_SJ") forState:UIControlStateSelected];
        [btn.titleLabel setTitleColor:RGB(255, 131, 20) forState:UIControlStateNormal];
        [btn.titleLabel setTitleColor:RGB(255, 131, 20) forState:UIControlStateSelected];
        tmp = btn;
        NSInteger state=0;
        if( btn.titleLabel.selected==YES){
            state=1;
        }else{
            state=0;
        }
        if ([self.delegate respondsToSelector:@selector(choiceRankIntegralClickWithPlace:WithState:)] && isClick) {
            [self.delegate choiceRankIntegralClickWithPlace:tag WithState:state];
        }
    }
    
    [self.btns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx<1) {
            FNCombinedButton* btn = obj;
            btn.selected = btn==tmp;
        }else{
            if(idx!=tag){
                FNCombinedButton* btn = obj;
                btn.titleLabel.selected=NO;
                [btn.titleLabel setImage:IMAGE(@"FJ_gray_sj") forState:UIControlStateNormal];
                [btn.titleLabel setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
                btn.selected = btn==tmp;
            }
        }
    }]; 
}
-(void)setSortPalce:(NSInteger)sortPalce{
    _sortPalce=sortPalce;
    if(self.btns.count>0){
       [self sortPitchon:sortPalce];
    } 
}
-(void)sortPitchon:(NSInteger)send{
    UIView *view =[self viewWithTag:send + 100];
    view.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [view addGestureRecognizer:tap];
//    [self tapClick:tap];
    [self updateAtIndex: tap isClick: NO];
}
@end
