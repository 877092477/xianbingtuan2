//
//  FNSaleGoodsViewCell.h
//  THB
//
//  Created by zhongxueyu on 2018/8/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNComponentBaseCell.h"

/**过去一小时商品View*/
#import "FNBuyProductHeatNView.h"

#import "MenuModel.h"

@interface FNSaleGoodsViewCell : FNComponentBaseCell

@property (nonatomic,strong) FNBuyProductHeatNView *heatView;


@property(nonatomic,strong)NSDictionary *restsDic;

@property(nonatomic,strong)NSMutableArray *seckillArr;

// 数组
//@property (nonatomic, strong)NSArray<MenuModel *> *index_tuwenwei_01List;

@property (nonatomic, copy)void (^selectComponentBaseNow)(FNBaseProductModel * model);

//@property (nonatomic, copy)void (^selectMemberShowAll)(MenuModel * model);

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end
