//
//  FNSpeciQuantityNeCell.h
//  THB
//
//  Created by Jimmy on 2018/9/27.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FNSpeciQuantityNeCellDelegate <NSObject>

@optional

- (void)SpeciMinusQuantity:(NSIndexPath *)indexPath;

- (void)SpeciAddQuantity:(NSIndexPath *)indexPath;

@end

@interface FNSpeciQuantityNeCell : UICollectionViewCell

/** 购买 **/
@property (strong , nonatomic)UILabel *QuantityTitleLabel;

/** 数量 **/
@property (strong , nonatomic)UILabel *QuantityLabel;

/** 加 **/
@property (nonatomic, strong)UIButton* addBtn;

/** 减 **/
@property (nonatomic, strong)UIButton* minusBtn;

@property (nonatomic, strong)NSIndexPath *indexPath;

@property (nonatomic, assign)NSInteger Quantity;

@property (nonatomic, weak) id<FNSpeciQuantityNeCellDelegate> delegate;

@end
