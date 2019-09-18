//
//  FNOddStyleLItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNdisOddLaunchModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNOddStyleLItemCell : UICollectionViewCell
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UIImageView *stateImg;
@property (nonatomic, strong)FNdisOddLaunchMoItemModel *model;
@end


NS_ASSUME_NONNULL_END
