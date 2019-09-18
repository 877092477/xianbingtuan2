//
//  CircleOfFriendsShopHeaderView.h
//  THB
//
//  Created by Weller on 2018/12/18.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CircleOfFriendsShopHeaderView;
@protocol CircleOfFriendsShopHeaderViewDelegate <NSObject>

- (void)didHeader: (CircleOfFriendsShopHeaderView*) header selectedAt: (NSInteger)index;

@end

@interface CircleOfFriendsShopHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<CircleOfFriendsShopHeaderViewDelegate> delegate;

- (void) setButtons: (NSArray<NSString*>*)titles;
- (void)setSelectedAt: (NSInteger)index;

@end

NS_ASSUME_NONNULL_END
