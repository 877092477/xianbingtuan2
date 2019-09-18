//
//  FNcandiesRanTopItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNcandiesRankingModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNcandiesRanTopItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView  *bgImgView;
@property (nonatomic, strong)FNcandiesRankingModel *model;

@property (nonatomic, strong)UIView   *bg1View;
@property (nonatomic, strong)UIView   *bg2View;
@property (nonatomic, strong)UIView   *bg3View;
@property (nonatomic, strong)UIView   *baseView;

@property (nonatomic, strong)UILabel   *name1LB;
@property (nonatomic, strong)UIButton   *designation1Btn;
@property (nonatomic, strong)UILabel   *gain1LB;
@property (nonatomic, strong)UILabel   *gainValue1LB;
@property (nonatomic, strong)UIImageView  *headImg1View;
@property (nonatomic, strong)UIImageView  *headCrownView; 

@property (nonatomic, strong)UILabel   *name2LB;
@property (nonatomic, strong)UIButton   *designation2Btn;
@property (nonatomic, strong)UILabel   *gain2LB;
@property (nonatomic, strong)UILabel   *gainValue2LB;
@property (nonatomic, strong)UIImageView  *headImg2View;
 

@property (nonatomic, strong)UILabel   *name3LB;
@property (nonatomic, strong)UIButton   *designation3Btn;
@property (nonatomic, strong)UILabel   *gain3LB;
@property (nonatomic, strong)UILabel   *gainValue3LB;
@property (nonatomic, strong)UIImageView  *headImg3View;
 
@end

NS_ASSUME_NONNULL_END
