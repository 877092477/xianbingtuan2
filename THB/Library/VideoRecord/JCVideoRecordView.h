//
//  JCVideoRecordView.h
//  Pods
//
//  Created by zhengjiacheng on 2017/8/31.
//
//

#import <Foundation/Foundation.h>
#import "JCVideoRecordManager.h"
typedef void(^JCVideoRecordViewDismissBlock)(void);
typedef void(^JCVideoRecordViewCompletionBlock)(NSURL *fileUrl);
typedef void(^JCVideoRecordViewImageCompletionBlock)(UIImage *image);

@interface JCVideoRecordView : UIWindow

@property (nonatomic, copy) JCVideoRecordViewDismissBlock cancelBlock;
@property (nonatomic, copy) JCVideoRecordViewCompletionBlock completionBlock;
@property (nonatomic, copy) JCVideoRecordViewImageCompletionBlock completionImageBlock;

- (void)present;

@end
