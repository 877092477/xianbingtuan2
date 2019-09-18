//
//  FNWaresSortItemACell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNWaresMultiNaModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNWaresSortItemACell : UICollectionViewCell
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UIImageView   *sortImgView;
@property (nonatomic, strong)FNWaresSortAModel  *model;

@end

NS_ASSUME_NONNULL_END
