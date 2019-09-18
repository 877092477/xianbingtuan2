//
//  FNVideoPlayerControlBar.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "JPVideoPlayerControlViews.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNVideoPlayerControlBar : UIView<JPVideoPlayerProtocol>

@property (nonatomic, strong) void (^DownloadBlock)(void);

@property (nonatomic, strong, readonly) UIButton *playButton;

@property (nonatomic, strong, readonly) UIView<JPVideoPlayerControlProgressProtocol> *progressView;

@property (nonatomic, strong, readonly) UILabel *timeLabel;

@property (nonatomic, strong, readonly) UIButton *landscapeButton;

- (instancetype)initWithProgressView:(UIView<JPVideoPlayerControlProgressProtocol> *_Nullable)progressView NS_DESIGNATED_INITIALIZER;

@end


NS_ASSUME_NONNULL_END
