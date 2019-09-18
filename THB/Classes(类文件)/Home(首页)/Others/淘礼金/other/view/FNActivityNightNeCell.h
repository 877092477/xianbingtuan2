//
//  FNActivityNightNeCell.h
//  THB
//
//  Created by Jimmy on 2018/10/23.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNCashActivityNeModel.h"
@protocol FNActivityNightNeCellDelegate <NSObject>
/** 点击立即购买**/
- (void)acNightPurchaseAction:(id)sender;
@end
@interface FNActivityNightNeCell : UITableViewCell
/**  bgOneImageView  **/
@property (nonatomic, strong)UIImageView * bgOneImageView;
/**  bgImageView  **/
@property (nonatomic, strong)UIImageView * bgImageView;
/** middleView **/
@property (nonatomic, strong)UIView* middleView;
/** goods_img **/
@property (nonatomic, strong)UIImageView *goodsImage;
/** goodsShade **/
@property (nonatomic, strong)UIImageView *goodsShadeView;
/** goods_title **/
@property (nonatomic, strong)UILabel* goodstitleLB;
/** ranking **/
@property (nonatomic, strong)UIImageView* rankingImageView;
/** rankingLB **/
@property (nonatomic, strong)UILabel* rankingLB;
/** circleImageView **/
@property (nonatomic, strong)UIImageView* circleImageView;
/** 原价BG **/
@property (nonatomic, strong)UIView* goodsPriceBGView;
/** 原价 **/
@property (nonatomic, strong)UILabel* goodsPrice;
/** 优惠券title **/
@property (nonatomic, strong)UILabel* onSaleTitleLB;
/** 优惠券金额 **/
@property (nonatomic, strong)UILabel* onSalePriceLB;
/** 淘礼金title **/
@property (nonatomic, strong)UILabel* cashTitleLB;
/** 淘礼金金额 **/
@property (nonatomic, strong)UILabel* cashPriceLB;
/** 立即购买 **/
@property (nonatomic, strong)UIButton* purchaseBtn;
/** nsidctry **/
@property (nonatomic, strong)NSDictionary* itemModel; 
/** delegate **/
@property(nonatomic ,weak) id<FNActivityNightNeCellDelegate> delegate;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
