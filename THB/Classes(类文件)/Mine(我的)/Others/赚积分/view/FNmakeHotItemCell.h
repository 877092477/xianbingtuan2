//
//  FNmakeHotItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNMakeTmodel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmakeHotItemCellDegate <NSObject>
// 点击
- (void)inMakeHotItemCellAction:(NSIndexPath *)indexPath;

@end
@interface FNmakeHotItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView *headView;
@property (nonatomic, strong)UIImageView *traceView;
@property (nonatomic, strong)UILabel  *titleLB;
@property (nonatomic, strong)UILabel  *numberLB;
@property (nonatomic, strong)UILabel  *referralLB;
@property (nonatomic, strong)UILabel  *sumLB;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UIView   *line;
@property (nonatomic, strong)FNMakeTaskItemTmodel *model;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property(nonatomic ,weak) id<FNmakeHotItemCellDegate> delegate;

@property (nonatomic, strong)UIImageView *integralImg;
@property (nonatomic, strong)UILabel *integralLB;
@property (nonatomic, strong)UIImageView *moneyImg;
@property (nonatomic, strong)UILabel *moneyLB;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
