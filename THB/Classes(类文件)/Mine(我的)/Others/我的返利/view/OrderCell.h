//
//  OrderCell.h
//  THB
//
//  Created by Weller Zhao on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OrderCell;
@protocol OrderCellDelegate <NSObject>

- (void)didCopyClick: (OrderCell*)cell;

- (void)didCheckLogisticsClick: (OrderCell*)cell;

@end

@interface OrderCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblMoney;
@property (nonatomic, strong) UILabel *lblTime;
@property (nonatomic, strong) UILabel *lblOrderNum;

@property (nonatomic, strong) UILabel *lblCommissionTitle;
@property (nonatomic, strong) UILabel *lblCommission;

@property (nonatomic, strong) UIView *vState;
@property (nonatomic, strong) UILabel *lblState;

@property (nonatomic, strong) UILabel *lblShop;
@property (nonatomic, strong) UILabel *lblType;
@property (nonatomic, strong) UIView *vShop;
@property (nonatomic, strong) UIButton *logisticsBtn;

@property (nonatomic, weak) id<OrderCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
