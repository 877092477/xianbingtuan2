//
//  FNmerIssueEditOCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerIssueocModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmerIssueEditOCellDelegate <NSObject>
// 编辑
- (void)didMerIssueEditOC:(NSIndexPath*)index withContent:(NSString*)content;
// 修改 红包 状态
- (void)didMerIssueLuckIndex:(NSIndexPath*)index withLuck:(NSString*)luck;
// 点击右边按钮
- (void)didMerIssueCouponUseIndex:(NSIndexPath*)index withView:(UICollectionViewCell*)cell;
// 开关
- (void)didMerIssueEditSwitch:(NSIndexPath*)index withView:(UICollectionViewCell*)cell;

// 线上
- (void)didMerIssueEditPaymentMethod:(NSIndexPath*)index withOnLine:(NSString*)onLineStyle;

// 线下
- (void)didMerIssueEditPaymentMethod:(NSIndexPath*)index withOnShop:(NSString*)onShopStyle;
@end
@interface FNmerIssueEditOCell : UICollectionViewCell<UITextFieldDelegate>
@property (nonatomic, strong)UIView     *dibuView;

@property (nonatomic, strong)UIView     *bgView;
@property (nonatomic, strong)UILabel    *leftTitleLB;
@property (nonatomic, strong)UILabel    *rightLB;
@property (nonatomic, strong)UIButton   *hintBtn;
@property (nonatomic, strong)UITextField  *compileField;

@property (nonatomic, strong)UIButton  *rightBtn;
@property (nonatomic, strong)UIButton  *switchBtn;

@property (nonatomic, strong)UIButton  *onlineBtn;
@property (nonatomic, strong)UIButton  *offlineBtn;

@property (nonatomic, strong)FNmerIssueocModel *model;
@property (nonatomic, strong)NSIndexPath  *index;

@property (nonatomic, assign)NSInteger  styleState;
@property (nonatomic, weak)id<FNmerIssueEditOCellDelegate> delegate;

//+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath withStyle:(NSInteger)styleInt;
@end

NS_ASSUME_NONNULL_END
