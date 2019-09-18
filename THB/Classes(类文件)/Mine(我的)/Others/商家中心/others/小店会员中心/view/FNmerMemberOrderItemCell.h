//
//  FNmerMemberOrderItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerMembersModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerMemberOrderItemCell : UICollectionViewCell
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UILabel *nameLB;
@property (nonatomic, strong)UILabel *timeLB;
@property (nonatomic, strong)UILabel *stateLB;
@property (nonatomic, strong)UIButton *evaluateBtn;
@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)FNmerMembersOrderItemModel *model;
@end

NS_ASSUME_NONNULL_END
