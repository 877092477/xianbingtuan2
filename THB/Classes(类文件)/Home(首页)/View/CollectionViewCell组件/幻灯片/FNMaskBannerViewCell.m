//
//  FNMaskBannerViewCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMaskBannerViewCell.h"
#import "FNImageCollectionViewCell.h"
#import "FNLOLCardLayout.h"

@interface FNMaskBannerViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *covImages;

@property (nonatomic, strong) NSArray* imageUrls;
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) NSTimer *timer;
//@property (nonatomic, assign) NSTimeInterval time;

@property (nonatomic, assign) BOOL dragging;

@end

@implementation FNMaskBannerViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.bannerArray = [NSArray new];
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews
{
    self.backgroundColor = UIColor.clearColor;
    
    FNLOLCardLayout *layout = [[FNLOLCardLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.headerReferenceSize = CGSizeZero;
    layout.footerReferenceSize = CGSizeZero;
    
    _covImages = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _covImages.backgroundColor = UIColor.clearColor;
    _covImages.pagingEnabled = YES;
    _covImages.showsVerticalScrollIndicator = NO;
    _covImages.showsHorizontalScrollIndicator = NO;
    
    [self.contentView addSubview:_covImages];
    [_covImages mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(4, 0, 0, 0));
    }];
    
    [_covImages registerClass:[FNImageCollectionViewCell class] forCellWithReuseIdentifier:@"FNImageCollectionViewCell"];
    
    _covImages.delegate = self;
    _covImages.dataSource = self;
    _time = 1;
    
    [self play];
    
}

- (void)setTime:(NSTimeInterval)time {
    _time = time;
    [self play];
}

- (void)stopPlaying {
    [_timer invalidate];
    _timer = nil;
}
- (void)play {
    [self stopPlaying];
    _timer = [NSTimer scheduledTimerWithTimeInterval:_time target:self selector:@selector(scrollNext) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void)dealloc
{
    [self stopPlaying];
}


- (void)scrollNext {
    if (_dragging) {
        return ;
    }
    if (_bannerArray.count >= 2) {
        [_covImages scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
    }
}


- (void)setBannerArray:(NSArray *)bannerArray{
    _bannerArray = bannerArray;
    if (_currentIndex >= bannerArray.count) {
        _currentIndex = 0;
    }
    
//    NSString *banner_speed=[bannerArray[0] valueForKey:@"banner_speed"];
//    NSString *bannerBili=[bannerArray[0] valueForKey:@"banner_bili"];
//    CGFloat bannerHight;
//    if([bannerBili kr_isNotEmpty]){
//        bannerHight=[bannerBili floatValue] *FNDeviceWidth;
//    }else{
//        bannerHight=0.52 *FNDeviceWidth;
//    }
//    _bannerView.frame=CGRectMake(0, 0, XYScreenWidth, bannerHight);
//    if([banner_speed kr_isNotEmpty]){
//        _time=[banner_speed floatValue]/1000;
//        [self play];
//    }
    
    if (_bannerArray.count> 0) {
        NSMutableArray* images = [NSMutableArray new];
        for (NSDictionary *dict in bannerArray) {
            Index_huandengpian_01Model *huandengpianModel=[Index_huandengpian_01Model mj_objectWithKeyValues:dict];
            [images addObject:huandengpianModel.img];
        }
//        _bannerView.imageURLStringsGroup = images;
        self.imageUrls = images;
    }
    [self reloadData];
}

- (void)reloadData {
    [self.covImages reloadData];
    if (self.imageUrls.count > 1) {
        [self.covImages scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:(UICollectionViewScrollPositionLeft) animated:NO];
    }
}

-(void)setModel:(Index_huandengpian_01Model *)model{
    
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_imageUrls == nil || _imageUrls.count == 0) {
        return 0;
    } else if (_imageUrls.count == 1) {
        return 1;
    } else {
        return 3;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FNImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNImageCollectionViewCell" forIndexPath:indexPath];
    
    NSInteger index = (_currentIndex + indexPath.row + _imageUrls.count - 1) % _imageUrls.count;
    [cell.imageView sd_setImageWithURL:_imageUrls[index] placeholderImage:IMAGE(@"APP底图")];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.bounds.size.width, collectionView.bounds.size.height);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_BannerClickedBlock) {
        _BannerClickedBlock(_currentIndex);
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    _currentIndex = (_currentIndex + 1) % _imageUrls.count;
//    NSLog(@"!!!!%ld", _currentIndex);
    [self reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat percent = (scrollView.contentOffset.x - _covImages.bounds.size.width) / _covImages.bounds.size.width;
//    NSLog(@"====%f", percent);
    if ([_delegate respondsToSelector:@selector(banner:didScrollToIndex:percent:)]) {
        [_delegate banner:self didScrollToIndex:_currentIndex percent:percent];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _dragging = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _dragging = NO;
    int index = _covImages.contentOffset.x / _covImages.bounds.size.width;
    if (_imageUrls.count > 1) {
        if (index == 0) {
            _currentIndex --;
        } else if (index == 2) {
            _currentIndex ++;
        }
    }
    _currentIndex = (_currentIndex + _imageUrls.count) % _imageUrls.count;
    NSLog(@"%ld", _currentIndex);
    if ([_delegate respondsToSelector:@selector(banner:didScrollToIndex:percent:)]) {
        [_delegate banner:self didScrollToIndex:_currentIndex percent:0];
    }
    [self reloadData];
    
    
}

@end
