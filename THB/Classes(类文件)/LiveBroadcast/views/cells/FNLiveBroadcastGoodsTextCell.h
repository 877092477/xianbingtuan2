//
//  FNLiveBroadcastGoodsTextCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNLiveBroadcastGoodsTextCell;
@protocol FNLiveBroadcastGoodsTextCellDelegate <NSObject>

- (void)didLongPress: (FNLiveBroadcastGoodsTextCell*)cell;

@end

@interface FNLiveBroadcastGoodsTextCell : UITableViewCell

@property (nonatomic, weak) id<FNLiveBroadcastGoodsTextCellDelegate> delegate;

@property (nonatomic, strong) UIImageView *imgHeader;

@property (nonatomic, strong) UILabel *lblContent;

@end

NS_ASSUME_NONNULL_END
