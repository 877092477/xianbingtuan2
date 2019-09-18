//
//  FNmerOrderMsgItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerOrderZModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerOrderMsgItemCell : UICollectionViewCell
@property (nonatomic, strong)UIView    *bgView;
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)FNmerOrderZZHModel   *model;

@end

NS_ASSUME_NONNULL_END
