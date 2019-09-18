//
//  FNmerDiscountsItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerDiscountsItemModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmerDiscountsItemCellDelegate <NSObject>
// 刷新某一行
- (void)didMerDiscountsRefreshIndex:(NSIndexPath*)index;
// 修改
- (void)didMerDiscountsAmendIndex:(NSIndexPath*)index;
// 上架||下架
- (void)didMerDiscountsStateIndex:(NSIndexPath*)index;
@end
@interface FNmerDiscountsItemCell : UICollectionViewCell
@property (nonatomic, strong)UIView    *bgView;
@property (nonatomic, strong)UILabel   *sumLB;
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UILabel   *str1LB;
@property (nonatomic, strong)UILabel   *str2LB;
@property (nonatomic, strong)UILabel   *typeLB;
@property (nonatomic, strong)UILabel   *dateLB;
@property (nonatomic, strong)UILabel   *limit1LB;
@property (nonatomic, strong)UILabel   *limit2LB;

@property (nonatomic, strong)UILabel   *wearDateLB;
@property (nonatomic, strong)UILabel   *endDateLB;
@property (nonatomic, strong)UILabel   *deadlineLB;

@property (nonatomic, strong)UIView  *centreView;
@property (nonatomic, strong)UIButton  *amendBtn;
@property (nonatomic, strong)UIButton  *cancelBtn;
@property (nonatomic, strong)UIImageView  *stateImage;

@property (nonatomic, strong)UIButton  *previewBtn;

@property (nonatomic, strong)FNmerDiscountsItemModel  *model;

@property (nonatomic, strong)NSIndexPath  *index;

@property (nonatomic, weak)id<FNmerDiscountsItemCellDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
