//
//  FNmerchantOrderItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNMerchantMeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerchantOrderItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *headImgView;
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UILabel   *dateLB;
@property (nonatomic, strong)UILabel   *sumLB;
@property (nonatomic, strong)FNMerchantItemMeModel  *daModel;
@end

NS_ASSUME_NONNULL_END
