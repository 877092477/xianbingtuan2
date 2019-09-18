//
//  FNConnectionsChatVoiceCell.h
//  THB
//
//  Created by Weller Zhao on 2019/1/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNConnectionsChatTextCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNConnectionsChatVoiceCell : UITableViewCell

@property (nonatomic, weak) id<FNConnectionsChatCellDelegate> delegate;
@property (nonatomic, assign, setter=setIsPlaying:) BOOL isPlaying;

- (void) setText: (NSString*)text withHeader: (NSString*)imgUrl isLeft: (BOOL)isLeft withStatus: (int)status ;

@end

NS_ASSUME_NONNULL_END
