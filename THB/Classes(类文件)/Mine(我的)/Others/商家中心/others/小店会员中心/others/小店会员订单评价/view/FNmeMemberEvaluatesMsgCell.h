//
//  FNmeMemberEvaluatesMsgCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmeMemberStarView.h"
#import "FNmeMemberEvaluatesModel.h"
#import "FNmerchentReviewModel.h" 
NS_ASSUME_NONNULL_BEGIN
@protocol FNmeMemberEvaluatesMsgCellDelegate <NSObject>

- (void)didmeMeConsumeEdit:(NSString*)consume;

- (void)didmeMeAnonymityAction:(NSString*)isAnonymity;

@end
@interface FNmeMemberEvaluatesMsgCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView *headImgView;
@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UIImageView *goodsimgView;
@property (nonatomic, strong)UIView *bgOneView;
@property (nonatomic, strong)UIView *bgYellowView;
@property (nonatomic, strong)UIView *bgTwoView;
@property (nonatomic, strong)UILabel *nameLB;
@property (nonatomic, strong)UIButton *timeBtn;
@property (nonatomic, strong)UILabel *hintLB;
@property (nonatomic, strong)UILabel *goodsLB;
@property (nonatomic, strong)UILabel *starStrLB;
@property (nonatomic, strong)UILabel *starHintLB;
@property (nonatomic, strong)UILabel *capitaLB;
@property (nonatomic, strong)UITextField  *compileField;
@property (nonatomic, strong)UIButton *anonymityBtn;
@property (nonatomic, strong)FNmeMemberStarView *starView;
@property (nonatomic, strong)FNmeMemberEvaluatesModel *model;
@property (nonatomic, strong)FNmerchentReviewModel *alterModel;
@property (nonatomic, weak)id<FNmeMemberEvaluatesMsgCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
