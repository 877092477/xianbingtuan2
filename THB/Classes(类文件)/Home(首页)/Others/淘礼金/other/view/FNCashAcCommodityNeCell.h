//
//  FNCashAcCommodityNeCell.h
//  THB
//
//  Created by Jimmy on 2018/10/23.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNCashActivityNeModel.h"
@interface FNCashAcCommodityNeCell : UICollectionViewCell
/** indexPath **/
@property (nonatomic, strong)NSIndexPath* indexPath;
/** goods_img **/
@property (nonatomic, strong)UIImageView *goodsImage;
/** goods_title **/
@property (nonatomic, strong)UILabel* goodstitleLB;
/** 销量ImageView **/
@property (nonatomic, strong)UIImageView* rankingImageView;
/** 销量LB **/
@property (nonatomic, strong)UILabel* rankingLB;
/** 原价 **/
@property (nonatomic, strong)UILabel* goodsPrice;
/** 优惠券 **/
@property (nonatomic, strong)UIImageView* couponImageView;
/** 优惠券金额 **/
@property (nonatomic, strong)UILabel* couponLB;
/** 减 **/
@property (nonatomic, strong)UIImageView* minusImageView;
/** 减金额 **/
@property (nonatomic, strong)UILabel* minusLB;
/** 专享价title **/
@property (nonatomic, strong)UILabel* cashTitleLB;
/** 专享价金额 **/
@property (nonatomic, strong)UILabel* cashPriceLB;

/** itemDic **/
@property (nonatomic, strong)NSDictionary* itemDic;
 

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end
