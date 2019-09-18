//
//  FNWebVoiceManager.m
//  THB
//
//  Created by Weller Zhao on 2019/2/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNWebVoiceManager.h"
#import "FNWebFileManager.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVFoundation.h>

@interface FNWebVoiceManager()<AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) FNWebVoicePlayCompletedBlock playBlock;

@end

@implementation FNWebVoiceManager

static FNWebVoiceManager* _instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    
    return _instance ;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [FNWebVoiceManager shareInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [FNWebVoiceManager shareInstance] ;
}

+ (float) getVoiceLength: (NSURL*)fileUrl {
    AVURLAsset *audioAsset = [AVURLAsset URLAssetWithURL:fileUrl options:nil];
    CMTime audioDuration = audioAsset.duration;
    float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
    return audioDurationSeconds;
}

- (void) downloadWithUrl: (NSURL*)url completed: (FNWebVoiceDownloaderCompletedBlock)block {
    if (url == nil) {
        return;
    }
    NSString *path = [[FNWebFileManager shareInstance] getCachePath:url];
    NSURL *cacheUrl = URL(path);
    
    [[FNWebFileManager shareInstance] downloadWithUrl:url completed:^(NSURL * fileUrl, NSError * error, BOOL finished) {
        if (error != nil) {
            block(0, nil, error, finished);
            return;
        }
        
        float audioDurationSeconds = [FNWebVoiceManager getVoiceLength:fileUrl];
        
        if (!isnan(audioDurationSeconds)) {
            block(audioDurationSeconds, fileUrl, nil, finished);
        }
        else {
            block(0, nil, error, finished);
        }
        
    }];
}

- (void) playWithUrl: (NSURL*)url completed: (FNWebVoicePlayCompletedBlock) block{
    
    [self stop];
    self.playBlock = block;
    if ([url isFileURL]) {
        [self play:url];
        return;
    }
    
    @weakify(self)
    [self downloadWithUrl:url completed:^(float length, NSURL * _Nonnull fileUrl, NSError * _Nonnull error, BOOL finished) {
        
        [self_weak_ play:fileUrl];
    }];
}

- (void)play: (NSURL*)fileUrl {
    NSError *err = nil;
    
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    self.player = [[AVAudioPlayer alloc] initWithData:data error:&err];
    self.player.delegate = self;
    
    // 准备播放
    [self.player prepareToPlay];
    [self.player play];
}

- (void) stop {
    [self.player stop];
    if (self.playBlock) {
        self.playBlock(NO);
    }
    self.playBlock = nil;
}

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (self.playBlock) {
        self.playBlock(YES);
    }
    self.playBlock = nil;
}

@end
