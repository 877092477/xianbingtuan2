//
//  FNNetCouponeRechargeFooterCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNNetCouponeRechargeFooterCell;
@protocol FNNetCouponeRechargeFooterCellDelegate <NSObject>

- (void)didRechargeClick: (FNNetCouponeRechargeFooterCell*)cell;

@end

@interface FNNetCouponeRechargeFooterCell : UITableViewCell

@property (nonatomic, weak) id<FNNetCouponeRechargeFooterCellDelegate> delegate;

@property (nonatomic, strong) UIButton *btnPay;
@property (nonatomic, strong) UILabel *lblPolicy;

@end

NS_ASSUME_NONNULL_END
