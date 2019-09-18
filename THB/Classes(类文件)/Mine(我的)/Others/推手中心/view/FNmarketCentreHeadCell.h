//
//  FNmarketCentreHeadCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/14.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNMarketCentreModel.h"
#import "FNmarScreensfView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmarketCentreHeadCellDelegate <NSObject>
// 点击 订单佣金  开店奖励
-(void)inMarketCentreHeadisSeletedType:(NSString *)type withIndex:(NSInteger)index;

@end
@interface FNmarketCentreHeadCell : UICollectionViewCell
@property (nonatomic, strong)UILabel *titleLB;
@property (nonatomic, strong)UILabel *sumLB;
@property (nonatomic, strong)UILabel *surplusTitleLB;
@property (nonatomic, strong)UILabel *surplusLB;
@property (nonatomic, strong)UILabel *gainTitleLB;
@property (nonatomic, strong)UILabel *gainLB;
@property (nonatomic, strong)UILabel *takesTitleLB;
@property (nonatomic, strong)UILabel *takesLB;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UIButton *leftTopBtn;
@property (nonatomic, strong)UIButton *rightTopBtn;
@property (nonatomic, strong)UIButton *leftBaseBtn;
@property (nonatomic, strong)UIButton *rightBaseBtn;
@property (nonatomic, strong)FNmarScreensfView *listView;
@property (nonatomic, strong)FNMarketCentreModel *model;
@property (nonatomic, strong)NSString *seletedType;

@property (nonatomic, weak)id<FNmarketCentreHeadCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
