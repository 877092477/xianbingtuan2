//
//  FNMakeHotTCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmakeHotListView.h"
#import "FNMakeTmodel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNMakeHotTCell : UICollectionViewCell
 
@property (nonatomic, strong)UIView   *bgView;
@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UILabel  *titleLB;
@property (nonatomic, strong)UILabel  *rightLB;
@property (nonatomic, strong)UIView   *line;
@property (nonatomic, strong)FNmakeHotListView   *listView;
@property (nonatomic, strong)FNMakeTaskTmodel *model;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
