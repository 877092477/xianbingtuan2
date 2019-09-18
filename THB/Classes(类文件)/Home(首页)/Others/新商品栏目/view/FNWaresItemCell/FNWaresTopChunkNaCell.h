//
//  FNWaresTopChunkNaCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNWaresMultiNaModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNWaresTopChunkNaCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)FNWaresMultiIcoItemModel *model;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath; 

@end

NS_ASSUME_NONNULL_END
