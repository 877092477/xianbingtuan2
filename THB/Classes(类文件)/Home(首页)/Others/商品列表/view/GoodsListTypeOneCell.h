//
//  GoodsListTypeOneCell.h
//  THB
//
//  Created by Fnuo-iOS on 2018/5/7.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsListTypeOneCell : UICollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong)FNBaseProductModel* model;

@property (nonatomic, weak)UIImageView *GoodsImage;

@property (nonatomic, weak)UILabel *GoodsName;

@property (nonatomic, weak)UILabel *OldPrice;

@property (nonatomic, weak)UILabel *promptPrice;

@property (nonatomic, weak)UILabel *Price;

@property (nonatomic, weak)UILabel *shop_title;

@property (nonatomic, weak)UILabel *from_sales;

@property (nonatomic, weak)UIButton *couponimBtn;

@end
