//
//  FNMineHeaderView.h
//  THB
//
//  Created by Weller Zhao on 2018/12/25.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FNMineHeaderView;
@protocol FNMineHeaderViewDelegate <NSObject>

- (void)didCopyClick:(FNMineHeaderView*)headerView;
- (void)didUpgradeClick: (FNMineHeaderView*)headerView;
- (void)didHeaderClick: (FNMineHeaderView*)headerView;
- (void)didSumClick: (FNMineHeaderView*)headerView;

@end

@interface FNMineHeaderView : UIView

@property (nonatomic, strong) UIButton *btnHeader;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIImageView *imgLevel;
@property (nonatomic, strong) UILabel *lblLevel;
@property (nonatomic, strong) UILabel *lblCode;

@property (nonatomic, strong) UIButton *btnUpgrade;
@property (nonatomic, strong) UILabel *lblUpgrade;

@property (nonatomic, strong) UIView *vSum;
@property (nonatomic, strong) UIImageView *imgSumBg;
@property (nonatomic, strong) UIImageView *imgSumIcon;
@property (nonatomic, strong) UILabel *lblSum;
@property (nonatomic, strong) UIButton *btnSum;

@property (nonatomic, strong) UIView *vCoupone;
@property (nonatomic, strong) UIImageView *imgCoupone;
@property (nonatomic, strong) UILabel *lblCoupone;
@property (nonatomic, strong) UILabel *lblCouponeDesc;

@property (nonatomic, strong) UIView *vJifen;
@property (nonatomic, strong) UIImageView *imgJifen;
@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UILabel *lblJifenTitle;
@property (nonatomic, strong) UIButton *btnMore;
@property (nonatomic, strong) UIImageView *imgMore;
@property (nonatomic, strong) UILabel *lblMore;
@property (nonatomic, strong) UILabel *lblJifen;
@property (nonatomic, strong) UILabel *lblJifenUnit;
@property (nonatomic, strong) UIImageView *imgJifenExchange;


@property (nonatomic, weak) id<FNMineHeaderViewDelegate> delegate;

- (void)setTextColor: (UIColor*)color;

@end

NS_ASSUME_NONNULL_END
