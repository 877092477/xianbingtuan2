//
//  FNmarketCentreItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNMarketCentreModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmarketCentreItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *imgView;
@property (nonatomic, strong)UILabel *titleLB;
@property (nonatomic, strong)UILabel *recommendLB;
@property (nonatomic, strong)UILabel *sumLB;
@property (nonatomic, strong)UILabel *sumHintLB;
@property (nonatomic, strong)UILabel *stateLB; 
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)FNMarketCentreStoreItemModel *model; 
@end

NS_ASSUME_NONNULL_END
