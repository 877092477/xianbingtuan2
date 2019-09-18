//
//  FNUpgradeRecommendNCell.h
//  THB
//
//  Created by Jimmy on 2018/9/25.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNUpgradeGoodsNView.h"
@protocol FNUpgradeRecommendNCellDelegate <NSObject>

/** 选择商品 **/
-(void)selectRecommendNAction:(id)model;

@end

@interface FNUpgradeRecommendNCell : UITableViewCell<FNUpgradeGoodsNViewDelegate>
/** 标题图片 **/
@property (nonatomic, strong)UIImageView* titleImage;
/** 推荐商品 **/
@property (nonatomic, strong)FNUpgradeGoodsNView* GoodsNView;

/** line **/
@property (nonatomic, strong)UIView* LineView;

@property (nonatomic, copy) NSDictionary *recommend;

@property(nonatomic ,weak) id<FNUpgradeRecommendNCellDelegate> delegate;

@end
