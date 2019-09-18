//
//  FNNewConnectionButtonsCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/6/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNMineIconsCell.h"

NS_ASSUME_NONNULL_BEGIN

@class FNNewConnectionButtonsCell;
@protocol FNNewConnectionButtonsCellDelegate <NSObject>

- (void)cell: (FNNewConnectionButtonsCell*)cell didButtonClickAt: (NSInteger)index;
- (void)cellDidMoreClick: (FNNewConnectionButtonsCell*)cell;

@end

@interface FNNewConnectionButtonsCell : UITableViewCell

@property (nonatomic, weak) id<FNNewConnectionButtonsCellDelegate> delegate;

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIButton *btnChat;
@property (nonatomic, strong) UIImageView *imgBackground;

- (void) setPadding: (CGFloat)padding;

- (void)showWithImages: (NSArray*)imgUrls andTitles: (NSArray*)titles andColors: (NSArray*)colors counts: (NSArray*)counts clickBlock: (MineIconsBlock) onClick;

@end

NS_ASSUME_NONNULL_END
