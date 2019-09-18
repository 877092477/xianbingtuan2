//
//  FNVideoPlayerControlBar.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNVideoPlayerControlBar.h"
#import "JPVideoPlayerCompat.h"
#import "UIView+WebVideoCache.h"

@interface FNVideoPlayerControlBar()

@property (nonatomic, strong) UIButton *downloadButton;

@property (nonatomic, strong) UIButton *playButton;

@property (nonatomic, strong) UIView<JPVideoPlayerControlProgressProtocol> *progressView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *landscapeButton;

@property (nonatomic, weak) UIView *playerView;

@property(nonatomic, assign) NSTimeInterval totalSeconds;

@end

static const CGFloat kJPVideoPlayerControlBarButtonWidthHeight = 22;
static const CGFloat kJPVideoPlayerControlBarElementGap = 16;
static const CGFloat kJPVideoPlayerControlBarTimeLabelWidth = 68;


@implementation FNVideoPlayerControlBar

- (void)dealloc {
    [self.progressView removeObserver:self forKeyPath:@"userDragTimeInterval"];
}

- (instancetype)initWithFrame:(CGRect)frame {
    NSAssert(NO, @"Please use given method to initialize this class.");
    return [self initWithProgressView:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSAssert(NO, @"Please use given method to initialize this class.");
    return [self initWithProgressView:nil];
}

- (instancetype)initWithProgressView:(UIView <JPVideoPlayerControlProgressProtocol> *_Nullable)progressView {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _progressView = progressView;
        [self _setup];
    }
    return self;
}

- (instancetype)init {
    NSAssert(NO, @"Please use given method to initialize this class.");
    return [self initWithProgressView:nil];
}


#pragma mark - JPVideoPlayerLayoutProtocol

- (void)layoutThatFits:(CGRect)constrainedRect
nearestViewControllerInViewTree:(UIViewController *_Nullable)nearestViewController
  interfaceOrientation:(JPVideoPlayViewInterfaceOrientation)interfaceOrientation {
    CGSize referenceSize = constrainedRect.size;
    CGFloat elementOriginY = (referenceSize.height - kJPVideoPlayerControlBarButtonWidthHeight) * 0.5;
    self.playButton.frame = CGRectMake(kJPVideoPlayerControlBarElementGap,
                                       elementOriginY,
                                       kJPVideoPlayerControlBarButtonWidthHeight,
                                       kJPVideoPlayerControlBarButtonWidthHeight);
    self.downloadButton.frame = CGRectMake(referenceSize.width - kJPVideoPlayerControlBarElementGap - kJPVideoPlayerControlBarButtonWidthHeight,
                                            elementOriginY,
                                            kJPVideoPlayerControlBarButtonWidthHeight,
                                            kJPVideoPlayerControlBarButtonWidthHeight);
    
    self.landscapeButton.frame = CGRectMake(self.downloadButton.frame.origin.x  - kJPVideoPlayerControlBarElementGap - kJPVideoPlayerControlBarButtonWidthHeight,
                                            elementOriginY,
                                            kJPVideoPlayerControlBarButtonWidthHeight,
                                            kJPVideoPlayerControlBarButtonWidthHeight);
    
    self.timeLabel.frame = CGRectMake(self.landscapeButton.frame.origin.x - kJPVideoPlayerControlBarTimeLabelWidth - kJPVideoPlayerControlBarElementGap,
                                      elementOriginY,
                                      kJPVideoPlayerControlBarTimeLabelWidth,
                                      kJPVideoPlayerControlBarButtonWidthHeight);
    CGFloat progressViewOriginX = self.playButton.frame.origin.x + self.playButton.frame.size.width + kJPVideoPlayerControlBarElementGap;
    CGFloat progressViewWidth = self.timeLabel.frame.origin.x - progressViewOriginX - kJPVideoPlayerControlBarElementGap;
    self.progressView.frame = CGRectMake(progressViewOriginX,
                                         elementOriginY,
                                         progressViewWidth,
                                         kJPVideoPlayerControlBarButtonWidthHeight);
    if([self.progressView respondsToSelector:@selector(layoutThatFits:nearestViewControllerInViewTree:interfaceOrientation:)]){
        [self.progressView layoutThatFits:self.progressView.bounds
          nearestViewControllerInViewTree:nearestViewController
                     interfaceOrientation:interfaceOrientation];
    }
}


#pragma mark - JPVideoPlayerProtocol

- (void)viewWillAddToSuperView:(UIView *)view {
    self.playerView = view;
    [self updateTimeLabelWithElapsedSeconds:0 totalSeconds:0];
    [self.progressView viewWillAddToSuperView:view];
}

- (void)viewWillPrepareToReuse {
    [self updateTimeLabelWithElapsedSeconds:0 totalSeconds:0];
    [self.progressView viewWillPrepareToReuse];
}

- (void)cacheRangeDidChange:(NSArray<NSValue *> *)cacheRanges
                   videoURL:(NSURL *)videoURL {
    [self.progressView cacheRangeDidChange:cacheRanges
                                  videoURL:videoURL];
}

- (void)playProgressDidChangeElapsedSeconds:(NSTimeInterval)elapsedSeconds
                               totalSeconds:(NSTimeInterval)totalSeconds
                                   videoURL:(NSURL *)videoURL {
    self.totalSeconds = totalSeconds;
    if(!self.progressView.userDragging){
        [self updateTimeLabelWithElapsedSeconds:elapsedSeconds totalSeconds:totalSeconds];
    }
    [self.progressView playProgressDidChangeElapsedSeconds:elapsedSeconds
                                              totalSeconds:totalSeconds
                                                  videoURL:videoURL];
}

- (void)didFetchVideoFileLength:(NSUInteger)videoLength
                       videoURL:(NSURL *)videoURL {
    [self.progressView didFetchVideoFileLength:videoLength
                                      videoURL:videoURL];
}

- (void)videoPlayerStatusDidChange:(JPVideoPlayerStatus)playerStatus
                          videoURL:(NSURL *)videoURL {
    BOOL isPlaying = playerStatus == JPVideoPlayerStatusBuffering || playerStatus == JPVideoPlayerStatusPlaying;
    self.playButton.selected = !isPlaying;
}

- (void)videoPlayerInterfaceOrientationDidChange:(JPVideoPlayViewInterfaceOrientation)interfaceOrientation
                                        videoURL:(NSURL *)videoURL {
    self.landscapeButton.selected = interfaceOrientation == JPVideoPlayViewInterfaceOrientationLandscape;
}


#pragma mark - Private

- (void)updateTimeLabelWithElapsedSeconds:(NSTimeInterval)elapsedSeconds
                             totalSeconds:(NSTimeInterval)totalSeconds {
    NSString *elapsedString = [self convertSecondsToTimeString:elapsedSeconds];
    NSString *totalString = [self convertSecondsToTimeString:totalSeconds];
    self.timeLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@/%@", elapsedString, totalString]
                                                                    attributes:@{
                                                                                 NSFontAttributeName : [UIFont systemFontOfSize:10],
                                                                                 NSForegroundColorAttributeName : [UIColor whiteColor]
                                                                                 }];
}

- (NSString *)convertSecondsToTimeString:(NSTimeInterval)seconds {
    NSUInteger minute = (NSUInteger)(seconds / 60);
    NSUInteger second = (NSUInteger)((NSUInteger)seconds % 60);
    return [NSString stringWithFormat:@"%02d:%02d", (int)minute, (int)second];
}

- (void)playButtonDidClick:(UIButton *)button {
    button.selected = !button.selected;
    BOOL isPlay = self.playerView.jp_playerStatus == JPVideoPlayerStatusBuffering ||
    self.playerView.jp_playerStatus == JPVideoPlayerStatusPlaying;
    isPlay ? [self.playerView jp_pause] : [self.playerView jp_resume];
}

- (void)landscapeButtonDidClick:(UIButton *)button {
    button.selected = !button.selected;
    self.playerView.jp_viewInterfaceOrientation == JPVideoPlayViewInterfaceOrientationPortrait ? [self.playerView jp_gotoLandscape] : [self.playerView jp_gotoPortrait];
}

- (void)downloadButtonDidClick:(UIButton *)button {
    button.selected = !button.selected;
    if (_DownloadBlock) {
        _DownloadBlock();
    }
//    self.playerView.jp_viewInterfaceOrientation == JPVideoPlayViewInterfaceOrientationPortrait ? [self.playerView jp_gotoLandscape] : [self.playerView jp_gotoPortrait];
}

- (void)_setup {
    NSBundle *bundle = [NSBundle bundleForClass:[JPVideoPlayer class]];
    NSString *bundlePath = [bundle pathForResource:@"JPVideoPlayer" ofType:@"bundle"];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.playButton = ({
        UIButton *button = [UIButton new];
        [button setImage:[UIImage imageNamed:[bundlePath stringByAppendingPathComponent:@"jp_videoplayer_pause"]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[bundlePath stringByAppendingPathComponent:@"jp_videoplayer_play"]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(playButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        button;
    });
    
    if(!self.progressView){
        self.progressView = ({
            JPVideoPlayerControlProgressView *view = [JPVideoPlayerControlProgressView new];
            [view addObserver:self forKeyPath:@"userDragTimeInterval" options:NSKeyValueObservingOptionNew context:nil];
            [self addSubview:view];
            
            view;
        });
    }
    
    self.timeLabel = ({
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        label;
    });
    
    self.landscapeButton = ({
        UIButton *button = [UIButton new];
        [button setImage:[UIImage imageNamed:[bundlePath stringByAppendingPathComponent:@"jp_videoplayer_landscape"]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[bundlePath stringByAppendingPathComponent:@"jp_videoplayer_portrait"]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(landscapeButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        button;
    });
    
    self.downloadButton = ({
        UIButton *button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"download"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(downloadButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        button;
    });
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath
                      ofObject:(nullable id)object
                        change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(nullable void *)context {
    if([keyPath isEqualToString:@"userDragTimeInterval"]) {
        NSNumber *timeIntervalNumber = change[NSKeyValueChangeNewKey];
        NSTimeInterval timeInterval = timeIntervalNumber.floatValue;
        [self updateTimeLabelWithElapsedSeconds:timeInterval totalSeconds:self.totalSeconds];
    }
}

@end
