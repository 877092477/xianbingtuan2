//
//  FNNetCouponeRechargeCardCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNNetCouponeRechargeModel.h"

NS_ASSUME_NONNULL_BEGIN


@class FNNetCouponeRechargeCardCell;
@protocol FNNetCouponeRechargeCardCellDelegate <NSObject>

- (void)cell: (FNNetCouponeRechargeCardCell*)cell didSelectAt: (NSInteger)index;

@end

@interface FNNetCouponeRechargeCardCell : UITableViewCell


@property (nonatomic, weak) id<FNNetCouponeRechargeCardCellDelegate> delegate;

- (void)setCards: (NSArray<FNNetCouponeRechargeCardModel*>*)cards;

- (void)setSelectedAt: (NSInteger)index;

@end

NS_ASSUME_NONNULL_END
