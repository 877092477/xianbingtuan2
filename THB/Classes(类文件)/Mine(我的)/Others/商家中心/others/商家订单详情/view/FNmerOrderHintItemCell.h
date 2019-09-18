//
//  FNmerOrderHintItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerOrderZModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerOrderHintItemCell : UICollectionViewCell
@property (nonatomic, strong)UIView        *topBgView;
@property (nonatomic, strong)UIView        *toplineView;
@property (nonatomic, strong)UIView        *bottomBgView;
@property (nonatomic, strong)UIButton  *contactBtn; 
@property (nonatomic, strong)UILabel   *sumLB;
@property (nonatomic, strong)UILabel   *hintLB;
@property (nonatomic, strong)FNmerOrderZModel   *model;
@end

NS_ASSUME_NONNULL_END
