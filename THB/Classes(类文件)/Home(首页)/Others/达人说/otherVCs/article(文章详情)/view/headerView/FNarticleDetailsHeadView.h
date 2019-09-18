//
//  FNarticleDetailsHeadView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNArticleDeailsXModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNarticleDetailsHeadView : UICollectionReusableView
@property (nonatomic, strong)UIImageView   *topbgImgView;
@property (nonatomic, strong)UIImageView   *topDimImgView;
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UIImageView   *headImg;
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UILabel   *dateLB;
@property (nonatomic, strong)UILabel   *checkLB;
@property (nonatomic, strong)UILabel   *shorttitleLB;
@property (nonatomic, strong)UIButton  *likeBtn;
@property (nonatomic, strong)FNArticleDeailsXModel *model;
@end

NS_ASSUME_NONNULL_END
