//
//  FNcandiesTextHintCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNCandiesMyModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNcandiesTextHintCellDelegate <NSObject>
// 点击
- (void)inCandiesRtightAction:(NSIndexPath*)index;

@end
@interface FNcandiesTextHintCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView  *bgImgView;
@property (nonatomic, strong)UIView    *dotView;
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *hintLB;
@property (nonatomic, strong)UILabel   *hint2LB;
@property (nonatomic, strong)UILabel   *value2LB;
@property (nonatomic, strong)UIButton  *rightBtn;
@property (nonatomic, strong)UIButton  *imgTextBtn;
@property (nonatomic, strong)FNCandiesMyoperationItemModel  *model;
@property (nonatomic, strong)FNCandiesMyModel  *daModel;
@property (nonatomic, strong)NSString *bgImg;
@property (nonatomic, strong)NSString *tgImg;
@property (nonatomic, strong)NSIndexPath *index;
@property (nonatomic, weak)id<FNcandiesTextHintCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
