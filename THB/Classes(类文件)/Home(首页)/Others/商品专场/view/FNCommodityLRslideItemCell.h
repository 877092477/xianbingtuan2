//
//  FNCommodityLRslideItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FNBaseProductModel;
NS_ASSUME_NONNULL_BEGIN

@interface FNCommodityLRslideItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UIImageView   *imgView;
@property (nonatomic, strong)UIImageView   *hotImgView;
@property (nonatomic, strong)UIImageView   *typeImgView;
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UILabel   *priceLB;
@property (nonatomic, strong)UILabel   *originalPriceLB;
@property (nonatomic, strong)UILabel   *salesLB;
@property (nonatomic, strong)UIButton  *archBtn;
@property (nonatomic, strong)UIButton  *favourBtn;
@property (nonatomic, strong)UIButton  *shareBtn;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong)FNBaseProductModel* model;
@property (nonatomic, copy)void (^sharerightNow)(FNBaseProductModel * model);
@end

NS_ASSUME_NONNULL_END
