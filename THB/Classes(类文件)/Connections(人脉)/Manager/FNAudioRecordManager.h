//
//  FNAudioRecordManager.h
//  THB
//
//  Created by Weller Zhao on 2019/2/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNAudioRecordManager : NSObject

typedef void(^FNAudioRecordCompletedBlock)(NSURL *fileUrl, NSError *error, BOOL finished);
typedef void(^FNAudioRecordVolumeBlock)(float volume);
+(instancetype) shareInstance;

- (void) startRecordWithVolume: (FNAudioRecordVolumeBlock) volumeBlock completed: (FNAudioRecordCompletedBlock)completedBlock;
- (void) stopRecord;
- (void) cancle;

- (NSData*) getDataWithFileName: (NSString*) filename;
- (NSURL*) getURLWithFileName: (NSString*) filename;

@end

NS_ASSUME_NONNULL_END
