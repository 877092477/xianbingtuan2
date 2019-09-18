//
//  FNConnectionsChatTextCell.h
//  THB
//
//  Created by Weller Zhao on 2019/1/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNChatModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FNConnectionsChatCellDelegate <NSObject>

- (void) didchatCellResendSelect: (UITableViewCell*)cell;

@end

@interface FNConnectionsChatTextCell : UITableViewCell

@property (nonatomic, weak) id<FNConnectionsChatCellDelegate> delegate;

/**
 设置文本

 @param text 文本
 @param imgUrl 头像url
 @param isLeft 头像是否在左边
 @param status 状态 1-loading 2-failed
 */
- (void) setText: (NSString*)text withHeader: (NSString*)imgUrl isLeft: (BOOL)isLeft withStatus: (int)status;

@end

NS_ASSUME_NONNULL_END
