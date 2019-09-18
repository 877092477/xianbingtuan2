//
//  FNMCouponGoodsView.h
//  THB
//
//  Created by jimmy on 2017/10/30.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FNMCTopGoodsModel;
@interface FNMCouponGoodsView : UIView
@property (nonatomic, strong)NSArray<FNMCTopGoodsModel *>* datas;
@property (nonatomic, copy)void (^viewclicked)(FNMCTopGoodsModel* mdoel);
@end
