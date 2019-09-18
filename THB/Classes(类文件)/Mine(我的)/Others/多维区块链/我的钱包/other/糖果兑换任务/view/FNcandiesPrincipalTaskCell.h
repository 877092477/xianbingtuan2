//
//  FNcandiesPrincipalTaskCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNCandiesConversionModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNcandiesPrincipalTaskCellDelegate <NSObject>
// 点击
- (void)inPrincipalTaskRtightAction:(id)model;

@end
@interface FNcandiesPrincipalTaskCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView  *bgImgView;
@property (nonatomic, strong)UIImageView  *lineView;
@property (nonatomic, strong)UILabel  *title1LB;
@property (nonatomic, strong)UILabel  *title2LB;
@property (nonatomic, strong)UILabel  *rightHintLB;
@property (nonatomic, strong)UILabel  *rightValLB;

@property (nonatomic, strong)UILabel  *timeLB;
@property (nonatomic, strong)UILabel  *numberLB;

@property (nonatomic, strong)UIButton *topBtn;
@property (nonatomic, strong)UIButton *baseBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)FNCandiesMyTaskModel *model;
@property (nonatomic, strong)NSString *bgImgUrl;
@property (nonatomic, strong)NSIndexPath *index;
@property (nonatomic, weak)id<FNcandiesPrincipalTaskCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
