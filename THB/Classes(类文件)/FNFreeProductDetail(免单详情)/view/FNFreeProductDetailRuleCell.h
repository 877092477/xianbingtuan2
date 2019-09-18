//
//  FNFreeProductDetailRuleCell.h
//  THB
//
//  Created by Weller on 2018/12/19.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNFreeProductDetailRuleCell;
@protocol FNFreeProductDetailRuleCellDelegate <NSObject>

- (void)didInviteButtonClick: (FNFreeProductDetailRuleCell*)cell;

@end

@interface FNFreeProductDetailRuleCell : UITableViewCell

@property (nonatomic, weak) id<FNFreeProductDetailRuleCellDelegate> delegate;

- (void) setTitles: (NSArray*)titles rules: (NSArray*)rules;
- (void) setInviteText: (NSString*)text Title: (NSString*)title;

@end

NS_ASSUME_NONNULL_END
