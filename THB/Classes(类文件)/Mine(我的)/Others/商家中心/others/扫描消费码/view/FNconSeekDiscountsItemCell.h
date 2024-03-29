//
//  FNconSeekDiscountsItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerConsumeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNconSeekDiscountsItemCell : UICollectionViewCell
@property (nonatomic, strong)UIView        *bgView;
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UILabel   *discountsLB;
@property (nonatomic, strong)UILabel   *sumLB;
@property (nonatomic, strong)FNmerConsumeGoodsItemModel   *model; 
@end

NS_ASSUME_NONNULL_END
