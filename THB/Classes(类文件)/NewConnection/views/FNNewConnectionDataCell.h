//
//  FNNewConnectionDataCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/6/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNNewConnectionDataCell;
@protocol FNNewConnectionDataCellDelegate <NSObject>

- (void) onLeftTopClick: (FNNewConnectionDataCell*)cell;
- (void) onRightTopClick: (FNNewConnectionDataCell*)cell;
- (void) onLeftBottomClick: (FNNewConnectionDataCell*)cell;
- (void) onCenterBottomClick: (FNNewConnectionDataCell*)cell;
- (void) onRightBottomClick: (FNNewConnectionDataCell*)cell;

@end

@interface FNNewConnectionDataCell : UITableViewCell

@property (nonatomic, weak) id<FNNewConnectionDataCellDelegate> delegate;

@property (nonatomic, strong) UIImageView *imgBackground;

@property (nonatomic, strong) UILabel *lblLeftTopTitle;
@property (nonatomic, strong) UIImageView *imgLeftTopTitle;
@property (nonatomic, strong) UILabel *lblLeftTopValue;
@property (nonatomic, strong) UIImageView *imgLeftTopValue;

@property (nonatomic, strong) UILabel *lblRightTopTitle;
@property (nonatomic, strong) UIImageView *imgRightTopTitle;
@property (nonatomic, strong) UILabel *lblRightTopValue;
@property (nonatomic, strong) UIImageView *imgRightTopValue;

@property (nonatomic, strong) UILabel *lblLeftBottomTitle;
@property (nonatomic, strong) UILabel *lblLeftBottomValue;

@property (nonatomic, strong) UILabel *lblCenterBottomTitle;
@property (nonatomic, strong) UILabel *lblCenterBottomValue;

@property (nonatomic, strong) UILabel *lblRightBottomTitle;
@property (nonatomic, strong) UILabel *lblRightBottomValue;

- (void) setPadding: (CGFloat)padding;

@end

NS_ASSUME_NONNULL_END
