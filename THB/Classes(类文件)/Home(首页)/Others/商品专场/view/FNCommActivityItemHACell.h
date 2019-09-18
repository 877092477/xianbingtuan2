//
//  FNCommActivityItemHACell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNBaseProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNCommActivityItemHACell : UICollectionViewCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UIImageView   *topImgView;

@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UILabel   *priceLB;

@property (nonatomic, strong)UIImageView  *ticketTwoImg;//券2图
@property (nonatomic, strong)UIButton  *ticketBtn; 
@property (nonatomic, strong)UIButton  *prospectBtn;//预计收益

@property (nonatomic, strong)FNBaseProductModel* model;

@end

NS_ASSUME_NONNULL_END
