//
//  FNShareMutiplyView.h
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMView.h"

@class FNShareMutiplyView;
@protocol FNShareMutiplyViewDelegate <NSObject>

- (void)didImageShare: (FNShareMutiplyView*)view withImages: (NSArray<NSString*>*) images atType: (UMSocialPlatformType) type;

@end

@interface FNShareMutiplyView : JMView

@property (nonatomic, weak) id<FNShareMutiplyViewDelegate> delegate;

@end
