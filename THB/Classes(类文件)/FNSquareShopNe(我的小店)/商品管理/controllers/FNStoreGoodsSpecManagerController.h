//
//  FNStoreGoodsSpecManagerController.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreGoodsSpecManagerModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNStoreGoodsSpecManagerController;
@protocol FNStoreGoodsSpecManagerControllerDelegate <NSObject>

- (void)goodsSpec: (FNStoreGoodsSpecManagerController*)vc didSelected: (FNStoreGoodsSpecManagerModel*) spec;

@end

@interface FNStoreGoodsSpecManagerController : SuperViewController

@property (nonatomic, strong) FNStoreGoodsSpecManagerModel *baseSpec;
@property (nonatomic, weak) id<FNStoreGoodsSpecManagerControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
