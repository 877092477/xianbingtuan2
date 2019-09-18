//
//  FNConvertHintfeCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/5.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNdistrictConvertTypefeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNConvertHintfeCell : UICollectionViewCell
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)FNConvertfeModel *model;
@end

NS_ASSUME_NONNULL_END
