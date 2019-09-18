//
//  FNVideoPlayerController.m
//  THB
//
//  Created by Weller Zhao on 2019/2/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNVideoPlayerController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "FNWebVideoManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface FNVideoPlayerController ()

@property (nonatomic, strong) MPMoviePlayerController *player;
@property (nonatomic, strong) UIButton *btnClose;

@end

@implementation FNVideoPlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _btnClose = [[UIButton alloc] init];
    [self.view addSubview:_btnClose];
    [_btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@40);
        make.left.equalTo(@0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(60);
    }];

    [_btnClose setImage:IMAGE(@"good_detail_close") forState:UIControlStateNormal];
    [_btnClose addTarget:self action:@selector(close)];
}

- (void)close {
    
    if (_player != nil) {
        [_player stop];
        [_player.view removeFromSuperview];
        _player = nil;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)playVideoWithUrl:(NSURL *)url {
    
    if ([url isFileURL]) {
        [self play:url];
        return;
    }
    @weakify(self)
    [[FNWebVideoManager shareInstance] downloadWithUrl:url completed:^(UIImage * _Nonnull coverImage, NSURL * _Nonnull fileUrl, NSError * _Nonnull error, BOOL finished) {
        @strongify(self)
        [self play:fileUrl];
    }];
    
}

- (void)play: (NSURL*)fileUrl {
    if (_player != nil) {
        [_player stop];
        [_player.view removeFromSuperview];
        _player = nil;
    }
    
    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:fileUrl];
    player.movieSourceType = MPMovieSourceTypeFile;
    player.fullscreen = YES;
    player.allowsAirPlay = YES;
    player.controlStyle = MPMovieControlStyleEmbedded;
    self.player = player;
    player.view.frame = self.view.frame;
    [self.view insertSubview:player.view atIndex:0];
    [player play];
}

@end
