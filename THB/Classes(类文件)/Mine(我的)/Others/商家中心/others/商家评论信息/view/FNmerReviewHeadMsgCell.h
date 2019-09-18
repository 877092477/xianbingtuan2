//
//  FNmerReviewHeadMsgCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerchentReviewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerReviewHeadMsgCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *bgTopImgView;
@property (nonatomic, strong)UIImageView   *headImgView;
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UILabel   *flowLB;
@property (nonatomic, strong)UILabel   *reviewLB;
@property (nonatomic, strong)UIView    *oneLine;
@property (nonatomic, strong)UIView    *twoLine;
@property (nonatomic, strong)FNmerReviewHeadModel    *model;
@end

NS_ASSUME_NONNULL_END
