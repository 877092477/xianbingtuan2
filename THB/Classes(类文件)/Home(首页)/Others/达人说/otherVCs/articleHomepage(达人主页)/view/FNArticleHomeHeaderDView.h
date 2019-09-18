//
//  FNArticleHomeHeaderDView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNArticleHomepageDModel.h"
#import "FNExpertSortNaNodel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNArticleHomeHeaderDView : UICollectionReusableView
@property (nonatomic, strong)UIImageView   *topbgImgView;
@property (nonatomic, strong)UIImageView   *topDimImgView;
@property (nonatomic, strong)UIImageView   *headImg;
@property (nonatomic, strong)UILabel       *nameLB;
@property (nonatomic, strong)UILabel       *checkLB;
@property (nonatomic, strong)UILabel       *articleCountLB;
@property (nonatomic, strong)FNArticleHomepageDModel *dataModel;
@property (nonatomic, strong)FNEssayItemDModel *twoModel;
@end

NS_ASSUME_NONNULL_END
