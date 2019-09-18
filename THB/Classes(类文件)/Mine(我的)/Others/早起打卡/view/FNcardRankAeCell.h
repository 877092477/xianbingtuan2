//
//  FNcardRankAeCell.h
//  THB
//
//  Created by Jimmy on 2019/2/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNCardItemAeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNcardRankAeCell : UICollectionViewCell
/** 今日状况  **/
@property (nonatomic, strong)UIButton *todayBtn;
/** 邀请  **/
@property (nonatomic, strong)UIButton *inviteBtn;
/** 邀请  **/
@property (nonatomic, strong)FNCardItemAeView *bestView;
/** 邀请  **/
@property (nonatomic, strong)FNCardItemAeView *firstView;
/** 邀请  **/
@property (nonatomic, strong)FNCardItemAeView *longestView;
@end

NS_ASSUME_NONNULL_END
