//
//  FNNewStoreCommentCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/25.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNNewStoreCommentCell;
@protocol FNNewStoreCommentCellDelegate <NSObject>

- (void)commentCell: (FNNewStoreCommentCell*)cell didImageClickAt: (NSInteger)index;
- (void)didThumbClick: (FNNewStoreCommentCell*)cell;
- (void)didQuestionClick: (FNNewStoreCommentCell*)cell;

@end

@interface FNNewStoreCommentCell : UICollectionViewCell

@property (nonatomic, weak) id<FNNewStoreCommentCellDelegate> delegate;

- (void)setModel: (FNStoreCommentModel*)model;

- (CGFloat) getHeight;

@end

NS_ASSUME_NONNULL_END
