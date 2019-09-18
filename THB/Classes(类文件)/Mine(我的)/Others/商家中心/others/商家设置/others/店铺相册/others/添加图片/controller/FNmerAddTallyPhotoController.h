//
//  FNmerAddTallyPhotoController.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FNmerAddTallyPhotoControllerDelegate <NSObject>
// 添加相册成功刷新
- (void)inDidMerAddTallyPhotoRefreshAction;
@end
@interface FNmerAddTallyPhotoController : SuperViewController
@property (nonatomic, weak)id<FNmerAddTallyPhotoControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
