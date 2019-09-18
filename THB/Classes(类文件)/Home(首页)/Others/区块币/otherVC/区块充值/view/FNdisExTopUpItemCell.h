//
//  FNdisExTopUpItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNdisExTopUpModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNdisExTopUpItemCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *stateImg;
@property(nonatomic,strong)UILabel *stateLB;
@property(nonatomic,strong)UILabel *nameLB;
@property(nonatomic,strong)UILabel *sumLB;
@property(nonatomic,strong)UILabel *dateLB;
@property(nonatomic,strong)UIView  *lineView;
@property(nonatomic,strong)FNdisExTopUpItemModel  *model;
@end

NS_ASSUME_NONNULL_END
