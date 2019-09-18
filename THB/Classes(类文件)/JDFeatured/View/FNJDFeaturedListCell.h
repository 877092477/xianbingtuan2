//
//  FNJDFeaturedListCell.h
//  THB
//
//  Created by jimmy on 2017/5/24.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMPProductCVCell.h"

@interface FNJDFeaturedListCell : JMPProductCVCell
@property (nonatomic, assign)CGFloat imgHeight;
@property (nonatomic, strong)FNBaseProductModel* model;
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end
