//
//  FNCommRecommendPView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHPopupContainer.h"
#import "FNBaseProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNCommRecommendPView : UIView<DSHCustomPopupView>
@property (nonatomic, strong)UIButton *cancelBtn;
@property (nonatomic, strong)UIView   *bgView;
@property (nonatomic, strong)UIImageView   *topImgView;
@property (nonatomic, strong)UIImageView   *typeImgView;
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UILabel   *priceLB;
@property (nonatomic, strong)UILabel   *originalPriceLB;
@property (nonatomic, strong)UILabel   *salesLB;
@property (nonatomic, strong)UIButton  *ticketBtn;
@property (nonatomic, strong)UIButton  *prospectBtn;//预计收益
@property (nonatomic, strong)UIButton  *lookBtn;
@property (nonatomic, strong)FNBaseProductModel *goodModel;

@property (nonatomic, copy)void (^showCheckGoods)(FNBaseProductModel * model);

@end

NS_ASSUME_NONNULL_END
