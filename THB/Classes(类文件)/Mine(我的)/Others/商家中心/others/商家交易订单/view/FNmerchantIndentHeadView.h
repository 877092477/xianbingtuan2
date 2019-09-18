//
//  FNmerchantIndentHeadView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/5.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerchantIndentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerchantIndentHeadView : UICollectionReusableView
@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UILabel   *leftTitleLB;
@property (nonatomic, strong)UILabel   *leftSumLB;
@property (nonatomic, strong)UILabel   *rightHintLB;
@property (nonatomic, strong)UILabel   *expenseCountLB;
@property (nonatomic, strong)UILabel   *expenseLB; 
@property (nonatomic, strong)UIButton  *rightBtn;
@property (nonatomic, strong)FNmerchantIndentModel  *topModel;
@property (nonatomic, strong)FNmerchantIndentModel  *bottomModel;
@end

NS_ASSUME_NONNULL_END
