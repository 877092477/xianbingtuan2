//
//  FNAddressCell.h
//  THB
//
//  Created by Weller Zhao on 2019/1/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNAddressCell;
@protocol FNAddressCellDelegate <NSObject>

- (void)didEditClick: (FNAddressCell*)cell;

@end

@interface FNAddressCell : UITableViewCell

@property (nonatomic, weak) id<FNAddressCellDelegate> delegate;

- (void) setName: (NSString*)name withPhone: (NSString*)phone tag: (NSString*)tag address: (NSString*)address isDefault: (BOOL) isDefault;

@end

NS_ASSUME_NONNULL_END
