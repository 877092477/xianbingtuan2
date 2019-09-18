//
//  FNCommodityGoodsItemMCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNBaseProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNCommodityGoodsItemMCell : UICollectionViewCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UIImageView   *topImgView;
@property (nonatomic, strong)UIImageView   *typeImgView;
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UILabel   *priceLB;
@property (nonatomic, strong)UILabel   *originalPriceLB;
@property (nonatomic, strong)UILabel   *salesLB;
@property (nonatomic, strong)UIButton  *ticketBtn;
@property (nonatomic, strong)UIButton  *prospectBtn;//返
@property (nonatomic, strong)UIButton  *shareBtn;
@property (nonatomic, strong)FNBaseProductModel* model;
@property (nonatomic, copy)void (^sharerightNow)(FNBaseProductModel * model);
@end

NS_ASSUME_NONNULL_END
