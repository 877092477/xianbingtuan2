//
//  FNVideoGalleryCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNVideoGalleryCell.h"
#import "NewPagedFlowView.h"

@interface FNVideoGalleryCell()<NewPagedFlowViewDataSource, NewPagedFlowViewDelegate>

@property (nonatomic, strong) NewPagedFlowView *pageFlowView;
@property (nonatomic, strong) NSArray<NSString*>* urls;

@end

@implementation FNVideoGalleryCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenWidth * 9 / 16)];
    _pageFlowView.backgroundColor = [UIColor whiteColor];
    _pageFlowView.delegate = self;
    _pageFlowView.dataSource = self;
    _pageFlowView.minimumPageAlpha = 0.1;
    _pageFlowView.isCarousel = YES;
    _pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    _pageFlowView.isOpenAutoScroll = YES;
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _pageFlowView.frame.size.height - 24 - 8, XYScreenWidth, 8)];
    _pageFlowView.pageControl = pageControl;
    [_pageFlowView addSubview:pageControl];
//    [pageFlowView startTimer];
    [self.contentView addSubview:_pageFlowView];
    [_pageFlowView reloadData];
}

#pragma mark - NewPagedFlowViewDataSource, NewPagedFlowViewDelegate

- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(XYScreenWidth - 60, (XYScreenWidth - 60) * 9 / 16);
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
}

- (void)didSelectCell:(PGIndexBannerSubiew *)subView withSubViewIndex:(NSInteger)subIndex {
    if ([_delegate respondsToSelector:@selector(cell:didItemClickAt:)]) {
        [_delegate cell:self didItemClickAt:subIndex];
    }
}

- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return _urls ? _urls.count : 0;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index {
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    //在这里下载网络图片
    [bannerView.mainImageView sd_setImageWithURL:URL(_urls[index])];
    
    return bannerView;
}

- (void)setImageUrls: (NSArray<NSString*>*)urls {
    _urls = urls;
    [_pageFlowView reloadData];
}

@end
