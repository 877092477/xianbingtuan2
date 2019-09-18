//
//  FNmerOrderGoodsItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerOrderZModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerOrderGoodsItemCell : UICollectionViewCell
@property (nonatomic, strong)UIView        *bgView;
@property (nonatomic, strong)UIImageView   *headImgView;
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UILabel   *countLB;
@property (nonatomic, strong)UILabel   *sumLB;
@property (nonatomic, strong)UILabel   *typeLB;
@property (nonatomic, strong)FNmerOrderGoodsItemHModel   *model;
@end

NS_ASSUME_NONNULL_END
