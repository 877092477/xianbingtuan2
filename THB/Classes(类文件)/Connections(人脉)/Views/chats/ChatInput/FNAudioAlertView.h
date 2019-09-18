//
//  FNAudioAlertView.h
//  THB
//
//  Created by Weller Zhao on 2019/2/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNAudioAlertView : UIView

- (void)setVoiceWithLevel: (int)level;

- (void)setRelease;

@end

NS_ASSUME_NONNULL_END
