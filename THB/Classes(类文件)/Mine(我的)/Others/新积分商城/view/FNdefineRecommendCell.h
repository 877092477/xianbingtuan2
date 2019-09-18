//
//  FNdefineRecommendCell.h
//  THB
//
//  Created by Jimmy on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNDefiniteStoreNeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNdefineRecommendCell : UICollectionViewCell
/** 灰色背景 **/
@property (nonatomic, strong)UIView *bgView;
/** img **/
@property (nonatomic, strong)UIImageView *RecommendImage;
/** 文本 **/
@property (nonatomic, strong)UILabel *versionLB;

/** model **/
@property (nonatomic, strong)FNDefiniteListItemModel *model;
@end

NS_ASSUME_NONNULL_END
