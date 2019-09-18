//
//  FNmakeTakeListItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNMakeTmodel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmakeTakeListItemCellDegate <NSObject>
// 点击
- (void)inMakeTakeListItemAction:(NSIndexPath *)indexPath;
// 点击任务详情
- (void)inMakeTakeListItemDetailsBtnAction:(NSIndexPath *)indexPath;
// 点击失败原因
- (void)inMakeTakeListcauseOfFailureAction:(NSIndexPath *)indexPath;
@end
@interface FNmakeTakeListItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView *headView;
@property (nonatomic, strong)UILabel  *titleLB;
@property (nonatomic, strong)UILabel  *referralLB;
@property (nonatomic, strong)UIButton *sumBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UIView   *line;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, strong)FNMakeTaskItemTmodel *model;
@property(nonatomic ,weak) id<FNmakeTakeListItemCellDegate> delegate;

@property (nonatomic, strong)UIImageView *integralImg;
@property (nonatomic, strong)UILabel *integralLB;
@property (nonatomic, strong)UIImageView *moneyImg;
@property (nonatomic, strong)UILabel *moneyLB;

@property (nonatomic, strong)UIButton *detailsBtn;
@property (nonatomic, strong)UIButton *causeBtn;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
