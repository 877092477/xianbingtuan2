//
//  FNmerSetingsItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerSetingsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerSetingsItemCell : UICollectionViewCell
@property (nonatomic, strong)UILabel   *leftTitleLB;
@property (nonatomic, strong)UILabel   *rightLB;
@property (nonatomic, strong)UIImageView *headView;
@property (nonatomic, strong)UIImageView *rightImgView;
@property (nonatomic, strong)UIView    *lineView;
@property (nonatomic, strong)FNmerSetingsItemModel *model;

@end

NS_ASSUME_NONNULL_END
