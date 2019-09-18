//
//  FNartcleTopFuzzyImgCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNartcleTopFuzzyImgCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *imgView;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
