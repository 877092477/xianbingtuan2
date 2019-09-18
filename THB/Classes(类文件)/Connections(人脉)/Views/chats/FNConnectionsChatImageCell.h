//
//  FNConnectionsChatImageCell.h
//  THB
//
//  Created by Weller Zhao on 2019/1/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNConnectionsChatTextCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNConnectionsChatImageCell : UITableViewCell

@property (nonatomic, weak) id<FNConnectionsChatCellDelegate> delegate;

- (void) setImageURL: (NSString*)imgUrl size: (CGSize)size withHeader: (NSString*)headerUrl isLeft: (BOOL)isLeft withStatus: (int)status isVideo:(BOOL)isVideo;
- (void) setImage: (UIImage*)image size: (CGSize)size withHeader: (NSString*)headerUrl isLeft: (BOOL)isLeft withStatus: (int)status isVideo:(BOOL)isVideo;
@end

NS_ASSUME_NONNULL_END
