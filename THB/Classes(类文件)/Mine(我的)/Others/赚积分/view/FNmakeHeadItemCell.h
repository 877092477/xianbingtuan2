//
//  FNmakeHeadItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNMakeTmodel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmakeHeadItemCell : UICollectionViewCell
@property (nonatomic, strong)UILabel  *titleLB;
@property (nonatomic, strong)UILabel  *numberLB;
@property (nonatomic, strong)FNMakeJFTmodel *model;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
