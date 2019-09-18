//
//  FNmerInformationsItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerInformationsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerInformationsItemCell : UICollectionViewCell
@property (nonatomic, strong)UILabel   *dateLB;
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *msgLB;
@property (nonatomic, strong)UIView    *bgView;
@property (nonatomic, strong)FNmerInformationsModel    *model;
@end

NS_ASSUME_NONNULL_END
