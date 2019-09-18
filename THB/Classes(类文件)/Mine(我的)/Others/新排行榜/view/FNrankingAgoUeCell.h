//
//  FNrankingAgoUeCell.h
//  THB
//
//  Created by 李显 on 2019/1/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNarrangeItemModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNrankingAgoUeCell : UICollectionViewCell
/** 排名 **/
@property (nonatomic, strong)UIImageView* rankingImageView;
/** 头像 **/
@property (nonatomic, strong)UIImageView* headImageView;
/** 等级背景 **/
@property (nonatomic, strong)UIImageView* gradeBGImg;
/** 排名 **/
@property (nonatomic, strong)UILabel* numLB;
/** 名字 **/
@property (nonatomic, strong)UILabel* nameLB;
/** 等级 **/
@property (nonatomic, strong)UILabel* gradeLB;
/** 其他1 **/
@property (nonatomic, strong)UILabel* otherOneLB;
/** 其他2 **/
@property (nonatomic, strong)UILabel* otherTwoLB;
/** line **/
@property (nonatomic, strong)UIView* line;
/** middleLine **/
@property (nonatomic, strong)UIView* middleLine;
/** model **/
@property (nonatomic, strong)FNarrangeItemModel* model;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
