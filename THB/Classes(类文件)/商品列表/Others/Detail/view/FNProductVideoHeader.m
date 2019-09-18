//
//  FNProductVideoHeader.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNProductVideoHeader.h"
#import "JPVideoPlayer/UIView+WebVideoCache.h"
#import "FNVideoPlayerControlBar.h"
#import "JPVideoPlayer/JPVideoPlayerKit.h"

@interface FNProductVideoHeader()

@property (nonatomic, strong) FNVideoPlayerControlBar *controlBar;
@property (nonatomic, strong) JPVideoPlayerControlView *controlView;
@property (nonatomic, assign) BOOL isVideoShow;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) BOOL canAutoScroll;

@end

@implementation FNProductVideoHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        _controlBar = [[FNVideoPlayerControlBar alloc] initWithProgressView:nil];
        
        _controlBar.DownloadBlock = self.DownloadBlock;
        _controlView = [[JPVideoPlayerControlView alloc] initWithControlBar:_controlBar blurImage:nil];
        [_controlView addSubview:_controlBar];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
        _canAutoScroll = YES;
    }
    return self;
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}
- (NSArray *)productDetailsArr{
    if (!_productDetailsArr) {
        _productDetailsArr = [NSArray array];
        
    }
    return _productDetailsArr;
}
- (UIButton *)playBtn{
    if (!_playBtn) {
        _playBtn = [[UIButton alloc]init];
        _playBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_playBtn setImage:[UIImage imageNamed:@"button_play"] forState:UIControlStateNormal];
    }
    return _playBtn;
}
- (UILabel *)indexLab{
    if (!_indexLab) {
        _indexLab = [[UILabel alloc]init];
        _indexLab.textColor = [UIColor whiteColor];
        _indexLab.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
        _indexLab.font = [UIFont systemFontOfSize:11];
        _indexLab.textAlignment = 1;
        _indexLab.layer.cornerRadius = 13;
        _indexLab.layer.masksToBounds = YES;
    }
    return _indexLab;
}
- (UIButton *)ToVideoBtn{
    if (!_ToVideoBtn) {
        _ToVideoBtn = [[UIButton alloc]init];
        [_ToVideoBtn setTitle:@"视频" forState:UIControlStateNormal];
        [_ToVideoBtn setTitle:@"视频" forState:UIControlStateSelected];
        [_ToVideoBtn setImage:IMAGE(@"play_button_normal") forState:UIControlStateNormal];
        [_ToVideoBtn setImage:IMAGE(@"play_button") forState:UIControlStateSelected];
        [_ToVideoBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:2];
        [_ToVideoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_ToVideoBtn setBackgroundColor:RED];
        _ToVideoBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_ToVideoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _ToVideoBtn.layer.cornerRadius = 13;
        _ToVideoBtn.layer.masksToBounds = YES;
    }
    return _ToVideoBtn;
}
- (UIButton *)ToPictureBtn{
    if (!_ToPictureBtn) {
        _ToPictureBtn = [[UIButton alloc]init];
        [_ToPictureBtn setTitle:@"图片" forState:UIControlStateNormal];
        [_ToPictureBtn setTitle:@"图片" forState:UIControlStateSelected];
        [_ToPictureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ToPictureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _ToPictureBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _ToPictureBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        _ToPictureBtn.layer.cornerRadius = 13;
        _ToPictureBtn.layer.masksToBounds = YES;
    }
    return _ToPictureBtn;
}

- (UIScrollView *)scrolV{
    if (!_scrolV) {
        _scrolV = [[UIScrollView alloc]init];
        _scrolV.pagingEnabled  = YES;
        _scrolV.showsVerticalScrollIndicator = NO;
        _scrolV.showsHorizontalScrollIndicator = NO;
    }
    return _scrolV;
}
- (UIImageView *)videoCoverImgV{
    if (!_videoCoverImgV) {
        _videoCoverImgV = [[UIImageView alloc]init];
        _videoCoverImgV.contentMode = UIViewContentModeScaleAspectFill;
        _videoCoverImgV.userInteractionEnabled = YES;
    }
    return _videoCoverImgV;
}
- (void)updateUIWithImageAndVideoArray:(NSArray *)detailsArr isVideoShow: (BOOL)isShow {
    self.productDetailsArr = detailsArr;
    _isVideoShow = isShow;
    NSInteger count = isShow ? (detailsArr.count + 1) : detailsArr.count;
    self.scrolV.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.scrolV.contentSize = CGSizeMake(count*self.frame.size.width, self.frame.size.height);
    self.scrolV.delegate  = self;
    self.scrolV.contentOffset = CGPointMake(0, 0);
    [self addSubview:self.scrolV];
    
    if (detailsArr.count <= 0)
        return;
    
    if (isShow) {
        self.videoCoverImgV.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.playBtn.frame = CGRectMake((self.frame.size.width - 70)/2.0, (self.frame.size.height - 70)/2.0, 70, 70);
        [self.playBtn addTarget:self action:@selector(playClick) forControlEvents:UIControlEventTouchUpInside];
        [self.videoCoverImgV addSubview:self.playBtn];
        [self.videoCoverImgV sd_setImageWithURL:detailsArr[0]];
        [self.scrolV addSubview:self.videoCoverImgV];
        
    }
    
    for (int i = 0; i < detailsArr.count; i ++) {
        
        UIImageView * imgV = [[UIImageView alloc]initWithFrame:CGRectMake((i + (isShow ? 1 : 0))*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        [imgV sd_setImageWithURL:detailsArr[i]];
        [self.scrolV addSubview:imgV];
        @weakify(self)
        int index = i;
        [imgV addJXTouch:^{
            @strongify(self)
            if (self.ClickBlock) {
                self.ClickBlock(index);
            }
        }];

        
    }
    
    self.indexLab.frame = CGRectMake(self.frame.size.width - 40 - 20, self.frame.size.height - 25 - 20, 40, 25);
    self.indexLab.text = [NSString stringWithFormat:@"%d/%d",1,(int)count];
    [self addSubview:self.indexLab];
    self.indexLab.hidden = NO;
    if (isShow) {
        //            添加“视频”、“图片”
        self.indexLab.hidden = YES;
        self.ToVideoBtn.frame = CGRectMake(self.center.x - 60-10, self.frame.size.height - 25 - 20, 60, 25);
        [self addSubview:self.ToVideoBtn];
        self.ToVideoBtn.selected = YES;
        self.ToPictureBtn.frame = CGRectMake(self.center.x + 10, self.frame.size.height - 25 - 20, 60, 25);
        [self addSubview:self.ToPictureBtn];
        self.ToPictureBtn.selected = NO;
        self.ToVideoBtn.tag = 10;
        self.ToPictureBtn.tag = 11;
        [self.ToVideoBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.ToPictureBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)updateTime {
    if (_currentIndex == 0 && _isVideoShow) {
        return;
    }
    if (!_canAutoScroll || self.productDetailsArr.count < 0) {
        return;
    }
    NSInteger count = self.productDetailsArr.count + (_isVideoShow ? 1 : 0);
    _currentIndex = (_currentIndex + 1) % count;
    if (_currentIndex == 0 && _isVideoShow) {
        _currentIndex = (_currentIndex + 1) % count;
    }
    self.indexLab.text = [NSString stringWithFormat:@"%d/%ld",(int)_currentIndex + 1,count];
    [self.scrolV setContentOffset:CGPointMake(_currentIndex*self.frame.size.width, 0) animated:YES];

}

- (void)changeBtnClick:(UIButton *)btn{
    if (btn.tag == 10) {
        //        视频
        self.ToVideoBtn.selected = YES;
        self.ToPictureBtn.selected = NO;
        self.ToVideoBtn.backgroundColor = RED;
        self.ToPictureBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        NSLog(@"点击视频");
        
        if ([self.scrolV.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
            
            [self.scrolV setContentOffset:CGPointMake(0, 0) animated:NO];
            [self scrollViewDidEndDecelerating:self.scrolV];
        }
        
    }
    else{
        //        图片
        self.ToVideoBtn.selected = NO;
        self.ToPictureBtn.selected = YES;
        
        self.ToVideoBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        self.ToPictureBtn.backgroundColor = RED;
        NSLog(@"点击图片");
        if (self.scrolV.contentOffset.x < self.frame.size.width) {
            if ([self.scrolV.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
                [self.scrolV setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
                [self scrollViewDidEndDecelerating:self.scrolV];
            }
        }
        
    }
    return;
}

- (void)updateIndex: (NSInteger)index {
    self.scrolV.contentOffset = CGPointMake(index*self.bounds.size.width, 0);
    if (self.scrolV.contentOffset.x < self.frame.size.width) {
        self.indexLab.hidden = YES;
        [self.scrolV setContentOffset:CGPointMake(0, 0) animated:NO];
        
    }
    else{
        self.indexLab.hidden = NO;
        self.scrolV.contentOffset = CGPointMake(_scrolV.contentOffset.x/self.frame.size.width*self.frame.size.width, 0);
    }
    self.indexLab.text = [NSString stringWithFormat:@"%d/%d",(int)index + 1,(int)self.productDetailsArr.count + (_isVideoShow ? 1 : 0)];
    if (self.scrollOptBlock) {
        self.scrollOptBlock(_currentIndex);
    }
}

#pragma mark - scrollView的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/self.bounds.size.width;
    _currentIndex = index;
    [self updateIndex: index];
    _canAutoScroll = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _canAutoScroll = NO;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrolV.contentOffset.x < self.frame.size.width) {
        //        处理“视频”按钮
        self.ToVideoBtn.selected = YES;
        self.ToPictureBtn.selected = NO;
        self.ToVideoBtn.backgroundColor = RED;
        self.ToPictureBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    }
    else{
        
        //        处理“图片”按钮
        self.ToVideoBtn.selected = NO;
        self.ToPictureBtn.selected = YES;
        self.ToVideoBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        self.ToPictureBtn.backgroundColor = RED;
        
    }
    
}
- (void)playClick{
    if (self.PlayVideoOptBlock) {
        self.PlayVideoOptBlock(YES);
    }
}

- (void)playWithUrl: (NSURL*)url {
    [self.videoCoverImgV jp_playVideoWithURL:url bufferingIndicator:nil controlView:_controlView progressView:nil configuration:nil];
}

- (void)stopPlaying {
    [self.videoCoverImgV jp_stopPlay];
}

- (void)pausePlaying {
    [self.videoCoverImgV jp_pause];
}

- (void)setDownloadBlock:(void (^)(void))DownloadBlock {
    _DownloadBlock = DownloadBlock;
    _controlBar.DownloadBlock = DownloadBlock;
}

@end

