//
//  UIImageView+Player.h
//  THB
//
//  Created by Weller on 2019/2/28.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Player)

- (void)playWithImages: (NSArray<NSString*>*) imageNames;
- (void)stopPlaying;

@end

NS_ASSUME_NONNULL_END
