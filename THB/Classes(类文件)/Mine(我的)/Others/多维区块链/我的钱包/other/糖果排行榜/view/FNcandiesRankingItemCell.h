//
//  FNcandiesRankingItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNcandiesRankingModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNcandiesRankingItemCell : UICollectionViewCell
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UILabel   *gainLB;
@property (nonatomic, strong)UILabel   *gainValueLB;
@property (nonatomic, strong)UIImageView  *headImgView; 
@property (nonatomic, strong)UIButton   *designationBtn;
@property (nonatomic, strong)FNcandiesRankItemModel *model;
@end

NS_ASSUME_NONNULL_END
