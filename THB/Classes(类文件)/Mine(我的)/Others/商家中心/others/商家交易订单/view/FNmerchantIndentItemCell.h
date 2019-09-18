//
//  FNmerchantIndentItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerchantIndentModel.h"
NS_ASSUME_NONNULL_BEGIN

@class FNmerchantIndentItemCell;
@protocol FNmerchantIndentItemCellDelegate <NSObject>

- (void) indentItemStateClick: (FNmerchantIndentItemCell*)cell;

@end

@interface FNmerchantIndentItemCell : UICollectionViewCell

@property (nonatomic, weak) id<FNmerchantIndentItemCellDelegate> delegate;

@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UIView        *lineView;
@property (nonatomic, strong)UIImageView   *headImgView;
@property (nonatomic, strong)UILabel   *nameTitleLB;
@property (nonatomic, strong)UILabel   *numberLB;
@property (nonatomic, strong)UIImageView   *imgView;
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UILabel   *dateLB;
@property (nonatomic, strong)UILabel   *sumLB;
@property (nonatomic, strong)UILabel   *stateLB;
@property (nonatomic, strong)UILabel *lblType;
@property (nonatomic, strong)FNmerchantIndentItemModel   *model;
@end

NS_ASSUME_NONNULL_END
