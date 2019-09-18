//
//  FNVideoCardBuyCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNVideoCardBuyCell;
@protocol FNVideoCardBuyCellDelegate <NSObject>

- (void)cell: (FNVideoCardBuyCell*)cell didCountChange: (NSInteger)count;

@end

@interface FNVideoCardBuyCell : UITableViewCell

@property (nonatomic, weak) id<FNVideoCardBuyCellDelegate> delegate;

- (void)setTitle: (NSString*)title count: (NSInteger)count withMaxCount: (NSInteger)maxCount;
- (void)setTitle: (NSString*)title withAttributeDesc: (NSAttributedString*)desc;

@end

NS_ASSUME_NONNULL_END
