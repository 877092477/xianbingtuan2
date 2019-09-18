//
//  FNoptionRightCollectionViewCell.h
//  THB
//
//  Created by Jimmy on 2018/9/5.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNLeftclassifyModel.h"
@interface FNoptionRightCollectionViewCell : UICollectionViewCell
/** 图片 **/
@property (nonatomic, strong)UIImageView* classifyImage;

/** 名字 **/
@property (nonatomic, strong)UILabel* nameLB;

@property (nonatomic, strong)NSIndexPath* indexPath;

#pragma mark - Model

@property (nonatomic, strong)FNRightclassifyModel* model;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end
