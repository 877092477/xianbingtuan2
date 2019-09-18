//
//  FNLiveBroadcastLogView.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNLiveBroadcastLogView : UIView

- (void)appendLog: (NSString*)log withImage: (NSString*)imgUrl icon: (NSString*)iconUrl;

@end

NS_ASSUME_NONNULL_END
