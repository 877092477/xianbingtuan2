//
//  FNRecommendGoodsItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNBaseProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNRecommendGoodsItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UIImageView   *goodsImg;
@property (nonatomic, strong)UILabel   *nameLB;

@property (nonatomic, strong)UIImageView  *ticketTwoImg;//券2图
@property (nonatomic, strong)UIButton  *ticketBtn;
//@property (nonatomic, strong)UILabel  *ticketOneLb;//券
@property (nonatomic, strong)UIButton  *prospectBtn;//预计收益

@property (nonatomic, strong)UILabel   *moneyLB;//现在价格
@property (nonatomic, strong)UILabel   *originalPriceLB;//原价
@property (nonatomic, strong)UILabel   *sellLB;//已售
@property (nonatomic, strong)FNBaseProductModel   *model;//已售

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
