//
//  FNConnectionsSettingMembersCell.h
//  THB
//
//  Created by Weller Zhao on 2019/3/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FNConnectionsSettingMembersCellDelegate <NSObject>

- (void) didMembersClickAt: (NSInteger)index;
- (void) didAddClick;
- (void) didRemoveClick;

@end

@interface FNConnectionsSettingMembersCell : UITableViewCell

@property (nonatomic, weak) id<FNConnectionsSettingMembersCellDelegate> delegate;

- (void)setImages: (NSArray<NSString*>*)imgNames withTitles: (NSArray<NSString*>*)titles isGrouper: (BOOL)isGrouper;

@end

NS_ASSUME_NONNULL_END
