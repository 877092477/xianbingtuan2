//
//  FNcanIncomeTopCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNcandiesIncomeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNcanIncomeTopCell : UICollectionViewCell
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *priceLB;
@property (nonatomic, strong)UILabel   *hintLB;
@property (nonatomic, strong)UIButton  *incomeBtn;
@property (nonatomic, strong)UIButton  *baseBtn;
@property (nonatomic, strong)UIImageView  *bgImgView;
@property (nonatomic, strong)FNcandiesIncomeModel  *model;
@end

NS_ASSUME_NONNULL_END
