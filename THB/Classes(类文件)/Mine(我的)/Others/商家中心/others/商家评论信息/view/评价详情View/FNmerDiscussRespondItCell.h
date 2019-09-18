//
//  FNmerDiscussRespondItCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/31.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerchentReviewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerDiscussRespondItCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *imgView;
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UILabel   *dateLB;
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UIView    *lineView;
@property (nonatomic, strong)FNmerchentReviewModel   *model; 
//@property (nonatomic, strong)FNmerReviewItemModel   *model;
@end

NS_ASSUME_NONNULL_END
