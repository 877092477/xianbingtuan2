//
//  FNmerOrderTopItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerOrderZModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerOrderTopItemCell : UICollectionViewCell
@property (nonatomic, strong)UIView        *topBgView;
//@property (nonatomic, strong)UIView        *twoBgView;
//@property (nonatomic, strong)UIView        *bottomBgView;
@property (nonatomic, strong)UIView        *oneLineView;
//@property (nonatomic, strong)UIView        *twoLineView;
//@property (nonatomic, strong)UIView        *threeLineView;

@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *hintLB;
@property (nonatomic, strong)UILabel   *sumLB;
//@property (nonatomic, strong)UILabel   *yardTitleLB;
//@property (nonatomic, strong)UILabel   *stateLB;
//@property (nonatomic, strong)UILabel   *nameLB;
//@property (nonatomic, strong)UIImageView   *yardImgView;
//@property (nonatomic, strong)UIImageView   *headImgView;
@property (nonatomic, strong)FNmerOrderZModel   *model;

@end

NS_ASSUME_NONNULL_END
