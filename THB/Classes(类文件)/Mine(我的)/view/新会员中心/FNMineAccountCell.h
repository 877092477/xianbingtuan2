//
//  FNMineAccountCell.h
//  THB
//
//  Created by Weller Zhao on 2018/12/25.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNMineAccountCell;
@protocol FNMineAccountCellDelegate <NSObject>

- (void)didWithdrawClick: (FNMineAccountCell*)cell;
- (void)didInviterClick: (FNMineAccountCell*)cell;

@end

@interface FNMineAccountCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgBackground;
@property (nonatomic, strong) UILabel *lblCommissionTitle;
@property (nonatomic, strong) UILabel *lblCommission;
@property (nonatomic, strong) UILabel *lblCommissionDesc;

@property (nonatomic, strong) UIView *vCommission;
@property (nonatomic, strong) UIButton *btnCommission;


@property (nonatomic, strong) UIView *vBottomLeft;
@property (nonatomic, strong) UIView *vBottomRight;

@property (nonatomic, strong) UILabel *lblBottomLeftTitle;
@property (nonatomic, strong) UILabel *lblBottomLeft;

@property (nonatomic, strong) UILabel *lblBottomRightTitle;
@property (nonatomic, strong) UILabel *lblBottomRight;

@property (nonatomic, weak) id<FNMineAccountCellDelegate> delegate;

- (void) setPadding: (CGFloat)padding;
- (void) setCenterWithTitles: (NSArray<NSString*>*)titles descs: (NSArray<NSString*>*)descs colors:(NSArray<UIColor*>*)colors ;

@end

NS_ASSUME_NONNULL_END
