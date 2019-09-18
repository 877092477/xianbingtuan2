//
//  FNcamdiesMyTaskItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNCandiesConversionModel.h"
#import "UIView+AZGradient.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNcamdiesMyTaskItemCellDelegate <NSObject>
// 点击
- (void)inMyTaskRtightAction:(id)model;

@end
@interface FNcamdiesMyTaskItemCell : UICollectionViewCell
@property (nonatomic, strong)UILabel  *titleLB;
@property (nonatomic, strong)UILabel  *hintLB;
@property (nonatomic, strong)UILabel  *hintRTimeLB;
@property (nonatomic, strong)UILabel  *baseLB;

@property (nonatomic, strong)UILabel  *rightHintLB;
@property (nonatomic, strong)UILabel  *rightValLB;
@property (nonatomic, strong)UIImageView  *bgImgView;
@property (nonatomic, strong)UIImageView  *imgView;
@property (nonatomic, strong)UIImageView  *planBgView;
@property (nonatomic, strong)UIView  *planImgView;
@property (nonatomic, strong)UILabel  *planLB;

@property (nonatomic, strong)UIButton *rightBtn;

@property (nonatomic, strong)FNCandiesMyTaskModel *model;
@property (nonatomic, strong)NSString *bgImgUrl;
@property (nonatomic, strong)NSIndexPath *index;
@property (nonatomic, weak)id<FNcamdiesMyTaskItemCellDelegate> delegate;
 
@end

NS_ASSUME_NONNULL_END
