//
//  FNAudioRecordManager.m
//  THB
//
//  Created by Weller Zhao on 2019/2/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNAudioRecordManager.h"
#import <AVFoundation/AVFoundation.h>

@interface FNAudioRecordManager()

@property (nonatomic, strong) AVAudioSession *session;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, strong) FNAudioRecordCompletedBlock completedBlock;
@property (nonatomic, strong) FNAudioRecordVolumeBlock volumeBlock;

@property (nonatomic, copy) NSString *currentPath;

@end

@implementation FNAudioRecordManager

static FNAudioRecordManager* _instance = nil;

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
    return [FNAudioRecordManager shareInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [FNAudioRecordManager shareInstance] ;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *sessionError;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        
        if (session == nil) {
            NSLog(@"Error creating session: %@",[sessionError description]);
        }else{
            [session setActive:YES error:nil];
            
        }
        self.session = session;
        
        
    }
    return self;
}

- (NSString*) getAudioPath {
    //1.获取沙盒地址
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/"];
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [path stringByAppendingString:[NSString stringWithFormat:@"/RRecord_%@.wav", [NSString GetNowTimes]]];
    return filePath;
}

- (NSData*) getDataWithFileName: (NSString*) filename {
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/"];
    NSString *filePath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@", filename]];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return data;
}

- (NSURL*) getURLWithFileName: (NSString*) filename {
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/"];
    NSString *filePath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@", filename]];
    return [[NSURL alloc] initFileURLWithPath:filePath];
}

- (void) startRecordWithVolume: (FNAudioRecordVolumeBlock) volumeBlock completed: (FNAudioRecordCompletedBlock)completedBlock{
    NSLog(@"开始录音");
    
    NSString *filePath = [self getAudioPath];
    _currentPath = filePath;
    [[NSFileManager defaultManager]removeItemAtPath:filePath error:nil];
    
    //2.获取文件路径
    NSURL *recordFileUrl = [NSURL fileURLWithPath:filePath];
    
    //设置参数
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey,
                                   // 音频格式
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   //采样位数  8、16、24、32 默认为16
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                   // 音频通道数 1 或 2
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                   //录音质量
                                   [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                   nil];
    
    NSError *error = nil;
    _recorder = [[AVAudioRecorder alloc] initWithURL:recordFileUrl settings:recordSetting error:&error];
    if (error) {
        completedBlock(nil, error, NO);
        return;
    }
    _completedBlock = completedBlock;
    _volumeBlock = volumeBlock;
    
    if (_recorder) {
        
        _recorder.meteringEnabled = YES;
        [_recorder prepareToRecord];
        [_recorder record];
        
        // 设置定时器,实时更新音量变化
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateMeters)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
    }else{
        NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
        
    }
    
}

// 检测当前的音量大小
- (void)updateMeters{
    
    // 更新音量
    [self.recorder updateMeters];
    
    // 获取0声道的音量 (0 默认左声道)
    //  averagePowerForChannel获取的是平均值
    //  peakPowerForChannel 极值, 返回当时的分贝
    CGFloat power = [self.recorder peakPowerForChannel:0];
    // 返回值为负数,当为0时说明是最大值了,如果外界声音比较小,数值就会很小,当返回值为-160时代表停止
    
    CGFloat level = (160 + power) / 160.0;
    CGFloat linear = powf(10, level) / 10;
//    NSLog(@"%f",linear);
    if (_volumeBlock) {
        _volumeBlock(level);
    }
}

- (void)cancle {
    if ([self.recorder isRecording]) {
        [self.recorder stop];
    }
    if (_completedBlock) {
        _completedBlock(nil, nil, NO);
    }
    
    _completedBlock = nil;
    _volumeBlock = nil;
    
    [_displayLink invalidate];
    _displayLink = nil;
}

- (void)stopRecord {
    
    NSLog(@"停止录音");
    
    if ([self.recorder isRecording]) {
        [self.recorder stop];
    }
    
//    NSString *filePath = [self getAudioPath];
    if ([_currentPath kr_isNotEmpty]) {
        if (_completedBlock && [[NSFileManager defaultManager] fileExistsAtPath:_currentPath]) {
            _completedBlock([NSURL fileURLWithPath:_currentPath], nil, YES);
        }
    }
    
    _completedBlock = nil;
    _volumeBlock = nil;
    _currentPath = nil;
    
    [_displayLink invalidate];
    _displayLink = nil;
    
}

@end
