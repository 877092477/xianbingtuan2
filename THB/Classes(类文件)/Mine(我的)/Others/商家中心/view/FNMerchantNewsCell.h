//
//  FNMerchantNewsCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNMerchantMeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNMerchantNewsCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *headImgView;
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UIButton  *rightBtn;
@property (nonatomic, strong)FNMerchantHeadMeModel  *model; 
@end

NS_ASSUME_NONNULL_END
