//
//  FNmerchentReviewItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/10.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerReviewPrintsView.h"
#import "FNmerGradeView.h"
#import "FNmerchentReviewModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmerchentReviewItemCellDelegate <NSObject>
// 点击点赞
- (void)didMerLikeActionIsIndex:(NSIndexPath*)index;
// 点击评论
- (void)didMerReviewActionIsIndex:(NSIndexPath*)index;
//点击疑问
- (void)didMerQueryActionIsIndex:(NSIndexPath*)index;

@end
@interface FNmerchentReviewItemCell : UICollectionViewCell

@property (nonatomic, strong)UIImageView   *headImgView;

@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UILabel   *dateLB;
@property (nonatomic, strong)UILabel   *pleasedLB;
@property (nonatomic, strong)UILabel   *reviewLB;

@property (nonatomic, strong)UILabel   *consumeLB;

@property (nonatomic, strong)UIButton  *likeBtn;
@property (nonatomic, strong)UIButton  *reviewBtn;
@property (nonatomic, strong)UIButton  *queryBtn;

@property (nonatomic, strong)NSIndexPath  *indexPa;

@property (nonatomic, strong)FNmerReviewPrintsView *imgListView;

@property (nonatomic, strong)FNmerGradeView *gradeView;

@property (nonatomic, strong)FNmerchentReviewModel  *model;

@property(nonatomic,weak)id<FNmerchentReviewItemCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
