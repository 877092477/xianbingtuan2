//
//  FNCandiesMyTopCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNCandiesMyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNCandiesMyTopCell : UICollectionViewCell
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *priceLB;
@property (nonatomic, strong)UILabel   *hintLB; 
@property (nonatomic, strong)UILabel   *comeUponLB;
@property (nonatomic, strong)UILabel   *unitLB;
@property (nonatomic, strong)UIButton  *incomeBtn;
@property (nonatomic, strong)UIButton  *convertBtn;
@property (nonatomic, strong)UIImageView  *bgImgView;
@property (nonatomic, strong)FNCandiesMyModel  *model;
@end

NS_ASSUME_NONNULL_END
