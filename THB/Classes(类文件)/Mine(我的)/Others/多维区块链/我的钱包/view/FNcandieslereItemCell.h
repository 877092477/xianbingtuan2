//
//  FNcandieslereItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNCandiesMyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNcandieslereItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView  *bgImgView;
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *hintLB;
@property (nonatomic, strong)UIImageView  *imgView;
@property (nonatomic, strong)FNCandiesMyoperationItemModel  *model;
@property (nonatomic, strong)NSString *bgImg;

@end

NS_ASSUME_NONNULL_END
