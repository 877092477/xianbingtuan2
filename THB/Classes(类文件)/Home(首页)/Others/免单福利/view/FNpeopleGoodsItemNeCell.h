//
//  FNpeopleGoodsItemNeCell.h
//  THB
//
//  Created by Jimmy on 2018/12/18.
//  Copyright © 2018 方诺科技. All rights reserved.
//  /新人免单cell

#import <UIKit/UIKit.h>

#import "FNwelfDeModel.h"

@protocol FNpeopleGoodsItemNeCellDegate <NSObject>

// 点击
- (void)itemGoodsItemClick:(NSDictionary*)dicTry;

@end

@interface FNpeopleGoodsItemNeCell : UICollectionViewCell
/** 商品img **/
@property (nonatomic, strong)UIImageView* goodsImageView;
/** 名字 **/
@property (nonatomic, strong)UILabel* nameLB;
/** 到手价 **/
@property (nonatomic, strong)UILabel* dsjLB;
/** 价格 **/
@property (nonatomic, strong)UILabel* priceLB;
/** 原价 **/
@property (nonatomic, strong)UILabel* rawLB;
/** 已抢数量 **/
@property (nonatomic, strong)UILabel* amountLB;
/** 马上抢 **/
@property (nonatomic, strong)UIButton* grabBtn;
/** line **/
@property (nonatomic, strong)UIView* line;

@property (nonatomic, strong)NSDictionary *itemDictry;

@property (nonatomic, strong)NSIndexPath* indexPath;

@property(nonatomic ,weak) id<FNpeopleGoodsItemNeCellDegate> delegate;

@end


