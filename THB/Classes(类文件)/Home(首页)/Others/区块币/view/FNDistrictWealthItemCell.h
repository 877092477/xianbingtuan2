//
//  FNDistrictWealthItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNDistrictCoinModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNDistrictWealthItemCellDelegate <NSObject>
// 点击  兑换
- (void)didDistrictWealthItemAddAction:(NSIndexPath*)index;
// 点击  充值
- (void)didDistrictWealthItemFullAction:(NSIndexPath*)index;

@end
@interface FNDistrictWealthItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UILabel   *titleLB; 
@property (nonatomic, strong)UIButton  *fullBtn;
@property (nonatomic, strong)UIButton  *addBtn;
@property (nonatomic, strong)FNDistrictCoinWealthItemModel *itemModel;
@property (nonatomic, strong)FNDistrictCoinModel *model;

@property (nonatomic ,weak) id<FNDistrictWealthItemCellDelegate> delegate;
@property (nonatomic, strong)NSIndexPath  *indexS;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
