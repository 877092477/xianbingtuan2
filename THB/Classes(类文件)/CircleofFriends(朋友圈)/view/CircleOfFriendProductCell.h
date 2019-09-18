//
//  CircleOfFriendProductCell.h
//  THB
//
//  Created by Weller on 2018/12/18.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleOfFriendsModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CircleOfFriendCommandView;
@protocol CircleOfFriendCommandViewDelegate  <NSObject>

- (void)didCommandViewClick: (CircleOfFriendCommandView*)view;

@end

@class CircleOfFriendProductCell;
@protocol CircleOfFriendProductCellDelegate <NSObject>

- (void)productCellDidLikeClick:(CircleOfFriendProductCell*)cell ;

- (void)productCellDidCommentClick:(CircleOfFriendProductCell*)cell ;

- (void)productCellDidShareClick:(CircleOfFriendProductCell*)cell ;

- (void)productCellDidSaveClick:(CircleOfFriendProductCell*)cell ;

- (void)productCellDidHeaderClick:(CircleOfFriendProductCell*)cell ;

- (void)productCell:(CircleOfFriendProductCell*)cell didCopyClickAtIndex: (NSInteger)index;

- (void)productCell:(CircleOfFriendProductCell*)cell didPhotoClickAtIndex: (NSInteger)index;

@end

@interface CircleOfFriendProductCell : UITableViewCell

@property (nonatomic, strong) UIButton *btnHeader;
@property (nonatomic, strong) UILabel *lblStore;
@property (nonatomic, strong) UIImageView *imgStore;
@property (nonatomic, strong) UILabel *lblTime;
@property (nonatomic, strong) UIButton *btnSaveAlbum;
@property (nonatomic, strong) UIButton *btnShare;
@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UILabel *lblCommission;

@property (nonatomic, strong) UIImageView *imgCommission;

@property (nonatomic, strong) UIButton *btnLike;
@property (nonatomic, strong) UIButton *btnCommand;

@property (nonatomic, weak) id<CircleOfFriendProductCellDelegate> delegate;

- (void)setImages: (NSArray<CircleOfFriendsImageModel*>*)models;
- (void)setCommands: (NSArray<NSString*>*) commands withColors: (NSArray<UIColor*>*)colors ButtonUrl: (NSArray<NSString*>*)urls;

@end

NS_ASSUME_NONNULL_END
