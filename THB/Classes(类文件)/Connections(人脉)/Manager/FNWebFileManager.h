//
//  FNWebFileManager.h
//  THB
//
//  Created by Weller Zhao on 2019/2/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNWebFileManager : NSObject

typedef void(^FNWebFileDownloaderCompletedBlock)(NSURL *fileUrl, NSError *error, BOOL finished);

+(instancetype) shareInstance;


/**
 通过url计算文件缓存路径

 @param url url
 @return 缓存路径
 */
- (NSString*) getCachePath: (NSURL*)url;


/**
 文件下载

 @param url url
 @param block 成功回掉
 */
- (void) downloadWithUrl: (NSURL*)url completed: (FNWebFileDownloaderCompletedBlock)block;

@end

NS_ASSUME_NONNULL_END
