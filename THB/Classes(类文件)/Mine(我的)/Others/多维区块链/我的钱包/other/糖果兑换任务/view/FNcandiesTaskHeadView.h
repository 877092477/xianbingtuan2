//
//  FNcandiesTaskHeadView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNCandiesConversionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNcandiesTaskHeadView : UICollectionReusableView 
@property (nonatomic, strong)UIImageView  *baskBgImgView;
@property (nonatomic, strong)UILabel  *taskTitleLB;
@property (nonatomic, strong)FNCandiesTaskStyleModel  *model;
@end

NS_ASSUME_NONNULL_END
