//
//  FNPosterCCell.h
//  THB
//
//  Created by jimmy on 2017/8/28.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNSuperCollectionViewCell.h"
@protocol FNPosterCCellDelegate <NSObject>
// 点击排序
- (void)posterChooseAction:(NSIndexPath*)sender;

@end
@interface FNPosterCCell : FNSuperCollectionViewCell
@property (nonatomic, strong)UIView* btmview;
@property (nonatomic, strong)UIButton* chooseBtn;

@property (nonatomic, strong)UIImageView* posterimgview;
@property (nonatomic, strong)NSIndexPath* indxpath;
@property (nonatomic ,weak) id<FNPosterCCellDelegate> delegate;
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end
