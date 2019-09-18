//
//  FNBuyProductCell.h
//  LikeKaGou
//
//  Created by jimmy on 16/9/29.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "FNSuperTableViewCell.h"
#import "JMProgressView.h"
/**
 *  抢购：限时商品cell
 */
typedef enum : NSUInteger {
    BPCButtonTypeRightNow,//馬上抢
    BPCButtonTypeDone,//已抢光
    BPCButtonTypeToBeBegun,//即将开抢
} BPCButtonType;
@class FNBuyProductModel;
@interface FNBuyProductCell : FNSuperTableViewCell
@property (nonatomic, weak) UIImageView *proImageView;
@property (nonatomic, weak) UILabel* titleLabel;

@property (nonatomic, weak) UIView *priceView;
@property (nonatomic, weak) UILabel* priceTitleLabel;//领券购
@property (nonatomic, weak) UILabel* realPriceLabel;//实际价格
@property (nonatomic, weak) UILabel* originalPriceLabel;//原价
@property (nonatomic, weak) UILabel* discountPriceLable;//券抵价格
@property (nonatomic, weak) UIView* verticalLineView;
@property (nonatomic, weak) JMProgressView* progressView;
@property (nonatomic, weak) UILabel* userCountLabel;//领用人数

@property (nonatomic, weak) UIButton* operationBtn;
@property (nonatomic, assign) BPCButtonType btnType;

@property (nonatomic, strong)NSIndexPath* indexPath;

@property (nonatomic, strong)FNBuyProductModel* model;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
