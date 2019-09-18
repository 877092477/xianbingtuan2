//
//  FNUpgradeGoodsNView.h
//  THB
//
//  Created by Jimmy on 2018/9/25.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FNBaseProductModel;

@protocol FNUpgradeGoodsNViewDelegate <NSObject>

/** 选择商品 **/
-(void)selectRecommendAction:(id)model;

@end
@interface FNUpgradeGoodsNView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>


@property(nonatomic,strong)UICollectionView* goodscollectionview;

@property(nonatomic,strong)NSMutableArray* productArr;

@property(nonatomic ,weak) id<FNUpgradeGoodsNViewDelegate> delegate;

@end
