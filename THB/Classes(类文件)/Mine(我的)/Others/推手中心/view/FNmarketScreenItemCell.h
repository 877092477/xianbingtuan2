//
//  FNmarketScreenItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/14.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNMarketCentreModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmarketScreenItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *imgView;
@property (nonatomic, strong)UILabel *titleLB;

@property (nonatomic, strong)FNMarketCentreSelectItemModel *model;
@end

NS_ASSUME_NONNULL_END
