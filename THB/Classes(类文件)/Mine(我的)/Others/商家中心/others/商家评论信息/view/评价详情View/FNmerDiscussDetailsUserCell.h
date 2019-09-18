//
//  FNmerDiscussDetailsUserCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/31.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerchentReviewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerDiscussDetailsUserCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *headImgView; 
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UILabel   *dateLB;
@property (nonatomic, strong)FNmerchentReviewModel   *model;
@end

NS_ASSUME_NONNULL_END
