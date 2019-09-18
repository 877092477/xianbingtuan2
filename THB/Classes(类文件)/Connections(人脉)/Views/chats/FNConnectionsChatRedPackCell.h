//
//  FNConnectionsChatRedPackCell.h
//  THB
//
//  Created by Weller Zhao on 2019/1/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNConnectionsChatTextCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNConnectionsChatRedPackCell : UITableViewCell

@property (nonatomic, weak) id<FNConnectionsChatCellDelegate> delegate;

- (void) setText: (NSString*)text withHeader: (NSString*)imgUrl isLeft: (BOOL)isLeft isRead: (BOOL)isRead withStatus: (int)status ;
@end

NS_ASSUME_NONNULL_END
