//
//  FNHomeSpecialCCell.h
//  THB
//
//  Created by Jimmy on 2017/12/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
extern const CGFloat _hscc_btm_h;
@interface FNHomeSpecialCCell : UICollectionViewCell
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, strong)FNBaseProductModel* model;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end
