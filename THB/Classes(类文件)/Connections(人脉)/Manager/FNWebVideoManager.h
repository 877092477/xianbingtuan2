//
//  FNWebVideoManager.h
//  THB
//
//  Created by Weller Zhao on 2019/2/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNWebVideoManager : NSObject

typedef void(^FNWebVideoDownloaderCompletedBlock)(UIImage *coverImage, NSURL *fileUrl, NSError *error, BOOL finished);

+(instancetype) shareInstance;

- (void) downloadWithUrl: (NSURL*)url completed: (FNWebVideoDownloaderCompletedBlock)block;

+ (UIImage *)getImage:(NSURL*)videoURL;

@end

NS_ASSUME_NONNULL_END
