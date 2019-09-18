//
//  FNNewConnectionFriendCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/6/5.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNNewConnectionFriendCell;
@protocol FNNewConnectionFriendCellDelegate <NSObject>

- (void)cellDidChatClick: (FNNewConnectionFriendCell*)cell;

@end

@interface FNNewConnectionFriendCell : UITableViewCell

@property (nonatomic, weak) id<FNNewConnectionFriendCellDelegate> delegate;

@property (nonatomic, strong) UIImageView *imgBackground;

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIButton *btnChat;

@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) UIImageView *imgLevel;
@property (nonatomic, strong) UILabel *lblLevel;
@property (nonatomic, strong) UILabel *lblPhone;
@property (nonatomic, strong) UILabel *lblTime;

@property (nonatomic, strong) UILabel *lblTeam;
@property (nonatomic, strong) UILabel *lblOrder;


@property (nonatomic, strong) UILabel *lblTitle1;
@property (nonatomic, strong) UILabel *lblTitle2;
@property (nonatomic, strong) UILabel *lblTitle3;
@property (nonatomic, strong) UILabel *lblTitle4;

@property (nonatomic, strong) UILabel *lblValue1;
@property (nonatomic, strong) UILabel *lblValue2;
@property (nonatomic, strong) UILabel *lblValue3;
@property (nonatomic, strong) UILabel *lblValue4;

- (void) setPadding: (CGFloat)padding;

@end

NS_ASSUME_NONNULL_END
