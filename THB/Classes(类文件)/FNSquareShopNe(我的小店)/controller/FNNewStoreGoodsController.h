//
//  FNNewStoreGoodsController.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/26.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNstoreInformationDaModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNNewStoreGoodsController : SuperViewController

@property (nonatomic, copy) NSString *storeID;
@property (nonatomic, copy) NSString *storeName;
@property (nonatomic, copy) NSString *goods_id;


-(void) setStore: (FNstoreInformationDaModel *) model;

@end

NS_ASSUME_NONNULL_END
