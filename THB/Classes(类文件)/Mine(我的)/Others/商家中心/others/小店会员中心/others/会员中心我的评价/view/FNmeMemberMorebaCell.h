//
//  FNmeMemberMorebaCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerchentReviewModel.h"
#import "FNmeMeEvaluatesModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmeMemberMorebaCell : UICollectionViewCell
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UIImageView *headImgView;
@property (nonatomic, strong)UIImageView *rightImgView;
@property (nonatomic, strong)UILabel *nameLB;
@property (nonatomic, strong)UILabel *hintLB;
@property (nonatomic, strong)UIButton  *bgBtn;
@property (nonatomic, strong)UIButton  *queryBtn; 
@property (nonatomic, strong)UIButton  *likeBtn;
@property (nonatomic, strong)UIButton  *moreBtn;
@property (nonatomic, strong)FNmerchentReviewModel   *model;
@end

NS_ASSUME_NONNULL_END
