//
//  FNcandiesIncomeItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNcandiesIncomeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNcandiesIncomeItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView  *iconView;
@property (nonatomic, strong)UIView    *dotView;
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *dateLB;
@property (nonatomic, strong)UILabel   *priceLB;
@property (nonatomic, strong)UILabel   *hintLB;
@property (nonatomic, strong)FNcandiesIncomeItemModel  *model;
@end

NS_ASSUME_NONNULL_END
