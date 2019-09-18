//
//  FNmemberStrategyNCell.h
//  THB
//
//  Created by 李显 on 2018/9/8.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GradeStrategyModel;

@interface FNmemberStrategyNCell : UICollectionViewCell
/** 白色View **/
@property (nonatomic, strong)UIView* whiteBgView;
/** 等级 **/
@property (nonatomic, strong)UIImageView* gradeImageView;
/** 等级数字 **/
@property (nonatomic, strong)UIImageView* gradeNumberImageView;
/** 等级文字 **/
@property (nonatomic, strong)UILabel* gradeLB;
//值scrollView
@property (nonatomic, strong)UIScrollView* priceScrollView; 
/** 灰色长条1 **/
@property (nonatomic, strong)UIImageView* grayOneImageView;
/** 灰色长条2 **/
@property (nonatomic, strong)UIImageView* grayTwoImageView;
/** 累计人标题 **/
@property (nonatomic, strong)UILabel* addUpPeopleTitleLB;
/** 累计人数 **/
@property (nonatomic, strong)UILabel* addUpPeopleNumberLB;
/** 等级其他 **/
@property (nonatomic, strong)UILabel* addUpValTitleLB;
/** 等级其他值 **/
@property (nonatomic, strong)UILabel* addUpValNumberLB;
/** 橙色view **/
@property (nonatomic, strong)UIView* orangeBgView;
/** 橙色line **/
@property (nonatomic, strong)UIImageView* orangelineImage;
/** 备注1 **/
@property (nonatomic, strong)UILabel* remarkOneLB;
/** 备注2 **/
@property (nonatomic, strong)UILabel* remarkTwoLB;

@property (nonatomic, strong)NSIndexPath* indexPath;


@property (nonatomic, strong)GradeStrategyModel *model;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end
