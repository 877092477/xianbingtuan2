//
//  FNhandTermItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNhandConditionsView.h"
#import "FNHandSlapdModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNhandTermItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UIImageView   *titleImgView;
@property (nonatomic, strong)UILabel *titleLB;
@property (nonatomic, strong)FNhandConditionsView *listView;
@property (nonatomic, strong)FNHandSlapdModel *model;
@end

NS_ASSUME_NONNULL_END
