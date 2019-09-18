//
//  FNmeMemberIndentitCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmeMemberIndentItemModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmeMemberIndentitCellDelegate <NSObject>
//取消退款
- (void)didmeMemberCancelRefundAction:(NSIndexPath*)indexPath;
//取消订单
- (void)didmeMemberCancelIndentitAction:(NSIndexPath*)indexPath;
//评价
- (void)didmeMemberEvaluateIndentitAction:(NSIndexPath*)index;
//确认送达
- (void)didmeMemberAffirmIndentitAction:(NSIndexPath*)indexPath;

@end
@interface FNmeMemberIndentitCell : UICollectionViewCell

@property (nonatomic, strong)UILabel *timeLB;
@property (nonatomic, strong)UILabel *typeLB;
@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UILabel *nameLB;
@property (nonatomic, strong)UILabel *hintLB;
@property (nonatomic, strong)UILabel *sumLB;
@property (nonatomic, strong)UILabel *sumHintLB;
@property (nonatomic, strong)UILabel *stateLB;
@property (nonatomic, strong)UIButton *evaluateBtn;
@property (nonatomic, strong)UIButton *affirmBtn;
@property (nonatomic, strong)NSIndexPath *index;
@property (nonatomic, strong)FNmeMemberIndentItemModel *model;
@property (nonatomic, weak)id<FNmeMemberIndentitCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
