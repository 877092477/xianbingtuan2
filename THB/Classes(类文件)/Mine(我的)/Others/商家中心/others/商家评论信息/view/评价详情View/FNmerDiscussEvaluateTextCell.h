//
//  FNmerDiscussEvaluateTextCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/31.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerGradeView.h"
#import "FNmerchentReviewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerDiscussEvaluateTextCell : UICollectionViewCell
@property (nonatomic, strong)FNmerGradeView *gradeView;
@property (nonatomic, strong)UILabel   *consumeLB;
@property (nonatomic, strong)UILabel   *pleasedLB;

@property (nonatomic, strong)UILabel   *reviewLB;

@property (nonatomic, strong)UILabel   *recommendLB;

@property (nonatomic, strong)FNmerchentReviewModel   *model;
@end

NS_ASSUME_NONNULL_END
