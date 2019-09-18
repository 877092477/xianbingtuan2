//
//  FNNewStoreDetailController.h
//  新版嗨如意
//
//  Created by Weller on 2019/6/19.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNNewStoreDetailController : SuperViewController

@property (nonatomic, copy) NSString *storeID;
@property (nonatomic, copy) NSString *storeName;

// 设置商品id，会跳转到商品页面
@property (nonatomic, assign) BOOL isNeedJumpGoods;
@property (nonatomic, copy) NSString *goods_id;

@end

NS_ASSUME_NONNULL_END
