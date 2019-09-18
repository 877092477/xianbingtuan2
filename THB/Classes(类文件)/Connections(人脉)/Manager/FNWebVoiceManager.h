//
//  FNWebVoiceManager.h
//  THB
//
//  Created by Weller Zhao on 2019/2/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNWebVoiceManager : NSObject

typedef void(^FNWebVoiceDownloaderCompletedBlock)(float length, NSURL *fileUrl, NSError *error, BOOL finished);
typedef void(^FNWebVoicePlayCompletedBlock)(BOOL finished);

+(instancetype) shareInstance;

+ (float) getVoiceLength: (NSURL*)fileUrl;

- (void) downloadWithUrl: (NSURL*)url completed: (FNWebVoiceDownloaderCompletedBlock)block;
- (void) playWithUrl: (NSURL*)url completed: (FNWebVoicePlayCompletedBlock) block;

- (void) stop;

@end

NS_ASSUME_NONNULL_END
