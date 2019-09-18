//
//  FNNPDSimularCell.h
//  THB
//
//  Created by Jimmy on 2017/12/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMCollectionViewCell.h"

@interface FNNPDSimularCell : JMCollectionViewCell
@property (nonatomic, strong)FNBaseProductModel* model;
@property (nonatomic,strong)NSIndexPath* indexPath;
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end
