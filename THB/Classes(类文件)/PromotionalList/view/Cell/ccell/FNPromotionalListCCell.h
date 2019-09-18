//
//  FNPromotionalListCCell.h
//  THB
//
//  Created by Jimmy on 2017/12/22.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMCollectionViewCell.h"

@interface FNPromotionalListCCell : JMCollectionViewCell
@property (nonatomic, strong)FNBaseProductModel* model;
@property (nonatomic,strong)NSIndexPath* indexPath;
@property (nonatomic, copy)NSString* view_type;

//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end
