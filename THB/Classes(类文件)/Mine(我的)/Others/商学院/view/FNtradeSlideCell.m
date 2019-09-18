//
//  FNtradeSlideCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNtradeSlideCell.h"

@implementation FNtradeSlideCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews]; 
    }
    return self;
}

- (void)initializedSubviews
{
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.delegate=self;
    self.searchBar.placeholder=@"";
    self.searchBar.cornerRadius=35/2;
    self.searchBar.backgroundImage = [UIImage createImageWithColor:RGBA(238, 238, 238,0.7)];
    [self addSubview:self.searchBar];
    [self.searchBar setImage:IMAGE(@"FJ_slices_img") forSearchBarIcon:UISearchBarIconSearch  state:UIControlStateNormal];
    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
    searchField.tintColor=[UIColor lightGrayColor];
    searchField.backgroundColor = [UIColor clearColor];
    if (searchField) {
        searchField.font=[UIFont systemFontOfSize:12];
        if ([self.searchBar.placeholder kr_isNotEmpty]) {
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.searchBar.placeholder attributes:
                                              @{NSForegroundColorAttributeName:RGB(190,189,189),
                                                NSFontAttributeName:[UIFont systemFontOfSize:12]}];
            searchField.attributedPlaceholder = attrString;
        }
    }
    
    self.searchBar.sd_layout
    .topSpaceToView(self, 13).leftSpaceToView(self, 35).rightSpaceToView(self, 35).heightIs(35);
    
    [self addPagerViews];
}
//幻灯片
- (void)addPagerViews {
    self.pagerView = [[TYCyclePagerView alloc]init];
    self.pagerView.dataSource = self;
    self.pagerView.delegate = self;
    self.pagerView.isInfiniteLoop = YES;
    self.pagerView.frame=CGRectMake(0, 61, XYScreenWidth, 135);
    [self.pagerView registerClass:[FNtradeMenusImgsCell class] forCellWithReuseIdentifier:@"FNtradeMenusImgsCellID"];
    [self addSubview:self.pagerView]; 
    
    self.pageControl = [[TYPageControl alloc]init];
    self.pageControl.currentPageIndicatorSize = CGSizeMake(16, 6);
    self.pageControl.pageIndicatorSize = CGSizeMake(6, 6);
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.animateDuring=1.0f;
    [self addSubview:self.pageControl];
    //self.pageControl.frame = CGRectMake(0, 165, XYScreenWidth-26, 26);
    self.pageControl.sd_layout
    .bottomSpaceToView(self, 8).centerXEqualToView(self).widthIs(XYScreenWidth-36).heightIs(26);
    
}
#pragma mark - 搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if ([searchBar.text kr_isNotEmpty]) {
        [self.searchBar resignFirstResponder];
    }
    if ([self.delegate respondsToSelector:@selector(inTradeSlideCompileAction:)]) {
        [self.delegate inTradeSlideCompileAction:searchBar.text];
    }
} 

-(void)setModel:(FNtradeHomeModel *)model{
    _model=model;
    if(model){
        self.searchBar.placeholder=model.select_tips;
        NSString *bannerBili=model.banner_bili;
        CGFloat bannerHight;
        if([bannerBili kr_isNotEmpty]){
            bannerHight=[bannerBili floatValue] *FNDeviceWidth;
        }else{
            bannerHight=135;
        }
        self.pagerView.frame=CGRectMake(0, 61, XYScreenWidth, bannerHight);
        
        NSArray *bannerList=self.model.banner;
        if(bannerList.count>1){
            self.pageControl.numberOfPages = 3;//bannerList.count;
            self.pagerView.autoScrollInterval = 5;
        }else{
            self.pagerView.autoScrollInterval = 0;
        }
        [self.pagerView reloadData];
    }
}

#pragma mark - TYCyclePagerViewDataSource
- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    NSArray *bannerList=self.model.banner;
    return bannerList.count;
}
- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    NSArray *bannerList=self.model.banner;
    FNtradeHomeBannerItemModel *model=[FNtradeHomeBannerItemModel mj_objectWithKeyValues:bannerList[index]];
    FNtradeMenusImgsCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"FNtradeMenusImgsCellID" forIndex:index];
    //cell.backgroundColor=[UIColor lightGrayColor];
    cell.typeInt=1;
    [cell.allImgView setUrlImg:model.img];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    NSString *bannerBili=self.model.banner_bili;
    CGFloat bannerHight;
    if([bannerBili kr_isNotEmpty]){
        bannerHight=[bannerBili floatValue] *FNDeviceWidth;
    }else{
        bannerHight=135;
    }
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(XYScreenWidth-24, bannerHight);
    layout.itemSpacing = 12;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSArray *bannerList=self.model.banner;
    if(bannerList.count>1){
       [self.pageControl setCurrentPage:toIndex animate:YES];
    }
}
- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(inTradeSlideClick:)]) {
        [self.delegate inTradeSlideClick:index];
    }
}
@end
