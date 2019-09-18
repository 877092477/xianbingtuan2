//
//  FNPartnerCenterCell.h
//  SuperMode
//
//  Created by jimmy on 2017/10/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNPartnerCenterCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView* iconimgview;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UILabel* subLabel;
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end
