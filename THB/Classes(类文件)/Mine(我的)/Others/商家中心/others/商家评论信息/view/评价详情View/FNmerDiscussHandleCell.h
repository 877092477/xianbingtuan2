//
//  FNmerDiscussHandleCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/31.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerchentReviewModel.h"
#import "FNmerGradeView.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerDiscussHandleCell : UICollectionViewCell

@property (nonatomic, strong)UIButton  *likeBtn;
@property (nonatomic, strong)UIButton  *reviewBtn;
@property (nonatomic, strong)UIButton  *queryBtn;
@property (nonatomic, strong)UIView    *lineOneView;
@property (nonatomic, strong)UIView    *lineTwoView;
@property (nonatomic, strong)UIImageView   *likeImgView;
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UIButton  *omitBtn;
@property (nonatomic, strong)FNmerGradeView *gradeView;

@property (nonatomic, strong)FNmerchentReviewModel   *model;
@end

NS_ASSUME_NONNULL_END
