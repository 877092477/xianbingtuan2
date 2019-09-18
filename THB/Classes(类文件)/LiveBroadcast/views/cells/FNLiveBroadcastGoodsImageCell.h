//
//  FNLiveBroadcastGoodsImageCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FNLiveBroadcastGoodsImageCellDelegate <NSObject>

- (void)onCell: (UITableViewCell*)cell imageClick: (UIImageView*)imageView;

@end

@interface FNLiveBroadcastGoodsImageCell : UITableViewCell

@property (nonatomic, weak) id<FNLiveBroadcastGoodsImageCellDelegate> delegate;

@property (nonatomic, strong) UIImageView *imgHeader;

- (void)setContentImage: (UIImage*)image;   


@end

NS_ASSUME_NONNULL_END
