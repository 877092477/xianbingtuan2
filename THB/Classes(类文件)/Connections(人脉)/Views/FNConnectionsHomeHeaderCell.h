//
//  FNConnectionsHomeHeaderCell.h
//  THB
//
//  Created by Weller Zhao on 2019/1/14.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNConnectionsHomeHeaderCell;
@protocol FNConnectionsHomeHeaderCellDelegate <NSObject>

- (void)headerCelldidMoreSelected: (FNConnectionsHomeHeaderCell*)cell;

@end

@interface FNConnectionsHomeHeaderCell : UITableViewHeaderFooterView

@property (nonatomic, weak) id<FNConnectionsHomeHeaderCellDelegate> delegate;

- (void)setTitle: (NSString*)title withMore: (NSString*)more;

@end

NS_ASSUME_NONNULL_END
