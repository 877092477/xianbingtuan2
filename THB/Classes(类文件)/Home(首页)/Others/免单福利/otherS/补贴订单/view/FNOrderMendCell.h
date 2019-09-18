//
//  FNOrderMendCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNOrderMendCell;
@protocol FNOrderMendCellDelegate <NSObject>

- (void)didButtonClick: (FNOrderMendCell*)cell;

@end

@interface FNOrderMendCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UILabel *lblMore;
@property (nonatomic, strong) UIButton *btnMore;

@property (nonatomic, weak) id<FNOrderMendCellDelegate> delegate;

- (void)setCommission: (NSAttributedString*)commission;
- (void)setEndTime: (NSDate*)date;
- (void)setPadding: (CGFloat)padding;
- (void)showLine: (BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
