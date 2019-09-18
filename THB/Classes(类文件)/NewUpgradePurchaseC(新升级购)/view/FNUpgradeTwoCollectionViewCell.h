//
//  FNUpgradeTwoCollectionViewCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/18.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNUpgradeTwoCollectionViewCell;
@protocol FNUpgradeTwoCollectionViewCellDelegate <NSObject>

- (void) didLeftClick: (FNUpgradeTwoCollectionViewCell*)cell;
- (void) didRightClick: (FNUpgradeTwoCollectionViewCell*)cell;

@end

@interface FNUpgradeTwoCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<FNUpgradeTwoCollectionViewCellDelegate> delegate;

@property (nonatomic, strong) UIImageView *imgLeft;
@property (nonatomic, strong) UIImageView *imgRight;

- (void)setJiange: (CGFloat)jiange;

@end

NS_ASSUME_NONNULL_END
