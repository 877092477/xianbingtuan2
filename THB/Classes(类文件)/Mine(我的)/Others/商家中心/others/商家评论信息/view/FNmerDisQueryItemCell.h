//
//  FNmerDisQueryItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/30.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerchentReviewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerDisQueryItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *stateView; 
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UIView    *lineView;
@property (nonatomic, strong)FNmerReviewQueryItemModel    *model;
@end

NS_ASSUME_NONNULL_END
