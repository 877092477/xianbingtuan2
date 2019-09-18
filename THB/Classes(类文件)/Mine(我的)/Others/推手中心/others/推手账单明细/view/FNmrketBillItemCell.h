//
//  FNmrketBillItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmarketBillModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmrketBillItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *imgView; 
@property (nonatomic, strong)UILabel *titleLB;
@property (nonatomic, strong)UILabel *sumLB;
@property (nonatomic, strong)UILabel *hintLB; 
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)FNmarketBillItemModel *model;
@end

NS_ASSUME_NONNULL_END
