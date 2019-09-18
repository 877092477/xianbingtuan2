//
//  FNArtcleTopSlideNCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNArtcleTopSlideNCell.h"

@implementation FNArtcleTopSlideNCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNArtcleTopSlideNCell";
    FNArtcleTopSlideNCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
     
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews
{
    //大幻灯片
    [self addPagerView];
    //模糊层
    _polishimg=[[DRNRealTimeBlurView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, 237)];
    [self.contentView addSubview:_polishimg];
    //图片
    self.bgImgView=[[UIImageView alloc]init];
    [self.contentView addSubview:self.bgImgView];
    self.bgImgView.sd_layout
    .leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 74).rightSpaceToView(self.contentView, 0).heightIs(163);
    //小幻灯片
    [self configUI]; 
    //横幅
    self.streamerNView=[[FNArtcleTopStreamerNView alloc]initWithFrame:CGRectMake(0, 290, FNDeviceWidth, 240)];
    [self.contentView addSubview:self.streamerNView];
}
//大幻灯片
- (void)addPagerView {
    
    _pagerView = [[TYCyclePagerView alloc]init];
    _pagerView.isInfiniteLoop = YES;
    _pagerView.autoScrollInterval = 0;
    _pagerView.dataSource = self;
    _pagerView.delegate = self;
    _pagerView.frame=CGRectMake(0, 0, XYScreenWidth, 237);
    [_pagerView registerClass:[FNartcleTopFuzzyImgCell class] forCellWithReuseIdentifier:@"FNartcleTopFuzzyImgCell"];
    
    [self.contentView addSubview:_pagerView];
   
//    TYPageControl *pageControl = [[TYPageControl alloc]init];
//    //pageControl.numberOfPages = _datas.count;
//    pageControl.currentPageIndicatorSize = CGSizeMake(6, 6);
//    pageControl.pageIndicatorSize = CGSizeMake(6, 6);
//    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
//    pageControl.pageIndicatorTintColor = [UIColor grayColor];
//    [self.contentView addSubview:pageControl];
//    _pageControl = pageControl;
//    _pageControl.frame = CGRectMake(0, 145, CGRectGetHeight(_pagerView.frame) - 26, 26);
    
}
//小幻灯片
- (void)configUI {
    _pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(12, 107, XYScreenWidth-24, 170)];
    _pageFlowView.backgroundColor = [UIColor whiteColor];
    _pageFlowView.delegate = self;
    _pageFlowView.dataSource = self;
    _pageFlowView.minimumPageAlpha = 0.1;
    _pageFlowView.isCarousel = YES;
    _pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    _pageFlowView.isOpenAutoScroll = YES;
    _pageFlowView.leftRightMargin=0;
    _pageFlowView.topBottomMargin=0;
    _pageFlowView.autoTime=5;
    _pageFlowView.cornerRadius=10;
    
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _pageFlowView.frame.size.height - 15 - 8, XYScreenWidth, 8)];
    _pageFlowView.pageControl = pageControl;
    [_pageFlowView addSubview:pageControl];
    [self.contentView addSubview:_pageFlowView];
    [_pageFlowView reloadData];
}

-(void)setDataModel:(FNExpertNaModel *)dataModel{
    _dataModel=dataModel;
    if(dataModel){
        NSArray *bannerArray=dataModel.topdata;
        self.bgImgView.image=IMAGE(@"FN_DR_HUImg"); 
        NSArray *newdataArray=dataModel.newdata;
        self.streamerNView.dataArr=newdataArray;
        self.streamerNView.titleLB.text=dataModel.second_title;
        [_pagerView reloadData];
        
        [_pageFlowView reloadData];
        
        //_pageControl.numberOfPages = bannerArray.count;
        
        _pageFlowView.pageControl.sd_layout
        .rightSpaceToView(self.pageFlowView, 30).heightIs(26).bottomSpaceToView(self.pageFlowView, 15).widthIs(10*bannerArray.count);
    }
}


#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    NSArray *bannerArray=self.dataModel.topdata;
    return bannerArray.count;
}
- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    
    NSArray *bannerArray=self.dataModel.topdata;
    FNEssayItemDModel *model=[FNEssayItemDModel mj_objectWithKeyValues:bannerArray[index]];
    FNartcleTopFuzzyImgCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"FNartcleTopFuzzyImgCell" forIndex:index];
    cell.cornerRadius=0;
    [cell.imgView setUrlImg:model.app_image];
    return cell;
    
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    //layout.itemSize = CGSizeMake(XYScreenWidth-24, 170);
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(XYScreenWidth, 237);
    layout.itemSpacing = 0;//12
    return layout;
    
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    //[_pageControl setCurrentPage:toIndex animate:YES];
    //NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

- (void)pageViewDidCollectionView:(UICollectionView *)collectionView ofsetX:(CGFloat)conX{
    if(collectionView==_pagerView.collectionView){
      //XYLog(@"pagerXX==%f",conX);
    }
}

#pragma mark - NewPagedFlowViewDataSource, NewPagedFlowViewDelegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(XYScreenWidth, 170);
}
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
}

- (void)didSelectCell:(PGIndexBannerSubiew *)subView withSubViewIndex:(NSInteger)subIndex {
    if ([self.delegate respondsToSelector:@selector(tendSlideClickAction:)]) {
        [self.delegate tendSlideClickAction:subIndex];
    }
}

- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    NSArray *bannerArray=self.dataModel.topdata;
    return bannerArray.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index {
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 0;
        bannerView.layer.masksToBounds = YES;
    }
    NSArray *bannerArray=self.dataModel.topdata;
    FNEssayItemDModel *model=[FNEssayItemDModel mj_objectWithKeyValues:bannerArray[index]];
    [bannerView.mainImageView setUrlImg:model.app_image];
    return bannerView;
}

- (void)didScroll:(UIScrollView *)scrollView{
    //XYLog(@"pager2X==%f",scrollView.contentOffset.x);
    CGFloat conX=scrollView.contentOffset.x;
    
    [_pagerView.collectionView setContentOffset:CGPointMake(conX, 0) animated:NO];
}
@end
