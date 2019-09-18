//
//  FNmerDiscountsSubtractCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerDiscountsItemModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmerDiscountsSubtractCellDelegate <NSObject>
// 修改
- (void)didMerDiscountsSubtractAmendIndex:(NSIndexPath*)index;
// 上架||下架
- (void)didMerDiscountsSubtractStateIndex:(NSIndexPath*)index;
@end
@interface FNmerDiscountsSubtractCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView    *bgView;

@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UILabel   *str1LB;
@property (nonatomic, strong)UILabel   *str2LB;
@property (nonatomic, strong)UILabel   *str3LB;
 
@property (nonatomic, strong)UIButton  *amendBtn;
@property (nonatomic, strong)UIButton  *cancelBtn;
@property (nonatomic, strong)UIImageView  *stateImage;



@property (nonatomic, strong)FNmerDiscountsItemModel  *model;

@property (nonatomic, strong)NSIndexPath  *index;

@property (nonatomic, weak)id<FNmerDiscountsSubtractCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
